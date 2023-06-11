import 'dart:convert';

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

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}