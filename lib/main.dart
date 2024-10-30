import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'games/Loading.dart';
import 'mainPage/MainScreen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InitializationScreen(),
    );
  }
}

class InitializationScreen extends StatefulWidget {
  @override
  _InitializationScreenState createState() => _InitializationScreenState();
}

class _InitializationScreenState extends State<InitializationScreen> {
  Future<void> checkFirstRun() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstRun = prefs.getBool('firstRun') ?? true;

    if (isFirstRun) {
      await prefs.setInt('coins', 250);
      await prefs.setBool('firstRun', false);
    }
  }

  @override
  void initState() {
    super.initState();
    checkFirstRun();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: Future.delayed(const Duration(seconds: 3)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else {
          return const MainPageGame();
        }
      },
    );
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}
