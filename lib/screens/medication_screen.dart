import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scalpinspector_app/screens/disease_screen.dart';
import 'package:scalpinspector_app/home_remedies.dart';

import 'alopethic_screen.dart';

class MedicationScreen extends StatelessWidget {
  final DiseaseType diseaseType;

  const MedicationScreen({super.key, required this.diseaseType});

  void _navigateToHomeRemediesScreen(BuildContext context) {
    Get.to(HomeRemedies(), arguments: [diseaseType]);
  }

//same for alopethic screen
  void _navigateToAllopathicMedicineScreen(BuildContext context) {
    Get.to(AlopethicScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medication'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              'assets/medicine.jpg',
              width: 200.0,
            ),
            SizedBox(height: 20.0),
            Spacer(),
            InkWell(
              onTap: () {
                _navigateToHomeRemediesScreen(context);
              },
              child: Container(
                width: Get.width,
                color: Colors.grey[300],
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    // Image.asset(
                    //   'assets/allopathic_medicine_pic.png',
                    //   width: 100.0,
                    //   height: 100.0,
                    // ),
                    Icon(Icons.medical_services, size: 50.0),
                    Spacer(),
                    Text('Home Remedies', style: TextStyle(fontSize: 25.0)),
                    SizedBox(width: 16.0),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),
            SizedBox(height: 16.0),
            InkWell(
              onTap: () {
                _navigateToAllopathicMedicineScreen(context);
              },
              child: Container(
                width: Get.width,
                color: Colors.grey[300],
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    // Image.asset(
                    //   'assets/allopathic_medicine_pic.png',
                    //   width: 100.0,
                    //   height: 100.0,
                    // ),
                    Icon(Icons.medical_information, size: 50.0),
                    Spacer(),
                    Text('Allopathic Medicine',
                        style: TextStyle(fontSize: 25.0)),
                    SizedBox(width: 16.0),
                  ],
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
