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

  final List<Map<String, dynamic>> _tasks = [
    {
      'title': 'Google Meet Call',
      'duration': '35 min',
      'time': '11:30 AM',
      'type': 'Meeting',
      'attendees': ['a', 'b', 'c', 'd'],
      'isCompleted': false,
    },
    {
      'title': 'WhatsApp Follow-up',
      'duration': '5 min',
      'time': '12:15 PM',
      'type': 'WhatsApp',
      'attendees': ['e'],
      'isCompleted': false,
    },
    {
      'title': 'Client Call',
      'duration': '15 min',
      'time': '01:30 PM',
      'type': 'Call',
      'attendees': ['f'],
      'isCompleted': false,
    },
    {
      'title': 'Proposal Review',
      'duration': '45 min',
      'time': '03:00 PM',
      'type': 'Review',
      'attendees': ['g', 'h'],
      'isCompleted': false,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CreateTaskScreen(initialDate: _selectedDate),
            ),
          );
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.black),
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
                Icons.arrow_back_ios_new_rounded,
                size: 20,
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
                      color: AppColors.textPrimary,
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
                color: _isCalendarExpanded
                    ? AppColors.primary
                    : AppColors.textPrimary,
                onTap: () {
                  setState(() {
                    _isCalendarExpanded = !_isCalendarExpanded;
                  });
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
        border: Border.all(color: AppColors.textPrimary.withValues(alpha: 0.1)),
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
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.chevron_left_rounded,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: AppColors.textPrimary,
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
                        color: isSelected
                            ? Colors.black
                            : AppColors.textSecondary,
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
    Color? color,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.surface,
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.textSecondary.withValues(alpha: 0.2),
          ),
        ),
        child: Icon(icon, color: color ?? AppColors.textPrimary, size: size),
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
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: const BorderRadius.only(
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
                'Sept',
                style: GoogleFonts.outfit(
                  color: AppColors.textTertiary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        _buildTimeLabel('11:00', 'AM'),
        _buildTimeLabel('12:00', 'PM'),
        _buildTimeLabel('01:00', 'PM'),
        _buildTimeLabel('02:00', 'PM'),
        _buildTimeLabel('03:00', 'PM'),
        _buildTimeLabel('04:00', 'PM'),
        _buildTimeLabel('05:00', 'PM'),
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
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
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
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 600),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: AppColors.surface.withValues(alpha: 0.5),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.zero,
                topRight: Radius.circular(40),
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: AnimationLimiter(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 30),
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                      horizontalOffset: 50.0,
                      child: FadeInAnimation(
                        child: _buildScheduleCard(_tasks[index]),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),

        // Time Indicator Line
        Positioned(
          top: 180, // Dynamic based on real time in real app
          left: -10,
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
                  '01:45 PM',
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
                decoration: BoxDecoration(
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

  Widget _buildScheduleCard(Map<String, dynamic> task) {
    Color cardColor;
    IconData icon;

    switch (task['type']) {
      case 'Meeting':
        cardColor = const Color(0xFFF7D5A2);
        icon = Icons.groups;
        break;
      case 'WhatsApp':
        cardColor = const Color(0xFFB4C8FF);
        icon = Icons.chat; // WhatsApp icon replacement
        break;
      case 'Call':
        cardColor = const Color(0xFFD0B4FF);
        icon = Icons.call;
        break;
      default:
        cardColor = AppColors.cardBackground;
        icon = Icons.assignment;
    }

    // For dark mode aesthetics, if cardColor is too bright, maybe adjust?
    // The previous design used specific pastel colors. Let's keep them but ensure text contrast.

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
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
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 20, color: Colors.black87),
              ),
              Text(
                task['duration'],
                style: GoogleFonts.outfit(
                  color: Colors.black87,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            task['title'],
            style: GoogleFonts.outfit(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildAvatarStack(task['attendees']),
        ],
      ),
    );
  }

  Widget _buildAvatarStack(List<String> ids) {
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
                border: Border.all(color: Colors.white, width: 2),
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
