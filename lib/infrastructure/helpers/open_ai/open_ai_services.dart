import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

String _apiKey = dotenv.get('API_KEY_GPT');

Future<String> sendTextCompletionRequest(String text) async {
  String baseUrl = "https://api.openai.com/v1/chat/completions";
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $_apiKey'
  };

  final res = await http.post(
    Uri.parse(baseUrl),
    headers: headers,
    body: json.encode({
      "model": "gpt-3.5-turbo",
      "messages": [
        {"role": "system", "content": "You are a helpful assistant."},
        {"role": "user", "content": text},
      ],
      "max_tokens": 200,
      "temperature": 0,
      "top_p": 1,
      "n": 1,
      "stream": false,
      "logprobs": null,
    }),
  );

  if (res.statusCode == 200) {
    final jsonResponse = json.decode(utf8.decode(res.bodyBytes));
    final String message = jsonResponse['choices'][0]['message']['content'];
    return message;
  } else {
    final errorResponse = json.decode(res.body);
    // throw Exception('Failed to load data: ${errorResponse['error']['message']}');
    return "Failed to load data: ${errorResponse['error']['message']}";
  }
}
