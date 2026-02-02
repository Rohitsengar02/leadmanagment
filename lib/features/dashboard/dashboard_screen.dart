import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/constants/app_colors.dart';
import '../lead_details/lead_details_screen.dart';
import '../leads/create_lead_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: AnimationLimiter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 375),
                childAnimationBuilder: (widget) => SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(child: widget),
                ),
                children: [
                  _buildTopBar(context),
                  const SizedBox(height: 20),
                  _buildLogo(),
                  const SizedBox(height: 30),

                  // Section 1: Top Metrics (Redesigned)
                  _buildSectionHeader('Performance Snapshot'),
                  const SizedBox(height: 16),
                  _buildMetricsWave(),
                  const SizedBox(height: 30),

                  // Original New Leads Section
                  _buildSectionHeader('New Leads'),
                  const SizedBox(height: 16),
                  _buildNewLeadsList(context),
                  const SizedBox(height: 30),

                  // Section 2: Active Pipeline Stages
                  _buildSectionHeader('Active Pipeline'),
                  const SizedBox(height: 16),
                  _buildPipelineStages(),
                  const SizedBox(height: 30),

                  // Original Daily Task Section
                  _buildSectionHeader('Your Daily Task'),
                  const SizedBox(height: 16),
                  _buildTaskFilters(),
                  const SizedBox(height: 16),
                  _buildTaskCard(),
                  const SizedBox(height: 30),

                  // Section 3: AI Conversion Predictor (WOW Section)
                  _buildAIInsightCard(),
                  const SizedBox(height: 30),

                  // Section 4: Team Activity
                  _buildSectionHeader('Team Presence'),
                  const SizedBox(height: 16),
                  _buildTeamActivity(),
                  const SizedBox(height: 30),

                  // Section 5: Lead Source Analysis
                  _buildSectionHeader('Source Insights'),
                  const SizedBox(height: 16),
                  _buildSourceAnalysis(),
                  const SizedBox(height: 30),

                  // Section 6: Revenue Milestone Tracker
                  _buildSectionHeader('Revenue Milestone'),
                  const SizedBox(height: 16),
                  _buildRevenueTracker(),
                  const SizedBox(height: 30),

                  // Section 7: Quick Utility Tools
                  _buildSectionHeader('Utility Tools'),
                  const SizedBox(height: 16),
                  _buildUtilityTools(),

                  const SizedBox(height: 120), // Extra space for dock
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- HEADER & LOGO ---
  Widget _buildTopBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildCircleIconButton(Icons.arrow_back, size: 24),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateLeadScreen(),
                  ),
                );
              },
              child: _buildCircleIconButton(Icons.add, size: 24),
            ),
            const SizedBox(width: 15),
            _buildCircleIconButton(
              Icons.notifications_none_rounded,
              size: 24,
              hasBadge: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCircleIconButton(
    IconData icon, {
    double size = 20,
    bool hasBadge = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white10),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(icon, color: Colors.white, size: size),
          if (hasBadge)
            Positioned(
              right: -2,
              top: -2,
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: AppColors.hotLead,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Row(
      children: [
        Text('W', style: GoogleFonts.outfit(fontSize: 42, color: Colors.white)),
        _buildLogoChar('O', true),
        Text(
          'RKF',
          style: GoogleFonts.outfit(fontSize: 42, color: Colors.white),
        ),
        _buildLogoChar('O', true, dotColor: AppColors.cardBlue),
        Text(
          'RCE',
          style: GoogleFonts.outfit(fontSize: 42, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildLogoChar(String char, bool symbol, {Color? dotColor}) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Text(
          char,
          style: GoogleFonts.outfit(fontSize: 42, color: Colors.white),
        ),
        if (symbol)
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: dotColor ?? AppColors.primary,
                width: 2,
              ),
            ),
            child: Center(
              child: Icon(
                Icons.circle,
                size: 6,
                color: dotColor ?? AppColors.primary,
              ),
            ),
          ),
      ],
    );
  }

  // --- 1. PERFORMANCE SNAPSHOT (METRICS WAVE) ---
  Widget _buildMetricsWave() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: Row(
        children: [
          _buildMetricCard('Total Leads', '1,280', '↑ 12%', AppColors.primary),
          const SizedBox(width: 16),
          _buildMetricCard('Hot Deals', '42', '↑ 5%', AppColors.hotLead),
          const SizedBox(width: 16),
          _buildMetricCard('Closed', '\$45k', '↑ 8%', AppColors.success),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String val, String trend, Color color) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: color.withValues(alpha: 0.1), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.outfit(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            val,
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              trend,
              style: GoogleFonts.outfit(
                color: color,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- 2. ACTIVE PIPELINE STAGES ---
  Widget _buildPipelineStages() {
    final stages = [
      {'name': 'New', 'count': '18', 'color': AppColors.cardBlue},
      {'name': 'Contacted', 'count': '12', 'color': AppColors.primary},
      {'name': 'Negotiating', 'count': '5', 'color': AppColors.cardPurple},
    ];
    return Row(
      children: stages
          .map(
            (s) => Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Text(
                      s['count'] as String,
                      style: GoogleFonts.outfit(
                        color: s['color'] as Color,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      s['name'] as String,
                      style: GoogleFonts.outfit(
                        color: AppColors.textTertiary,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  // --- 3. AI INSIGHT CARD ---
  Widget _buildAIInsightCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [AppColors.surface, Colors.black]),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          const Text('🤖', style: TextStyle(fontSize: 32)),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI Smart Insight',
                  style: GoogleFonts.outfit(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'James Miller is 85% likely to close if you call him before 6 PM today.',
                  style: GoogleFonts.outfit(
                    color: Colors.white70,
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

  // --- 4. TEAM ACTIVITY ---
  Widget _buildTeamActivity() {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        itemCount: 8,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundImage: NetworkImage(
                    'https://i.pravatar.cc/150?u=team$index',
                  ),
                ),
                Positioned(
                  right: 2,
                  bottom: 2,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: index % 3 == 0 ? Colors.green : Colors.orange,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // --- 5. SOURCE ANALYSIS ---
  Widget _buildSourceAnalysis() {
    return Container(
      height: 180,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(30),
      ),
      child: BarChart(
        BarChartData(
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          barGroups: [
            _makeGroupData(0, 15, AppColors.primary),
            _makeGroupData(1, 25, AppColors.cardBlue),
            _makeGroupData(2, 10, AppColors.cardPurple),
            _makeGroupData(3, 20, AppColors.hotLead),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _makeGroupData(int x, double y, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: color,
          width: 30,
          borderRadius: BorderRadius.circular(8),
        ),
      ],
    );
  }

  // --- 6. REVENUE milestones TRACKER ---
  Widget _buildRevenueTracker() {
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
              Text(
                '\$45,280 / \$100k',
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                '45%',
                style: GoogleFonts.outfit(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: 0.45,
              minHeight: 12,
              backgroundColor: Colors.white12,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.primary,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'You are \$54k away from your monthly target.',
            style: GoogleFonts.outfit(
              color: AppColors.textTertiary,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // --- 7. UTILITY TOOLS ---
  Widget _buildUtilityTools() {
    final tools = [
      {'name': 'Export CSV', 'icon': Icons.file_download_outlined},
      {'name': 'Settings', 'icon': Icons.settings_outlined},
      {'name': 'Help Center', 'icon': Icons.help_outline_rounded},
    ];
    return Row(
      children: tools
          .map(
            (t) => Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Icon(t['icon'] as IconData, color: Colors.white70),
                    const SizedBox(height: 8),
                    Text(
                      t['name'] as String,
                      style: GoogleFonts.outfit(
                        color: AppColors.textTertiary,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  // --- ORIGINAL UI BLOCKS (NEW LEADS & TASK) ---
  Widget _buildNewLeadsList(BuildContext context) {
    return SizedBox(
      height: 260,
      child: ListView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        children: [
          _buildLeadCard(
            context,
            'Adriana Williams',
            'Marketing Director',
            const Color(0xFFF7D5A2),
            'https://i.pravatar.cc/150?u=a',
          ),
          const SizedBox(width: 20),
          _buildLeadCard(
            context,
            'William Boucher',
            'Financial Advisor',
            const Color(0xFFB4C8FF),
            'https://i.pravatar.cc/150?u=b',
          ),
          const SizedBox(width: 20),
          _buildLeadCard(
            context,
            'Sophie Turner',
            'Product Owner',
            const Color(0xFFD0B4FF),
            'https://i.pravatar.cc/150?u=c',
          ),
        ],
      ),
    );
  }

  Widget _buildLeadCard(
    BuildContext context,
    String name,
    String role,
    Color color,
    String image,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LeadDetailsScreen(name: name),
          ),
        );
      },
      child: SizedBox(
        width: 190,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            ClipPath(
              clipper: LeadCardClipper(),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: color),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white.withValues(alpha: 0.3),
                      backgroundImage: NetworkImage(image),
                    ),
                    const Spacer(),
                    Text(
                      name,
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      role,
                      style: GoogleFonts.outfit(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      '🔥 Hot Lead',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildSmallPill('LinkedIn'),
                  ],
                ),
              ),
            ),
            Positioned(top: 20, right: -10, child: _buildArrowButton()),
          ],
        ),
      ),
    );
  }

  Widget _buildArrowButton() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white10),
      ),
      child: const Icon(
        Icons.north_east_rounded,
        color: Colors.white,
        size: 16,
      ),
    );
  }

  Widget _buildSmallPill(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: GoogleFonts.outfit(color: Colors.black, fontSize: 10),
      ),
    );
  }

  Widget _buildTaskFilters() {
    final filters = ['All', 'Hot', 'Due Today', 'Overdue'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters
            .map(
              (f) => Container(
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: f == 'All' ? Colors.white : AppColors.surface,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  f,
                  style: GoogleFonts.outfit(
                    color: f == 'All' ? Colors.black : AppColors.textSecondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildTaskCard() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipPath(
          clipper: TaskCardClipper(),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(color: Color(0xFFEBEBEB)),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                    'https://i.pravatar.cc/150?u=johan',
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Johan Carter',
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Chief Operating Officer',
                        style: GoogleFonts.outfit(
                          color: Colors.black54,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(top: 20, right: 0, child: _buildArrowButton()),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Icon(Icons.tune_rounded, color: AppColors.textSecondary, size: 18),
      ],
    );
  }
}

// --- CLIPPERS ---
class LeadCardClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double r = 40;
    path.moveTo(r, 0);
    path.lineTo(size.width - r * 2.5, 0);
    path.quadraticBezierTo(size.width - r, 0, size.width - r, r);
    path.quadraticBezierTo(size.width - r, r * 2, size.width, r * 2);
    path.lineTo(size.width, size.height - r);
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - r,
      size.height,
    );
    path.lineTo(r, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - r);
    path.lineTo(0, r);
    path.quadraticBezierTo(0, 0, r, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class TaskCardClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double r = 40;
    path.moveTo(r, 0);
    path.lineTo(size.width - r * 2, 0);
    path.quadraticBezierTo(size.width - r, 0, size.width - r, r);
    path.quadraticBezierTo(size.width - r, r * 1.5, size.width, r * 1.5);
    path.lineTo(size.width, size.height - r);
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - r,
      size.height,
    );
    path.lineTo(r, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - r);
    path.lineTo(0, r);
    path.quadraticBezierTo(0, 0, r, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
