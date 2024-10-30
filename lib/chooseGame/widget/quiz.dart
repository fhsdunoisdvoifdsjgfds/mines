class QuizQuestion {
  final String question;
  final List<String> answers;
  final int correctIndex;

  QuizQuestion({
    required this.question,
    required this.answers,
    required this.correctIndex,
  });
}

final List<QuizQuestion> questions = [
  QuizQuestion(
    question: "What is the result of 7 × 8?",
    answers: ["54", "56", "64", "48"],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: "Solve the equation: 15 + 26",
    answers: ["41", "42", "39", "40"],
    correctIndex: 0,
  ),
  QuizQuestion(
    question: "Find the result of 100 ÷ 4",
    answers: ["20", "25", "24", "22"],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: "Calculate: 17 - 9",
    answers: ["8", "7", "9", "6"],
    correctIndex: 0,
  ),
  QuizQuestion(
    question: "What is the value of 5²?",
    answers: ["10", "20", "25", "30"],
    correctIndex: 2,
  ),
  QuizQuestion(
    question: "What is the result of 6 × 9?",
    answers: ["54", "48", "52", "56"],
    correctIndex: 0,
  ),
  QuizQuestion(
    question: "Solve the equation: 44 - 19",
    answers: ["23", "25", "24", "26"],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: "What is the square root of 81?",
    answers: ["7", "9", "8", "6"],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: "Calculate: 36 ÷ 6",
    answers: ["5", "6", "7", "8"],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: "What is the result of 8 + 15?",
    answers: ["23", "24", "22", "20"],
    correctIndex: 0,
  ),
  QuizQuestion(
    question: "What is 4³?",
    answers: ["64", "16", "24", "32"],
    correctIndex: 0,
  ),
  QuizQuestion(
    question: "Solve for x if x = 5 × 4",
    answers: ["20", "25", "15", "10"],
    correctIndex: 0,
  ),
  QuizQuestion(
    question: "What is 90 ÷ 9?",
    answers: ["9", "10", "8", "11"],
    correctIndex: 0,
  ),
  QuizQuestion(
    question: "Calculate: 64 - 37",
    answers: ["27", "26", "29", "25"],
    correctIndex: 0,
  ),
  QuizQuestion(
    question: "What is the value of 3 × 11?",
    answers: ["33", "34", "32", "35"],
    correctIndex: 0,
  ),
  QuizQuestion(
    question: "Solve the equation: 7 + 18",
    answers: ["26", "25", "24", "23"],
    correctIndex: 3,
  ),
  QuizQuestion(
    question: "What is the square of 12?",
    answers: ["144", "124", "136", "132"],
    correctIndex: 0,
  ),
  QuizQuestion(
    question: "Calculate the value: 25 ÷ 5",
    answers: ["5", "6", "4", "3"],
    correctIndex: 0,
  ),
  QuizQuestion(
    question: "What is 11²?",
    answers: ["111", "121", "131", "141"],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: "Solve: 50 - 28",
    answers: ["22", "24", "21", "23"],
    correctIndex: 0,
  ),
];
