import 'package:flutter/material.dart';
import 'package:prj_gateway/dummy_data.dart';
import 'package:prj_gateway/patient_information.dart';
import 'package:prj_gateway/utils/app_colors.dart';
import 'package:prj_gateway/utils/filter_page.dart';
import 'patient.dart';

class PatientsPage extends StatefulWidget {
  const PatientsPage({super.key});

  @override
  State<PatientsPage> createState() => _PatientsPageState();
}

class _PatientsPageState extends State<PatientsPage> {

  List<Patient> sortedPatients = [];

  @override
  void initState() {
    super.initState();
    sortPatients();
  }

  void sortPatients() {
    // Filter and sort the patients' names alphabetically
    sortedPatients = patients.toList();
    sortedPatients.sort((a, b) => a.name!.compareTo(b.name!));
  }

  void sortPatientsReverse() {
    // Filter and sort the patients' names in reverse alphabetical order
    sortedPatients = patients.toList();
    sortedPatients.sort((a, b) => b.name!.compareTo(a.name!));
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
                      patientHeader(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "NAME",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                final selectedFilters = await Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => FilterPage()),
                                );

                                if (selectedFilters != null) {
                                  // Do something with selectedFilters
                                  // Example: Update the patient list based on the selected filters

                                  if (selectedFilters == 0) {
                                    sortPatients(); // Sort the patients if selectedFilters is 0
                                  } else if (selectedFilters == 1) {
                                    sortPatientsReverse(); // Sort the patients in reverse order if selectedFilters is 1
                                  }

                                  setState(() {});
                                }
                              },
                              child: const Row(
                                children: [
                                  Text("Filter",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black)),
                                  SizedBox(width: 10),
                                  Icon(Icons.filter_list)
                                ],
                              ))
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: sortedPatients.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: AppColors.secondary)),
                                  ),
                                  child: ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: Text(sortedPatients[index].name ?? "N/A"),
                                    trailing: const Icon(Icons.arrow_forward_ios),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PatientInformation(
                                                    patient: sortedPatients[index])),
                                      );
                                    },
                                  ),
                                );
                              }))
                      // ListView.builder(itemBuilder:
                      // )
                    ]))));
  }

  Container patientHeader() {
    return Container(
      // margin: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const SizedBox(
          height: 125,
        ),
        SizedBox(
          child: Column(
            children: [
              Icon(
                Icons.people,
                color: AppColors.focus,
                size: 50,
              ),
              const Text(
                "Patient Directory",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
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
