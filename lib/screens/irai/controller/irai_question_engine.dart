//----------------------------------------------------------
// IRAI QUESTION ENGINE
//----------------------------------------------------------
//
// M3 - DYNAMIC PERSONAL DISCOVERY
//
// PURPOSE
// ---------------------------------------------------------
// The Question Engine controls the flow of a Question Set.
//
// It is responsible for:
//
// • Loading the question set
// • Providing the current question
// • Receiving an answer
// • Moving to the next question
// • Tracking progress
// • Detecting completion
//
// IMPORTANT
// ---------------------------------------------------------
// The UI does NOT decide which question comes next.
//
// UI
//  ↓
// Question Engine
//  ↓
// Current Question
//
// This separation allows us to change the questions later
// without changing the IRAI Page.
//
// CURRENT
// ---------------------------------------------------------
// • Local question data
// • Sequential question flow
// • Local answers
//
// FUTURE
// ---------------------------------------------------------
// • Dynamic questions
// • Conditional questions
// • Adaptive questioning
// • User profile context
// • Previous interaction context
// • AI-selected next question
// • Firebase question sets
//
//----------------------------------------------------------

import '../models/irai_question.dart';
import '../models/irai_question_set.dart';


//==========================================================
// QUESTION ENGINE
//==========================================================

class IraiQuestionEngine {

  //----------------------------------------------------------
  // QUESTION SET
  //----------------------------------------------------------
  //
  // The currently active question set.
  //
  //----------------------------------------------------------

  final IraiQuestionSet questionSet;


  //----------------------------------------------------------
  // CURRENT INDEX
  //----------------------------------------------------------
  //
  // Keeps track of the current question.
  //
  //----------------------------------------------------------

  int _currentIndex = 0;


  //----------------------------------------------------------
  // ANSWERS
  //----------------------------------------------------------
  //
  // Stores answers during the current assessment.
  //
  // Example:
  //
  // questionId → selectedOptionId
  //
  //----------------------------------------------------------

  final Map<String, String> _answers = {};


  //----------------------------------------------------------
  // CONSTRUCTOR
  //----------------------------------------------------------

  IraiQuestionEngine({
    required this.questionSet,
  });


  //==========================================================
  // CURRENT QUESTION
  //==========================================================


  //----------------------------------------------------------
  // GET CURRENT QUESTION
  //----------------------------------------------------------
  //
  // Returns the question currently being shown.
  //
  //----------------------------------------------------------

  IraiQuestion? get currentQuestion {

    final questions =
        activeQuestions;

    if (questions.isEmpty) {
      return null;
    }

    if (_currentIndex >= questions.length) {
      return null;
    }

    return questions[_currentIndex];
  }


  //==========================================================
  // ACTIVE QUESTIONS
  //==========================================================


  //----------------------------------------------------------
  // ACTIVE QUESTIONS
  //----------------------------------------------------------
  //
  // Only active questions participate in the assessment.
  //
  // Later Firebase can enable/disable questions without
  // deleting them.
  //
  //----------------------------------------------------------

  List<IraiQuestion> get activeQuestions {

    final questions =
        questionSet.questions
            .where(
              (question) =>
                  question.active,
            )
            .toList();

    questions.sort(
      (a, b) =>
          a.order.compareTo(b.order),
    );

    return questions;
  }


  //==========================================================
  // PROGRESS
  //==========================================================


  //----------------------------------------------------------
  // CURRENT QUESTION NUMBER
  //----------------------------------------------------------
  //
  // Example:
  //
  // 1
  // 2
  // 3
  //
  //----------------------------------------------------------

  int get currentQuestionNumber {

    if (activeQuestions.isEmpty) {
      return 0;
    }

    if (_currentIndex >= activeQuestions.length) {
      return activeQuestions.length;
    }

    return _currentIndex + 1;
  }


  //----------------------------------------------------------
  // TOTAL QUESTIONS
  //----------------------------------------------------------

  int get totalQuestions {

    return activeQuestions.length;
  }


  //----------------------------------------------------------
  // PROGRESS VALUE
  //----------------------------------------------------------
  //
  // Returns a value between 0.0 and 1.0.
  //
  // Example:
  //
  // Question 5 of 15
  //
  // progress = 0.33
  //
  //----------------------------------------------------------

  double get progress {

    if (totalQuestions == 0) {
      return 0.0;
    }

    return currentQuestionNumber /
        totalQuestions;
  }


  //==========================================================
  // ANSWER
  //==========================================================


  //----------------------------------------------------------
  // SAVE ANSWER
  //----------------------------------------------------------
  //
  // Saves the user's answer for the current question.
  //
  // This version accepts a String so it can support:
  //
  // • Option ID
  // • Text
  // • Voice-transcribed text
  //
  //----------------------------------------------------------

  void answer(
    String value,
  ) {

    final question =
        currentQuestion;

    if (question == null) {
      return;
    }

    _answers[question.id] =
        value;
  }


  //----------------------------------------------------------
  // GET ANSWER
  //----------------------------------------------------------
  //
  // Returns the answer for a particular question.
  //
  //----------------------------------------------------------

  String? answerFor(
    String questionId,
  ) {

    return _answers[questionId];
  }


  //==========================================================
  // NAVIGATION
  //==========================================================


  //----------------------------------------------------------
  // MOVE TO NEXT QUESTION
  //----------------------------------------------------------
  //
  // The current prototype uses sequential progression.
  //
  // Future:
  //
  // Answer
  //   ↓
  // Rules
  //   ↓
  // Next Best Question
  //
  //----------------------------------------------------------

  bool next() {

    if (isComplete) {
      return false;
    }

    _currentIndex++;

    return !isComplete;
  }


  //----------------------------------------------------------
  // MOVE TO PREVIOUS QUESTION
  //----------------------------------------------------------
  //
  // Useful later if we want the user to edit an answer.
  //
  //----------------------------------------------------------

  bool previous() {

    if (_currentIndex <= 0) {
      return false;
    }

    _currentIndex--;

    return true;
  }


  //==========================================================
  // COMPLETION
  //==========================================================


  //----------------------------------------------------------
  // IS COMPLETE
  //----------------------------------------------------------
  //
  // Returns true when all active questions have been
  // completed.
  //
  //----------------------------------------------------------

  bool get isComplete {

    return _currentIndex >=
        activeQuestions.length;
  }


  //----------------------------------------------------------
  // HAS STARTED
  //----------------------------------------------------------

  bool get hasStarted {

    return _currentIndex > 0 ||
        _answers.isNotEmpty;
  }


  //==========================================================
  // ANSWERS
  //==========================================================


  //----------------------------------------------------------
  // ALL ANSWERS
  //----------------------------------------------------------
  //
  // Returns a copy so external code cannot directly modify
  // the internal answer map.
  //
  //----------------------------------------------------------

  Map<String, String> get answers {

    return Map.unmodifiable(
      _answers,
    );
  }


  //----------------------------------------------------------
  // ANSWER COUNT
  //----------------------------------------------------------

  int get answeredCount {

    return _answers.length;
  }


  //==========================================================
  // RESET
  //==========================================================


  //----------------------------------------------------------
  // RESET ENGINE
  //----------------------------------------------------------
  //
  // Starts the assessment again from Question 1.
  //
  //----------------------------------------------------------

  void reset() {

    _currentIndex = 0;

    _answers.clear();
  }
}