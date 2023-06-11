import 'package:flutter/material.dart';
import 'package:prj_gateway/dummy_data.dart';
import 'package:prj_gateway/patient.dart';
import 'package:prj_gateway/utils/app_colors.dart';
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
        // appBar: CustomAppBar(),
        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFFFFFFF), // Ending color (#FFFFFF)
                  Color(0xFFEEF2FF), // Starting color (#EEF2FF)
                ],
                stops: [0.0, 1.0],
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Center(
                child: Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                  const SizedBox(
                    height: 100,
                  ),
                  SizedBox(
                    child: Column(
                      children: [
                        Icon(
                          Icons.family_restroom_outlined,
                          color: AppColors.secondary,
                          fill: 0.0,
                        ),
                        const Text(
                          "Paulius Russel, MD",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const Text(
                          "Family Doctor",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Recent Logs",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.55,
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: clinicalNotes.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  padding: const EdgeInsets.only(top: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: index % 2 == 0
                                          ? AppColors.listItem1border
                                          : AppColors.listItem2border,
                                      width: 1.0,
                                    ),
                                    color: index % 2 == 0
                                        ? AppColors.listItem1card
                                        : AppColors.listItem2card,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(
                                            0.4), // Set the desired shadow color
                                        spreadRadius: 2,
                                        blurRadius: 4,
                                        offset: const Offset(0,
                                            2), // Set the desired offset for the shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const SizedBox(
                                                width: 25,
                                              ),
                                              Text(
                                                clinicalNotes[index]
                                                        .appointmentTimeHourMinute() ??
                                                    " ",
                                                style: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                clinicalNotes[index]
                                                        .patientName ??
                                                    " ",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                clinicalNotes[index]
                                                        .appointmentDateFormatted() ??
                                                    " ",
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            width: 295,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: index % 2 == 0
                                                      ? AppColors
                                                          .listItem1border
                                                          .withOpacity(0.3)
                                                      : AppColors
                                                          .listItem2border
                                                          .withOpacity(0.3),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              padding: const EdgeInsets.all(15),
                                              margin: const EdgeInsets.all(15),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    clinicalNotes[index]
                                                            .content ??
                                                        "",
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                    overflow: TextOverflow.clip,
                                                    maxLines: 1,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      // Handle the "see more" action here
                                                    },
                                                    child: const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          'See more...',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ));
                            },
                          ),
                        ),
                      ]),
                ])))));
  }
}
