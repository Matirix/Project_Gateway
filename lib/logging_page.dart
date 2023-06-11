import 'package:flutter/material.dart';
import 'package:prj_gateway/patient.dart';
import '../open_ai.dart';

class LoggingPage extends StatefulWidget {
  const LoggingPage({super.key});

  @override
  State<LoggingPage> createState() => _LoggingPageState();
}

class _LoggingPageState extends State<LoggingPage> {
  final TextEditingController prompt = TextEditingController();

  String responseData = '';

  Patient patient = Patient(
    name: 'John Doe',
    age: 30,
    dob: DateTime(1992, 10, 15),
    sex: 'M',
    insuranceProvider: 'ABC Insurance',
    medications: [
      Drug(name: 'Fluoxetine', dosage: "2.5mg"),
      Drug(name: 'Loratadine', dosage: "0.5mg"),
    ],
    doctorNotes: [
      DoctorNote(
        date: DateTime(2023, 6, 10),
        noteId: 'N001',
        doctorName: 'Dr. Smith',
        content:
            'The purpose of this note is to provide information regarding their respiratory infection and necessary medical attention.',
      ),
    ],
    medicalHistory: [
      'Diagnosed in 2012, controlled through diet and exercise. No medication required.',
      'Known allergy to penicillin.'
    ],
  );

  Future<void> getResponse(String prompt) async {
    responseData = await callOpenAI(1, patient);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your logic here
          // This callback will be invoked when the button is pressed
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
          child: Column(
        children: [
          TextField(
            controller: prompt,
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: const Color(0xFFF2F2F2),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              contentPadding: const EdgeInsets.only(
                top: -15,
                left: 10,
                right: 10,
              ),
              labelText: 'Prompt',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10), // Set border radius
                borderSide: const BorderSide(
                  color: Color(0xfff1f1f1), // Customize border color
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10), // Set border radius
                borderSide: const BorderSide(
                  color: Color(0xfff1f1f1), // Customize focused border color
                ),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () => getResponse(prompt.text),
              child: const Text('Submit')),
          Text(responseData),
        ],
      )),
    );
  }
}
