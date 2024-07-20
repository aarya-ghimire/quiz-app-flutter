import 'package:flutter/material.dart';
import 'package:read_from_file/screens/gender_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainQuizHomePage(),
    );
  }
}

class MainQuizHomePage extends StatelessWidget {
  const MainQuizHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sample Quiz'),
        ),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MainQuizHomePage()),
                );
              },
              child: const Text('Play Quiz'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GenderScreen()),
                );
              },
              child: const Text('Analyze Gender'),
            ),
          ],
        ));
  }
}
