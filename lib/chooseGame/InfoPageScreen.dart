import 'package:flutter/material.dart';

class InfoGame extends StatefulWidget {
  const InfoGame({super.key});

  @override
  State<InfoGame> createState() => _InfoGameState();
}

class _InfoGameState extends State<InfoGame> {
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
            Positioned(
              top: 60,
              left: 30,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Container(
                      height: 55,
                      width: 55,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/icons/btn_arrow_back.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: MediaQuery.of(context).size.width * .85,
                height: MediaQuery.of(context).size.height * .6,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/about.png')),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
