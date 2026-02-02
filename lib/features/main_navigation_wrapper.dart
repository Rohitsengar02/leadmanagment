import 'package:flutter/material.dart';
import 'dashboard/dashboard_screen.dart';
import 'leads/leads_screen.dart';
import 'pipeline/pipeline_screen.dart';
import 'tasks/tasks_screen.dart';
import 'analytics/analytics_screen.dart';
import '../core/constants/app_colors.dart';

class MainNavigationWrapper extends StatefulWidget {
  const MainNavigationWrapper({super.key});

  @override
  State<MainNavigationWrapper> createState() => _MainNavigationWrapperState();
}

class _MainNavigationWrapperState extends State<MainNavigationWrapper> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const DashboardScreen(),
    const LeadsScreen(),
    const PipelineScreen(),
    const TasksScreen(),
    const AnalyticsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          _pages[_currentIndex],
          Positioned(
            bottom: 30,
            left: 50,
            right: 50,
            child: _buildFloatingDock(),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingDock() {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E).withOpacity(0.9),
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
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
          _buildDockItem(2, Icons.account_tree_rounded),
          _buildDockItem(3, Icons.calendar_today_rounded),
          _buildDockItem(4, Icons.analytics_rounded),
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
          color: isSelected ? AppColors.primary : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.black : Colors.white54,
          size: 24,
        ),
      ),
    );
  }
}
