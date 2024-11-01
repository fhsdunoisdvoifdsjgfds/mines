import 'package:flutter/material.dart';
import 'package:mines/chooseGame/ChooseGameModeScreen.dart';
import 'package:mines/chooseGame/InfoPageScreen.dart';
import 'package:mines/chooseGame/widget/settings.dart';

class MainPageGame extends StatefulWidget {
  const MainPageGame({super.key});

  @override
  State<MainPageGame> createState() => _MainPageGameState();
}

class _MainPageGameState extends State<MainPageGame> {
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
            image: AssetImage('assets/bg/main_page.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Positioned(
            //   top: 50,
            //   right: 20,
            //   child: Align(
            //     alignment: Alignment.topRight,
            //     child: GestureDetector(
            //       onTap: () {
            //         // Navigator.of(context).push(MaterialPageRoute(
            //         //   builder: (context) => const BonusGameScreen(),
            //         // ));
            //       },
            //       child: Container(
            //         height: 90,
            //         width: 90,
            //         decoration: const BoxDecoration(
            //           image: DecorationImage(
            //             image: AssetImage('assets/icons/btn_bonus_game.png'),
            //             fit: BoxFit.cover,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ChooseGame(),
                      ));
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * .08,
                      width: MediaQuery.of(context).size.width * .4,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/icons/btn_play.png'),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const InfoGame(),
                      ));
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * .08,
                      width: MediaQuery.of(context).size.width * .4,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/icons/btn_about.png'),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SettingsScreen(),
                      ));
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * .08,
                      width: MediaQuery.of(context).size.width * .4,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/icons/btn_settings.png'),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
