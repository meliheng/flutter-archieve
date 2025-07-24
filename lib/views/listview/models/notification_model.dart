class NotificationModel {
  final String title;
  final String message;
  final DateTime timestamp;

  NotificationModel({
    required this.title,
    required this.message,
    required this.timestamp,
  });

  @override
  String toString() {
    return 'NotificationModel(title: $title, message: $message, timestamp: $timestamp)';
  }

  static List<NotificationModel> get notifications {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final dayBeforeYesterday = today.subtract(const Duration(days: 2));
    
    return [
      NotificationModel(
        title: 'New Message',
        message: 'You have received a new message.',
        timestamp: today.add(const Duration(hours: 9)),
      ),
      NotificationModel(
        title: 'Update Available',
        message: 'A new update is available for download.',
        timestamp: today.add(const Duration(hours: 14)),
      ),
      NotificationModel(
        title: 'Reminder',
        message: 'Don\'t forget your appointment tomorrow.',
        timestamp: yesterday.add(const Duration(hours: 10)),
      ),
      NotificationModel(
        title: 'Alert',
        message: 'There is an alert in your area.',
        timestamp: yesterday.add(const Duration(hours: 16)),
      ),
      NotificationModel(
        title: 'System Notification',
        message: 'Your system will restart in 5 minutes.',
        timestamp: dayBeforeYesterday.add(const Duration(hours: 8)),
      ),
      NotificationModel(
        title: 'Meeting Reminder',
        message: 'Team meeting in 15 minutes.',
        timestamp: today.add(const Duration(hours: 11)),
      ),
      NotificationModel(
        title: 'Weather Alert',
        message: 'Heavy rain expected in your area.',
        timestamp: yesterday.add(const Duration(hours: 7)),
      ),
      NotificationModel(
        title: 'App Update',
        message: 'WhatsApp has been updated to version 2.23.4.',
        timestamp: dayBeforeYesterday.add(const Duration(hours: 12)),
      ),
    ];
  }
}