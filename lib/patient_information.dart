import 'package:flutter/material.dart';

import 'patient.dart';

class PatientInformation extends StatefulWidget {
  const PatientInformation({super.key, required this.patient});

  final Patient patient;

  @override
  State<PatientInformation> createState() => _PatientInformationState();
}

class _PatientInformationState extends State<PatientInformation> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
