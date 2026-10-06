//----------------------------------------------------------
// IRAI SESSION MODEL
//----------------------------------------------------------
//
// Represents one continuous interaction session with IRAI.
//
// Example:
//
// User opens IRAI
//       ↓
// Session starts
//       ↓
// Question
//       ↓
// Answer
//       ↓
// Follow-up
//       ↓
// Answer
//       ↓
// Session continues
//
// FUTURE:
// This session can later be stored in Firebase.
//
//----------------------------------------------------------

import 'irai_answer.dart';

class IraiSession {
  final String id;

  final DateTime startedAt;

  DateTime lastUpdatedAt;

  final List<IraiAnswer> answers;

  IraiSession({
    required this.id,
    required this.startedAt,
    required this.lastUpdatedAt,
    List<IraiAnswer>? answers,
  }) : answers = answers ?? [];

  //----------------------------------------------------------
  // ADD ANSWER
  //----------------------------------------------------------

  void addAnswer(IraiAnswer answer) {
    answers.add(answer);

    lastUpdatedAt = DateTime.now();
  }

  //----------------------------------------------------------
  // ANSWER COUNT
  //----------------------------------------------------------

  int get answerCount {
    return answers.length;
  }
}