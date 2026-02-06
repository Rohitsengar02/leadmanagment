import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../core/constants/app_colors.dart';
import '../../core/models/lead_model.dart';
import '../../core/services/lead_service.dart';
import '../lead_details/lead_details_screen.dart';
import 'create_lead_screen.dart';

class LeadsScreen extends StatefulWidget {
  const LeadsScreen({super.key});

  @override
  State<LeadsScreen> createState() => _LeadsScreenState();
}

class _LeadsScreenState extends State<LeadsScreen> {
  final LeadService _leadService = LeadService();
  late Future<List<Lead>> _leadsFuture;

  @override
  void initState() {
    super.initState();
    _refreshLeads();
  }

  void _refreshLeads() {
    setState(() {
      _leadsFuture = _leadService.getLeads();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(child: _buildLeadsList()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _buildCircleIcon(
                Icons.arrow_back,
                onTap: () => Navigator.pop(context),
              ),
              const SizedBox(width: 16),
              FutureBuilder<List<Lead>>(
                future: _leadsFuture,
                builder: (context, snapshot) {
                  final count = snapshot.hasData ? snapshot.data!.length : 0;
                  return Text(
                    'Leads ($count)',
                    style: GoogleFonts.outfit(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  );
                },
              ),
            ],
          ),
          Row(
            children: [
              _buildCircleIcon(Icons.search_rounded),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () => _showAddOptions(context),
                child: _buildCircleIcon(Icons.add_rounded),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCircleIcon(IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.surface,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white10),
        ),
        child: Icon(icon, color: AppColors.textPrimary, size: 24),
      ),
    );
  }

  Widget _buildLeadsList() {
    return FutureBuilder<List<Lead>>(
      future: _leadsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: GoogleFonts.outfit(color: AppColors.hotLead),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              'No leads found',
              style: GoogleFonts.outfit(color: AppColors.textSecondary),
            ),
          );
        }

        final leads = snapshot.data!;

        return AnimationLimiter(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            itemCount: leads.length,
            itemBuilder: (context, index) {
              final lead = leads[index];
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(child: _buildLeadCard(lead)),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildLeadCard(Lead lead) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LeadDetailsScreen(name: lead.name),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(35),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                    'https://i.pravatar.cc/150?u=${lead.name}',
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lead.name,
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        lead.company ?? 'Unknown Company',
                        style: GoogleFonts.outfit(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.north_east_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildStatusTag(lead.status, const Color(0xFFF7D5A2)),
                const SizedBox(width: 8),
                _buildStatusTag(lead.priority, const Color(0xFFB4C8FF)),
                const Spacer(),
                if (lead.priority == 'Urgent 🔥')
                  Text(
                    '🔥 Hot Lead',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: AppColors.textPrimary,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.call_rounded,
                    color: AppColors.textSecondary,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    lead.phone ?? 'N/A',
                    style: GoogleFonts.outfit(
                      color: AppColors.textPrimary,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Icon(
                    Icons.email_rounded,
                    color: AppColors.textSecondary,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      lead.email ?? 'N/A',
                      style: GoogleFonts.outfit(
                        color: AppColors.textPrimary,
                        fontSize: 13,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'Source',
                  style: GoogleFonts.outfit(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(width: 12),
                _buildSourcePill(lead.source),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: GoogleFonts.outfit(
          color: color.withValues(alpha: 1.0),
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _showAddOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add New Lead',
              style: GoogleFonts.outfit(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 20),
            _buildOptionItem(
              Icons.edit_note_rounded,
              'Manual Entry',
              'Fill in lead details manually',
              () async {
                Navigator.pop(context);
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateLeadScreen(),
                  ),
                );
                if (result == true) {
                  _refreshLeads();
                }
              },
            ),
            _buildOptionItem(
              Icons.upload_file_rounded,
              'Import CSV / Excel',
              'Bulk upload leads from file',
              () {
                Navigator.pop(context);
                // Mock import action
              },
            ),
            _buildOptionItem(
              Icons.camera_enhance_rounded,
              'Scan Business Card',
              'Use OCR to extract details',
              () {
                Navigator.pop(context);
                // Mock camera action
              },
            ),
            _buildOptionItem(
              Icons.qr_code_scanner_rounded,
              'Scan QR Code',
              'Capture lead from QR',
              () {
                Navigator.pop(context);
                // Mock QR action
              },
            ),
            _buildOptionItem(
              Icons.web_rounded,
              'Website Form / Ads',
              'Integrate with online sources',
              () {
                Navigator.pop(context);
                // Mock integration dialog
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionItem(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.primary, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: AppColors.textTertiary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSourcePill(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.textTertiary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: GoogleFonts.outfit(color: AppColors.textSecondary, fontSize: 11),
      ),
    );
  }
}
