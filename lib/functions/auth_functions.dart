import 'package:url_launcher/url_launcher.dart';

class FunctionsAuth {
  static Future<void> launchWhatsApp() async {
    const whatsappUrl = "https://wa.me/212648446217";
    if (!await launchUrl(Uri.parse(whatsappUrl),
        mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch WhatsApp');
    }
  }
}
