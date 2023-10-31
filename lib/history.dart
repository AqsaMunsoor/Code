import 'package:flutter/material.dart';

import 'db_helper.dart';

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
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('History'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/clock_pic.png',
            height: 200.0,
            width: 200.0,
          ),
          // Replace with your clock image path
          SizedBox(height: 16.0),
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
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Result'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: [
                TextField(
                  controller: _medicationController,
                  decoration: InputDecoration(labelText: 'Medication'),
                ),
                TextField(
                  controller: _diseaseController,
                  decoration: InputDecoration(labelText: 'Disease'),
                ),
                TextField(
                  controller: _improvementController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Improvement'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _addResult();
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
