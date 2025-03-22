import 'package:flutter/material.dart';
import 'package:lenore/application/localization/localization.dart';
import 'package:lenore/application/provider/locale_provider/locale_provider.dart';
import 'package:lenore/core/constant.dart';
import 'package:provider/provider.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    final currentLocale = Localizations.localeOf(context).languageCode;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: textColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Language',
          style: TextStyle(
            fontFamily: 'Segoe',
            color: textColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // English option
          ListTile(
            title: Text(
              'English',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            leading: Radio<String>(
              value: 'en',
              groupValue: currentLocale,
              activeColor: Colors.teal,
              onChanged: (value) {
                if (value != null) {
                  Provider.of<LocaleProvider>(context, listen: false)
                      .setLocale(Locale(value));
                }
              },
            ),
          ),
          Divider(
            color: Colors.grey.shade300,
            thickness: 1,
            indent: 16,
            endIndent: 16,
          ),
          // Arabic option
          ListTile(
            title: Text(
              'Arabic', //   AppLocalizations.of(context)!.arabic,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            leading: Radio<String>(
              value: 'ar',
              groupValue: currentLocale,
              activeColor: Colors.teal,
              onChanged: (value) {
                if (value != null) {
                  Provider.of<LocaleProvider>(context, listen: false)
                      .setLocale(Locale(value));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
// class LanguageSelectionScreen extends StatefulWidget {
//   const LanguageSelectionScreen({super.key});

//   @override
//   State<LanguageSelectionScreen> createState() =>
//       _LanguageSelectionScreenState();
// }

// class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
//   String _selectedLanguage = 'English';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios, color: textColor),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: Text(
//           'Language',
//           style: TextStyle(
//             fontFamily: 'Segoe',
//             color: textColor,
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           // English option
//           ListTile(
//             title: const Text(
//               'English',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             leading: Radio<String>(
//               value: 'English',
//               groupValue: _selectedLanguage,
//               activeColor: Colors.teal,
//               onChanged: (value) {
//                 setState(() {
//                   _selectedLanguage = value!;
//                 });
//               },
//             ),
//           ),
//           Divider(
//             color: Colors.grey.shade300,
//             thickness: 1,
//             indent: 16,
//             endIndent: 16,
//           ),
//           // Arabic option
//           ListTile(
//             title: Text(
//               'العربية',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             leading: Radio<String>(
//               value: 'العربية',
//               groupValue: _selectedLanguage,
//               activeColor: Colors.teal,
//               onChanged: (value) {
//                 setState(() {
//                   _selectedLanguage = value!;
//                 });
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
