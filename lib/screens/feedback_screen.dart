// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  String feedbackText = '';
  IconData selectedEmoji = Icons.sentiment_neutral;

  void selectEmoji(IconData emoji) {
    setState(() {
      selectedEmoji = emoji;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'How was your experience?',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () =>
                          selectEmoji(Icons.sentiment_very_dissatisfied),
                      child: Icon(
                        Icons.sentiment_very_dissatisfied,
                        size: 40.0,
                        color:
                            selectedEmoji == Icons.sentiment_very_dissatisfied
                                ? Colors.red
                                : null,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => selectEmoji(Icons.sentiment_dissatisfied),
                      child: Icon(
                        Icons.sentiment_dissatisfied,
                        size: 40.0,
                        color: selectedEmoji == Icons.sentiment_dissatisfied
                            ? Colors.orange
                            : null,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => selectEmoji(Icons.sentiment_neutral),
                      child: Icon(
                        Icons.sentiment_neutral,
                        size: 40.0,
                        color: selectedEmoji == Icons.sentiment_neutral
                            ? Colors.yellow
                            : null,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => selectEmoji(Icons.sentiment_satisfied),
                      child: Icon(
                        Icons.sentiment_satisfied,
                        size: 40.0,
                        color: selectedEmoji == Icons.sentiment_satisfied
                            ? Colors.lightGreen
                            : null,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => selectEmoji(Icons.sentiment_very_satisfied),
                      child: Icon(
                        Icons.sentiment_very_satisfied,
                        size: 40.0,
                        color: selectedEmoji == Icons.sentiment_very_satisfied
                            ? Colors.green
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Tell us more about your experience:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Expanded(
                child: TextField(
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: 'Write your feedback here...',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      feedbackText = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 16.0),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Handle submission of feedback
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Feedback Submitted'),
                          content: const Text('Thank you for your feedback!'),
                          actions: [
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.pop(context); // Close the dialog
                                Navigator.pop(
                                    context); // Go back to the home screen
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text('Submit Feedback'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
