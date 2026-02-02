import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../core/constants/app_colors.dart';
import 'create_task_screen.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  bool _isCalendarExpanded = false;
  DateTime _selectedDate = DateTime(2024, 9, 6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildCalendarDropdown(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTimeColumn(),
                    const SizedBox(width: 20),
                    Expanded(child: _buildScheduleArea()),
                  ],
                ),
              ),
            ),
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
                size: 24,
                onTap: () => Navigator.pop(context),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Day Schedule',
                    style: GoogleFonts.outfit(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '${_selectedDate.day} September, 2024',
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              _buildCircleIcon(
                Icons.calendar_today_rounded,
                size: 20,
                color: _isCalendarExpanded ? AppColors.primary : Colors.white,
                onTap: () {
                  setState(() {
                    _isCalendarExpanded = !_isCalendarExpanded;
                  });
                },
              ),
              const SizedBox(width: 12),
              _buildCircleIcon(
                Icons.add_rounded,
                size: 24,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CreateTaskScreen(initialDate: _selectedDate),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarDropdown() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.fastOutSlowIn,
      height: _isCalendarExpanded ? 340 : 0,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: _isCalendarExpanded ? 20 : 0),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white10),
      ),
      clipBehavior: Clip.antiAlias,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'September 2024',
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.chevron_left_rounded,
                        color: Colors.white54,
                      ),
                      const SizedBox(width: 10),
                      const Icon(
                        Icons.chevron_right_rounded,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildCalendarGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final days = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: days
                .map(
                  (d) => Text(
                    d,
                    style: GoogleFonts.outfit(
                      color: AppColors.textTertiary,
                      fontSize: 12,
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
            ),
            itemCount: 31,
            itemBuilder: (context, index) {
              int day = index + 1;
              bool isSelected = day == _selectedDate.day;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedDate = DateTime(2024, 9, day);
                    _isCalendarExpanded = false;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '$day',
                      style: GoogleFonts.outfit(
                        color: isSelected ? Colors.black : Colors.white70,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCircleIcon(
    IconData icon, {
    double size = 20,
    Color color = Colors.white,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.surface,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white10),
        ),
        child: Icon(icon, color: color, size: size),
      ),
    );
  }

  Widget _buildTimeColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 80,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Color(0xFF141414),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _selectedDate.day.toString().padLeft(2, '0'),
                style: GoogleFonts.outfit(
                  color: AppColors.primary,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'September',
                style: GoogleFonts.outfit(
                  color: AppColors.textTertiary,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        _buildTimeLabel('11:30', 'am'),
        _buildTimeLabel('12:00', ''),
        _buildTimeLabel('01:30', 'pm'),
        _buildTimeLabel('02:00', 'pm'),
        _buildTimeLabel('02:30', 'pm'),
        _buildTimeLabel('03:00', 'pm'),
        _buildTimeLabel('04:00', 'pm'),
        _buildTimeLabel('05:00', 'pm'),
      ],
    );
  }

  Widget _buildTimeLabel(String time, String period) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            time,
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (period.isNotEmpty)
            Text(
              period,
              style: GoogleFonts.outfit(
                color: AppColors.textTertiary,
                fontSize: 12,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildScheduleArea() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.zero,
            topRight: Radius.circular(40),
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
          child: Container(
            color: AppColors.surface,
            child: AnimationLimiter(
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                children: AnimationConfiguration.toStaggeredList(
                  duration: const Duration(milliseconds: 375),
                  childAnimationBuilder: (widget) => SlideAnimation(
                    horizontalOffset: 50.0,
                    child: FadeInAnimation(child: widget),
                  ),
                  children: [
                    _buildScheduleCard(
                      'Google Meet Call',
                      '35 min.',
                      const Color(0xFFF7D5A2),
                      ['a', 'b', 'c', 'd'],
                    ),
                    const SizedBox(height: 20),
                    _buildScheduleCard(
                      'Review Meeting',
                      '25 min.',
                      const Color(0xFFB4C8FF),
                      ['e', 'f'],
                    ),
                    const SizedBox(height: 100),
                    _buildScheduleCard(
                      'Google Meet Call',
                      '45 min.',
                      const Color(0xFF2C2C2E),
                      ['g', 'h'],
                      isDarkCard: true,
                    ),
                    const SizedBox(height: 20),
                    _buildScheduleCard(
                      'Project Sync',
                      '60 min.',
                      const Color(0xFFD0B4FF),
                      ['x', 'y', 'z'],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        Positioned(
          top: 320,
          left: -40,
          right: 0,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '01:45 pm',
                  style: GoogleFonts.outfit(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 1,
                  color: AppColors.primary.withValues(alpha: 0.5),
                ),
              ),
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildScheduleCard(
    String title,
    String duration,
    Color color,
    List<String> userIds, {
    bool isDarkCard = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isDarkCard ? Colors.white10 : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Google_Calendar_icon_%282020%29.svg/1024px-Google_Calendar_icon_%282020%29.svg.png',
                  width: 20,
                  height: 20,
                ),
              ),
              Text(
                duration,
                style: GoogleFonts.outfit(
                  color: isDarkCard ? Colors.white70 : Colors.black87,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: GoogleFonts.outfit(
              color: isDarkCard ? Colors.white : Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildAvatarStack(userIds, isDarkCard),
        ],
      ),
    );
  }

  Widget _buildAvatarStack(List<String> ids, bool isDarkCard) {
    return SizedBox(
      height: 32,
      child: Stack(
        children: List.generate(
          ids.length,
          (index) => Positioned(
            left: index * 20.0,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isDarkCard ? const Color(0xFF2C2C2E) : Colors.white,
                  width: 2,
                ),
              ),
              child: CircleAvatar(
                radius: 14,
                backgroundImage: NetworkImage(
                  'https://i.pravatar.cc/150?u=${ids[index]}',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
