import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_colors.dart';

class CreateTaskScreen extends StatefulWidget {
  final DateTime? initialDate;
  const CreateTaskScreen({super.key, this.initialDate});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _selectedDate;
  TimeOfDay _selectedTime = const TimeOfDay(hour: 10, minute: 0);
  String _selectedType = 'Call';
  String _selectedPriority = 'Medium';
  String _selectedDuration = '30 min';

  final List<String> _taskTypes = [
    'Call',
    'Meeting',
    'Email',
    'Follow-up',
    'Presentation',
  ];
  final List<String> _priorities = ['Low', 'Medium', 'High', 'Urgent 🔥'];
  final List<String> _durations = [
    '15 min',
    '30 min',
    '45 min',
    '1 hour',
    '2 hours',
  ];

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? DateTime.now();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025, 12, 31),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.primary,
              onPrimary: Colors.black,
              surface: AppColors.surface,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.primary,
              onPrimary: Colors.black,
              surface: AppColors.surface,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Schedule New Task',
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Task Details'),
              const SizedBox(height: 16),
              _buildTextField(
                'Task Title',
                Icons.task_alt_rounded,
                'e.g. Follow up with William',
              ),
              const SizedBox(height: 20),
              _buildTextField(
                'Description',
                Icons.description_outlined,
                'Add notes or agenda...',
                maxLines: 3,
              ),

              const SizedBox(height: 40),
              _buildSectionTitle('Schedule'),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildDateTimePicker(
                      'Date',
                      Icons.calendar_today_rounded,
                      DateFormat('MMM dd, yyyy').format(_selectedDate),
                      _selectDate,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildDateTimePicker(
                      'Time',
                      Icons.access_time_rounded,
                      _selectedTime.format(context),
                      _selectTime,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildDropdownField(
                'Duration',
                Icons.timer_outlined,
                _durations,
                _selectedDuration,
                (val) {
                  setState(() => _selectedDuration = val!);
                },
              ),

              const SizedBox(height: 40),
              _buildSectionTitle('Classification'),
              const SizedBox(height: 16),
              _buildDropdownField(
                'Task Type',
                Icons.category_outlined,
                _taskTypes,
                _selectedType,
                (val) {
                  setState(() => _selectedType = val!);
                },
              ),
              const SizedBox(height: 20),
              _buildDropdownField(
                'Priority',
                Icons.flag_outlined,
                _priorities,
                _selectedPriority,
                (val) {
                  setState(() => _selectedPriority = val!);
                },
              ),

              const SizedBox(height: 40),
              _buildSectionTitle('Assign to Lead'),
              const SizedBox(height: 16),
              _buildTextField(
                'Search Lead',
                Icons.person_search_rounded,
                'Start typing lead name...',
              ),

              const SizedBox(height: 60),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Complete Schedule',
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.outfit(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: AppColors.primary.withValues(alpha: 0.8),
        letterSpacing: 1,
      ),
    );
  }

  Widget _buildTextField(
    String label,
    IconData icon,
    String hint, {
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(
            color: AppColors.textSecondary,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: GoogleFonts.outfit(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.outfit(
              color: AppColors.textTertiary,
              fontSize: 14,
            ),
            prefixIcon: Icon(
              icon,
              color: AppColors.primary.withValues(alpha: 0.5),
              size: 20,
            ),
            filled: true,
            fillColor: AppColors.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateTimePicker(
    String label,
    IconData icon,
    String value,
    VoidCallback onTap,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(
            color: AppColors.textSecondary,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: AppColors.primary.withValues(alpha: 0.5),
                  size: 18,
                ),
                const SizedBox(width: 12),
                Text(
                  value,
                  style: GoogleFonts.outfit(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField(
    String label,
    IconData icon,
    List<String> items,
    String currentVal,
    Function(String?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(
            color: AppColors.textSecondary,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: currentVal,
              isExpanded: true,
              dropdownColor: AppColors.surface,
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.textTertiary,
              ),
              style: GoogleFonts.outfit(color: Colors.white, fontSize: 14),
              onChanged: onChanged,
              items: items.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Row(
                    children: [
                      Icon(
                        icon,
                        color: AppColors.primary.withValues(alpha: 0.5),
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Text(value),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
