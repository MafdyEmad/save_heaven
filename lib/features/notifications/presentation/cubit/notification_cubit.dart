import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/features/notifications/data/data_source/models/notification_model.dart';
import 'package:save_heaven/features/notifications/data/data_source/notification_remote_data_source.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRemoteDataSource _notificationRemoteDataSource;
  NotificationCubit(this._notificationRemoteDataSource)
    : super(NotificationInitial());
  void getNotifications() async {
    emit(GetNotificationsLoading());
    final result = await _notificationRemoteDataSource.getNotifications();
    result.fold(
      (error) => emit(GetNotificationsFail(message: error.message)),
      (notifications) =>
          emit(GetNotificationsSuccess(notifications: notifications)),
    );
  }

  void getUnreadNotificationsCount() async {
    emit(GetUnReadNotificationsCountLoading());
    final result = await _notificationRemoteDataSource
        .getUnreadNotificationsCount();
    result.fold(
      (error) => emit(GetUnReadNotificationsCountFail(message: error.message)),
      (count) => emit(GetUnReadNotificationsCountSuccess(count: count)),
    );
  }

  void makeNotificationRead() async {
    await _notificationRemoteDataSource.makeNotationRead();
  }
}
