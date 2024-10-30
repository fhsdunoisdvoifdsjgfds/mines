import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mines/mainPage/MainScreen.dart';

Widget winLose(BuildContext context, bool isWin, String coins) {
  return Container(
    color: Colors.black.withOpacity(0.7),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 100,
          ),
          Container(
            height: MediaQuery.of(context).size.height * .3,
            width: MediaQuery.of(context).size.width * .85,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(!isWin
                    ? 'assets/images/win_ig.png'
                    : 'assets/images/lose_ig.png'),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width * .8,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 24, 19, 19).withOpacity(0.7),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  child: Image.asset(
                    'assets/images/coins.png',
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(width: 10),
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
          const SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const MainPageGame(),
                ),
                (Route<dynamic> route) => false,
              );
            },
            child: Container(
              height: 50,
              width: 50,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/home.png')),
              ),
            ),
          )
        ],
      ),
    ),
  );
}
