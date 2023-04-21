import 'package:flutter/material.dart';
import 'package:flutter_training/model/example_model.dart';
import 'package:flutter_training/pages/submit_attendance_page.dart';

class ListAttendancePage extends StatelessWidget {
  const ListAttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Back"),
            ),
          ),
          SizedBox(height: 12),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/submit-attendance', arguments: "String");
              },
              child: Text("Next"),
            ),
          ),
        ],
      ),
    );
  }
}
