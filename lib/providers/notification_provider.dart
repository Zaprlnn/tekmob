import 'package:flutter/material.dart';
import 'package:flutter_ui_coffee_shop_2/models/notification_item.dart';

class NotificationProvider extends ChangeNotifier {
  final List<NotificationItem> _notifications = [];
  List<NotificationItem> get notifications => _notifications;

  void addNotification({required String title, required String message, String? image}) {
    _notifications.insert(0, NotificationItem(
      title: title,
      message: message,
      timestamp: DateTime.now(),
      image: image,
    ));
    notifyListeners();
  }

  // DIUBAH: Menambahkan fungsi untuk menghapus notifikasi
  void removeNotificationAt(int index) {
    if (index >= 0 && index < _notifications.length) {
      _notifications.removeAt(index);
      notifyListeners();
    }
  }
}