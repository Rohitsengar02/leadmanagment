import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_colors.dart';

class CreatePipelineScreen extends StatefulWidget {
  final Map<String, dynamic>? initialData;
  const CreatePipelineScreen({super.key, this.initialData});

  @override
  State<CreatePipelineScreen> createState() => _CreatePipelineScreenState();
}

class _CreatePipelineScreenState extends State<CreatePipelineScreen> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _selectedDate;
  String _selectedStage = 'New';
  String _selectedPriority = 'Medium';

  final List<String> _stages = [
    'New',
    'Contacted',
    'Qualified',
    'Proposal',
    'Negotiation',
    'Won',
    'Lost',
  ];
  final List<String> _priorities = ['Low', 'Medium', 'High', 'Urgent 🔥'];

  @override
  void initState() {
    super.initState();
    _selectedDate =
        widget.initialData?['date'] ??
        DateTime.now().add(const Duration(days: 7));
    _selectedStage = widget.initialData?['stage'] ?? 'New';
    _selectedPriority = widget.initialData?['priority'] ?? 'Medium';
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2026, 12, 31),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
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

  @override
  Widget build(BuildContext context) {
    final bool isEditing = widget.initialData != null;

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
          isEditing ? 'Edit Deal' : 'Add New Deal',
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
              _buildSectionTitle('Deal Information'),
              const SizedBox(height: 16),
              _buildTextField(
                'Deal Title',
                Icons.business_center_outlined,
                'e.g. Enterprise CRM License',
              ),
              const SizedBox(height: 20),
              _buildTextField(
                'Lead Name',
                Icons.person_outline_rounded,
                'e.g. William Boucher',
              ),
              const SizedBox(height: 20),
              _buildTextField(
                'Deal Value (\$)',
                Icons.attach_money_rounded,
                'e.g. 15000',
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 40),
              _buildSectionTitle('Pipeline Logistics'),
              const SizedBox(height: 16),
              _buildDropdownField(
                'Pipeline Stage',
                Icons.account_tree_outlined,
                _stages,
                _selectedStage,
                (val) {
                  setState(() => _selectedStage = val!);
                },
              ),
              const SizedBox(height: 20),
              _buildDateTimePicker(
                'Expected Close Date',
                Icons.calendar_today_rounded,
                DateFormat('MMM dd, yyyy').format(_selectedDate),
                _selectDate,
              ),
              const SizedBox(height: 20),
              _buildDropdownField(
                'Priority Level',
                Icons.flag_outlined,
                _priorities,
                _selectedPriority,
                (val) {
                  setState(() => _selectedPriority = val!);
                },
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
                  isEditing ? 'Update Deal' : 'Add to Pipeline',
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
          keyboardType: keyboardType,
          style: GoogleFonts.outfit(color: AppColors.textPrimary),
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
                  style: GoogleFonts.outfit(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                  ),
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
              style: GoogleFonts.outfit(
                color: AppColors.textPrimary,
                fontSize: 14,
              ),
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
