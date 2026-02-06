import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../core/constants/app_colors.dart';

class LeadDetailsScreen extends StatefulWidget {
  final String name;
  const LeadDetailsScreen({super.key, required this.name});

  @override
  State<LeadDetailsScreen> createState() => _LeadDetailsScreenState();
}

class _LeadDetailsScreenState extends State<LeadDetailsScreen> {
  String _selectedStatus = 'Contacted';
  final List<String> _statuses = [
    'New',
    'Contacted',
    'Qualified',
    'Proposal',
    'Negotiation',
    'Won',
    'Lost',
  ];
  bool _isReminderEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: AnimationLimiter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: AnimationConfiguration.toStaggeredList(
                    duration: const Duration(milliseconds: 375),
                    childAnimationBuilder: (widget) => SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(child: widget),
                    ),
                    children: [
                      const SizedBox(height: 20),
                      _buildLeadScoreCard(),
                      const SizedBox(height: 30),
                      _buildQuickActions(),
                      const SizedBox(height: 30),
                      _buildSectionHeader('Lead Information'),
                      const SizedBox(height: 16),
                      _buildInfoSection(),
                      const SizedBox(height: 30),
                      _buildSectionHeader('Follow-up Planner'),
                      const SizedBox(height: 16),
                      _buildFollowUpSection(),
                      const SizedBox(height: 30),
                      _buildSectionHeader('Notes & Attachments'),
                      const SizedBox(height: 16),
                      _buildNotesSection(),
                      const SizedBox(height: 30),
                      _buildSectionHeader('Engagement History'),
                      const SizedBox(height: 16),
                      _buildTimelineSection(),
                      const SizedBox(height: 120),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomSheet: _buildBottomCTA(),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 280,
      pinned: true,
      backgroundColor: AppColors.background,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: AppColors.textPrimary,
          size: 20,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.edit_outlined, color: AppColors.textPrimary),
          onPressed: () {},
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  'https://i.pravatar.cc/150?u=${widget.name}',
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.name,
                style: GoogleFonts.outfit(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              _buildStatusDropdown(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedStatus,
          dropdownColor: AppColors.surface,
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.primary,
            size: 20,
          ),
          style: GoogleFonts.outfit(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
          onChanged: (String? newValue) {
            setState(() {
              _selectedStatus = newValue!;
            });
          },
          items: _statuses.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildLeadScoreCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                  value: 0.85,
                  strokeWidth: 6,
                  backgroundColor: Colors.white12,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              ),
              Text(
                '85%',
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI Lead Score',
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  'Very high conversion probability',
                  style: GoogleFonts.outfit(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildActionItem(Icons.call_rounded, 'Call', Colors.green),
        _buildActionItem(Icons.chat_rounded, 'WhatsApp', Colors.teal),
        _buildActionItem(Icons.email_rounded, 'Email', Colors.blue),
        _buildActionItem(Icons.note_add_rounded, 'Note', Colors.orange),
      ],
    );
  }

  Widget _buildActionItem(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          _buildInfoRow(Icons.business_rounded, 'Company', 'Acme Corp'),
          _buildInfoDivider(),
          _buildInfoRow(Icons.phone_rounded, 'Phone', '+91 98765 43210'),
          _buildInfoDivider(),
          _buildInfoRow(Icons.email_rounded, 'Email', 'william.b@example.com'),
          _buildInfoDivider(),
          _buildInfoRow(Icons.language_rounded, 'Source', 'LinkedIn'),
          _buildInfoDivider(),
          _buildInfoRow(Icons.attach_money_rounded, 'Budget', '\$12,500'),
          _buildInfoDivider(),
          _buildInfoRow(Icons.flag_rounded, 'Priority', 'High 🔥'),
          _buildInfoDivider(),
          _buildInfoRow(
            Icons.person_outline_rounded,
            'Assigned To',
            'Rohit Patel',
          ),
          _buildInfoDivider(),
          _buildInfoRow(
            Icons.label_outline_rounded,
            'Tags',
            'Tech, High-Value',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: AppColors.textTertiary, size: 20),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 11,
                color: AppColors.textTertiary,
              ),
            ),
            Text(
              value,
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoDivider() => Divider(
    height: 32,
    color: AppColors.textSecondary.withValues(alpha: 0.1),
  );

  Widget _buildFollowUpSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Next Follow-up',
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Tomorrow, 10:30 AM',
                    style: GoogleFonts.outfit(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              Switch(
                value: _isReminderEnabled,
                activeTrackColor: AppColors.primary,
                onChanged: (val) => setState(() => _isReminderEnabled = val),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: _buildTypeButton('Call', Icons.call, true)),
              const SizedBox(width: 12),
              Expanded(child: _buildTypeButton('Meeting', Icons.groups, false)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTypeButton(String label, IconData icon, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : Colors.black26,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.black : AppColors.textSecondary,
            size: 18,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.outfit(
              color: isSelected ? Colors.black : AppColors.textSecondary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineSection() {
    return Column(
      children: [
        _buildTimelineItem(
          'Sent WhatsApp Pitch',
          'Today, 2:00 PM',
          Icons.chat_bubble_rounded,
          Colors.teal,
        ),
        _buildTimelineItem(
          'Updated Status to Proposal',
          'Yesterday, 11:30 AM',
          Icons.swap_horiz_rounded,
          AppColors.primary,
        ),
        _buildTimelineItem(
          'Follow-up Call Made',
          '2 days ago',
          Icons.call_rounded,
          Colors.green,
        ),
        _buildTimelineItem(
          'Lead Captured via LinkedIn',
          'Jan 28, 2024',
          Icons.add_circle_rounded,
          Colors.blue,
        ),
      ],
    );
  }

  Widget _buildTimelineItem(
    String title,
    String time,
    IconData icon,
    Color color,
  ) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 16),
              ),
              Expanded(
                child: Container(
                  width: 1,
                  color: AppColors.textSecondary.withValues(alpha: 0.1),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    time,
                    style: GoogleFonts.outfit(
                      color: AppColors.textTertiary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          _buildNoteItem(
            'Discussed Q4 budget requirements',
            'Yesterday',
            false,
          ),
          Divider(
            height: 24,
            color: AppColors.textSecondary.withValues(alpha: 0.1),
          ),
          _buildNoteItem('Sent initial proposal PDF', 'Jan 28, 2024', true),
          const SizedBox(height: 16),
          _buildAddNoteButton(),
        ],
      ),
    );
  }

  Widget _buildNoteItem(String text, String date, bool isAttachment) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          isAttachment
              ? Icons.attach_file_rounded
              : Icons.sticky_note_2_rounded,
          color: AppColors.textTertiary,
          size: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: GoogleFonts.outfit(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                date,
                style: GoogleFonts.outfit(
                  color: AppColors.textTertiary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAddNoteButton() {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, size: 18, color: AppColors.primary),
            const SizedBox(width: 8),
            Text(
              'Add Note or File',
              style: GoogleFonts.outfit(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        Text(
          title,
          style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildBottomCTA() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      color: AppColors.background,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.black,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        child: Text(
          'Update Lead Status',
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}
