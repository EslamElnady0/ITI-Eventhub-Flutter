import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failure_guard.dart';
import '../../../../auth/data/repos/auth_repository.dart';
import '../../../data/entities/event_entity.dart';
import '../../../data/repos/events_repository.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit(this._eventsRepository, this._authRepository)
    : super(const FavoritesState());

  final EventsRepository _eventsRepository;
  final AuthRepository _authRepository;

  Future<void> load() async {
    emit(state.copyWith(status: FavoritesStatus.loading, errorMessage: ''));
    await FailureGuard.handle(
      () async {
        switch (await _authRepository.getCurrentUser()) {
          case null:
            return const <EventEntity>[];
          case final user:
            return _eventsRepository.getFavoriteEvents(user.id);
        }
      },
      onSuccess: (events) {
        final ids = events.map((event) => event.id).toSet();
        emit(
          state.copyWith(
            status: FavoritesStatus.success,
            favoriteIds: ids,
            events: events,
          ),
        );
      },
      onFailure: (failure) {
        emit(
          state.copyWith(
            status: FavoritesStatus.failure,
            errorMessage: failure.message,
          ),
        );
      },
    );
  }

  Future<void> toggle(EventEntity event) async {
    await FailureGuard.handle(
      _authRepository.getCurrentUser,
      onSuccess: (user) async {
        switch (user) {
          case null:
            emit(
              state.copyWith(
                status: FavoritesStatus.failure,
                errorMessage: 'Please sign in to save events.',
              ),
            );
          default:
            await _toggleForUser(user.id, event);
        }
      },
      onFailure: (failure) {
        emit(
          state.copyWith(
            status: FavoritesStatus.failure,
            errorMessage: failure.message,
          ),
        );
      },
    );
  }

  Future<void> _toggleForUser(String userId, EventEntity event) async {
    final wasFavorite = state.favoriteIds.contains(event.id);
    final previousIds = {...state.favoriteIds};
    final previousEvents = [...state.events];
    final nextIds = {...state.favoriteIds};
    final nextEvents = [...state.events];

    switch (wasFavorite) {
      case true:
        nextIds.remove(event.id);
        nextEvents.removeWhere((item) => item.id == event.id);
      case false:
        nextIds.add(event.id);
        nextEvents.removeWhere((item) => item.id == event.id);
        nextEvents.insert(0, event);
    }

    emit(
      state.copyWith(
        status: FavoritesStatus.success,
        favoriteIds: nextIds,
        events: nextEvents,
        errorMessage: '',
      ),
    );

    await FailureGuard.handle(
      () => wasFavorite
          ? _eventsRepository.removeFavoriteEvent(
              userId: userId,
              eventId: event.id,
            )
          : _eventsRepository.addFavoriteEvent(userId: userId, event: event),
      onSuccess: (_) {},
      onFailure: (failure) async {
        emit(
          state.copyWith(
            status: FavoritesStatus.failure,
            favoriteIds: previousIds,
            events: previousEvents,
            errorMessage: failure.message,
          ),
        );
        await load();
      },
    );
  }
}
