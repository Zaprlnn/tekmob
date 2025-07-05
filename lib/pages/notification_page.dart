import 'package:flutter/material.dart';
import 'package:flutter_ui_coffee_shop_2/common/app_colors.dart';
import 'package:flutter_ui_coffee_shop_2/models/notification_item.dart';
import 'package:flutter_ui_coffee_shop_2/pages/dashboard_page.dart';
import 'package:flutter_ui_coffee_shop_2/providers/notification_provider.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg_hagia.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                const Gap(24),
                Expanded(
                  child: Consumer<NotificationProvider>(
                    builder: (context, provider, child) {
                      if (provider.notifications.isEmpty) {
                        return _buildEmptyState();
                      }
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        itemCount: provider.notifications.length,
                        itemBuilder: (context, index) {
                          final notification = provider.notifications[index];
                          // DIUBAH: Membungkus item dengan Dismissible
                          return Dismissible(
                            key: Key(notification.timestamp.toIso8601String()), // Key unik
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              // Aksi menghapus notifikasi
                              provider.removeNotificationAt(index);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Notifikasi "${notification.title}" dihapus.'),
                                ),
                              );
                            },
                            background: _buildDismissibleBackground(),
                            child: _buildNotificationItem(notification),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  // Widget untuk background saat item di-swipe
  Widget _buildDismissibleBackground() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 240, 240, 240),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Align(
        alignment: Alignment.centerRight,
        child: Icon(Icons.delete_outline, color: Color.fromARGB(255, 20, 58, 5)),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 24, 0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => DashboardPage()),
                (Route<dynamic> route) => false,
              );
            },
          ),
          const Gap(8),
          Text(
            'Notifications',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(NotificationItem notification) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF0E391F),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                notification.image ?? 'assets/images/logo2.png',
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const Gap(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(4),
                  Text(
                    notification.message,
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Gap(8),
            Text(
              DateFormat('HH:mm').format(notification.timestamp),
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.white54),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_off_outlined,
              size: 80, color: Colors.white.withAlpha(150)),
          const Gap(16),
          Text(
            'No Notifications Yet',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(8),
          Text(
            "You'll see notifications about your account\nand favorite items here.",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }
}