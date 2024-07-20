import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:read_from_file/models/quiz_model.dart';
import 'package:read_from_file/services/quiz_service.dart';

class QuizHomePage extends StatefulWidget {
  const QuizHomePage({super.key});

  @override
  State<QuizHomePage> createState() => _QuizHomePageState();
}

class _QuizHomePageState extends State<QuizHomePage> {
  List<QuizQuestion>? _questionsList;
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _quizFinished = false;
  bool _startQuiz = false;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    List<QuizQuestion> questions = await fetchQuizQuestions();
    setState(() {
      _questionsList = questions;
    });
  }

  void _answerQuestion(String answer) {
    if (answer == _questionsList![_currentQuestionIndex].answer) {
      _score++;
    }
    setState(() {
      if (_currentQuestionIndex < _questionsList!.length - 1) {
        _currentQuestionIndex++;
      } else {
        _quizFinished = true;
      }
    });
  }

  void _restartQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _score = 0;
      _quizFinished = false;
      _startQuiz = false;
    });
  }

  void _startQuizfn() {
    setState(() {
      _startQuiz = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_startQuiz) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Sample Quiz',
          ),
          centerTitle: true,
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: _startQuizfn,
            child: const Text('Start Quiz'),
          ),
        ),
      );
    } else if (_quizFinished) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Sample Quiz',
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Your score: $_score / ${_questionsList!.length}'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _restartQuiz,
                child: const Text('Restart Quiz'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz App"),
        centerTitle: true,
        backgroundColor: Colors.yellow,
        elevation: 10,
      ),
      body: Center(
        child: Column(
          children: [
            // Display question in a row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    HtmlUnescape().convert(
                        _questionsList![_currentQuestionIndex].question),
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),
            // Build options just below the question
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _questionsList![_currentQuestionIndex]
                  .options
                  .map<Widget>((option) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: ElevatedButton(
                          onPressed: () => _answerQuestion(option),
                          child: Text(option),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
