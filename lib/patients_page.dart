import 'package:flutter/material.dart';
import 'package:prj_gateway/dummy_data.dart';
import 'package:prj_gateway/patient_information.dart';
import 'package:prj_gateway/utils/app_colors.dart';

class PatientsPage extends StatefulWidget {
  const PatientsPage({super.key});

  @override
  State<PatientsPage> createState() => _PatientsPageState();
}

class _PatientsPageState extends State<PatientsPage> {
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
                            "A",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          ElevatedButton(
                              onPressed: () {},
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
                              itemCount: patients.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: AppColors.secondary)),
                                  ),
                                  child: ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: Text(patients[index].name ?? "N/A"),
                                    trailing:
                                        const Icon(Icons.arrow_forward_ios),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PatientInformation(
                                                    patient: patients[index])),
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
