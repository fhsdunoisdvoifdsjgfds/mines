import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mines/chooseGame/chooseDifficultScreen.dart';
import 'package:mines/games/PairsGameScreen.dart';

import 'quizGame.dart';
import 'widget/gameCard.dart';

class ChooseGame extends StatefulWidget {
  const ChooseGame({super.key});

  @override
  State<ChooseGame> createState() => _ChooseGameState();
}

class _ChooseGameState extends State<ChooseGame> {
  @override
  void initState() {
    super.initState();
    // AudioManager().initAudio();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg/choose_game.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 200),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Gamecard(
                          image: 'assets/icons/game1.png',
                          text: 'Minesweeper',
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const ChooseDifficulty(
                                gameMode: 'Minesweeper',
                              ),
                            ));
                          },
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Gamecard(
                          image: 'assets/icons/game2.png',
                          text: 'Memo',
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const PairsGameScreen(),
                            ));
                          },
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Gamecard(
                          image: 'assets/icons/game3.png',
                          text: 'Quiz',
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const MathQuizGame(),
                            ));
                          },
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 60,
              left: 30,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: 55,
                      width: 55,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/icons/btn_arrow_back.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 50),
                  Container(
                    height: MediaQuery.of(context).size.height * .08,
                    width: MediaQuery.of(context).size.width * .4,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/difficulty.png'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
