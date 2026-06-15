import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/app_failure.dart';
import '../../../data/entities/event_entity.dart';
import '../../../data/repos/events_repository.dart';

part 'event_details_state.dart';

class EventDetailsCubit extends Cubit<EventDetailsState> {
  EventDetailsCubit(this._repository) : super(const EventDetailsState());

  final EventsRepository _repository;

  Future<void> load(String eventId) async {
    emit(const EventDetailsState(status: DetailsStatus.loading));
    try {
      final event = await _repository.getEventDetails(eventId);
      emit(EventDetailsState(status: DetailsStatus.success, event: event));
    } on AppFailure catch (failure) {
      emit(
        EventDetailsState(
          status: DetailsStatus.failure,
          errorMessage: failure.message,
        ),
      );
    }
  }
}
