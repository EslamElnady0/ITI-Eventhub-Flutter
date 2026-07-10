import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../events/data/entities/event_entity.dart';
import '../events/ui/cubit/events_list/events_list_cubit.dart';
import 'widgets/event_marker_preview_sheet.dart';

class MapView extends StatefulWidget {
  static const String routeName = '/map';
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
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
                const Center(child: CircularProgressIndicator()),
              if (state.status == ListStatus.failure)
                Positioned(
                  top: 16,
                  left: 16,
                  right: 16,
                  child: Card(
                    color: Colors.red.shade100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        state.errorMessage.isNotEmpty ? state.errorMessage : 'Failed to load events',
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Set<Marker> _buildMarkers(BuildContext context, List<EventEntity> events) {
    return events
        .where((e) => e.latitude != 0 && e.longitude != 0)
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
