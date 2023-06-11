import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';
import 'package:prj_gateway/appointment.dart';
import 'package:prj_gateway/utils/app_colors.dart';
import 'package:prj_gateway/utils/pdfscreen.dart';
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
  final int _pages = 0;
  bool isReady = false;
  String pathPDF = "";

  @override
  void initState() {
    super.initState();
    name = widget.appointment.patient!.name!;
    notes = widget.appointment.appointmentNotes!;
    _initSpeech();

    fromAsset('assets/mri_knee_sample.pdf', 'demo.pdf').then((f) {
      setState(() {
        pathPDF = f.path;
      });
    });
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
    response = callOpenAI(4, widget.appointment.patient!, question: _lastWords);
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
            appointmentNotes(context, true),
            generateResponse(),
            // doctorNotes(),
            Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                // const Text("Hold down to record inquiry",
                //     style:
                //         TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
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

  Future<File> fromAsset(String asset, String filename) async {
    Completer<File> completer = Completer();

    try {
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  // void showPdfPopup(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Dialog(
  //         child: Container(
  //           height: MediaQuery.of(context).size.height * 0.9,
  //           width: MediaQuery.of(context).size.width * 1.0,
  //           child: Column(
  //             children: [
  //               Expanded(
  //                 child: PDFView(
  //                   filePath: 'assets/mri_knee_sample.pdf',
  //                   enableSwipe: true,
  //                   swipeHorizontal: true,
  //                   autoSpacing: false,
  //                   pageFling: false,
  //                   onRender: (_pages) {
  //                     setState(() {
  //                       _pages = _pages;
  //                       isReady = true;
  //                     });
  //                   },
  //                 ),
  //               ),
  //               ElevatedButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop(); // Close the popup
  //                 },
  //                 child: const Text('Close'),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  Column appointmentNotes(BuildContext context, bool showButton) {
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
            border: Border.all(color: AppColors.listItem1card),
          ),
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
        if (showButton) // Conditionally show the button if showButton is true
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: ElevatedButton(
              onPressed: () {
                if (pathPDF.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PDFScreen(path: pathPDF),
                    ),
                  );
                }
                // Handle button click event
              },
              child: const Text('Button'),
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
                "See Patient Profile",
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
