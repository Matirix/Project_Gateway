class Patient {
  String? name;
  int? age;
  DateTime? dob;
  String? sex;
  String? insuranceProvider;
  List<Drug>? medications;
  List<DoctorNote>? doctorNotes;
  List<dynamic>? medicalHistory;

  Patient({
    this.name,
    this.age,
    this.dob,
    this.sex,
    this.insuranceProvider,
    this.medications,
    this.doctorNotes,
    this.medicalHistory,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'dob': dob?.toIso8601String(),
      'sex': sex,
      'medications': medications?.map((drug) => drug.toJson()).toList(),
      'doctorNotes': doctorNotes?.map((note) => note.toJson()).toList(),
      'medicalHistory': medicalHistory,
    };
  }
}


class Drug {
  String? name;
  String? dosage;

  Drug({
    this.name,
    this.dosage,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dosage': dosage,
    };
  }
}


class DoctorNote {
  DateTime? date;
  String? noteId;
  String? doctorName;
  String? content;

  DoctorNote({
    this.date,
    this.noteId,
    this.doctorName,
    this.content,
  });

  @override
  String toString() {
    return 'Date: ${date?.toString()}, Note ID: $noteId, Doctor: $doctorName, Content: $content';
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'noteId': noteId,
      'doctorName': doctorName,
      'content': content,
    };
  }
}
