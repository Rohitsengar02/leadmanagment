import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dashboard/dashboard_screen.dart';
import 'leads/leads_screen.dart';
import 'pipeline/pipeline_screen.dart';
import 'tasks/tasks_screen.dart';
import 'analytics/analytics_screen.dart';
import 'profile/profile_screen.dart';
import 'premium/ai_tools_screen.dart';
import 'premium/documents_screen.dart';
import '../core/constants/app_colors.dart';

class MainNavigationWrapper extends StatefulWidget {
  const MainNavigationWrapper({super.key});

  @override
  State<MainNavigationWrapper> createState() => _MainNavigationWrapperState();
}

class _MainNavigationWrapperState extends State<MainNavigationWrapper> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    DashboardScreen(),
    const LeadsScreen(),
    const PipelineScreen(),
    const TasksScreen(),
    const AnalyticsScreen(),
    // Profile is navigated via the slider, but we can keep it here if we want direct index access
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // If the index is valid for our main pages list, show it.
    // Otherwise fallback safely.
    Widget displayPage = (_currentIndex >= 0 && _currentIndex < _pages.length)
        ? _pages[_currentIndex]
        : _pages[0];

    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (context, _, _) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: Stack(
            children: [
              displayPage,
              Positioned(
                bottom: 30,
                left: 50,
                right: 50,
                child: _buildFloatingDock(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFloatingDock() {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E).withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildDockItem(0, Icons.home_filled),
          _buildDockItem(1, Icons.people_rounded),
          // Centre Menu Button
          GestureDetector(
            onTap: _showMenuSlider,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.grid_view_rounded,
                color: Colors.black,
                size: 28,
              ),
            ),
          ),
          _buildDockItem(3, Icons.calendar_today_rounded),
          _buildDockItem(5, Icons.person_rounded), // Index 5 is Profile
        ],
      ),
    );
  }

  Widget _buildDockItem(int index, IconData icon) {
    bool isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.white54,
          size: 24,
        ),
      ),
    );
  }

  void _showMenuSlider() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: 380,
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Quick Navigation',
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    _buildMenuItem(Icons.dashboard_rounded, 'Dashboard', 0),
                    _buildMenuItem(Icons.people_alt_rounded, 'Leads', 1),
                    _buildMenuItem(Icons.account_tree_rounded, 'Pipeline', 2),

                    // Row 2
                    _buildMenuItem(Icons.calendar_month_rounded, 'Tasks', 3),
                    _buildMenuItem(Icons.analytics_rounded, 'Analytics', 4),
                    _buildMenuItem(Icons.settings_rounded, 'Settings', 5),

                    // Row 3 (Premium)
                    _buildNavigableMenuItem(
                      Icons.auto_awesome_rounded,
                      'AI Tools',
                      const AiToolsScreen(),
                    ),
                    _buildNavigableMenuItem(
                      Icons.description_rounded,
                      'Documents',
                      const DocumentsScreen(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMenuItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () {
        setState(() => _currentIndex = index);
        Navigator.pop(context);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: _currentIndex == index
                    ? AppColors.primary
                    : Colors.white12,
              ),
            ),
            child: Icon(
              icon,
              color: _currentIndex == index ? AppColors.primary : Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.outfit(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigableMenuItem(
    IconData icon,
    String label,
    Widget destination,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context); // Close the slider
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(
                0xFF2A2A2A,
              ), // Slightly different shade for premium tools
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white12),
            ),
            child: Icon(icon, color: AppColors.primary, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.outfit(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
