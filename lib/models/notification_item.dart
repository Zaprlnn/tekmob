// models/notification_item.dart
class NotificationItem {
  final String title;
  final String message;
  final DateTime timestamp;
  final String? image; // Opsional, jika notifikasi punya gambar

  NotificationItem({
    required this.title,
    required this.message,
    required this.timestamp,
    this.image,
  });
}