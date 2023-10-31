import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:scalpinspector_app/animation.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HelpScreen extends StatefulWidget {
  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
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

  List<Color> customColor = <Color>[
    Colors.blue.shade200,
    Colors.orange.shade200,
    Colors.pink.shade200,
    Colors.green.shade200
  ];

  // List<String> images = [
  List<String> titles = [
    'FaQs',
    'Privacy Policy',
    'Terms of Service',
    'Tutorial and Guideline',
  ];

  void _navigateToScreen(int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FAQsScreen(
                    faqs: faqs,
                  )),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PrivacyPolicyScreen(
                    privacyPolicy: privacyPolicy,
                  )),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TermsOfServiceScreen(
                    termsOfService: termsOfService,
                  )),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TutorialScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: width,
                height: height / 3.5,
                // color: Colors.blue,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      HexColor('fccc8c'),
                      HexColor('fab67e'),
                      HexColor('f89f6f'),
                      HexColor('f78961'),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FadeAnimation(
                      delay: 1,
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(
                            'https://cdn-icons-png.flaticon.com/128/4288/4288903.png'),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              )),
          Positioned(
            top: 200,
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
              width: width,
              height: height / 1.5,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(30))),
              child: FadeAnimation(
                delay: 1.4,
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        _navigateToScreen(index);
                      },
                      child: Container(
                        height: width / 5.5,
                        margin: EdgeInsets.symmetric(
                          horizontal: width / 20,
                          vertical: width / 30,
                        ),
                        decoration: BoxDecoration(
                            color: customColor[index],
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 30,
                                spreadRadius: 5,
                              ),
                            ]),
                        child: Center(
                          child: Text(
                            titles[index],
                            style: GoogleFonts.robotoCondensed(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 3,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
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
        title: const Text('FAQs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
        title: const Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
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
        title: const Text('Terms of Service'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
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
        title: const Text('Tutorial and Guideline'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              tutorialDescription,
              style: const TextStyle(fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
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
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ),
      ),
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.blueAccent,
      progressColors: const ProgressBarColors(
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
