import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../app_colors.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isNarrow = width < 700;
    final hPad = isNarrow ? 24.0 : 80.0;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(hPad, 24, hPad, 24),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: isNarrow
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLogo(),
                const SizedBox(height: 16),
                _buildLinks(),
                const SizedBox(height: 16),
                _buildCopyright(),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLogo(),
                const Spacer(),
                _buildLinks(),
                const Spacer(),
                _buildCopyright(),
              ],
            ),
    );
  }

  Widget _buildLogo() {
    return Text(
      'IREMIDE.DEV',
      style: GoogleFonts.jetBrainsMono(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: AppColors.textSecondary,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildLinks() {
    final links = <(String, VoidCallback)>[
      (
        'GitHub',
        () async {
          final uri = Uri.parse('https://github.com/Iremide-ds');
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        }
      ),
      (
        'LinkedIn',
        () async {
          final uri = Uri.parse(
              'https://www.linkedin.com/in/iremide-adeboye-02b2b5206/');
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        }
      )
    ];
    return Wrap(
      spacing: 24,
      children: links
          .map((l) => _FooterLink(
                label: l.$1,
                onTap: l.$2,
              ))
          .toList(),
    );
  }

  Widget _buildCopyright() {
    return Text(
      "© ${DateTime.now().year} Iremide's Portfolio. Engineered with Flutter Web.",
      style: GoogleFonts.jetBrainsMono(
        fontSize: 10,
        color: AppColors.accent.withOpacity(0.7),
      ),
    );
  }
}

class _FooterLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _FooterLink({required this.label, required this.onTap});

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 150),
          style: GoogleFonts.jetBrainsMono(
            fontSize: 11,
            color: _hovering ? AppColors.textPrimary : AppColors.textMuted,
          ),
          child: Text(widget.label),
        ),
      ),
    );
  }
}
