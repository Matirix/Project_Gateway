class Patient {
  String? name;
  int? age;
  DateTime? dob;
  String? sex;
  List<Drug>? medications;
  List<DoctorNote>? doctorNotes;
  List<dynamic>? medicalHistory;

  Patient({
    this.name,
    this.age,
    this.dob,
    this.sex,
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
  double? dosage;

  Drug({
    this.name,
    this.dosage,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name
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

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'noteId': noteId,
      'doctorName': doctorName,
      'content': content,
    };
  }
}
