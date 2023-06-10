import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'utils/api_keys.dart';

Future<String> callOpenAI() async {
  // API key stored in Flutter Secure Storage
  const storage = FlutterSecureStorage();

  // API endpoint and parameters
  String apiUrl = 'https://api.openai.com/v1/chat/completions';
  String? apiKey = await storage.read(key: 'api_key') ?? openAiApiKey; //get apikey from secure storage
  String prompt = 'Tell me about Sir Winston Churchill';

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

  // Parse the response
  if (response.statusCode == 200) {
    Map<String, dynamic> responseData = jsonDecode(response.body);
    String completionText = responseData['choices'][0]['message']['content'];
    debugPrint('Successful Response: ${response.statusCode}\nResponse: ${response.body}\nHeaders: ${response.headers}');
    return completionText;
  } else {
    throw Exception('Failed to call OpenAI API: ${response.statusCode}\nResponse: ${response.body}\nHeaders: ${response.headers}');
  }
}