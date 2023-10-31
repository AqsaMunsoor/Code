import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Scalp Inspector'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to Scalp Inspector!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'At Scalp Inspector, our mission is to empower individuals to take control of their scalp health and find effective solutions for their scalp-related concerns. We understand the impact that scalp issues can have on self-confidence and overall well-being, and we\'re here to provide a comprehensive and user-friendly platform to address those concerns.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 24.0),
            Text(
              'Key Features of Scalp Inspector:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            FeatureItem(
              icon: Icons.track_changes,
              title: 'Scalp Condition Tracking',
              description:
              'Monitor the health of your scalp over time, allowing you to detect any changes or progress in your condition.',
            ),
            FeatureItem(
              icon: Icons.chat_bubble,
              title: 'Virtual Assistant',
              description:
              'Our intelligent virtual assistant provides guidance and helps you find the right doctors and specialists in your local area who can assist with your specific scalp issues.',
            ),
            FeatureItem(
              icon: Icons.medical_services,
              title: 'Personalized Medicine Recommendations',
              description:
              'Based on your scalp condition and specific needs, Scalp Inspector suggests two types of medicines: Allopecia and Home Remedies. Choose the option that aligns with your preferences and requirements.',
            ),
            FeatureItem(
              icon: Icons.timeline,
              title: 'Progress Monitoring',
              description:
              'Keep track of your progress and see the effectiveness of the treatments you\'re using. Scalp Inspector helps you stay motivated and informed on your journey towards a healthier scalp.',
            ),
            SizedBox(height: 24.0),
            Text(
              'Join thousands of satisfied users who have found relief and improved confidence through Scalp Inspector. Take the first step towards a healthier scalp today!',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}

class FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 40.0,
            color: Colors.blue,
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  description,
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
