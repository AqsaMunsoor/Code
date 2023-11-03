import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scalpinspector_app/animation.dart';

import '../db_helper.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  HistoryScreenState createState() => HistoryScreenState();
}

class HistoryScreenState extends State<HistoryScreen> {
  final TextEditingController _medicationController = TextEditingController();
  final TextEditingController _diseaseController = TextEditingController();
  final TextEditingController _improvementController = TextEditingController();
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  List<Result> _results = [];

  @override
  void initState() {
    super.initState();
    _getAllResults(); // Call the method to load results from the database
  }

  void _getAllResults() async {
    List<Result> results = await _databaseHelper.getAllResults();
    setState(() {
      _results = results;
      _results.sort((a, b) => b.date.compareTo(a.date));
    });
  }

  void _addResult() async {
    String medication = _medicationController.text;
    String disease = _diseaseController.text;
    double improvement = double.tryParse(_improvementController.text) ?? 0.0;
    DateTime date = DateTime.now();

    Result result = Result(
      medication: medication,
      disease: disease,
      date: date,
      improvement: improvement,
    );

    int id = await _databaseHelper.insertResult(result);

    setState(() {
      _results.add(result.copyWith(id: id));
    });

    _clearTextFields();
  }

  void _clearTextFields() {
    _medicationController.clear();
    _diseaseController.clear();
    _improvementController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/green_back.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(
              color: Colors.white,
              size: 35,
            ),
          ),
          floatingActionButton: Align(
            alignment: Alignment.bottomCenter,
            child: FloatingActionButton(
              backgroundColor: Colors.green.shade200,
              onPressed: _showAddDialog,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
          body: Column(
            children: [
              Column(
                children: [
                  FadeAnimation(
                    delay: 1,
                    child: SizedBox(
                      child: Image.network(
                          'https://cdn-icons-png.flaticon.com/128/2707/2707335.png'),
                      width: 100,
                      height: 100,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _results.length,
                  itemBuilder: (BuildContext context, int index) {
                    Result result = _results[index];
                    return ListTile(
                      title: Text(
                        'Medication: ${result.medication}\nDisease: ${result.disease}\nDate: ${result.date.toString().split(' ')[0]} \n Time: ${result.date.toString().split(' ')[1]}',
                      ),
                      subtitle: LinearProgressIndicator(
                        value: result.improvement,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Result'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: [
                TextField(
                  controller: _medicationController,
                  decoration: const InputDecoration(labelText: 'Medication'),
                ),
                TextField(
                  controller: _diseaseController,
                  decoration: const InputDecoration(labelText: 'Disease'),
                ),
                TextField(
                  controller: _improvementController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Improvement'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _addResult();
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
