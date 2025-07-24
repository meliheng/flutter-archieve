part of 'get_notification_cubit.dart';

@immutable
sealed class GetNotificationState {}

final class GetNotificationInitial extends GetNotificationState {}

final class GetNotificationLoading extends GetNotificationState {}

final class GetNotificationLoaded extends GetNotificationState {
  final List<NotificationModel> notifications;
  final Map<String, List<NotificationModel>> groupedNotifications;
  final bool isEditMode;
  final Set<int> selectedIndices;

  GetNotificationLoaded({
    required this.notifications,
    required this.groupedNotifications,
    this.isEditMode = false,
    this.selectedIndices = const <int>{},
  });
}

final class GetNotificationError extends GetNotificationState {
  final String message;

  GetNotificationError(this.message);
}
