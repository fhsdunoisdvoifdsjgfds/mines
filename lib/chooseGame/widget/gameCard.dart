import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Gamecard extends StatefulWidget {
  final String image;
  final String text;
  final String? price;
  final bool? isLocked;
  final VoidCallback onTap;

  const Gamecard(
      {super.key,
      required this.image,
      required this.text,
      required this.onTap,
      this.price,
      this.isLocked});
  @override
  State<Gamecard> createState() => _GamecardState();
}

class _GamecardState extends State<Gamecard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * .3,
        width: MediaQuery.of(context).size.width * .6,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .22,
              width: MediaQuery.of(context).size.width * .6,
              // child: Image.asset(widget.image),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width * .5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  widget.text,
                  style: GoogleFonts.shantellSans(
                    color: Colors.pink,
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
