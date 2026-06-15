part of 'event_details_cubit.dart';

enum DetailsStatus { initial, loading, success, failure }

class EventDetailsState extends Equatable {
  const EventDetailsState({
    this.status = DetailsStatus.initial,
    this.event,
    this.errorMessage = '',
  });

  final DetailsStatus status;
  final EventEntity? event;
  final String errorMessage;

  @override
  List<Object?> get props => [status, event, errorMessage];
}
