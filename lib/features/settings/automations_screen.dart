import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';

class AutomationsScreen extends StatelessWidget {
  const AutomationsScreen({super.key});

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
          'Automations',
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add_rounded, color: AppColors.primary),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildAutomationCard(
            'Welcome Email Sequence',
            'Trigger: New Lead Value > \$5000',
            'Action: Send Email Template #3',
            true,
          ),
          _buildAutomationCard(
            'High Priority Alert',
            'Trigger: Deal Stage = Closed Won',
            'Action: Notify Manager via Slack',
            true,
          ),
          _buildAutomationCard(
            'Inactive Lead archive',
            'Trigger: No Activity > 30 Days',
            'Action: Change Status to Lost',
            false,
          ),
        ],
      ),
    );
  }

  Widget _buildAutomationCard(
    String title,
    String trigger,
    String action,
    bool isActive,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isActive
              ? AppColors.primary.withValues(alpha: 0.3)
              : Colors.white.withValues(alpha: 0.05),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              Switch(
                value: isActive,
                onChanged: (val) {},
                activeThumbColor: AppColors.primary,
                activeTrackColor: AppColors.primary.withValues(alpha: 0.3),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildFlowStep(Icons.flash_on_rounded, trigger),
          _buildFlowLine(),
          _buildFlowStep(Icons.send_rounded, action),
        ],
      ),
    );
  }

  Widget _buildFlowStep(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: AppColors.textTertiary, size: 16),
        const SizedBox(width: 8),
        Text(
          text,
          style: GoogleFonts.outfit(
            color: AppColors.textSecondary,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _buildFlowLine() {
    return Container(
      margin: const EdgeInsets.only(left: 7, top: 4, bottom: 4),
      height: 12,
      width: 2,
      color: Colors.white12,
    );
  }
}
