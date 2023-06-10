import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prj_gateway/patient.dart';
import 'utils/api_keys.dart';

Future<String> callOpenAI(int promptOption, Patient patient, {String? question}) async {

  // --------------------------- Extract patient info and set OpenAI request prompt ---------------------------//
  List<String> drugList = patient.medications!.map((drug) => '${drug.name} (${drug.dosage})').toList();
  String drugs = drugList.join(', ');

  List<String> medicalHistoryList = patient.medicalHistory!.map((item) => item.toString()).toList();
  String medicalHistory = medicalHistoryList.join(', ');

  List<String> doctorNotesList = patient.doctorNotes!.map((note) => note.toString()).toList();
  String doctorNotes = doctorNotesList.join('\n');

  String prompt;

  if (promptOption == 1) {
    // Quick summary of patient
    prompt = "Could you provide a short paragraph summary of the patient given the following information: name is ${patient.name}, "
        "age is ${patient.age}, dob is ${patient.dob}, insurance provider is ${patient.insuranceProvider},"
        "medications currently taking are $drugs\n Patient's existing doctor's note: $doctorNotes\n"
        "Patient's medical history: $medicalHistory.\n Make sure the keep the date short form and don't need to "
        "include the hour, minute, and seconds.";
  } else if (promptOption == 2) {
    // drug interaction summary
    prompt = "A patient is taking the following drugs: $drugs. "
        "What are some of the drug interaction side effects if any? "
        "Keep it one paragraph and do not include a sentence that says consult a health care professional for advice. ";
  } else if (promptOption == 3) {
    // medical history summary
    prompt = "A patient has the following medical history: $medicalHistory. Provide a paragraph summary of the patient's medical history";
  } else {
    // random question
    prompt = "Here is some information about a patient: name is ${patient.name}, "
        "age is ${patient.age}, dob is ${patient.dob}, insurance provider is ${patient.insuranceProvider},"
        "medications currently taking are $drugs\n Patient's existing doctor's note: $doctorNotes\n"
        "Patient's medical history: $medicalHistory\nCould you answer this question given the above"
        "patient information: $question.\nIf you do not have the answer, specifically and only say "
        "there is insufficient information provided to determine. Limit the response to a short paragraph.";
  }

  debugPrint("PROMPT: $prompt");


  // ---------------------------------------- Call OpenAI API ----------------------------------------//

  // API key stored in Flutter Secure Storage
  const storage = FlutterSecureStorage();

  // API endpoint and parameters
  String apiUrl = 'https://api.openai.com/v1/chat/completions';
  String? apiKey = await storage.read(key: 'api_key') ?? openAiApiKey; //get apikey from secure storage

  // Request payload
  Map<String, dynamic> data = {
    'model': 'gpt-3.5-turbo',
    'messages': [
      {'role': 'user', 'content': prompt},
    ],
  };

  // Encode the data as JSON
  String requestBody = jsonEncode(data);

  // API request
  http.Response response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
    },
    body: requestBody,
  );

  // Parse and return response
  if (response.statusCode == 200) {
    Map<String, dynamic> responseData = jsonDecode(response.body);
    String completionText = responseData['choices'][0]['message']['content'];
    debugPrint("RETURN RESULT: $completionText");
    // debugPrint('Successful Response: ${response.statusCode}\nResponse: ${response.body}\nHeaders: ${response.headers}');
    return completionText;
  } else {
    throw Exception('Failed to call OpenAI API: ${response.statusCode}\nResponse: ${response.body}\nHeaders: ${response.headers}');
  }
}
