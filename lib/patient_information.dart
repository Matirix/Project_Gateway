import 'package:flutter/material.dart';

import 'patient.dart';
import 'utils/app_colors.dart';

class PatientInformation extends StatefulWidget {
  const PatientInformation({super.key, required this.patient});

  final Patient patient;

  @override
  State<PatientInformation> createState() => _PatientInformationState();
}

class _PatientInformationState extends State<PatientInformation> {
  late Patient patient;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    patient = widget.patient;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                height: MediaQuery.of(context).size.height * 1.25,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 60),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                          ),
                        ),
                        const Text("Back")
                      ],
                    ),
                    const SizedBox(height: 15),
                    patientHeader(),
                    doctorsNotes(context),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        const Text("Profile",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: AppColors.secondary,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: const Text(
                                    "Insurance Provider:",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  trailing: Text(
                                    patient.insuranceProvider ?? "N/A",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: AppColors.secondary,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: const Text(
                                    "Sex:",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  trailing: Text(
                                    patient.sex ?? "N/A",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: const Text(
                                  "Age:",
                                  style: TextStyle(fontSize: 16),
                                ),
                                trailing: Text(
                                  patient.age.toString() ?? "N/A",
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: AppColors.secondary,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  child: const ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: Text(
                                      "Diagnostic History",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    trailing: Icon(Icons.arrow_forward_ios),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: AppColors.secondary,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  child: const ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: Text(
                                      "Family History",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    trailing: Icon(Icons.arrow_forward_ios),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: AppColors.secondary,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  child: const ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: Text(
                                      "Medications",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    trailing: Icon(Icons.arrow_forward_ios),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: AppColors.secondary,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  child: const ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: Text(
                                      "Tests",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    trailing: Icon(Icons.arrow_forward_ios),
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ],
                ))));
  }

  Column doctorsNotes(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Appointment History",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Column(
          children: [
            SizedBox(
              height: 150,
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: patient.doctorNotes!.length,
                  itemBuilder: (BuildContext context, index) {
                    return Container(
                      margin: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.listItem1border,
                          width: 1.0,
                        ),
                        color: AppColors.listItem1border.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: Text(
                          patient.doctorNotes![index].doctorName ?? "N/A",
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        trailing: Text(
                          patient.doctorNotes![index]
                                  .appointmentDateFormatted() ??
                              "N/A",
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        // subtitle: Text(
                        //   patient.doctorNotes![index].note ?? "N/A",
                        //   style: const TextStyle(
                        //       fontSize: 14,
                        //       fontWeight: FontWeight.bold),
                        // ),
                      ),
                    );
                  }),
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("See More"),
                    Icon(Icons.arrow_downward_rounded),
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  Container patientHeader() {
    return Container(
      // margin: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(
          child: Column(
            children: [
              Icon(
                Icons.person,
                color: AppColors.focus,
                size: 50,
              ),
              Text(
                patient.name ?? "N/A",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const Text(
                "Last checked activity today",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 40,
        ),
      ]),
    );
  }
}
