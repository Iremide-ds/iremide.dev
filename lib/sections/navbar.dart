import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_colors.dart';

final navBarActiveIndex = ValueNotifier(0);

class Navbar extends StatefulWidget {
  final VoidCallback onBioTap;
  final VoidCallback onTechTap;
  final VoidCallback onProjectsTap;
  final VoidCallback onContactTap;

  const Navbar({
    super.key,
    required this.onBioTap,
    required this.onTechTap,
    required this.onProjectsTap,
    required this.onContactTap,
  });

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isNarrow = width < 700;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.bg.withOpacity(0.85),
          border: const Border(
            bottom: BorderSide(color: AppColors.border, width: 1),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: isNarrow ? 20 : 48),
          child: ValueListenableBuilder(
              valueListenable: navBarActiveIndex,
              builder: (context, value, child) {
                return Row(
                  children: [
                    Text(
                      'IREMIDE.DEV',
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const Spacer(),
                    if (!isNarrow) ...[
                      _NavItem(
                        label: 'Bio',
                        isActive: value == 0,
                        onTap: () {
                          navBarActiveIndex.value = 0;
                          widget.onBioTap();
                        },
                      ),
                      const SizedBox(width: 28),
                      _NavItem(
                        label: 'Tech Stack',
                        isActive: value == 1,
                        onTap: () {
                          navBarActiveIndex.value = 1;
                          widget.onTechTap();
                        },
                      ),
                      const SizedBox(width: 28),
                      _NavItem(
                        label: 'Projects',
                        isActive: value == 2,
                        onTap: () {
                          navBarActiveIndex.value = 2;
                          widget.onProjectsTap();
                        },
                      ),
                      const SizedBox(width: 28),
                      _NavItem(
                        label: 'Contact',
                        isActive: value == 3,
                        onTap: () {
                          navBarActiveIndex.value = 3;
                          widget.onContactTap();
                        },
                      ),
                      const SizedBox(width: 32),
                    ],
                    _GetInTouchButton(onTap: widget.onContactTap),
                  ],
                );
              }),
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            border: widget.isActive
                ? const Border(
                    bottom: BorderSide(color: AppColors.accent, width: 2),
                  )
                : null,
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.jetBrainsMono(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: widget.isActive || _hovering
                  ? AppColors.accentLight
                  : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

class _GetInTouchButton extends StatefulWidget {
  final VoidCallback onTap;
  const _GetInTouchButton({required this.onTap});

  @override
  State<_GetInTouchButton> createState() => _GetInTouchButtonState();
}

class _GetInTouchButtonState extends State<_GetInTouchButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: _hovering ? AppColors.accentLight : AppColors.accent,
            borderRadius: BorderRadius.circular(6),
            boxShadow: _hovering
                ? [
                    BoxShadow(
                      color: AppColors.accent.withOpacity(0.4),
                      blurRadius: 16,
                      spreadRadius: 0,
                    ),
                  ]
                : [],
          ),
          child: Text(
            'Get in Touch',
            style: GoogleFonts.jetBrainsMono(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
