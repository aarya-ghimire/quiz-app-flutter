import '../models/quiz_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<QuizQuestion>> fetchQuizQuestions() async {
  final response = await http
      .get(Uri.parse('https://opentdb.com/api.php?amount=50&category=21'));

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    final List<dynamic> questionsJson = jsonData['results'];
    final List<QuizQuestion> questions = [];
    for (var questionJson in questionsJson) {
      questions.add(QuizQuestion.fromJson(questionJson));
    }
    return questions;
  } else {
    throw Exception('Failed to load questions');
  }
}
