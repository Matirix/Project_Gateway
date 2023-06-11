import 'package:prj_gateway/patient.dart';
import 'appointment.dart';
import 'clinical_note.dart';

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
          'The purpose of this note is to provide information regarding John\'s respiratory infection and necessary medical attention.',
    ),
    DoctorNote(
      date: DateTime(2023, 6, 12),
      noteId: 'N002',
      doctorName: 'Dr. Johnson',
      content:
          'Follow-up appointment. John\'s condition has improved. Prescribed antibiotics for another week.',
    ),
    DoctorNote(
      date: DateTime(2023, 6, 15),
      noteId: 'N003',
      doctorName: 'Dr. Rodriguez',
      content:
          'Johns respiratory infection has resolved. Advised to follow up if symptoms reappear.',
    ),
  ],
  medicalHistory: [
    'Diagnosed with asthma in 2010. Uses inhaler as needed.',
    'No known allergies.',
  ],
);

Patient april = Patient(
  name: 'April Doe',
  age: 25,
  dob: DateTime(1997, 4, 5),
  sex: 'F',
  insuranceProvider: 'Blue Cross Insurance',
  medications: [
    Drug(name: 'Ibuprofen', dosage: "200mg"),
    Drug(name: 'Loratadine', dosage: "10mg"),
  ],
  doctorNotes: [
    DoctorNote(
      date: DateTime(2023, 6, 10),
      noteId: 'N001',
      doctorName: 'Dr. Johnson',
      content:
          'April had a minor injury and required stitches. The wound is healing well.',
    ),
  ],
  medicalHistory: [
    'No major medical conditions.',
    'Allergic to shellfish.',
  ],
);

Patient matthew = Patient(
  name: 'Matthew Doe',
  age: 40,
  dob: DateTime(1983, 8, 20),
  sex: 'M',
  insuranceProvider: 'Green Leaf Insurance',
  medications: [
    Drug(name: 'Metformin', dosage: "1000mg"),
    Drug(name: 'Lisinopril', dosage: "10mg"),
  ],
  doctorNotes: [
    DoctorNote(
      date: DateTime(2023, 6, 10),
      noteId: 'N001',
      doctorName: 'Dr. Thompson',
      content:
          'Matthew has been managing his diabetes well. No significant changes in his condition.',
    ),
  ],
  medicalHistory: [
    'Type 2 diabetes diagnosed in 2010. Requires regular blood sugar monitoring.',
    'No known allergies.',
  ],
);

Patient gareth = Patient(
  name: 'Gareth Doe',
  age: 52,
  dob: DateTime(1971, 12, 12),
  sex: 'M',
  insuranceProvider: 'Red Shield Insurance',
  medications: [
    Drug(name: 'Atorvastatin', dosage: "20mg"),
    Drug(name: 'Aspirin', dosage: "81mg"),
  ],
  doctorNotes: [
    DoctorNote(
      date: DateTime(2023, 6, 10),
      noteId: 'N001',
      doctorName: 'Dr. Wilson',
      content:
          'Gareth has high cholesterol levels. Recommending dietary changes and medication.',
    ),
  ],
  medicalHistory: [
    'High blood pressure diagnosed in 2005. Takes medication to control it.',
    'No known allergies.',
  ],
);

Patient heidi = Patient(
  name: 'Heidi Doe',
  age: 35,
  dob: DateTime(1988, 7, 30),
  sex: 'F',
  insuranceProvider: 'Purple Health Insurance',
  medications: [
    Drug(name: 'Sertraline', dosage: "50mg"),
    Drug(name: 'Lorazepam', dosage: "1mg"),
  ],
  doctorNotes: [
    DoctorNote(
      date: DateTime(2023, 6, 10),
      noteId: 'N001',
      doctorName: 'Dr. Rodriguez',
      content:
          'Heidi is experiencing symptoms of anxiety. Prescribing medication and therapy.',
    ),
  ],
  medicalHistory: [
    'No major medical conditions.',
    'No known allergies.',
  ],
);

Appointment appointment = Appointment(
  appointmentTime: DateTime(2023, 6, 15, 10, 30),
  appointmentNotes: 'Nausea, unstable bowels, and dizziness.',
  patient: john,
);

Appointment appointment1 = Appointment(
  appointmentTime: DateTime(2023, 6, 15, 11, 30),
  appointmentNotes: 'Follow-up appointment',
  patient: heidi,
);

Appointment appointment2 = Appointment(
  appointmentTime: DateTime(2023, 6, 15, 12, 30),
  appointmentNotes: 'Follow-up appointment',
  patient: gareth,
);

Appointment appointment3 = Appointment(
  appointmentTime: DateTime(2023, 6, 15, 12, 30),
  appointmentNotes: 'Follow-up appointment',
  patient: april,
);

Appointment appointment4 = Appointment(
  appointmentTime: DateTime(2023, 6, 15, 12, 30),
  appointmentNotes: 'Follow-up appointment',
  patient: matthew,
);

List<Appointment> appointments = [
  appointment,
  appointment1,
  appointment2,
  appointment3,
  appointment4,
];

List<Patient> patients = [john, april, matthew, gareth, heidi];

var note1 = ClinicalNote(
  date: DateTime(2023, 6, 9),
  patientName: 'Heidi Doe',
  content:
      'Patient presented with flu-like symptoms. Prescribed antiviral medication and advised rest.',
);

var note2 = ClinicalNote(
  date: DateTime(2023, 6, 10),
  patientName: 'Matthew Doe',
  content:
      'Patient came in for a follow-up after surgery. Incision healing well. Removed sutures and provided instructions for wound care.',
);

var note3 = ClinicalNote(
  date: DateTime.now(),
  patientName: 'Gareth Doe',
  content:
      'Patient reported persistent headache. Conducted neurological examination and referred for further tests.',
);

List<ClinicalNote> clinicalNotes = [note1, note2, note3];
