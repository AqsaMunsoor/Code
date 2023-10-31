import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scalp Inspector',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scalp Inspector'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Help'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HelpScreen()),
            );
          },
        ),
      ),
    );
  }
}

class HelpScreen extends StatelessWidget {
  final List<FAQ> faqs = [
    FAQ(
      question: 'How do I track my scalp condition?',
      answer:
      'To track your scalp condition, go to the "Diagnose" section in the app. Follow the instructions to capture images and monitor the progress of your scalp health over time.',
    ),
    FAQ(
      question: 'Can I use the app for hair loss treatment?',
      answer:
      'The Scalp Inspector app is designed to help you monitor and track the condition of your scalp. It does not provide hair loss treatment. We recommend consulting a healthcare professional for personalized advice.',
    ),
    // Add more FAQs here...
  ];

  final String howToGuideVideoUrl =
      'https://example.com/how-to-guide-video.mp4';

  final String howToGuideText =
      'To use the Scalp Inspector app, follow these steps:\n\n'
      '1. Download and install the app from the App Store or Google Play Store.\n'
      '2. Sign up or log in to your account.\n'
      '3. Navigate to the various features of the app, such as diagnosing scalp conditions, tracking progress, and accessing virtual assistance.\n'
      '4. Follow the on-screen instructions and use the app to monitor and improve your scalp health.';

  final String privacyPolicy =
      'At Scalp Inspector, we prioritize the privacy and security of our users. We collect minimal personal information required for app functionality and do not share it with third parties. Your data is encrypted and stored securely. For more details, please read our Privacy Policy on our website.';

  final String termsOfService =
      'By using the Scalp Inspector app, you agree to comply with our Terms of Service. These terms outline the guidelines and rules for using the app. We reserve the right to update or modify the terms at any time. For a complete understanding, please read the Terms of Service on our website.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help'),
        automaticallyImplyLeading: false, // Remove the back button
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/help_image.png',
                  width: 200,
                ),
                SizedBox(height: 16.0),
                Text(
                  'How can we help you?',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 32.0),
                Padding(
                  padding: EdgeInsets.all(8.0), // Adjust the outer padding value as per your requirement
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FAQsScreen(faqs: faqs)),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(16.0), // Adjust the inner padding value as per your requirement
                    ),
                    child: Text('FAQs'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0), // Adjust the outer padding value as per your requirement
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PrivacyPolicyScreen(privacyPolicy: privacyPolicy)),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Adjust the inner padding value as per your requirement
                      child: Text('Privacy Policy'),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0), // Adjust the outer padding value as per your requirement
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TermsOfServiceScreen(termsOfService: termsOfService)),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.all(16.0), // Adjust the inner padding value as per your requirement
                      child: Text('Terms of Service'),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0), // Adjust the outer padding value as per your requirement
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TutorialScreen()),
                      );
                    },
                    child: Text('Tutorial and Guideline'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FAQsScreen extends StatelessWidget {
  final List<FAQ> faqs;

  const FAQsScreen({required this.faqs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQs'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: faqs.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(faqs[index].question),
              subtitle: Text(faqs[index].answer),
            );
          },
        ),
      ),
    );
  }
}

class PrivacyPolicyScreen extends StatelessWidget {
  final String privacyPolicy;

  const PrivacyPolicyScreen({required this.privacyPolicy});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Text(privacyPolicy),
      ),
    );
  }
}

class TermsOfServiceScreen extends StatelessWidget {
  final String termsOfService;

  const TermsOfServiceScreen({required this.termsOfService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms of Service'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Text(termsOfService),
      ),
    );
  }
}

class TutorialScreen extends StatelessWidget {
  final String tutorialDescription =
      'Watch this tutorial to learn how to use the Scalp Inspector app effectively.';
  final String tutorialVideoUrl = 'https://youtu.be/OCnFnBtlg-c';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tutorial and Guideline'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              tutorialDescription,
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            AspectRatio(
              aspectRatio: 16 / 9,
              child: VideoPlayerScreen(videoUrl: tutorialVideoUrl),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoPlayerScreen extends StatelessWidget {
  final String videoUrl;

  const VideoPlayerScreen({required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(videoUrl)!,
        flags: YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ),
      ),
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.blueAccent,
      progressColors: ProgressBarColors(
        playedColor: Colors.blue,
        handleColor: Colors.blueAccent,
      ),
      onReady: () {},
      onEnded: (_) {},
    );
  }
}

class FAQ {
  final String question;
  final String answer;

  FAQ({required this.question, required this.answer});
}
