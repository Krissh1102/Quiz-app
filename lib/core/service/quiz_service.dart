import 'dart:convert';
import 'package:http/http.dart' as http;

class QuizService {
  static const String _apiUrl = 'https://api.jsonserve.com/Uw5CrX';

  static Future<List<dynamic>> fetchQuestions() async {
    try {
      final response = await http.get(Uri.parse(_apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['questions'];
      } else {
        throw Exception('Failed to load quiz');
      }
    } catch (e) {
      throw Exception('Error fetching questions: $e');
    }
  }
}
