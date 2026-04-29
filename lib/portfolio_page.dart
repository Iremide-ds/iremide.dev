import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'sections/contact_section.dart';
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
                HeroSection(
                  key: _heroKey,
                  onProjectsTap: () => _scrollToSection(_worksKey),
                  onContactTap: () => _scrollToSection(_contactKey),
                ),
                TechStackSection(key: _techKey),
                SelectedWorksSection(key: _worksKey),
                ContactSection(key: _contactKey),
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
