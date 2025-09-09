import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const SectionHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1a1a1a),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          subtitle,
          style: GoogleFonts.inter(
            fontSize: 18,
            color: const Color(0xFF6b7280),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}