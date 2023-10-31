import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'db_helper.dart';
import 'disease_screen.dart';
import 'medication_screen.dart';

class ResultScreen extends StatelessWidget {
  final File? imageFile;
  final String? diseaseName;
  final String? confidenceScore;

  const ResultScreen(
      {Key? key,
      required this.imageFile,
      required this.diseaseName,
      required this.confidenceScore})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            imageFile != null
                ? Image.file(imageFile!, width: 300, height: 250)
                : Placeholder(fallbackHeight: 200),
            Text(
              'Disease Detected:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              diseaseName!,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            // Text(
            //   'Score:',
            //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            // ),
            // SizedBox(height: 10),
            // Text(
            //   confidenceScore!,
            //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            // ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _saveResultToDatabase(diseaseName!, confidenceScore!);
              },
              child: Text('Save Result'),
            ),
            //medication page
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MedicationScreen(
                          diseaseType: matchDiseaseNameWithEnums(diseaseName!),
                        )));
              },
              child: Text('Medication'),
            ),
          ],
        ),
      ),
    );
  }

  matchDiseaseNameWithEnums(String diseaseName) {
    if (diseaseName.toLowerCase() == 'healthy') {
      return DiseaseType.Healthy;
    } else if (diseaseName.toLowerCase() == 'alopecia') {
      return DiseaseType.Alopecia;
    }
    //for seborrheic dermatitis
    else if (diseaseName.toLowerCase() == 'seborrheic') {
      return DiseaseType.Seborrheic;
    }
    //for folliculitis
    else if (diseaseName.toLowerCase() == 'folliculitis') {
      return DiseaseType.Folliculitis;
    }
    //for dandruff
    else if (diseaseName.toLowerCase() == 'dandruff') {
      return DiseaseType.Dandruff;
    } else {
      return DiseaseType.Healthy;
    }
  }

  Future<void> _saveResultToDatabase(String disease, String medication) async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    int id = await databaseHelper.insertApiResult(disease, medication);
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Text('Result saved to database.'),
        duration: Duration(seconds: 1),
      ),
    );
  }
}
