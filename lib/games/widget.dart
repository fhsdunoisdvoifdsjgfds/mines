import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget statusBar(
    BuildContext context,
    final int bombs,
    final int flags,
    VoidCallback onTapFlag,
    VoidCallback onTapReplay,
    VoidCallback onTapSettings) {
  return Container(
    height: 70,
    width: MediaQuery.of(context).size.width * .9,
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 137, 89, 107).withOpacity(0.7),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(width: 10),
        Container(
          height: 50,
          width: 80,
          decoration: BoxDecoration(
            color: const Color(0xFFFFD1E2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/bomb.png'),
              Text(
                bombs.toString(),
                style: GoogleFonts.shantellSans(
                  color: const Color(0xFF3F3F3F),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Container(
          height: 50,
          width: 80,
          decoration: BoxDecoration(
            color: const Color(0xFFFFD1E2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/flags.png'),
              Text(
                flags.toString(),
                style: GoogleFonts.shantellSans(
                  color: const Color(0xFF3F3F3F),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 20),
        GestureDetector(
          onTap: onTapReplay,
          child: Container(
            height: 50,
            width: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFFFD1E2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset('assets/images/replay.png'),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: onTapSettings,
          child: Container(
            height: 50,
            width: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFFFD1E2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset('assets/images/settings.png'),
          ),
        ),
        const SizedBox(width: 10),
      ],
    ),
  );
}
