import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scalp Inspector',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ServicesScreen(),
    );
  }
}

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Services'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              'Welcome to Scalp Inspector Services!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ListView(
              children: const [
                ServiceItem(
                  title: 'Scalp Analysis',
                  image: 'assets/track_scalp_condition.jpg',
                  description:
                      'Offer a service to analyze the health of the user scalp using images. Use computer vision algorithms to detect common scalp issues such as dandruff, alopecia, seborrheic and folliculitis.',
                ),
                ServiceItem(
                  title: 'Virtual Assistance',
                  image: 'assets/virtual_assistance.jpg',
                  description:
                      'Our virtual assistant is your trusted companion in finding the right doctors for your scalp concerns. With our advanced technology, we connect you with a network of skilled and experienced doctors in your area. Our virtual assistant simplifies the process by providing personalized recommendations based on your specific needs. From dermatologists to trichologists, our virtual assistant guides you in selecting the ideal healthcare professional who specializes in scalp health. Take advantage of our virtual assistant to make informed decisions and embark on your journey towards a healthier scalp.',
                ),
                ServiceItem(
                  title: 'Medicines',
                  image: 'assets/medicine.jpg',
                  description:
                      'We provide two types of medicines:\n\n1. Home Remedies\n2. Allopathic Medicines\n\n Allopecia medication includes scientifically formulated treatments that target specific scalp issues and promote hair growth. On the other hand, our home remedies consist of natural ingredients and DIY solutions that provide gentle care and nourishment to the scalp. Whether you prefer clinically tested solutions or holistic approaches, our range of medicines caters to your individual needs. Choose the option that suits you best for effective scalp care and restoration.',
                ),
                ServiceItem(
                  title: 'Track Your Progress',
                  image: 'assets/track_progress.jpg',
                  description:
                      ' Implement a feature that enables users to track their scalp health progress over time. Set reminders for regular scalp care routines, product application, or follow-up appointments.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceItem extends StatelessWidget {
  final String title;
  final String image;
  final String description;

  const ServiceItem({
    super.key,
    required this.title,
    required this.image,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ServiceDetailsPage(
              title: title,
              image: image,
              description: description,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            Image.asset(
              image,
              width: 200,
            ),
            const SizedBox(height: 16.0),
            Text(
              description,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceDetailsPage extends StatelessWidget {
  final String title;
  final String image;
  final String description;

  const ServiceDetailsPage({
    super.key,
    required this.title,
    required this.image,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style:
                  const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            Image.asset(
              image,
              width: 200,
            ),
            const SizedBox(height: 16.0),
            Text(
              description,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
