class NotificationModel {
  final String? title;
  final String? body;

  NotificationModel({required this.title, required this.body});

  static NotificationModel emptyNotification() {
    return NotificationModel(title: '', body: '');
  }

  factory NotificationModel.fromNotificationMap(Map<String, dynamic> map) {
    return NotificationModel(title: map['title'], body: map['body']);
  }
}
