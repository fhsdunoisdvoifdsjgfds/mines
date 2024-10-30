import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mines/WinLoseScreen.dart';
import 'package:mines/mainPage/MainScreen.dart';
import 'dart:math' as math;
import 'widget/quiz.dart';
import 'widget/settings.dart';
import 'widget/winLose.dart';

class MathQuizGame extends StatefulWidget {
  const MathQuizGame({Key? key}) : super(key: key);

  @override
  State<MathQuizGame> createState() => _MathQuizGameState();
}

class _MathQuizGameState extends State<MathQuizGame> {
  int currentQuestionIndex = 0;
  int coins = 100;
  bool isWin = false;
  bool gameOver = false;
  bool isPaused = false;

  void togglePause() {
    setState(() {
      isPaused = !isPaused;
    });
  }

  void checkAnswer(int selectedIndex) {
    final currentQuestion = questions[currentQuestionIndex];

    if (selectedIndex == currentQuestion.correctIndex) {
      // Правильный ответ
      setState(() {
        coins += 20;
        if (currentQuestionIndex < questions.length - 1) {
          currentQuestionIndex++;
        } else {
          gameOver = true;
          isWin = true;
        }
      });
    } else {
      // Неправильный ответ
      setState(() {
        coins = math.max(0, coins - 10);
        gameOver = true;
        isWin = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/quiz.png'),
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 50,
              child: Container(
                height: 80,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: togglePause,
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/pause.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * .34,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 44, 31, 31)
                            .withOpacity(0.4),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              child: Image.asset(
                                'assets/images/coins.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(width: 5),
                            Text(
                              '$coins',
                              style: GoogleFonts.shantellSans(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              ),
            ),

            Positioned(
              top: 120,
              left: 20,
              right: 20,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: const Color(0xFF5CB2DD),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.9),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          currentQuestion.question,
                          style: GoogleFonts.shantellSans(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )),
                ],
              ),
            ),

            // Answer Buttons
            Positioned(
              bottom: 40,
              left: 20,
              right: 20,
              child: Column(
                children: List.generate(
                  4,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: ElevatedButton(
                      onPressed: () => checkAnswer(index),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        currentQuestion.answers[index],
                        style: GoogleFonts.shantellSans(
                          fontSize: 20,
                          color: const Color(0xFFE74583),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (gameOver) winLose(context, !isWin, coins.toString()),
            if (isPaused)
              PauseOverlay(
                onResume: () {
                  setState(() {
                    isPaused = false;
                  });
                },
                onExit: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const MainScreenGame(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                },
                onTapSettings: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ));
                },
              ),
          ],
        ),
      ),
    );
  }
}
