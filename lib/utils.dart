import 'package:url_launcher/url_launcher.dart';

Future<void> launchCV() async {
  final uri = Uri.parse(
    'https://drive.google.com/drive/folders/1Zu6Yz9D4GlvBF-AH6uCyT-nzWYiJaPWR?usp=sharing',
  );

  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
