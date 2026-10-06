//----------------------------------------------------------
// IRAI QUESTION SET MODEL
//----------------------------------------------------------
//
// PURPOSE
// ---------------------------------------------------------
// Represents a collection of questions used for one
// particular IRAI assessment or discovery flow.
//
// Example:
//
// constitution_assessment_v1
//       ↓
// Q1
// Q2
// Q3
// ...
// Q15
//
// IMPORTANT
// ---------------------------------------------------------
// The application should NOT assume that every question
// set contains exactly 15 questions.
//
// Today:
// 15 questions.
//
// Future:
// 10, 15, 20 or adaptive questions.
//
//----------------------------------------------------------

import 'irai_question.dart';


//==========================================================
// IRAI QUESTION SET
//==========================================================

class IraiQuestionSet {

  //----------------------------------------------------------
  // IDENTIFICATION
  //----------------------------------------------------------

  /// Unique ID of this question set.
  final String id;


  //----------------------------------------------------------
  // NAME
  //----------------------------------------------------------

  /// Human-readable name.
  ///
  /// Example:
  /// "Personal Discovery"
  ///
  final String name;


  //----------------------------------------------------------
  // VERSION
  //----------------------------------------------------------

  /// Version of the complete question set.
  ///
  /// Example:
  ///
  /// Version 1
  /// Version 2
  /// Version 3
  ///
  final int version;


  //----------------------------------------------------------
  // QUESTIONS
  //----------------------------------------------------------

  /// Questions belonging to this set.
  final List<IraiQuestion> questions;


  //----------------------------------------------------------
  // ACTIVE
  //----------------------------------------------------------

  /// Whether this question set is currently active.
  final bool active;


  //----------------------------------------------------------
  // CONSTRUCTOR
  //----------------------------------------------------------

  const IraiQuestionSet({

    required this.id,

    required this.name,

    required this.version,

    required this.questions,

    this.active = true,
  });


  //----------------------------------------------------------
  // TOTAL QUESTIONS
  //----------------------------------------------------------

  int get totalQuestions {
    return questions.length;
  }
}