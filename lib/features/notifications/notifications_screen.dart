import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.textPrimary,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Notifications',
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.playlist_add_check_rounded,
              color: AppColors.textTertiary,
            ),
            tooltip: 'Mark all as read',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSectionHeader('Today'),
          const SizedBox(height: 12),
          _buildNotificationItem(
            'New Lead Assigned',
            'You have been assigned to "Sarah Connors" from LinkedIn campaign.',
            '2 mins ago',
            Icons.person_add_rounded,
            Colors.blueAccent,
            true,
          ),
          _buildNotificationItem(
            'Task Reminder',
            'Call with John Doe is starting in 15 minutes.',
            '1 h ago',
            Icons.access_time_filled_rounded,
            Colors.orangeAccent,
            true,
          ),

          const SizedBox(height: 30),
          _buildSectionHeader('Earlier'),
          const SizedBox(height: 12),
          _buildNotificationItem(
            'Deal Won! 🎉',
            'Big win! The deal with "TechCorp" was moved to Closed Won.',
            'Yesterday',
            Icons.emoji_events_rounded,
            AppColors.primary,
            false,
          ),
          _buildNotificationItem(
            'System Update',
            'We have updated our privacy policy. Please review the changes.',
            '2 days ago',
            Icons.security_rounded,
            Colors.grey,
            false,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: GoogleFonts.outfit(
        color: AppColors.textTertiary,
        fontWeight: FontWeight.bold,
        fontSize: 13,
        letterSpacing: 1,
      ),
    );
  }

  Widget _buildNotificationItem(
    String title,
    String body,
    String time,
    IconData icon,
    Color color,
    bool isUnread,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isUnread ? AppColors.surface : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: isUnread
            ? null
            : Border.all(color: AppColors.textSecondary.withValues(alpha: 0.1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.outfit(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      time,
                      style: GoogleFonts.outfit(
                        color: AppColors.textTertiary,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: GoogleFonts.outfit(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          if (isUnread)
            Container(
              margin: const EdgeInsets.only(left: 8, top: 20),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}
