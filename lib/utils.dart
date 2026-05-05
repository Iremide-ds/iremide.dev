import 'package:url_launcher/url_launcher.dart';

Future<void> launchCV() async {
  final uri = Uri.parse(
    'https://drive.google.com/file/d/1GlDuCFxdLPM_q-Xz2ZTKd0lS03XVTUD2/view?usp=sharing',
  );

  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
