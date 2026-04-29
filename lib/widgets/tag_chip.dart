import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_colors.dart';

class TagChip extends StatelessWidget {
  final String label;
  final Color? accentColor;

  const TagChip({super.key, required this.label, this.accentColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: accentColor != null
            ? accentColor!.withOpacity(0.1)
            : AppColors.tagBg,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: accentColor != null
              ? accentColor!.withOpacity(0.25)
              : AppColors.border,
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.jetBrainsMono(
          fontSize: 11,
          color: accentColor != null
              ? accentColor!.withOpacity(0.9)
              : AppColors.tagText,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
