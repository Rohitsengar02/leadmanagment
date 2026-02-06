import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../core/constants/app_colors.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

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
                  _buildHeader(),
                  const SizedBox(height: 24),
                  _buildHeroRevenueSection(),
                  const SizedBox(height: 30),
                  _buildSectionHeader('Key Performance Indicators'),
                  const SizedBox(height: 16),
                  _buildMetricGrid(),
                  const SizedBox(height: 30),
                  _buildChartCard('Revenue Growth Trend', _buildLineChart()),
                  const SizedBox(height: 30),
                  _buildSourceBreakdown(),
                  const SizedBox(height: 30),
                  _buildChartCard('Leads Distribution', _buildPieChart()),
                  const SizedBox(height: 30),
                  _buildTopReferralsList(),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Performance Analytics',
              style: GoogleFonts.outfit(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              'Insights from the last 30 days',
              style: GoogleFonts.outfit(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        _buildCircleIconButton(Icons.ios_share_rounded),
      ],
    );
  }

  Widget _buildCircleIconButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.textPrimary.withValues(alpha: 0.1)),
      ),
      child: Icon(icon, color: AppColors.textPrimary, size: 20),
    );
  }

  Widget _buildHeroRevenueSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.8),
            AppColors.primary.withValues(alpha: 0.5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(35),
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
                    'Total Revenue',
                    style: GoogleFonts.outfit(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    '\$128,430.00',
                    style: GoogleFonts.outfit(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.show_chart_rounded,
                  color: Colors.black,
                  size: 24,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildRevenueSubMetric(
                  'Net Profit',
                  '\$42.8k',
                  Icons.arrow_upward_rounded,
                  Colors.greenAccent,
                ),
                Container(width: 1, height: 40, color: Colors.black12),
                _buildRevenueSubMetric(
                  'Expenses',
                  '\$85.6k',
                  Icons.arrow_downward_rounded,
                  Colors.black87,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRevenueSubMetric(
    String label,
    String value,
    IconData icon,
    Color iconColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: iconColor, size: 14),
            const SizedBox(width: 4),
            Text(
              label,
              style: GoogleFonts.outfit(
                color: Colors.black45,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Text(
          value,
          style: GoogleFonts.outfit(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  Widget _buildMetricGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.2,
      children: [
        _buildMetricCard(
          'Conversion Rate',
          '18.2%',
          '+2.4%',
          Icons.auto_graph_rounded,
          Colors.cyanAccent,
        ),
        _buildMetricCard(
          'Lead Volume',
          '432',
          '+12%',
          Icons.people_outline_rounded,
          Colors.orangeAccent,
        ),
        _buildMetricCard(
          'Avg. Deal Size',
          '\$4.5k',
          '+\$1.2k',
          Icons.payments_outlined,
          Colors.purpleAccent,
        ),
        _buildMetricCard(
          'Sales Velocity',
          '12 Days',
          '-2 Days',
          Icons.bolt_rounded,
          Colors.pinkAccent,
        ),
      ],
    );
  }

  Widget _buildMetricCard(
    String title,
    String value,
    String trend,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 20),
              Text(
                trend,
                style: GoogleFonts.outfit(
                  color: trend.contains('+')
                      ? Colors.greenAccent
                      : Colors.redAccent,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: GoogleFonts.outfit(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                title,
                style: GoogleFonts.outfit(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSourceBreakdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Lead Sources'),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            children: [
              _buildSourceRow('LinkedIn Ads', 0.65, AppColors.primary),
              const SizedBox(height: 16),
              _buildSourceRow('Direct Referral', 0.45, Colors.blueAccent),
              const SizedBox(height: 16),
              _buildSourceRow('Google Search', 0.30, Colors.purpleAccent),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSourceRow(String label, double progress, Color color) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: GoogleFonts.outfit(
                color: AppColors.textPrimary.withValues(alpha: 0.7),
                fontSize: 13,
              ),
            ),
            Text(
              '${(progress * 100).toInt()}%',
              style: GoogleFonts.outfit(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.white.withOpacity(0.05),
          valueColor: AlwaysStoppedAnimation<Color>(color),
          borderRadius: BorderRadius.circular(10),
          minHeight: 6,
        ),
      ],
    );
  }

  Widget _buildTopReferralsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Top Performers'),
        const SizedBox(height: 16),
        ...List.generate(3, (index) => _buildPerformerCard(index)),
      ],
    );
  }

  Widget _buildPerformerCard(int index) {
    final names = ['Alex Johnson', 'Sarah Wilson', 'Mike Ross'];
    final roles = ['Regional Sales', 'Account Exec.', 'Lead Gen'];
    final revenue = ['\$42k', '\$38k', '\$31k'];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
              'https://i.pravatar.cc/150?u=perf$index',
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  names[index],
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  roles[index],
                  style: GoogleFonts.outfit(
                    color: AppColors.textTertiary,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Text(
            revenue[index],
            style: GoogleFonts.outfit(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: GoogleFonts.outfit(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildChartCard(String title, Widget chart) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(35),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(height: 200, child: chart),
        ],
      ),
    );
  }

  Widget _buildLineChart() {
    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: false),
        titlesData: const FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: const [
              FlSpot(0, 3),
              FlSpot(2, 2.5),
              FlSpot(4, 5.5),
              FlSpot(6, 4),
              FlSpot(8, 6),
              FlSpot(10, 5),
              FlSpot(11, 7),
            ],
            isCurved: true,
            color: AppColors.primary,
            barWidth: 6,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withOpacity(0.2),
                  AppColors.primary.withOpacity(0.0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPieChart() {
    return PieChart(
      PieChartData(
        sectionsSpace: 6,
        centerSpaceRadius: 40,
        sections: [
          PieChartSectionData(
            color: AppColors.primary,
            value: 40,
            title: '',
            radius: 50,
          ),
          PieChartSectionData(
            color: Colors.blueAccent,
            value: 30,
            title: '',
            radius: 55,
          ),
          PieChartSectionData(
            color: Colors.purpleAccent,
            value: 30,
            title: '',
            radius: 50,
          ),
        ],
      ),
    );
  }
}
