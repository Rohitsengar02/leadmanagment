import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import 'team_members_screen.dart';
import 'automations_screen.dart';
import 'integrations_screen.dart';
import 'subscription_screen.dart';
import '../notifications/notifications_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Settings',
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildSectionHeader('Workspace'),
            const SizedBox(height: 16),
            _buildSettingsTile(
              context,
              Icons.people_outline_rounded,
              'Team Members',
              'Manage users, roles & permissions',
              const TeamMembersScreen(),
            ),
            _buildSettingsTile(
              context,
              Icons.bolt_rounded,
              'Automations',
              'Workflows & triggers',
              const AutomationsScreen(),
            ),
            _buildSettingsTile(
              context,
              Icons.extension_rounded,
              'Integrations',
              'Slack, Google, Stripe',
              const IntegrationsScreen(),
            ),

            const SizedBox(height: 30),
            _buildSectionHeader('Billing & Plan'),
            const SizedBox(height: 16),
            _buildSettingsTile(
              context,
              Icons.credit_card_rounded,
              'Subscription',
              'Billing history & invoices',
              const SubscriptionScreen(),
            ),

            const SizedBox(height: 30),
            _buildSectionHeader('App Preferences'),
            const SizedBox(height: 16),
            _buildSettingsTile(
              context,
              Icons.notifications_none_rounded,
              'Notification Center',
              'Manage alerts & reminders',
              const NotificationsScreen(),
            ),
            _buildSettingsTile(
              context,
              Icons.security_rounded,
              'Security',
              '2FA & Password',
              // Placeholder for now or lead to a generic screen
              null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: GoogleFonts.outfit(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppColors.textTertiary,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildSettingsTile(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    Widget? destination,
  ) {
    return GestureDetector(
      onTap: () {
        if (destination != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(icon, color: AppColors.primary, size: 24),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.outfit(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textTertiary,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
