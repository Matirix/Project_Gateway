import 'package:flutter/material.dart';
import 'package:prj_gateway/patient.dart';
import 'package:prj_gateway/sign_in.dart';
import 'appointment.dart';

Future<void> main() async {
  runApp(const MyApp());

  // ------------------ Create a Patient instance for testing ------------------//
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

  // ------------------ Test calling callOpenAI in open_ai.dart file ------------------//
  // try {
  //   final response = await callOpenAI(1, patient);
  //   debugPrint('API response: $response');
  // } catch (error) {
  //   debugPrint('Error: $error');
  // }

  // ------------------ Create an appointment instance for testing ------------------//
  Appointment appointment = Appointment(
    appointmentTime: DateTime(2023, 6, 15, 10, 30),
    appointmentNotes: 'Follow-up appointment',
    patient: patient,
  );

  Map<String, dynamic> appointmentJson = appointment.toJson();
  debugPrint('Appointment JSON $appointmentJson');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SignIn(),
    );
  }
}
