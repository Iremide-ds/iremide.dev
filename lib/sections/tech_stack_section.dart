import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_colors.dart';
import '../widgets/section_label.dart';
import '../widgets/tag_chip.dart';

class TechStackSection extends StatelessWidget {
  const TechStackSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isNarrow = width < 700;
    final hPad = isNarrow ? 24.0 : 80.0;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(hPad, 80, hPad, 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionLabel(
              icon: Icons.circle_outlined, label: 'Technical Arsenal'),
          const SizedBox(height: 36),
          isNarrow
              ? const Column(
                  children: [
                    _TechCard(
                      badge: 'CORE EXPERTISE',
                      title: 'Flutter & Dart',
                      icon: Icons.smartphone_rounded,
                      description:
                          'Building pixel-perfect, 60fps cross-platform applications with complex state management and custom animations.',
                      tags: [
                        'Bloc / Riverpod / Provider / GetX',
                        'Custom Painters',
                        'Animations',
                        'Clean Architecture',
                        'CI/CD: Azure / Codemagic',
                      ],
                    ),
                    SizedBox(height: 16),
                    _TechCard(
                      badge: '● CURRENTLY SCALING',
                      title: 'Golang',
                      icon: Icons.storage_rounded,
                      description:
                          'Learning to architect high-concurrency microservices and robust REST/gRPC APIs.',
                      tags: [
                        'Goroutines',
                        'REST API',
                        'PostgreSQL',
                        'Docker',
                      ],
                      badgeColor: AppColors.green,
                    ),
                  ],
                )
              : const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _TechCard(
                        badge: 'CORE EXPERTISE',
                        title: 'Flutter & Dart',
                        icon: Icons.smartphone_rounded,
                        description:
                            'Building pixel-perfect, 60fps cross-platform applications with complex state management and custom animations.',
                        tags: [
                          'Bloc / Riverpod / Provider / GetX',
                          'Custom Painters',
                          'Animations',
                          'Clean Architecture',
                          'CI/CD: Azure / Codemagic',
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _TechCard(
                        badge: '● CURRENTLY SCALING',
                        title: 'Golang',
                        icon: Icons.storage_rounded,
                        description:
                            'Learning to architect high-concurrency microservices and robust REST/gRPC APIs.',
                        tags: [
                          'Goroutines',
                          'REST API',
                          'PostgreSQL',
                          'Docker',
                        ],
                        badgeColor: AppColors.green,
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}

class _TechCard extends StatefulWidget {
  final String badge;
  final String title;
  final IconData icon;
  final String description;
  final List<String> tags;
  final Color badgeColor;

  const _TechCard({
    required this.badge,
    required this.title,
    required this.icon,
    required this.description,
    required this.tags,
    this.badgeColor = AppColors.textMuted,
  });

  @override
  State<_TechCard> createState() => _TechCardState();
}

class _TechCardState extends State<_TechCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: _hovering ? AppColors.surfaceElevated : AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _hovering
                ? AppColors.accent.withOpacity(0.4)
                : AppColors.border,
            width: 1,
          ),
          boxShadow: _hovering
              ? [
                  BoxShadow(
                    color: AppColors.accent.withOpacity(0.08),
                    blurRadius: 30,
                    spreadRadius: 0,
                  )
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.badge,
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 10,
                        color: widget.badgeColor,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.title,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.tagBg,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Icon(widget.icon,
                      size: 18, color: AppColors.textSecondary),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(color: AppColors.border, height: 1),
            const SizedBox(height: 20),
            Text(
              widget.description,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: AppColors.textSecondary,
                height: 1.65,
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.tags.map((t) => TagChip(label: t)).toList(),
            ),
          ],
        ),
      ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1, end: 0),
    );
  }
}
