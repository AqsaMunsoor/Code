// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scalpinspector_app/animation.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/orange_back.png',
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
          body: Column(
            children: [
              Column(
                children: [
                  FadeAnimation(
                    delay: 1,
                    child: SizedBox(
                      child: Image.network(
                          'https://cdn-icons-png.flaticon.com/128/1147/1147509.png'),
                      width: 100,
                      height: 100,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 100, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Gutter(),
                        GestureDetector(
                          onTap: _selectDate,
                          child: Container(
                            height: 50,
                            width: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.orange.shade200,
                            ),
                            child: Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.calendar_month_rounded,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                Text(
                                  'Select Date',
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            )),
                          ),
                        ),
                        const Gutter(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              selectedDate != null
                                  ? 'Selected Date: ${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}'
                                  : 'No Date Selected',
                              style: GoogleFonts.roboto(
                                fontSize: 18.0,
                                letterSpacing: 2,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        const Gutter(),
                        GestureDetector(
                          onTap: _setReminder,
                          child: Container(
                            height: 50,
                            width: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.orange.shade200,
                            ),
                            child: Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.notifications_rounded,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                Text(
                                  'Set Reminder',
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            )),
                          ),
                        ),
                        const Gutter(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
