import 'package:flutter/material.dart';
import 'package:prj_gateway/appointment.dart';
import 'package:prj_gateway/utils/app_colors.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key, required this.appointment});
  final Appointment appointment;

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  String name = "N/A";
  String notes = "";

  @override
  void initState() {
    super.initState();
    name = widget.appointment.patient!.name!;
    notes = widget.appointment.appointmentNotes!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        patientHeader(),
        appointmentNotes(context),
        quickSearch(),
        // doctorNotes(),
        Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text("Hold down to record inquiry",
                style: TextStyle(fontSize: 16)),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.red, width: 2.0),
                color: Colors.red,
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.mic_rounded,
                  size: 50.0,
                  color: Colors.white,
                ),
              ),
            )
          ],
        )
      ]),
    ));
  }

  Column quickSearch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        const Text("Quick Search:",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Wrap(direction: Axis.horizontal, spacing: 5.5, children: [
          ElevatedButton(
              onPressed: () {}, child: const Text("Patient Summary")),
          ElevatedButton(
              onPressed: () {}, child: const Text("Medical History")),
          ElevatedButton(
              onPressed: () {}, child: const Text("Drug Interactions")),
        ]),
      ],
    );
  }

  Column doctorNotes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        const Text("Doctor's Notes",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        TextField(
          decoration: const InputDecoration(
              hintText: 'Type or Record Patient Updates',
              fillColor: Colors.white),
          maxLines: 1,
          onChanged: (value) {
            notes = value;
          },
        )
      ],
    );
  }

  Column appointmentNotes(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Appointment Notes:",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Container(
          height: 125,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.listItem1card)),
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Text(
              notes,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
          ),
        ),
      ],
    );
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
              Text(
                "Check up with $name" ?? "N/A",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const Text(
                "Last check up, etc months ago.",
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
      ]),
    );
  }
}
