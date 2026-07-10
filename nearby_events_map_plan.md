# Plan: Nearby Events on Google Maps (Map Tab)

## 1. Goal

Turn the placeholder **Map** tab (`lib/features/map/map_view.dart`, already wired as the
3rd branch in `AppRouter`'s `StatefulShellRoute.indexedStack`) into a real screen that:

1. Fetches nearby events the same way the app already does for the Events list's
   "nearby" mode (Ticketmaster `latlong` + `radius` search).
2. Renders each event as a marker on a Google Map.
3. Tapping a marker shows a small preview card (reusing `HorizontalEventCard`) in a
   bottom sheet with a "View details" button that pushes `EventDetailsView`.

## 2. Decisions locked in

| Question | Decision |
|---|---|
| Data source | Reuse the **Events feature's** `EventListMode.nearby` (`EventEntity` already has `latitude`/`longitude`) — **not** Home's `nearbyEvents` (which has no coordinates). |
| Map center / location | Same approach as Home's nearby section today: the **hardcoded point** `latitude: 40.7484, longitude: -73.9857` (New York). No GPS/`geolocator` integration in this pass. |
| Marker tap behavior | Modal bottom sheet with a `HorizontalEventCard` preview + "View details" button → navigates to `EventDetailsView`. |

Because `EventListMode.nearby` is already implemented end-to-end in
`EventsRepositoryImpl._toQueryParams` and already registered in the DI container as
`getIt<EventsListCubit>(param1: EventListMode.nearby)`, **no new repository, data
source, or cubit is required** — this plan is mostly UI + wiring + map SDK setup.

## 3. Dependencies to add

`pubspec.yaml`:
```yaml
dependencies:
  google_maps_flutter: ^2.9.0   # check latest stable at implementation time
```
`geolocator` / `permission_handler` are **not** needed since we're keeping the
hardcoded-location approach for now (matches Home's current behavior). Note this as a
deliberate scope cut so it's easy to revisit later — see §9.

## 4. Native platform setup

### Android (`android/app/src/main/AndroidManifest.xml`)
Add inside `<application>`:
```xml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="${MAPS_API_KEY}" />
```
`minSdkVersion` must be >= 21 (check `android/app/build.gradle.kts`, currently default
Flutter template — confirm it's already >= 21, it should be).

### iOS (`ios/Runner/AppDelegate.swift`)
```swift
import GoogleMaps // add import

// inside application(_:didFinishLaunchingWithOptions:)
GMSServices.provideAPIKey("YOUR_API_KEY")
```
No location usage-description keys are needed in `Info.plist` since we are not
requesting device location in this pass.

### API key handling
The existing Ticketmaster key is hardcoded directly in `dio_helper.dart`, so for
consistency the simplest path is to hardcode the Maps key the same way. Recommended
(slightly better) alternative, worth a quick decision at implementation time:
pass it via `--dart-define=MAPS_API_KEY=...` and inject into the Android manifest
placeholder / iOS AppDelegate at build time instead of committing it to source. Either
way, **do not** reuse the Ticketmaster key pattern of committing it under version
control if this repo will ever go public with billing enabled on the Maps key.

## 5. New/changed files

```
lib/features/map/
  map_view.dart                    (rewrite — was a placeholder)
  widgets/
    event_marker_preview_sheet.dart (new — bottom sheet wrapper around HorizontalEventCard)
```

No changes needed to:
- `lib/core/di/service_locator.dart` (EventsListCubit is already registered with
  `registerFactoryParam`, so it can be constructed with any `EventListMode`, including
  `nearby`, without touching this file)
- `lib/features/events/data/**` (nearby mode + lat/lng already implemented)

## 6. `MapView` implementation sketch

```dart
class MapView extends StatelessWidget {
  static const String routeName = '/map';
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<EventsListCubit>(param1: EventListMode.nearby)..load(),
      child: const _MapViewBody(),
    );
  }
}

class _MapViewBody extends StatefulWidget {
  const _MapViewBody();
  @override
  State<_MapViewBody> createState() => _MapViewBodyState();
}

class _MapViewBodyState extends State<_MapViewBody> {
  static const _defaultCenter = LatLng(40.7484, -73.9857); // same point as Home nearby
  GoogleMapController? _mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<EventsListCubit, EventsListState>(
        builder: (context, state) {
          final markers = _buildMarkers(context, state.events);
          return Stack(
            children: [
              GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: _defaultCenter,
                  zoom: 12,
                ),
                markers: markers,
                onMapCreated: (c) => _mapController = c,
                myLocationEnabled: false,
              ),
              if (state.status == ListStatus.loading)
                const Positioned(
                  top: 16, left: 0, right: 0,
                  child: Center(child: CircularProgressIndicator()),
                ),
              if (state.status == ListStatus.failure)
                _MapErrorBanner(message: state.errorMessage),
            ],
          );
        },
      ),
    );
  }

  Set<Marker> _buildMarkers(BuildContext context, List<EventEntity> events) {
    return events
        .where((e) => e.latitude != 0 && e.longitude != 0) // guard bad/missing coords
        .map((event) => Marker(
              markerId: MarkerId(event.id),
              position: LatLng(event.latitude, event.longitude),
              infoWindow: InfoWindow(title: event.title),
              onTap: () => _showEventPreview(context, event),
            ))
        .toSet();
  }

  void _showEventPreview(BuildContext context, EventEntity event) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => EventMarkerPreviewSheet(event: event),
    );
  }
}
```

Key points baked into the sketch:
- Reuses `EventsListCubit`/`EventsListState`/`ListStatus` exactly as `AllEventsView`
  does — same loading/failure handling, no new state machine.
- Filters out any event whose `latitude`/`longitude` parsed to `0` (Ticketmaster
  sometimes omits venue geo — `EventDto.fromJson` already defaults these to `0` when
  missing), so we don't drop a pin in the ocean at `(0,0)`.
- No pagination/infinite-scroll wiring — a map doesn't need "load more" the way a list
  does; `EventQuery`'s default `size: 20` is enough pins for one map view. (If this
  needs to change later, `EventsListCubit.load()` already supports paging.)

## 7. `EventMarkerPreviewSheet` sketch

```dart
class EventMarkerPreviewSheet extends StatelessWidget {
  final EventEntity event;
  const EventMarkerPreviewSheet({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            HorizontalEventCard(
              event: event,
              onTap: () => context.push('${EventDetailsView.routeName}/${event.id}'),
            ),
            const SizedBox(height: 12),
            CustomButton( // reuse core/widgets/custom_button.dart
              text: 'View details',
              onPressed: () => context.push('${EventDetailsView.routeName}/${event.id}'),
            ),
          ],
        ),
      ),
    );
  }
}
```
`HorizontalEventCard` already needs a `FavoritesCubit` in context (it shows a favorite
toggle) — confirm this by checking its full body; if so, wrap the bottom sheet's
`builder` in a `BlocProvider.value(value: getIt<FavoritesCubit>())` the same way
`AppRouter` does for `EventDetailsView`/`SearchView` routes.

## 8. Router wiring

`AppRouter`'s Map branch currently is:
```dart
StatefulShellBranch(
  routes: [
    GoRoute(
      path: MapView.routeName,
      builder: (context, state) => const MapView(),
    ),
  ],
),
```
No change needed here since `MapView` now provisions its own `EventsListCubit`
internally (matches how `ExploreView`'s branch works, where `HomeCubit` is provided at
the route level, vs. how `EventDetailsView` provisions inline). Keep it consistent
with the `ExploreView` branch instead by moving the `BlocProvider` up into the route
`builder`, i.e.:
```dart
GoRoute(
  path: MapView.routeName,
  builder: (context, state) => BlocProvider(
    create: (_) => getIt<EventsListCubit>(param1: EventListMode.nearby)..load(),
    child: const MapView(),
  ),
),
```
and drop the `BlocProvider` from inside `MapView` itself — pick one convention and
apply it consistently; the codebase currently does route-level provisioning for
`ExploreView`, `AllEventsView`, and `ProfileView`, so mirror that.

## 9. Explicit scope cuts (call these out to the reviewer/instructor)

- **No real device GPS.** Map always centers on the same hardcoded NYC point Home
  already uses. A follow-up could add `geolocator`, request
  `NSLocationWhenInUseUsageDescription` (iOS) / `ACCESS_FINE_LOCATION` (Android), and
  feed the real coordinates into both Home's nearby query and this map.
- **No marker clustering.** Fine for `size: 20` results; would need
  `google_maps_cluster_manager` or similar if `size` grows much larger.
- **No "search this area" / re-query on map pan.** The map shows one fixed nearby
  query result; panning/zooming doesn't refetch.

## 10. Step-by-step implementation order

1. Add `google_maps_flutter` to `pubspec.yaml`, run `flutter pub get`.
2. Add the Maps API key to `AndroidManifest.xml` and `AppDelegate.swift` (§4).
3. Build and run once with an empty `GoogleMap()` in `MapView` to confirm the SDK/API
   key setup works before touching any data logic.
4. Wire the route-level `BlocProvider(EventsListCubit, param1: EventListMode.nearby)`
   in `app_router.dart` (§8).
5. Implement `_buildMarkers` + loading/failure states in `MapView` (§6).
6. Implement `EventMarkerPreviewSheet` reusing `HorizontalEventCard` + `CustomButton`
   (§7); confirm `FavoritesCubit` provisioning requirement.
7. Manual QA (§11).

## 11. Manual QA checklist

- [ ] Map tab loads and centers on New York with pins for nearby events.
- [ ] Loading indicator shows briefly on first load.
- [ ] Simulate a network failure (airplane mode) → failure banner shows, no crash.
- [ ] Tap a marker → bottom sheet shows correct event image/title/date/venue.
- [ ] Tap "View details" → navigates to the correct `EventDetailsView` for that event.
- [ ] Favoriting from the preview card's heart icon (if present) reflects correctly
      when later visiting Favorites tab.
- [ ] Events with missing/zero venue coordinates do not produce a marker at `(0,0)`.
- [ ] Works on both Android and iOS builds (API key wired on both platforms).
