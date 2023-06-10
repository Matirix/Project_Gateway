import 'package:flutter/material.dart';
import 'package:prj_gateway/dummy_data.dart';
import 'package:prj_gateway/utils/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
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
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Today's Appintments",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: appointments.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: index % 2 == 0
                                  ? AppColors.listItem1border
                                  : AppColors.listItem2border,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            color: index % 2 == 0
                                ? AppColors.listItem1card
                                : AppColors.listItem2card,
                          ),
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(appointments[index]
                                  .appointmentTimeHourMinute()),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                appointments[index].patient!.name ?? "N/A",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
