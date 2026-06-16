import 'dart:developer' as developer;

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/ui/cubit/auth_cubit.dart';
import '../../features/events/ui/cubit/details/event_details_cubit.dart';
import '../../features/events/ui/cubit/events_list/events_list_cubit.dart';
import '../../features/events/ui/cubit/favorites/favorites_cubit.dart';
import '../../features/events/ui/cubit/search/search_cubit.dart';
import '../../features/home/ui/cubit/home_cubit.dart';
import '../../features/profile/ui/cubit/profile_cubit.dart';

part 'app_bloc_observer_formatter.dart';

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
    developer.log(
      'State: ${formatState(change.nextState)}',
      name: bloc.runtimeType.toString(),
    );
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
