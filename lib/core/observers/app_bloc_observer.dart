import 'dart:developer' as developer;

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/events/ui/cubit/details/event_details_cubit.dart';
import '../../features/events/ui/cubit/events_list/events_list_cubit.dart';
import '../../features/events/ui/cubit/search/search_cubit.dart';
import '../../features/home/ui/cubit/home_cubit.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    developer.log('Created', name: bloc.runtimeType.toString());
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    developer.log('Closed', name: bloc.runtimeType.toString());
    super.onClose(bloc);
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);

    developer.log(
      '${change.currentState.runtimeType} -> ${change.nextState.runtimeType}',
      name: bloc.runtimeType.toString(),
    );

    final nextState = change.nextState;
    if (nextState is HomeState && nextState.status == HomeStatus.success) {
      final total =
          nextState.upcomingEvents.length + nextState.nearbyEvents.length;
      developer.log(
        'Events loaded: $total '
        '(upcoming: ${nextState.upcomingEvents.length}, '
        'nearby: ${nextState.nearbyEvents.length})',
        name: bloc.runtimeType.toString(),
      );
    } else if (nextState is EventsListState &&
        nextState.status == ListStatus.success &&
        nextState.errorMessage.isEmpty) {
      developer.log(
        'Events loaded: ${nextState.events.length}',
        name: bloc.runtimeType.toString(),
      );
    } else if (nextState is SearchState &&
        nextState.status == SearchStatus.success &&
        nextState.errorMessage.isEmpty) {
      developer.log(
        'Events loaded: ${nextState.events.length}',
        name: bloc.runtimeType.toString(),
      );
    } else if (nextState is EventDetailsState &&
        nextState.status == DetailsStatus.success &&
        nextState.event != null) {
      developer.log('Events loaded: 1', name: bloc.runtimeType.toString());
    }
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    developer.log(
      error.toString(),
      name: bloc.runtimeType.toString(),
      error: error,
      stackTrace: stackTrace,
    );
    super.onError(bloc, error, stackTrace);
  }
}
