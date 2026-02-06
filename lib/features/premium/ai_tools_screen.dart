import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';

class AiToolsScreen extends StatefulWidget {
  const AiToolsScreen({super.key});

  @override
  State<AiToolsScreen> createState() => _AiToolsScreenState();
}

class _AiToolsScreenState extends State<AiToolsScreen> {
  final TextEditingController _promptController = TextEditingController();
  String? _generatedContent;
  bool _isGenerating = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.textPrimary,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Icon(
              Icons.auto_awesome_rounded,
              color: AppColors.primary,
              size: 24,
            ),
            const SizedBox(width: 8),
            Text(
              'AI Sales Assistant',
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildToolsGrid(),
            const SizedBox(height: 30),
            _buildGeneratorSection(),
            if (_generatedContent != null) ...[
              const SizedBox(height: 30),
              _buildResultCard(),
            ],
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildToolsGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select a Tool',
          style: GoogleFonts.outfit(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.5,
          children: [
            _buildToolCard(
              'Cold Email',
              Icons.mail_outline_rounded,
              Colors.blueAccent,
              true,
            ),
            _buildToolCard(
              'Sales Script',
              Icons.record_voice_over_rounded,
              Colors.orangeAccent,
              false,
            ),
            _buildToolCard(
              'Objection Fix',
              Icons.gpp_good_rounded,
              Colors.greenAccent,
              false,
            ),
            _buildToolCard(
              'LinkedIn Msg',
              Icons.link_rounded,
              Colors.indigoAccent,
              false,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildToolCard(
    String title,
    IconData icon,
    Color color,
    bool isSelected,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.textPrimary.withValues(alpha: 0.1)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: isSelected ? Colors.black : color, size: 28),
          const SizedBox(height: 12),
          Text(
            title,
            style: GoogleFonts.outfit(
              color: isSelected ? Colors.black : AppColors.textPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGeneratorSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Input Details',
          style: GoogleFonts.outfit(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            children: [
              TextField(
                controller: _promptController,
                maxLines: 4,
                style: GoogleFonts.outfit(color: AppColors.textPrimary),
                decoration: InputDecoration(
                  hintText:
                      'e.g. Write a follow-up email to a client who hasn\'t responded in 3 days. The deal value is \$5000.',
                  hintStyle: GoogleFonts.outfit(color: AppColors.textTertiary),
                  border: InputBorder.none,
                ),
              ),
              Divider(
                color: AppColors.textSecondary.withValues(alpha: 0.1),
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    setState(() => _isGenerating = true);
                    // Mock generation delay
                    Future.delayed(const Duration(seconds: 2), () {
                      setState(() {
                        _isGenerating = false;
                        _generatedContent =
                            "Subject: Quick question about our proposal?\n\nHi [Name],\n\nI wanted to circle back on the proposal I sent over earlier this week. \n\nGiven the potential impact on your team's efficiency, I'd hate for this to slip through the cracks.\n\nAre you free for a 5-minute chat tomorrow?\n\nBest,\nRohit";
                      });
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  icon: _isGenerating
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.black,
                          ),
                        )
                      : Icon(Icons.auto_awesome_rounded, color: Colors.black),
                  label: Text(
                    _isGenerating ? 'Generating Magic...' : 'Generate Content',
                    style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildResultCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Generated Result',
              style: GoogleFonts.outfit(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.copy_rounded,
                color: AppColors.textTertiary,
                size: 20,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
          ),
          child: Text(
            _generatedContent!,
            style: GoogleFonts.outfit(
              color: AppColors.textSecondary,
              fontSize: 14,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}
