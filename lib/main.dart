import 'package:flutter/material.dart';
import 'package:quizzler_app/questions.dart';
import 'package:quizzler_app/quizBrain.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(const Quizzler());

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int questionIndex = 0;

  List<Icon> scoreKeeper = [];
  List<Icon> reverseScoreKeeper = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.questionBank[questionIndex].questionText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.green), // Set the button's background color
              ),
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.

                bool correctAnswer =
                    quizBrain.questionBank[questionIndex].answer;

                setState(() {
                  if (questionIndex == quizBrain.questionBank.length - 1) {
                    questionIndex = 0;
                  } else {
                    questionIndex++;
                  }
                  if (correctAnswer == true) {
                    scoreKeeper.add(
                      const Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                    );
                  } else {
                    scoreKeeper.add(
                      const Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                    );
                    reverseScoreKeeper =
                        scoreKeeper.reversed.toList(growable: true);
                  }
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.red), // Set the button's background color
              ),
              child: const Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.

                bool correctAnswer =
                    quizBrain.questionBank[questionIndex].answer;

                setState(() {
                  if (questionIndex == quizBrain.questionBank.length - 1) {
                    questionIndex = 0;
                  } else {
                    questionIndex++;
                  }
                  if (correctAnswer) {
                    scoreKeeper.add(
                      const Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                    );
                    reverseScoreKeeper =
                        scoreKeeper.reversed.toList(growable: true);
                  } else {
                    scoreKeeper.add(
                      const Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                    );
                    reverseScoreKeeper =
                        scoreKeeper.reversed.toList(growable: true);
                  }
                });
              },
            ),
          ),
        ),
        //TODO: Add a Row here as your score keeper

        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: reverseScoreKeeper.length,
            itemBuilder: (BuildContext context, int index) {
              return reverseScoreKeeper[index];
            },
          ),
        )
      ],
    );
  }
}
