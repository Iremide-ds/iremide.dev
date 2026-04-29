import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_colors.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  bool _sending = false;
  bool _sent = false;

  Future<void> _handleSend() async {
    if (_emailController.text.isEmpty || _messageController.text.isEmpty)
      return;
    setState(() => _sending = true);
    await Future.delayed(const Duration(milliseconds: 1200));
    setState(() {
      _sending = false;
      _sent = true;
    });
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      setState(() {
        _sent = false;
        _emailController.clear();
        _messageController.clear();
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isNarrow = width < 700;
    final hPad = isNarrow ? 24.0 : 80.0;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(hPad, 80, hPad, 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border, width: 1),
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent.withOpacity(0.06),
                  blurRadius: 60,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Initiate Connection',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(duration: 400.ms),
                const SizedBox(height: 12),
                Text(
                  "Whether it's a complex Flutter architecture or a fast Go backend, let's discuss how we can build something robust together.",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ).animate(delay: 100.ms).fadeIn(duration: 400.ms),
                const SizedBox(height: 32),

                // Email field
                const _FieldLabel(label: 'Transmission Protocol (Email)'),
                const SizedBox(height: 8),
                _CodeTextField(
                  controller: _emailController,
                  hint: 'hello@domain.com',
                  maxLines: 1,
                ),
                const SizedBox(height: 20),

                // Message field
                const _FieldLabel(label: 'Payload (Message)'),
                const SizedBox(height: 8),
                _CodeTextField(
                  controller: _messageController,
                  hint: 'print("Hello World");',
                  maxLines: 5,
                ),
                const SizedBox(height: 24),

                // Send button
                _SendButton(
                  sending: _sending,
                  sent: _sent,
                  onTap: _handleSend,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String label;
  const _FieldLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: GoogleFonts.jetBrainsMono(
          fontSize: 11,
          color: AppColors.textMuted,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _CodeTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final int maxLines;

  const _CodeTextField({
    required this.controller,
    required this.hint,
    required this.maxLines,
  });

  @override
  State<_CodeTextField> createState() => _CodeTextFieldState();
}

class _CodeTextFieldState extends State<_CodeTextField> {
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (f) => setState(() => _focused = f),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          color: AppColors.surfaceElevated,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color:
                _focused ? AppColors.accent.withOpacity(0.6) : AppColors.border,
            width: 1,
          ),
          boxShadow: _focused
              ? [
                  BoxShadow(
                    color: AppColors.accent.withOpacity(0.12),
                    blurRadius: 12,
                    spreadRadius: 0,
                  )
                ]
              : [],
        ),
        child: TextField(
          controller: widget.controller,
          maxLines: widget.maxLines,
          style: GoogleFonts.jetBrainsMono(
            fontSize: 13,
            color: AppColors.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: GoogleFonts.jetBrainsMono(
              fontSize: 13,
              color: AppColors.textMuted,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ),
    );
  }
}

class _SendButton extends StatefulWidget {
  final bool sending;
  final bool sent;
  final VoidCallback onTap;

  const _SendButton({
    required this.sending,
    required this.sent,
    required this.onTap,
  });

  @override
  State<_SendButton> createState() => _SendButtonState();
}

class _SendButtonState extends State<_SendButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.sending || widget.sent ? null : widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: double.infinity,
          height: 48,
          decoration: BoxDecoration(
            color: widget.sent
                ? AppColors.green
                : _hovering
                    ? AppColors.accentLight
                    : AppColors.accent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: _hovering && !widget.sent
                ? [
                    BoxShadow(
                      color: AppColors.accent.withOpacity(0.4),
                      blurRadius: 20,
                    )
                  ]
                : [],
          ),
          child: Center(
            child: widget.sending
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.sent ? 'Transmission Sent!' : 'Execute Send',
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        widget.sent ? Icons.check_rounded : Icons.send_rounded,
                        size: 16,
                        color: Colors.white,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
