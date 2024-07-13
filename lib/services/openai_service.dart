import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OpenAIService {
  final String _apiKey = dotenv.env['OPENAI_API_KEY'] ?? '';

  Future<String> generateImage(String prompt) async {
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/images/generations'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: jsonEncode({
        'model': 'dall-e-3',
        'prompt': prompt,
        'num_images': 1,
        'size': '1024x1024',
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data'][0]['url'];
    } else {
      // Handle different error status codes
      String errorMessage;
      switch (response.statusCode) {
        case 400:
          errorMessage = 'Bad Request: The request was unacceptable, often due to missing a required parameter.';
          break;
        case 401:
          errorMessage = 'Unauthorized: No valid API key provided.';
          break;
        case 404:
          errorMessage = 'Not Found: The requested resource doesn’t exist.';
          break;
        case 429:
          errorMessage = 'Too Many Requests: You have hit your rate limit.';
          break;
        case 500:
          errorMessage = 'Server Error: Something went wrong on OpenAI\'s end.';
          break;
        default:
          errorMessage = 'Failed to load image: ${response.reasonPhrase}';
      }
      throw Exception(errorMessage);
    }
  }
}