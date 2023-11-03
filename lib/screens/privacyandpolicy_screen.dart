import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy and Policy'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy and Policy',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'At Scalp Inspector, we are committed to protecting your privacy and ensuring the security of your personal information. This Privacy and Policy page explains how we collect, use, and safeguard your data when you use our application. By using Scalp Inspector, you agree to the terms and conditions outlined in this policy. Please read this document carefully.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '1. Accessibility',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'We strive to make Scalp Inspector accessible to all users, regardless of their abilities or disabilities. Our application is designed with accessibility features to provide an inclusive user experience. We are continuously working to improve accessibility and welcome your feedback on how we can enhance our app for everyone.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '2. Reliability',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'We make every effort to ensure that Scalp Inspector is a reliable and accurate tool for diagnosing diseases. However, it is important to note that our application provides general information and should not be considered a substitute for professional medical advice. Always consult with a qualified healthcare provider for a proper diagnosis and treatment plan.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '3. Compatibility',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Scalp Inspector is compatible with a wide range of devices and operating systems. We regularly update our application to ensure compatibility with the latest technologies and platforms. However, please note that older devices or outdated software versions may not fully support all features of our app. It is recommended to use Scalp Inspector on devices with up-to-date software for the best user experience.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '4. Data Security',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'We take data security seriously and implement industry-standard measures to protect your personal information. Scalp Inspector securely stores your data and ensures that it is only accessible to authorized personnel. We do not share your data with third parties without your explicit consent, except as required by law.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '5. Data Collection',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'When you use Scalp Inspector, we may collect certain data to improve our services and provide a personalized experience. This may include anonymous usage statistics, diagnostic results, and user feedback. We do not collect any personally identifiable information without your consent.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '6. Third-Party Services',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Scalp Inspector may integrate with third-party services, such as chatbots or medication providers, to enhance your experience. When using these services, you may be subject to their respective privacy policies and terms of service. We encourage you to review the policies of these third parties before sharing any personal information with them.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '7. Changes to the Privacy Policy',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Scalp Inspector reserves the right to update or modify this Privacy and Policy page at any time. We will notify you of any significant changes through the app or by other means of communication. By continuing to use the application after the updates, you agree to the revised terms.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '8. Contact Us',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'If you have any questions or concerns regarding our Privacy and Policy, please contact us at support@scalpinspector.com. We will be happy to assist you and address any issues.',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Privacy and Policy Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const PrivacyPolicyScreen(),
  ));
}
