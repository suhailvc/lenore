import 'package:flutter/material.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/presentation/widgets/name_top_bar.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var querySize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: const Text('Privacy Policy'),
      //   elevation: 0,
      // ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customOneSizedBox(querySize),
            nameTopBar(querySize, context, 'Order History'),
            customSizedBox(querySize),
            const Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Lenore.qa is committed to protecting your privacy. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you visit our website Lenore.qa, including any other media form, media channel, mobile website, or mobile application related or connected thereto. Please read this privacy policy carefully. If you do not agree with the terms of this privacy policy, please do not access the site.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            _buildExpandableSection(
              context,
              '1. Information We Collect',
              [
                _buildSubSection(
                  '1.1. Personal Information',
                  'We may collect personal information such as your name, email address, mailing address, phone number, QID or Passport information, payment information, and other details you provide when you make a purchase or create an account.',
                ),
                _buildSubSection(
                  '1.2. Non-Personal Information',
                  'We may collect non-personal information about you such as your browser type, language preference, referring site, and the date and time of each visitor request.',
                ),
                _buildSubSection(
                  '1.3. Cookies',
                  'We may use cookies and similar tracking technologies to collect information and improve our services. You can instruct your browser to refuse all cookies or to indicate when a cookie is being sent.',
                ),
              ],
            ),
            _buildExpandableSection(
              context,
              '2. How We Use Your Information',
              [
                _buildSubSection(
                  '2.1. Usage',
                  '• To operate and maintain the Site\n'
                      '• To process and fulfill orders, including sending you emails related to your order or account\n'
                      '• To improve customer service\n'
                      '• To personalize user experience and respond to your inquiries\n'
                      '• To send you promotional information, newsletters, or marketing communications (you may opt out of receiving these communications at any time)',
                ),
              ],
            ),
            _buildExpandableSection(
              context,
              '3. Sharing Your Information',
              [
                _buildSubSection(
                  '3.1. Data Sharing Policy',
                  'We do not sell, trade, or otherwise transfer to outside parties your personally identifiable information. This does not include trusted third parties who assist us in operating our website, conducting our business, or servicing you, as long as those parties agree to keep this information confidential.',
                ),
                _buildSubSection(
                  '3.2. Legal Compliance',
                  'We may also release your information when we believe release is appropriate to comply with the law, enforce our site policies, or protect ours or others\' rights, property, or safety.',
                ),
              ],
            ),
            _buildExpandableSection(
              context,
              '4. Your Choices Regarding Your Information',
              [
                _buildSubSection(
                  '4.1. Account Settings',
                  'You can update your account information and communication preferences by logging into your account settings page.',
                ),
                _buildSubSection(
                  '4.2. Unsubscribe Options',
                  'You may unsubscribe from receiving promotional emails from us by following the instructions provided in those emails.',
                ),
              ],
            ),
            _buildExpandableSection(
              context,
              '5. Changes to This Privacy Policy',
              [
                _buildSubSection(
                  '5.1. Updates',
                  'We may update this Privacy Policy from time to time in order to reflect, for example, changes to our practices or for other operational, legal, or regulatory reasons.',
                ),
              ],
            ),
            _buildExpandableSection(
              context,
              '6. Contact Us',
              [
                _buildSubSection(
                  '6.1. Contact Information',
                  'If you have any questions about this Privacy Policy, please contact us at +974 3000 0822 or support@lenore.qa',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandableSection(
      BuildContext context, String title, List<Widget> children) {
    return ExpansionTile(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      children: children,
      initiallyExpanded: true,
    );
  }

  Widget _buildSubSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
