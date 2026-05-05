import 'package:architect_portfolio/sections/navbar.dart';
import 'package:architect_portfolio/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../app_colors.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    required this.onProjectsTap,
    required this.onContactTap,
  });

  final VoidCallback onProjectsTap;
  final VoidCallback onContactTap;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isNarrow = width < 860;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        isNarrow ? 24 : 80,
        isNarrow ? 100 : 120,
        isNarrow ? 24 : 80,
        isNarrow ? 64 : 100,
      ),
      child: isNarrow
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _LeftContent(
                  onProjectsTap: onProjectsTap,
                  onContactTap: onContactTap,
                ),
                const SizedBox(height: 48),
                _RightContent(),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5,
                  child: _LeftContent(
                    onProjectsTap: onProjectsTap,
                    onContactTap: onContactTap,
                  ),
                ),
                const SizedBox(width: 64),
                Expanded(flex: 4, child: _RightContent()),
              ],
            ),
    );
  }
}

class _LeftContent extends StatelessWidget {
  const _LeftContent({
    super.key,
    required this.onProjectsTap,
    required this.onContactTap,
  });

  final VoidCallback onProjectsTap;
  final VoidCallback onContactTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Logo icon
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border, width: 1.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.terminal_rounded,
            color: AppColors.textSecondary,
            size: 24,
          ),
        )
            .animate()
            .fadeIn(duration: 600.ms)
            .slideY(begin: -0.2, end: 0, duration: 600.ms),
        const SizedBox(height: 20),

        // Available badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.greenDim,
            borderRadius: BorderRadius.circular(20),
            border:
                Border.all(color: AppColors.green.withOpacity(0.3), width: 1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: AppColors.green,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Available for new opportunities',
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 11,
                  color: AppColors.green,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        )
            .animate(delay: 150.ms)
            .fadeIn(duration: 500.ms)
            .slideX(begin: -0.1, end: 0),
        const SizedBox(height: 28),

        // Headline
        Text(
          'Flutter Frontend',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 52,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
            height: 1.1,
          ),
        )
            .animate(delay: 250.ms)
            .fadeIn(duration: 500.ms)
            .slideY(begin: 0.2, end: 0),
        Row(
          children: [
            Container(
              width: 4,
              height: 52,
              margin: const EdgeInsets.only(right: 12),
              color: AppColors.accent,
            ),
            Expanded(
              child: Text(
                'Golang Backend',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 52,
                  fontWeight: FontWeight.w800,
                  color: AppColors.accentLight,
                  height: 1.1,
                ),
              ),
            ),
          ],
        )
            .animate(delay: 350.ms)
            .fadeIn(duration: 500.ms)
            .slideY(begin: 0.2, end: 0),
        const SizedBox(height: 24),

        // Subtext
        Text(
          'Architecting scalable, high-performance, pixel-perfect applications with Flutter. Currently expanding deep into backend engineering with Go to build end-to-end systems.',
          style: GoogleFonts.inter(
            fontSize: 15,
            color: AppColors.textSecondary,
            height: 1.7,
          ),
        ).animate(delay: 450.ms).fadeIn(duration: 500.ms),
        const SizedBox(height: 36),

        // CTA Buttons
        Row(
          children: [
            _PrimaryButton(
                label: 'View Work',
                onTap: () {
                  navBarActiveIndex.value = 2;
                  onProjectsTap();
                }),
            const SizedBox(width: 12),
            _OutlineButton(
              label: 'My Resume',
              onTap: () {
                launchCV();
              },
            ),
          ],
        )
            .animate(delay: 550.ms)
            .fadeIn(duration: 500.ms)
            .slideY(begin: 0.1, end: 0),
        const SizedBox(height: 36),

        // Social Links
        Row(
          children: [
            Text(
              'CONNECT:',
              style: GoogleFonts.jetBrainsMono(
                fontSize: 10,
                color: AppColors.textMuted,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(width: 16),
            _SocialIcon(
              icon: Icons.code,
              label: 'GitHub',
              onTap: () async {
                final uri = Uri.parse('https://github.com/Iremide-ds');
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              },
            ),
            const SizedBox(width: 12),
            _SocialIcon(
              icon: Icons.business,
              label: 'LinkedIn',
              onTap: () async {
                final uri = Uri.parse(
                  'https://www.linkedin.com/in/iremide-adeboye-02b2b5206/',
                );
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              },
            ),
            const SizedBox(width: 12),
            _SocialIcon(
              icon: Icons.cloud_download,
              label: 'My Resume',
              onTap: () async {},
            ),
          ],
        ).animate(delay: 650.ms).fadeIn(duration: 500.ms),
      ],
    );
  }
}

class _RightContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Code preview card
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border, width: 1),
            color: AppColors.surface,
            boxShadow: [
              BoxShadow(
                color: AppColors.accent.withOpacity(0.08),
                blurRadius: 40,
                spreadRadius: 10,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Window chrome
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: AppColors.border)),
                ),
                child: Row(
                  children: [
                    _dot(const Color(0xFFFF5F57)),
                    const SizedBox(width: 6),
                    _dot(const Color(0xFFFFBD2E)),
                    const SizedBox(width: 6),
                    _dot(const Color(0xFF28CA41)),
                  ],
                ),
              ),
              // "image" placeholder with gradient
              Container(
                height: 200,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF1a1f35),
                      AppColors.bg,
                      Color(0xFF0f1520),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Icon(
                        Icons.laptop_mac_rounded,
                        size: 64,
                        color: AppColors.accent.withOpacity(0.3),
                      ),
                    ),
                    // Fake code lines overlay
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _codeLine('func NewServer() *Server {',
                                AppColors.accentLight, 13),
                            _codeLine('  return &Server{',
                                AppColors.textSecondary, 12),
                            _codeLine('    router: chi.NewRouter(),',
                                AppColors.textMuted, 12),
                            _codeLine('    db: postgres.Connect(),',
                                AppColors.textMuted, 12),
                            _codeLine('  }', AppColors.textSecondary, 12),
                            _codeLine('}', AppColors.accentLight, 13),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Terminal footer
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: AppColors.border)),
                  color: Color(0xFF0f1218),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      'main.go',
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 11,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const Spacer(),
                    const _BlinkingCursor(),
                    const SizedBox(width: 6),
                    Text(
                      'Compiling success...',
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 11,
                        color: AppColors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
            .animate(delay: 400.ms)
            .fadeIn(duration: 600.ms)
            .slideY(begin: 0.15, end: 0),
      ],
    );
  }

  Widget _dot(Color color) => Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      );

  Widget _codeLine(String text, Color color, double size) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Text(
          text,
          style: GoogleFonts.jetBrainsMono(
            fontSize: size,
            color: color,
          ),
        ),
      );
}

class _BlinkingCursor extends StatefulWidget {
  const _BlinkingCursor();

  @override
  State<_BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<_BlinkingCursor>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) => Opacity(
        opacity: _controller.value,
        child: Container(
          width: 7,
          height: 13,
          color: AppColors.green,
        ),
      ),
    );
  }
}

class _PrimaryButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _PrimaryButton({required this.label, required this.onTap});

  @override
  State<_PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<_PrimaryButton> {
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
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: _hovering ? AppColors.accentLight : AppColors.accent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: _hovering
                ? [
                    BoxShadow(
                      color: AppColors.accent.withOpacity(0.45),
                      blurRadius: 20,
                      spreadRadius: 0,
                    )
                  ]
                : [],
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.jetBrainsMono(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class _OutlineButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _OutlineButton({required this.label, required this.onTap});

  @override
  State<_OutlineButton> createState() => _OutlineButtonState();
}

class _OutlineButtonState extends State<_OutlineButton> {
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
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: _hovering ? AppColors.border : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _hovering ? AppColors.accentLight : AppColors.border,
              width: 1.5,
            ),
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.jetBrainsMono(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color:
                  _hovering ? AppColors.textPrimary : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SocialIcon({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _hovering = true),
          onExit: (_) => setState(() => _hovering = false),
          child: GestureDetector(
            onTap: widget.onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color:
                    _hovering ? AppColors.surfaceElevated : AppColors.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _hovering ? AppColors.accent : AppColors.border,
                  width: 1,
                ),
              ),
              child: Icon(
                widget.icon,
                size: 16,
                color:
                    _hovering ? AppColors.accentLight : AppColors.textSecondary,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          widget.label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
  }
}
