import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../../core/models/lead_model.dart';
import '../../core/services/lead_service.dart';
import 'package:intl/intl.dart';

class CreateLeadScreen extends StatefulWidget {
  const CreateLeadScreen({super.key});

  @override
  State<CreateLeadScreen> createState() => _CreateLeadScreenState();
}

class _CreateLeadScreenState extends State<CreateLeadScreen> {
  final _formKey = GlobalKey<FormState>();
  final LeadService _leadService = LeadService();
  bool _isLoading = false;

  // Controllers
  final _nameController = TextEditingController();
  final _companyController = TextEditingController();
  final _roleController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _dealValueController = TextEditingController();
  final _tagsController = TextEditingController();
  final _notesController = TextEditingController();

  String _selectedPriority = 'Medium';
  String _selectedSource = 'LinkedIn';
  String _selectedAssignee = 'Rohit (Me)';
  DateTime? _selectedDate;

  @override
  void dispose() {
    _nameController.dispose();
    _companyController.dispose();
    _roleController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _dealValueController.dispose();
    _tagsController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _createLead() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final lead = Lead(
        name: _nameController.text,
        company: _companyController.text,
        phone: _phoneController.text,
        email: _emailController.text,
        dealValue: double.tryParse(_dealValueController.text) ?? 0,
        source: _selectedSource,
        priority: _selectedPriority,
        assignedTo: _selectedAssignee,
        status: 'New',
        tags: _tagsController.text.isNotEmpty
            ? _tagsController.text.split(',').map((e) => e.trim()).toList()
            : [],
        notes: _notesController.text.isNotEmpty ? [_notesController.text] : [],
        expectedCloseDate: _selectedDate,
      );

      await _leadService.createLead(lead);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Lead created successfully!',
              style: GoogleFonts.outfit(),
            ),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context, true); // Return true to refresh list
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Error: ${e.toString()}',
              style: GoogleFonts.outfit(),
            ),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
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
          icon: Icon(Icons.close_rounded, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Create New Lead',
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: AppColors.textPrimary,
          ),
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
              _buildSectionTitle('Basic Information'),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _nameController,
                label: 'Full Name',
                icon: Icons.person_outline_rounded,
                hint: 'e.g. John Doe',
                validator: (val) =>
                    val == null || val.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: _companyController,
                label: 'Company Name',
                icon: Icons.business_rounded,
                hint: 'e.g. Acme Corp',
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: _roleController,
                label: 'Role / Designation',
                icon: Icons.work_outline_rounded,
                hint: 'e.g. Marketing Manager',
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: _phoneController,
                label: 'Phone Number',
                icon: Icons.phone_outlined,
                hint: '+1 (555) 000-0000',
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: _emailController,
                label: 'Email Address',
                icon: Icons.email_outlined,
                hint: 'john@example.com',
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 40),
              _buildSectionTitle('Lead Classification'),
              const SizedBox(height: 16),
              _buildDropdownField(
                'Lead Source',
                Icons.language_rounded,
                [
                  'LinkedIn',
                  'Dribbble',
                  'Referral',
                  'Website',
                  'Ads',
                  'WhatsApp',
                ],
                _selectedSource,
                (val) {
                  setState(() => _selectedSource = val!);
                },
              ),
              const SizedBox(height: 20),
              _buildDropdownField(
                'Assigned Person',
                Icons.person_pin_circle_outlined,
                ['Rohit (Me)', 'Sarah Wilson', 'Mike Ross'],
                _selectedAssignee,
                (val) {
                  setState(() => _selectedAssignee = val!);
                },
              ),
              const SizedBox(height: 20),
              _buildDropdownField(
                'Priority Level',
                Icons.flag_outlined,
                ['Low', 'Medium', 'High', 'Urgent 🔥'],
                _selectedPriority,
                (val) {
                  setState(() => _selectedPriority = val!);
                },
              ),

              const SizedBox(height: 40),
              _buildSectionTitle('Budget & Value'),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _dealValueController,
                label: 'Estimated Deal Value',
                icon: Icons.attach_money_rounded,
                hint: 'e.g. 5000',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: _tagsController,
                label: 'Tags',
                icon: Icons.label_outline_rounded,
                hint: 'e.g. Tech, Local, High-Value',
              ),
              const SizedBox(height: 20),
              _buildDatePicker(context),
              const SizedBox(height: 20),
              _buildTextField(
                controller: _notesController,
                label: 'Notes',
                icon: Icons.note_alt_outlined,
                hint: 'Enter any additional details...',
                maxLines: 3,
              ),

              const SizedBox(height: 60),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _createLead,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    elevation: 0,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.black,
                          ),
                        )
                      : Text(
                          'Create Lead',
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
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
        color: AppColors.primary,
        letterSpacing: 1,
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Follow-up Date',
          style: GoogleFonts.outfit(
            color: AppColors.textSecondary,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.light(
                      primary: AppColors.primary,
                      onPrimary: Colors.black,
                      surface: AppColors.surface,
                      onSurface: AppColors.textPrimary,
                    ),
                    dialogBackgroundColor: AppColors.surface,
                  ),
                  child: child!,
                );
              },
            );
            if (date != null) {
              setState(() {
                _selectedDate = date;
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today_rounded,
                  color: AppColors.primary.withValues(alpha: 0.5),
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  _selectedDate == null
                      ? 'Select Date'
                      : DateFormat('MMM dd, yyyy').format(_selectedDate!),
                  style: GoogleFonts.outfit(
                    color: _selectedDate == null
                        ? AppColors.textTertiary
                        : AppColors.textPrimary,
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String hint,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
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
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          validator: validator,
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
