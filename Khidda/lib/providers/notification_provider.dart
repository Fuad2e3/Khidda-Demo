import 'package:flutter/material.dart';

enum NotificationType { promotion, order, system }

class NotificationModel {
  final String id;
  final String title;
  final String message;
  final DateTime timestamp;
  final NotificationType type;
  bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    required this.type,
    this.isRead = false,
  });
}

class NotificationProvider with ChangeNotifier {
  final List<NotificationModel> _notifications = [
    NotificationModel(
      id: '1',
      title: '20% OFF! Special Deal',
      message: 'Use code KHIDDA20 on your next order of Beef Biryani.',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      type: NotificationType.promotion,
    ),
    NotificationModel(
      id: '2',
      title: 'Order Delivered',
      message: 'Your order #12345 has been successfully delivered. Enjoy!',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      type: NotificationType.order,
    ),
    NotificationModel(
      id: '3',
      title: 'Welcome to Khidda',
      message: 'Discover the authentic taste of Bangladesh right here in Canada.',
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      type: NotificationType.system,
    ),
  ];

  List<NotificationModel> get notifications => [..._notifications];

  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  void markAsRead(String id) {
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      _notifications[index].isRead = true;
      notifyListeners();
    }
  }

  void markAllAsRead() {
    for (var n in _notifications) {
      n.isRead = true;
    }
    notifyListeners();
  }

  void clearAll() {
    _notifications.clear();
    notifyListeners();
  }
}
