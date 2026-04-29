import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../app_colors.dart';
import '../widgets/section_label.dart';
import '../widgets/tag_chip.dart';

class SelectedWorksSection extends StatelessWidget {
  const SelectedWorksSection({super.key});

  static final _projects = <_ProjectData>[
    _ProjectData(
      onTap: (BuildContext context) async {
        final uri = Uri.parse(
          'https://play.google.com/store/apps/details?id=com.investment.one.phoenix',
        );
        final uri2 = Uri.parse(
          'https://apps.apple.com/ng/app/investment-one/id1634598997',
        );

        await _showPopUp(context, uri, uri2);
      },
      title: 'Investment One Financial Services',
      description:
          'A high-performance Flutter mobile application for seasoned investors featuring complex state management initially via Bloc and dependency injection with GetIt but then migrated to Riverpod for both, and secure biometric authentication.',
      tags: ['Flutter', 'Dart', 'Firebase'],
      cta: 'View App →',
      gradient: [
        const Color(0xFF0f1e3d),
        const Color(0xFF0a0f1a),
        const Color(0xFF0d1520)
      ],
      accentColor: const Color(0xFF2563EB),
      icon: Icons.bar_chart_rounded,
    ),
    _ProjectData(
      onTap: (BuildContext context) async {
        final uri = Uri.parse(
          'https://play.google.com/store/apps/details?id=com.investment_one.ziing',
        );
        final uri2 = Uri.parse(
          'https://apps.apple.com/ng/app/ziing-your-financial-buddy/id1453535735',
        );

        await _showPopUp(context, uri, uri2);
      },
      title: 'Ziing',
      description:
          'A high-performance Flutter mobile application for seasoned investors featuring complex state management via Bloc and GetX, dependency injection with GetIt, and secure biometric authentication.',
      tags: ['Flutter', 'Dart', 'Firebase'],
      cta: 'View App →',
      gradient: [
        const Color(0xFF0a1f1a),
        const Color(0xFF0a130f),
        const Color(0xFF071210)
      ],
      accentColor: const Color(0xFF10B981),
      icon: Icons.bar_chart_rounded,
    ),
    _ProjectData(
      onTap: (BuildContext context) async {
        final uri = Uri.parse(
          'https://play.google.com/store/apps/details?id=com.flitaa.app',
        );
        final uri2 = Uri.parse(
          'https://apps.apple.com/ng/app/flitaa/id1566777501',
        );

        await _showPopUp(context, uri, uri2);
      },
      title: 'Flitaa',
      description:
          'A secure, easy to navigate Flutter mobile app that provides fast and secured Crypto trading African users featuring biometric authentication, in-app support, state mangement and dependency injection with Riverpod.',
      tags: ['Flutter', 'Dart', 'Firebase'],
      cta: 'View App →',
      gradient: [
        const Color(0xFF1a0f2e),
        const Color(0xFF120a1a),
        const Color(0xFF0d0a12)
      ],
      accentColor: const Color(0xFF8B5CF6),
      icon: Icons.lock,
    ),
  ];

  static Future<void> _showPopUp(
      BuildContext context, Uri uri, Uri uri2) async {
    await showAdaptiveDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          title: const Text('Select a platform'),
          content: const Text(
              'This is a cross-platform mobile application available on App Store and play store.'),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();

                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              },
              child: const Text('Android'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();

                if (await canLaunchUrl(uri2)) {
                  await launchUrl(uri2, mode: LaunchMode.externalApplication);
                }
              },
              child: const Text('iOS'),
            ),
          ],
        );
      },
    );
  }

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
            icon: Icons.north_east_rounded,
            label: 'Selected Works',
          ),
          const SizedBox(height: 36),
          isNarrow
              ? Column(
                  children: _projects
                      .map((p) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: _ProjectCard(data: p),
                          ))
                      .toList(),
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _projects
                      .map((p) => Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: _ProjectCard(data: p),
                            ),
                          ))
                      .toList(),
                ),
        ],
      ),
    );
  }
}

class _ProjectData {
  final String title;
  final String description;
  final List<String> tags;
  final String cta;
  final List<Color> gradient;
  final Color accentColor;
  final IconData icon;

  final Future<void> Function(BuildContext context) onTap;

  const _ProjectData({
    required this.title,
    required this.description,
    required this.tags,
    required this.cta,
    required this.gradient,
    required this.accentColor,
    required this.icon,
    required this.onTap,
  });
}

class _ProjectCard extends StatefulWidget {
  final _ProjectData data;

  const _ProjectCard({required this.data});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: () => widget.data.onTap(context),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _hovering
                  ? widget.data.accentColor.withOpacity(0.4)
                  : AppColors.border,
              width: 1,
            ),
            boxShadow: _hovering
                ? [
                    BoxShadow(
                      color: widget.data.accentColor.withOpacity(0.1),
                      blurRadius: 30,
                      spreadRadius: 0,
                    )
                  ]
                : [],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thumbnail area
              Container(
                height: 160,
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: widget.data.gradient,
                  ),
                ),
                child: Stack(
                  children: [
                    // Grid overlay
                    Positioned.fill(
                      child: CustomPaint(
                        painter: _ThumbnailGridPainter(widget.data.accentColor),
                      ),
                    ),
                    Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: widget.data.accentColor
                              .withOpacity(_hovering ? 0.25 : 0.15),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: widget.data.accentColor.withOpacity(0.4),
                          ),
                        ),
                        child: Icon(
                          widget.data.icon,
                          size: 24,
                          color: widget.data.accentColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Content
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.data.title,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.data.description,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: widget.data.tags
                          .map((t) => TagChip(
                              label: t, accentColor: widget.data.accentColor))
                          .toList(),
                    ),
                    const SizedBox(height: 16),
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 150),
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: _hovering
                            ? widget.data.accentColor
                            : AppColors.textMuted,
                      ),
                      child: Text(widget.data.cta),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1, end: 0),
      ),
    );
  }
}

class _ThumbnailGridPainter extends CustomPainter {
  final Color accentColor;
  _ThumbnailGridPainter(this.accentColor);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = accentColor.withOpacity(0.06)
      ..strokeWidth = 0.5;

    const spacing = 30.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
