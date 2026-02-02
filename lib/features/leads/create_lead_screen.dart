import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';

class CreateLeadScreen extends StatefulWidget {
  const CreateLeadScreen({super.key});

  @override
  State<CreateLeadScreen> createState() => _CreateLeadScreenState();
}

class _CreateLeadScreenState extends State<CreateLeadScreen> {
  final _formKey = GlobalKey<FormState>();
  String _selectedPriority = 'Medium';
  String _selectedSource = 'LinkedIn';

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
          'Create New Lead',
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
              _buildSectionTitle('Basic Information'),
              const SizedBox(height: 16),
              _buildTextField(
                'Full Name',
                Icons.person_outline_rounded,
                'e.g. John Doe',
              ),
              const SizedBox(height: 20),
              _buildTextField(
                'Role / Decoration',
                Icons.work_outline_rounded,
                'e.g. Marketing Manager',
              ),
              const SizedBox(height: 20),
              _buildTextField(
                'Phone Number',
                Icons.phone_outlined,
                '+1 (555) 000-0000',
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                'Email Address',
                Icons.email_outlined,
                'john@example.com',
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 40),
              _buildSectionTitle('Lead Classification'),
              const SizedBox(height: 16),
              _buildDropdownField(
                'Lead Source',
                Icons.language_rounded,
                ['LinkedIn', 'Dribbble', 'Referral', 'Website'],
                _selectedSource,
                (val) {
                  setState(() => _selectedSource = val!);
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
                'Estimated Deal Value',
                Icons.attach_money_rounded,
                'e.g. 5000',
                keyboardType: TextInputType.number,
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
                  'Create Lead',
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
