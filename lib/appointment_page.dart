import 'package:flutter/material.dart';
import 'package:prj_gateway/appointment.dart';
import 'package:prj_gateway/utils/app_colors.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'open_ai.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key, required this.appointment});
  final Appointment appointment;

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  String name = "N/A";
  String notes = "";
  Future<String>? response;
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    name = widget.appointment.patient!.name!;
    notes = widget.appointment.appointmentNotes!;
    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  Future<void> getResponse(int prompt) async {
    response = callOpenAI(prompt, widget.appointment.patient!);
    setState(() {});
  }

  FutureBuilder<String?> generateResponse() {
    return FutureBuilder(
        future: response,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // return Text(snapshot.data.toString());
            return responsebox(snapshot.data.toString());
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.hasData) {
            return Container(
              margin: const EdgeInsets.only(top: 20),
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            );
          } else {
            return quickSearch();
          }
        });
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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            patientHeader(),
            appointmentNotes(context),
            generateResponse(),
            // doctorNotes(),
            Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text("Hold down to record inquiry",
                    style:
                        TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.red, width: 2.0),
                    color: _speechToText.isNotListening
                        ? Colors.red.withOpacity(0.5)
                        : Colors.red,
                  ),
                  child: IconButton(
                    onPressed: () {
                      _speechToText.isNotListening
                          ? _startListening()
                          : _stopListening();
                    },
                    // icon: const Icon(
                    //   Icons.mic_rounded,
                    //   size: 50.0,
                    //   color: Colors.white,
                    // ),
                    icon: Icon(
                        _speechToText.isNotListening
                            ? Icons.mic_off
                            : Icons.mic,
                        size: 50.0,
                        color: Colors.white),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    // If listening is active show the recognized words
                    _speechToText.isListening
                        ? _lastWords
                        // If listening isn't active but could be tell the user
                        // how to start it, otherwise indicate that speech
                        // recognition is not yet ready or not supported on
                        // the target device
                        : _speechEnabled
                            ? 'Press the microphone to start listening...'
                            : 'Speech not available, check permissions',
                  ),
                ),
              ],
            )
          ]),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed:
      //       // If not yet listening for speech start, otherwise stop
      //       _speechToText.isNotListening ? _startListening : _stopListening,
      //   tooltip: 'Listen',
      //   child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
      // ),
    );
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
              onPressed: () {
                getResponse(1);
              },
              child: const Text("Patient Summary")),
          ElevatedButton(
              onPressed: () {
                getResponse(3);
              },
              child: const Text("Medical History")),
          ElevatedButton(
              onPressed: () {
                getResponse(2);
              },
              child: const Text("Drug Interactions")),
        ]),
      ],
    );
  }

  Container responsebox(response) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text("AI Response:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(
            response,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
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