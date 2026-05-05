import 'package:architect_portfolio/analytics.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'app_colors.dart';
import 'sections/footer_section.dart';
import 'sections/hero_section.dart';
import 'sections/navbar.dart';
import 'sections/selected_works_section.dart';
import 'sections/tech_stack_section.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final ScrollController _scrollController = ScrollController();

  // Section keys for scroll-to navigation
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _techKey = GlobalKey();
  final GlobalKey _worksKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  void _scrollToSection(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          // Subtle grid background
          Positioned.fill(
            child: CustomPaint(painter: _GridPainter()),
          ),
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                VisibilityDetector(
                  key: _heroKey,
                  onVisibilityChanged: (info) {
                    if (info.visibleFraction > 0.4) {
                      AnalyticsService.instance
                          .logSectionViewed('Hero Section');
                    }
                  },
                  child: HeroSection(
                    onProjectsTap: () => _scrollToSection(_worksKey),
                    onContactTap: () => _scrollToSection(_contactKey),
                  ),
                ),
                VisibilityDetector(
                  key: _techKey,
                  onVisibilityChanged: (info) {
                    if (info.visibleFraction > 0.4) {
                      AnalyticsService.instance
                          .logSectionViewed('Tech Stack Section');
                    }
                  },
                  child: const TechStackSection(),
                ),
                VisibilityDetector(
                  key: _worksKey,
                  onVisibilityChanged: (info) {
                    if (info.visibleFraction > 0.4) {
                      AnalyticsService.instance
                          .logSectionViewed('Works Section');
                    }
                  },
                  child: SelectedWorksSection(
                    key: _worksKey,
                  ),
                ),
                // ContactSection(key: _contactKey,),
                const FooterSection(),
              ],
            ),
          ),
          Navbar(
            onBioTap: () => _scrollToSection(_heroKey),
            onTechTap: () => _scrollToSection(_techKey),
            onProjectsTap: () => _scrollToSection(_worksKey),
            onContactTap: () => _scrollToSection(_contactKey),
          ),
        ],
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1A1F2E).withOpacity(0.5)
      ..strokeWidth = 0.5;

    const spacing = 60.0;

    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_GridPainter oldDelegate) => false;
}
