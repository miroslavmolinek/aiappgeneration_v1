import 'package:flutter/material.dart';

void main() {
 runApp(MyApp());
}

class MyApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     theme: ThemeData(
       primaryColor: Color(0xFFEE3124), // Honeywell red
       colorScheme: ColorScheme.fromSwatch().copyWith(
         secondary: Colors.black,
         primary: Color(0xFFEE3124),
       ),
       textTheme: TextTheme(
         bodyLarge: TextStyle(color: Colors.white),
         bodyMedium: TextStyle(color: Colors.white),
       ),
     ),
     home: QuizScreen(),
   );
 }
}

class QuizScreen extends StatefulWidget {
 @override
 _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
 int _currentQuestionIndex = 0;
 int _score = 0;

 final List<Map<String, Object>> _questions = [
   {
     'question': 'What is not a type of innovation?',
     'options': ['Incremental', 'Repair', 'Disruptive'],
     'correctAnswer': 'Repair',
   },
   {
     'question': 'What is the main Honeywell business?',
     'options': ['Industrial Automation', 'Aerospace', 'PPE'],
     'correctAnswer': 'Aerospace',
   },
 ];

 void _answerQuestion(String answer) {
   if (answer == _questions[_currentQuestionIndex]['correctAnswer']) {
     _score++;
   }
   setState(() {
     _currentQuestionIndex++;
   });
 }

 void _resetQuiz() {
   setState(() {
     _currentQuestionIndex = 0;
     _score = 0;
   });
 }

 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text('Honeywell Quiz'),
     ),
     body: _currentQuestionIndex < _questions.length
         ? Quiz(
             question: _questions[_currentQuestionIndex]['question'] as String,
             options: _questions[_currentQuestionIndex]['options'] as List<String>,
             answerQuestion: _answerQuestion,
           )
         : Result(score: _score, resetQuiz: _resetQuiz),
   );
 }
}

class Quiz extends StatelessWidget {
 final String question;
 final List<String> options;
 final Function(String) answerQuestion;

 Quiz({
   required this.question,
   required this.options,
   required this.answerQuestion,
 });

 @override
 Widget build(BuildContext context) {
   return Column(
     mainAxisAlignment: MainAxisAlignment.center,
     children: <Widget>[
       Text(
         question,
         style: TextStyle(fontSize: 24, color: Colors.black),
         textAlign: TextAlign.center,
       ),
       ...options.map((option) {
         return ElevatedButton(
           onPressed: () => answerQuestion(option),
           child: Text(option),
           style: ElevatedButton.styleFrom(
             backgroundColor: Color(0xFFEE3124), // Honeywell red
             foregroundColor: Colors.white,
           ),
         );
       }).toList(),
     ],
   );
 }
}

class Result extends StatelessWidget {
 final int score;
 final VoidCallback resetQuiz;

 Result({required this.score, required this.resetQuiz});

 @override
 Widget build(BuildContext context) {
   return Center(
     child: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       children: <Widget>[
         Text(
           'You scored $score out of 2!',
           style: TextStyle(fontSize: 24, color: Colors.black),
         ),
         ElevatedButton(
           onPressed: resetQuiz,
           child: Text('Restart Quiz'),
           style: ElevatedButton.styleFrom(
             backgroundColor: Color(0xFFEE3124), // Honeywell red
             foregroundColor: Colors.white,
           ),
         ),
       ],
     ),
   );
 }
}
