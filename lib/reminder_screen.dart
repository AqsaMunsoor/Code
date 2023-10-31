import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ReminderScreen extends StatefulWidget {
  @override
  _ReminderScreenState createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  DateTime? selectedDate;

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _setReminder() {
    if (selectedDate != null) {
      final String formattedDate =
          "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}";
      showToast("Reminder set for $formattedDate");
    } else {
      showToast("Please select a date");
    }
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey[800],
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reminder'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Image.asset('assets/reminder_pic.png'),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: _selectDate,
              icon: Icon(Icons.calendar_today),
              label: Text('Select Date'),
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            selectedDate != null
                ? 'Selected Date: ${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}'
                : 'No Date Selected',
            style: TextStyle(fontSize: 18.0),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.0),
          Container(
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _setReminder,
              child: Text('Set Reminder'),
            ),
          ),
          Spacer(),
          BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.help),
                label: 'Help',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            onTap: (index) {
              if (index == 0) {
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
