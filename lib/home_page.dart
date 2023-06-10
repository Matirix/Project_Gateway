import 'package:flutter/material.dart';
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
            ),
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
            )
          ],
        ),
      ),
    ));
  }
}
