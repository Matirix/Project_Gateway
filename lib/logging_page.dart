import 'package:flutter/material.dart';
import 'package:prj_gateway/utils/custom_app_bar.dart';

class LoggingPage extends StatefulWidget {
  const LoggingPage({super.key});

  @override
  State<LoggingPage> createState() => _LoggingPageState();
}

class _LoggingPageState extends State<LoggingPage> {
  final TextEditingController prompt = TextEditingController();
  String responseData = '';

  void getResponse(String prompt) {
    responseData = prompt;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Center(
          child: Column(
        children: [
          TextField(
            controller: prompt,
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: const Color(0xFFF2F2F2),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              contentPadding: const EdgeInsets.only(
                top: -15,
                left: 10,
                right: 10,
              ),
              labelText: 'Prompt',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10), // Set border radius
                borderSide: const BorderSide(
                  color: Color(0xfff1f1f1), // Customize border color
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10), // Set border radius
                borderSide: const BorderSide(
                  color: Color(0xfff1f1f1), // Customize focused border color
                ),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () => getResponse(prompt.text),
              child: const Text('Submit')),
          Text(responseData),
        ],
      )),
    );
  }
}
