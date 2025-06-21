part of 'notification_cubit.dart';

sealed class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

final class NotificationInitial extends NotificationState {}

//? GET NOTIFICATIONS
final class GetNotificationsLoading extends NotificationState {}

final class GetNotificationsSuccess extends NotificationState {
  final List<NotificationModel> notifications;

  const GetNotificationsSuccess({required this.notifications});
}

final class GetNotificationsFail extends NotificationState {
  final String message;

  const GetNotificationsFail({required this.message});
}
