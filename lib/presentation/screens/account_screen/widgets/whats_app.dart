import 'package:url_launcher/url_launcher.dart';

Future<void> openWhatsApp() async {
  // const phoneNumber = "19544556395";
  //final whatsappUrl = "https://wa.me/$phoneNumber";
  final whatsappUrl = Uri.parse('https://wa.me/+97431243888');

  //if (
  //await canLaunchUrl(whatsappUrl);
  //) {
  await launchUrl(whatsappUrl);
  // } else {
  //   throw "Could not open WhatsApp";
  // }
}
