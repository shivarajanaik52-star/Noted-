import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PDF Study Manager',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const PdfUploadScreen(),
    );file:///storage/emulated/0/Vibe 87/lib_main89 (1).dart
  }
}

class PdfUploadScreen extends StatefulWidget {
  const PdfUploadScreen({super.key});

  @override
  _PdfUploadScreenState createState() => _PdfUploadScreenState();
}

class _PdfUploadScreenState extends State<PdfUploadScreen> {
  String? _pdfPath;

  Future<void> _pickPdfFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _pdfPath = result.files.single.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My PDF Manager'),
      ),
      body: Center(
        child: _pdfPath == null
            ? const Text('No PDF uploaded yet. Tap the button below to upload.')
            : SfPdfViewer.file(File(_pdfPath!)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickPdfFile,
        child: const Icon(Icons.upload_file),
        tooltip: 'Upload PDF',
      ),
    );
  }
}
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '10th Standard Quiz',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;
  int _score = 0;
  bool _isFinished = false;

  // 10th Grade Offline Questions List
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'What is the chemical formula of water? \n(ನೀರಿನ ರಾಸಾಯನಿಕ ಸೂತ್ರವೇನು?)',
      'options': ['H2O', 'CO2', 'NaCl', 'O2'],
      'answer': 0,
    },
    {
      'question': 'S.I. unit of Force is? \n(ಬಲದ ಎಸ್.ಐ. ಏಕಮಾನ ಯಾವುದು?)',
      'options': ['Joule', 'Newton', 'Watt', 'Pascal'],
      'answer': 1,
    },
    {
      'question': 'Who is known as the Iron Man of India? \n(ಭಾರತದ ಲೋಹದ ಪುರುಷ ಎಂದು ಯಾರನ್ನು ಕರೆಯುತ್ತಾರೆ?)',
      'options': ['Mahatma Gandhi', 'Subhas Chandra Bose', 'Sardar Vallabhbhai Patel', 'Jawaharlal Nehru'],
      'answer': 2,
    },
  ];

  void _answerQuestion(int selectedIndex) {
    if (_questions[_currentIndex]['answer'] == selectedIndex) {
      _score++;
    }

    setState(() {
      if (_currentIndex < _questions.length - 1) {
        _currentIndex++;
      } else {
        _isFinished = true;
      }
    });
  }

  void _restartQuiz() {
    setState(() {
      _currentIndex = 0;
      _score = 0;
      _isFinished = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('10th Offline Quiz App')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isFinished
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Quiz Completed! \nScore: $_score / ${_questions.length}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _restartQuiz,
                      child: const Text('Restart Quiz (ಮತ್ತೆ ಪ್ರಾರಂಭಿಸಿ)'),
                    ),
                  ],
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Question ${_currentIndex + 1} of ${_questions.length}',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _questions[_currentIndex]['question'],
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  ...List.generate(
                    (_questions[_currentIndex]['options'] as List).length,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: ElevatedButton(
                        onPressed: () => _answerQuestion(index),
                        child: Text(_questions[_currentIndex]['options'][index]),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
