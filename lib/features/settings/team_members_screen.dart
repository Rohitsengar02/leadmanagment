import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';

class TeamMembersScreen extends StatelessWidget {
  const TeamMembersScreen({super.key});

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
          'Team Members',
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.person_add_alt_1_rounded,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildMemberCard(
            'Rohit Patel',
            'Lead Manager',
            'Admin',
            'https://i.pravatar.cc/150?u=rohit',
            true,
          ),
          _buildMemberCard(
            'Sarah Wilson',
            'Sales Executive',
            'Member',
            'https://i.pravatar.cc/150?u=sarah',
            false,
          ),
          _buildMemberCard(
            'Mike Ross',
            'Lead Gen Specialist',
            'Member',
            'https://i.pravatar.cc/150?u=mike',
            false,
          ),
          _buildMemberCard(
            'Jessica Pearson',
            'Account Manager',
            'Manager',
            'https://i.pravatar.cc/150?u=jessica',
            false,
          ),
        ],
      ),
    );
  }

  Widget _buildMemberCard(
    String name,
    String role,
    String accessLevel,
    String imageUrl,
    bool isOnline,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.textPrimary.withValues(alpha: 0.05),
        ),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(radius: 24, backgroundImage: NetworkImage(imageUrl)),
              if (isOnline)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.surface, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  role,
                  style: GoogleFonts.outfit(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: accessLevel == 'Admin'
                  ? AppColors.primary.withValues(alpha: 0.2)
                  : AppColors.textSecondary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              accessLevel,
              style: GoogleFonts.outfit(
                color: accessLevel == 'Admin'
                    ? AppColors.primary
                    : AppColors.textSecondary,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
