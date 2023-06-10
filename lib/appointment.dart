import 'package:prj_gateway/patient.dart';

class Appointment {
  DateTime? appointmentTime;
  String? appointmentNotes;
  Patient? patient;

  Appointment({
    this.appointmentTime,
    this.appointmentNotes,
    this.patient,
  });

  Map<String, dynamic> toJson() {
    return {
      'appointmentTime': appointmentTime?.toIso8601String(),
      'appointmentNotes': appointmentNotes,
      'patient': patient?.toJson(),
    };
  }

  @override
  String toString() {
    String patientString = patient != null ? patient.toString() : 'No patient assigned';
    return 'Appointment Time: $appointmentTime\n'
        'Appointment Notes: $appointmentNotes\n'
        'Patient: $patientString';
  }

}