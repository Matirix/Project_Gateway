import 'package:prj_gateway/patient.dart';

import 'appointment.dart';

Patient john = Patient(
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
      date: DateTime(2023, 6, 11),
      noteId: 'N001',
      doctorName: 'Dr. Smith',
      content:
          'The purpose of this note is to provide information regarding their respiratory infection and necessary medical attention.',
    ),
    DoctorNote(
      date: DateTime(2023, 6, 15),
      noteId: 'N001',
      doctorName: 'Dr. Smith',
      content:
          'The purpose of this note is to provide information regarding their respiratory infection and necessary medical attention.',
    ),
    DoctorNote(
      date: DateTime(2023, 6, 13),
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
Patient april = Patient(
  name: 'April Doe',
  age: 30,
  dob: DateTime(1992, 10, 15),
  sex: 'M',
  insuranceProvider: 'Blue Cross Insurance',
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

Patient matthew = Patient(
  name: 'Matthew Doe',
  age: 30,
  dob: DateTime(1992, 10, 15),
  sex: 'M',
  insuranceProvider: 'Blue Cross Insurance',
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

Patient gareth = Patient(
  name: 'Gareth Doe',
  age: 30,
  dob: DateTime(1992, 10, 15),
  sex: 'M',
  insuranceProvider: 'Blue Cross Insurance',
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
Patient heidi = Patient(
  name: 'Heidi Doe',
  age: 30,
  dob: DateTime(1992, 10, 15),
  sex: 'M',
  insuranceProvider: 'Blue Cross Insurance',
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

Appointment appointment = Appointment(
  appointmentTime: DateTime(2023, 6, 15, 10, 30),
  appointmentNotes: 'Nausea, unstable bowels, and dizziness. ',
  patient: john,
);

Appointment appointment1 = Appointment(
  appointmentTime: DateTime(2023, 6, 15, 11, 30),
  appointmentNotes: 'Follow-up appointment',
  patient: john,
);

Appointment appointment2 = Appointment(
  appointmentTime: DateTime(2023, 6, 15, 12, 30),
  appointmentNotes: 'Follow-up appointment',
  patient: april,
);

Appointment appointment3 = Appointment(
  appointmentTime: DateTime(2023, 6, 15, 12, 30),
  appointmentNotes: 'Follow-up appointment',
  patient: april,
);

Appointment appointment4 = Appointment(
  appointmentTime: DateTime(2023, 6, 15, 12, 30),
  appointmentNotes: 'Follow-up appointment',
  patient: april,
);

List<Appointment> appointments = [
  appointment,
  appointment1,
  appointment2,
  appointment3,
  appointment4
];
List<Patient> patients = [john, april, matthew, gareth, heidi];
