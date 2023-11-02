import 'package:flutter/material.dart';
import 'package:scalpinspector_app/screens/medication_screen.dart';

enum DiseaseType {
  Alopecia,
  Dandruff,
  Folliculitis,
  Seborrheic,
  Healthy,
}

class DiseaseScreen extends StatefulWidget {
  @override
  _DiseaseScreenState createState() => _DiseaseScreenState();
}

class _DiseaseScreenState extends State<DiseaseScreen> {
  late DiseaseType _selectedDisease;

  void _detectDisease() {
    // Implement disease detection logic here
    // Based on the detection result, set the appropriate disease
    // You can replace this logic with your actual disease detection algorithm

    // For example, if disease is detected:
    _selectedDisease = DiseaseType.Alopecia;

    // If disease is not detected:
    // _selectedDisease = DiseaseType.Healthy;

    setState(() {});
  }

  void _navigateToMedicationScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              MedicationScreen(diseaseType: _selectedDisease)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Diagnose'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                width: screenSize.width * 0.4,
                height: screenSize.width * 0.4,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: IconButton(
                  icon: const Icon(Icons.camera_alt),
                  iconSize: screenSize.width * 0.3,
                  onPressed: () {
                    // Implement camera/gallery functionality here
                  },
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _detectDisease();
              },
              child: const Text('Submit'),
            ),
            if (_selectedDisease != null &&
                _selectedDisease != DiseaseType.Healthy) ...[
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  _navigateToMedicationScreen();
                },
                child: const Text('Medication'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  MedicationScreen({required DiseaseType diseaseType}) {}
}
