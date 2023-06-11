import 'dart:convert';

import 'package:intl/intl.dart';

class ClinicalNote {
  final DateTime? date;
  final String? patientName;
  final String? content;

  ClinicalNote({this.date, this.patientName, this.content});

  Map<String, dynamic> toJson() {
    return {
      'date': date?.toIso8601String(),
      'patientName': patientName,
      'content': content,
    };
  }

  String appointmentTimeHourMinute() {
    return DateFormat.Hm().format(date!);
  }

  String appointmentDateFormatted() {
    return DateFormat('MM-dd-yyyy').format(date!);
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
