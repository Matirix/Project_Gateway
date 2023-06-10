import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        // appBar: CustomAppBar(),
        body: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 100,
          ),
          Icon(
            Icons.family_restroom_outlined,
            color: Colors.blue,
            fill: 0.0,
          ),
          Text(
            "Paulius Russel, MD",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            "Family Doctor",
            style: TextStyle(
              fontSize: 16,
            ),
          )
        ],
      ),
    ));
  }
}
