import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../core/constants/app_colors.dart';
import '../lead_details/lead_details_screen.dart';
import 'create_lead_screen.dart';

class LeadsScreen extends StatefulWidget {
  const LeadsScreen({super.key});

  @override
  State<LeadsScreen> createState() => _LeadsScreenState();
}

class _LeadsScreenState extends State<LeadsScreen> {
  final List<Map<String, String>> leads = [
    {
      'name': 'William Boucher',
      'role': 'Financial Advisor',
      'phone': '(704) 592 0627',
      'email': 'william.b@email.com',
      'image': 'https://i.pravatar.cc/150?u=william',
      'status1': 'Connected',
      'status2': 'Application Approved',
    },
    {
      'name': 'Adriana Williams',
      'role': 'Marketing Director',
      'phone': '(704) 592 0627',
      'email': 'adriana.w@email.com',
      'image': 'https://i.pravatar.cc/150?u=adriana',
      'status1': 'In Progress',
      'status2': 'Application Approved',
    },
    {
      'name': 'James Miller',
      'role': 'Sales Manager',
      'phone': '(704) 592 0627',
      'email': 'james.m@email.com',
      'image': 'https://i.pravatar.cc/150?u=james',
      'status1': 'Qualified',
      'status2': 'Proposal Sent',
    },
    {
      'name': 'Sophia Chen',
      'role': 'Product Manager',
      'phone': '(704) 592 0627',
      'email': 'sophia.c@email.com',
      'image': 'https://i.pravatar.cc/150?u=sophia',
      'status1': 'New Lead',
      'status2': 'Meeting Scheduled',
    },
  ];

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
              _buildCircleIcon(Icons.arrow_back),
              const SizedBox(width: 16),
              Text(
                'Leads (24)',
                style: GoogleFonts.outfit(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Row(
            children: [
              _buildCircleIcon(Icons.search_rounded),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateLeadScreen(),
                    ),
                  );
                },
                child: _buildCircleIcon(Icons.add_rounded),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCircleIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white10),
      ),
      child: Icon(icon, color: Colors.white, size: 24),
    );
  }

  Widget _buildLeadsList() {
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
  }

  Widget _buildLeadCard(Map<String, String> lead) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LeadDetailsScreen(name: lead['name']!),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(35),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(lead['image']!),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lead['name']!,
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        lead['role']!,
                        style: GoogleFonts.outfit(
                          color: Colors.black54,
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
                _buildStatusTag(lead['status1']!, const Color(0xFFF7D5A2)),
                const SizedBox(width: 8),
                _buildStatusTag(lead['status2']!, const Color(0xFFB4C8FF)),
                const Spacer(),
                const Text(
                  '🔥 Hot Lead',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.black,
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
                  const Icon(
                    Icons.call_rounded,
                    color: Colors.black54,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    lead['phone']!,
                    style: GoogleFonts.outfit(
                      color: Colors.black87,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(width: 15),
                  const Icon(
                    Icons.email_rounded,
                    color: Colors.black54,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      lead['email']!,
                      style: GoogleFonts.outfit(
                        color: Colors.black87,
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
                    color: Colors.black45,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(width: 12),
                _buildSourcePill('LinkedIn'),
                const SizedBox(width: 8),
                _buildSourcePill('Dribbble'),
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

  Widget _buildSourcePill(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: GoogleFonts.outfit(color: Colors.black54, fontSize: 11),
      ),
    );
  }
}
