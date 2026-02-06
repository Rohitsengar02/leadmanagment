import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../core/constants/app_colors.dart';
import 'create_pipeline_screen.dart';

class PipelineScreen extends StatefulWidget {
  const PipelineScreen({super.key});

  @override
  State<PipelineScreen> createState() => _PipelineScreenState();
}

class _PipelineScreenState extends State<PipelineScreen> {
  // Mock Data Structure
  Map<String, List<Map<String, dynamic>>> pipelineData = {
    'New': [
      {
        'id': '1',
        'name': 'William Boucher',
        'role': 'Financial Advisor',
        'value': '12500',
        'priority': 'High',
        'daysLeft': 3,
        'image': 'https://i.pravatar.cc/150?u=william',
        'tag': 'Hot Lead',
      },
      {
        'id': '2',
        'name': 'Sophia Chen',
        'role': 'Product Manager',
        'value': '8500',
        'priority': 'Medium',
        'daysLeft': 5,
        'image': 'https://i.pravatar.cc/150?u=sophia',
        'tag': 'Warm',
      },
    ],
    'Contacted': [
      {
        'id': '3',
        'name': 'James Miller',
        'role': 'Sales Lead',
        'value': '25000',
        'priority': 'Urgent 🔥',
        'daysLeft': 1,
        'image': 'https://i.pravatar.cc/150?u=james',
        'tag': 'Hot',
      },
    ],
    'Qualified': [],
    'Proposal': [],
    'Won': [],
  };

  final List<String> stages = [
    'New',
    'Contacted',
    'Qualified',
    'Proposal',
    'Won',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: stages
                      .map((stage) => _buildPipelineColumn(stage))
                      .toList(),
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
              _buildIconButton(
                Icons.arrow_back_ios_new_rounded,
                onTap: () => Navigator.pop(context),
              ),
              const SizedBox(width: 16),
              Text(
                'Sales Pipeline',
                style: GoogleFonts.outfit(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          Row(
            children: [
              _buildIconButton(
                Icons.filter_list_rounded,
                onTap: _showFilterOptions,
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreatePipelineScreen(),
                    ),
                  );
                },
                child: _buildIconButton(Icons.add_rounded),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.textPrimary, size: 20),
      ),
    );
  }

  void _showFilterOptions() {
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
              'Filter Pipeline',
              style: GoogleFonts.outfit(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.person_outline, color: AppColors.textPrimary),
              title: Text(
                'By Owner',
                style: GoogleFonts.outfit(color: AppColors.textPrimary),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.calendar_today, color: AppColors.textPrimary),
              title: Text(
                'By Date',
                style: GoogleFonts.outfit(color: AppColors.textPrimary),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.label_outline, color: AppColors.textPrimary),
              title: Text(
                'By Deal Value',
                style: GoogleFonts.outfit(color: AppColors.textPrimary),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPipelineColumn(String stage) {
    final leads = pipelineData[stage] ?? [];
    double totalValue = 0;
    for (var lead in leads) {
      totalValue += double.tryParse(lead['value'].toString()) ?? 0;
    }

    return DragTarget<Map<String, dynamic>>(
      onWillAcceptWithDetails: (details) => true,
      onAcceptWithDetails: (details) {
        final data = details.data;
        final fromStage = _findStageOfLead(data['id']);
        if (fromStage != null && fromStage != stage) {
          setState(() {
            pipelineData[fromStage]?.removeWhere((l) => l['id'] == data['id']);
            pipelineData[stage]?.add(data);
          });
        }
      },
      builder: (context, candidateData, rejectedData) {
        return Container(
          width: 300,
          margin: const EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            color: candidateData.isNotEmpty
                ? AppColors.primary.withValues(alpha: 0.05)
                : AppColors.surface,
            borderRadius: BorderRadius.circular(35),
            border: Border.all(
              color: AppColors.textPrimary.withValues(alpha: 0.1),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          stage,
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${leads.length}',
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          'Total: ',
                          style: GoogleFonts.outfit(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '\$${totalValue.toStringAsFixed(0)}',
                          style: GoogleFonts.outfit(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, color: Colors.black12),
              Expanded(
                child: AnimationLimiter(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: leads.length,
                    itemBuilder: (context, index) {
                      final lead = leads[index];
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: FadeInAnimation(
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: _buildDraggableCard(lead, stage),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String? _findStageOfLead(String id) {
    for (var stage in stages) {
      if (pipelineData[stage]!.any((l) => l['id'] == id)) {
        return stage;
      }
    }
    return null;
  }

  Widget _buildDraggableCard(Map<String, dynamic> lead, String stage) {
    return LongPressDraggable<Map<String, dynamic>>(
      data: lead,
      feedback: Material(
        color: Colors.transparent,
        child: SizedBox(
          width: 260,
          child: _buildPipelineCard(lead, isFeedback: true),
        ),
      ),
      childWhenDragging: Opacity(opacity: 0.5, child: _buildPipelineCard(lead)),
      child: _buildPipelineCard(lead),
    );
  }

  Widget _buildPipelineCard(
    Map<String, dynamic> lead, {
    bool isFeedback = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: AppColors.textPrimary.withValues(
            alpha: isFeedback ? 0.0 : 0.05,
          ),
        ),
        boxShadow: isFeedback
            ? [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ]
            : [],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(lead['image']),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lead['name'],
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      lead['role'],
                      style: GoogleFonts.outfit(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Edit
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.textPrimary.withValues(alpha: 0.05),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.edit_note_rounded,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Deal Value',
                    style: GoogleFonts.outfit(
                      color: AppColors.textSecondary,
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    '\$${lead['value']}',
                    style: GoogleFonts.outfit(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildSmallTag(lead['tag'], AppColors.hotLead),
                  const SizedBox(height: 6),
                  Text(
                    '${lead['daysLeft']} days left',
                    style: GoogleFonts.outfit(
                      color: AppColors.textSecondary,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSmallTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: GoogleFonts.outfit(
          color: color,
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
