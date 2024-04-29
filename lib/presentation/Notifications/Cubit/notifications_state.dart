
abstract class NotificationsState {}

final class NotificationsInitial extends NotificationsState {}
class NotificationsLoading extends NotificationsState{}
class NotificationsSucced extends NotificationsState {}
class NotificationsError extends NotificationsState {
  final String Error;

  NotificationsError({required this.Error});


}