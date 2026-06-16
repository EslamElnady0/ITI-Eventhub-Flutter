import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/failure_guard.dart';
import '../../data/entities/home_category_entity.dart';
import '../../data/entities/home_event_entity.dart';
import '../../data/repos/home_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._repository) : super(const HomeState());

  final HomeRepository _repository;

  Future<void> load() async {
    emit(state.copyWith(status: HomeStatus.loading, errorMessage: ''));
    await FailureGuard.handle(
      _repository.getHomeData,
      onSuccess: (data) {
        emit(
          state.copyWith(
            status: HomeStatus.success,
            categories: data.categories,
            upcomingEvents: data.upcomingEvents,
            nearbyEvents: data.nearbyEvents,
          ),
        );
      },
      onFailure: (failure) {
        emit(
          state.copyWith(
            status: HomeStatus.failure,
            errorMessage: failure.message,
          ),
        );
      },
    );
  }
}
