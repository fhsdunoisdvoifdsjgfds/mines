import 'dart:async';
import 'dart:math' as math;
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mines/WinLoseScreen.dart';
import 'package:mines/chooseGame/widget/settings.dart';
import 'package:mines/chooseGame/widget/winLose.dart';
import 'package:mines/games/widget.dart';
import 'package:mines/mainPage/MainScreen.dart';

class MinesSweeper extends StatefulWidget {
  final String difficulty;
  const MinesSweeper({super.key, required this.difficulty});

  @override
  State<MinesSweeper> createState() => _MinesSweeperState();
}

class _MinesSweeperState extends State<MinesSweeper> {
  final int rows = 8;
  final int columns = 6;
  late int bombs;
  late int flags;
  late int remainingSeconds;
  bool isLose = false;
  late List<List<bool>> revealed;
  late List<List<bool>> hasMine;
  bool gameOver = false;
  late List<List<bool>> flagged;
  int coins = 100;
  bool timeOut = false;
  bool isPaused = false;
  bool isWin = false;
  bool isSoundEnabled = true;
  bool isFlagMode = false;
  final AudioPlayer successPlayer = AudioPlayer();
  final AudioPlayer failurePlayer = AudioPlayer();
  final AudioPlayer victoryPlayer = AudioPlayer();
  late Timer gameTimer;

  @override
  void initState() {
    super.initState();
    setDifficulty();
    initializeGame();
    loadSounds();
    startTimer();
  }

  void setDifficulty() {
    switch (widget.difficulty) {
      case 'easy':
        bombs = 1;
        flags = 1;
        remainingSeconds = 300;
        break;
      case 'medium':
        bombs = 5;
        flags = 5;
        remainingSeconds = 180;
        break;
      case 'hard':
        bombs = 7;
        flags = 7;
        remainingSeconds = 120;
        break;
    }
  }

  @override
  void dispose() {
    gameTimer.cancel();
    successPlayer.dispose();
    failurePlayer.dispose();
    victoryPlayer.dispose();
    super.dispose();
  }

  void toggleFlagMode() {
    setState(() {
      isFlagMode = !isFlagMode;
    });
  }

  void onFlagCell(int row, int col) {
    if (revealed[row][col] || gameOver) return;
    setState(() {
      flagged[row][col] = !flagged[row][col];
    });
    checkWin();
  }

  void initializeGame() {
    revealed = List.generate(rows, (_) => List.filled(columns, false));
    hasMine = List.generate(rows, (_) => List.filled(columns, false));
    flagged = List.generate(rows, (_) => List.filled(columns, false));

    final random = math.Random();
    int minesPlaced = 0;

    while (minesPlaced < bombs) {
      final mineRow = random.nextInt(rows);
      final mineCol = random.nextInt(columns);
      if (!hasMine[mineRow][mineCol]) {
        hasMine[mineRow][mineCol] = true;
        minesPlaced++;
      }
    }
  }

  void loadSounds() async {
    await successPlayer.setSource(AssetSource('music/complete_word.mp3'));
    await failurePlayer.setSource(AssetSource('music/time_out.mp3'));
    await victoryPlayer.setSource(AssetSource('music/end_level.mp3'));
  }

  void startTimer() {
    gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isPaused) {
        setState(() {
          if (remainingSeconds > 0) {
            remainingSeconds--;
          } else {
            timer.cancel();
            showTimeUpDialog();
          }
        });
      }
    });
  }

  void togglePause() {
    setState(() {
      isPaused = !isPaused;
    });
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void playVictorySound() {
    if (isSoundEnabled) {
      victoryPlayer.resume();
    }
  }

  void playSuccessSound() {
    if (isSoundEnabled) {
      successPlayer.resume();
    }
  }

  void playFailureSound() {
    if (isSoundEnabled) {
      failurePlayer.resume();
    }
  }

  int getAdjacentMines(int row, int col) {
    int count = 0;
    for (int i = -1; i <= 1; i++) {
      for (int j = -1; j <= 1; j++) {
        final newRow = row + i;
        final newCol = col + j;
        if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < columns) {
          if (hasMine[newRow][newCol]) count++;
        }
      }
    }
    return count;
  }

  void showTimeUpDialog() {
    playFailureSound();
    setState(() {
      coins = math.max(0, coins - 10);
      timeOut = true;
      isLose = true;
      isWin = false;
      gameOver = true;
    });
  }

  void checkWin() {
    int correctlyFlagged = 0;
    int unrevealed = 0;

    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < columns; j++) {
        if (hasMine[i][j] && flagged[i][j]) correctlyFlagged++;
        if (!revealed[i][j] && !hasMine[i][j]) unrevealed++;
      }
    }

    if (correctlyFlagged == bombs && unrevealed == 0) {
      setState(() {
        isWin = true;
        gameOver = true;
        playVictorySound();
      });
    }
  }

  void revealCell(int row, int col) {
    if (flagged[row][col] || revealed[row][col] || gameOver || isPaused) return;

    setState(() {
      revealed[row][col] = true;

      if (hasMine[row][col]) {
        gameOver = true;
        isLose = true;
        playFailureSound();
        coins = math.max(0, coins - 10);
        for (int i = 0; i < rows; i++) {
          for (int j = 0; j < columns; j++) {
            if (hasMine[i][j]) revealed[i][j] = true;
          }
        }
      } else {
        playSuccessSound();
        checkWin();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Color(0xFFfed0e1),
        ),
        child: Stack(
          children: [
            // Header with controls
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
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * .25,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 44, 31, 31)
                            .withOpacity(0.4),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Text(
                          formatTime(remainingSeconds),
                          style: GoogleFonts.shantellSans(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              ),
            ),

            Positioned(
              top: 130,
              left: 20,
              child: statusBar(
                context,
                bombs,
                flags,
                toggleFlagMode,
                () {
                  setState(() => initializeGame());
                  startTimer();
                },
                () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsScreen(),
                      ));
                },
              ),
            ),

            // Game grid
            Positioned(
              top: 180,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      childAspectRatio: 1.0,
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                    ),
                    itemCount: rows * columns,
                    itemBuilder: (context, index) {
                      final row = index ~/ columns;
                      final col = index % columns;

                      return GestureDetector(
                        onTap: () => revealCell(row, col),
                        child: TweenAnimationBuilder(
                          tween: Tween<double>(
                            begin: revealed[row][col] ? 0.0 : 180.0,
                            end: revealed[row][col] ? 180.0 : 0.0,
                          ),
                          duration: Duration(milliseconds: 300),
                          builder: (context, double value, child) {
                            return Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.001)
                                ..rotateX(value * math.pi / 180),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: revealed[row][col]
                                      ? Color(0xFFfed0e1)
                                      : Color(0xFFE74583),
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(0, 2),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                                child: revealed[row][col]
                                    ? Center(
                                        child: hasMine[row][col]
                                            ? Icon(Icons.close,
                                                color: Colors.red, size: 30)
                                            : getAdjacentMines(row, col) > 0
                                                ? RotationTransition(
                                                    turns:
                                                        new AlwaysStoppedAnimation(
                                                            180 / 360),
                                                    child: Text(
                                                      '${getAdjacentMines(row, col)}',
                                                      style: TextStyle(
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.blue,
                                                      ),
                                                    ),
                                                  )
                                                : null,
                                      )
                                    : null,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            // Game over overlay
            if (gameOver) winLose(context, isLose, coins.toString()),

            // Pause overlay
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
                      builder: (context) => const MainPageGame(),
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
