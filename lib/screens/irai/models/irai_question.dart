//----------------------------------------------------------
// IRAI QUESTION MODEL
//----------------------------------------------------------
//
// M3 - DYNAMIC QUESTION ENGINE
//
// PURPOSE
// ---------------------------------------------------------
// Represents one question used by IRAI.
//
// A question is DATA.
// It is NOT part of the UI.
//
// This is important because the actual IRAI questions
// may change in the future.
//
// Example:
//
// Today:
// "How do you usually feel after waking up?"
//
// Future:
// The wording, options, order or even the question itself
// can be changed without rebuilding the IRAI page.
//
// CURRENT:
// • Local sample questions
// • Constitution scoring support
//
// FUTURE:
// • Firebase question data
// • Versioned question sets
// • Adaptive questions
// • AI-selected questions
// • Different assessment methodologies
//
//----------------------------------------------------------


//==========================================================
// QUESTION TYPE
//==========================================================

enum IraiQuestionType {

  //----------------------------------------------------------
  // User selects one option.
  //----------------------------------------------------------

  singleChoice,

  //----------------------------------------------------------
  // User can select multiple options.
  //----------------------------------------------------------

  multipleChoice,

  //----------------------------------------------------------
  // User writes an answer.
  //----------------------------------------------------------

  text,

  //----------------------------------------------------------
  // User speaks an answer.
  //----------------------------------------------------------

  voice,
}


//==========================================================
// IRAI QUESTION
//==========================================================

class IraiQuestion {

  //----------------------------------------------------------
  // IDENTIFICATION
  //----------------------------------------------------------

  /// Unique question ID.
  final String id;


  //----------------------------------------------------------
  // QUESTION SET
  //----------------------------------------------------------

  /// ID of the question set this question belongs to.
  ///
  /// Example:
  ///
  /// "constitution_assessment_v1"
  ///
  final String questionSetId;


  //----------------------------------------------------------
  // VERSION
  //----------------------------------------------------------

  /// Version of this question.
  ///
  /// This allows the question to evolve later.
  ///
  final int version;


  //----------------------------------------------------------
  // QUESTION TEXT
  //----------------------------------------------------------

  /// Main question shown to the user.
  final String question;


  //----------------------------------------------------------
  // SUPPORTING TEXT
  //----------------------------------------------------------

  /// Optional explanation below the question.
  final String? subtitle;


  //----------------------------------------------------------
  // QUESTION TYPE
  //----------------------------------------------------------

  /// Defines how the user answers.
  final IraiQuestionType type;


  //----------------------------------------------------------
  // OPTIONS
  //----------------------------------------------------------

  /// Available answer options.
  ///
  /// For text/voice questions this can remain empty.
  ///
  final List<IraiQuestionOption> options;


  //----------------------------------------------------------
  // ORDER
  //----------------------------------------------------------

  /// Default position inside the question set.
  ///
  /// The Question Engine may later choose a different
  /// question dynamically.
  ///
  final int order;


  //----------------------------------------------------------
  // ACTIVE
  //----------------------------------------------------------

  /// Whether this question is currently active.
  ///
  /// Future Firebase version can use this to disable
  /// questions without deleting them.
  ///
  final bool active;


  //----------------------------------------------------------
  // CONSTRUCTOR
  //----------------------------------------------------------

  const IraiQuestion({

    required this.id,

    required this.questionSetId,

    required this.version,

    required this.question,

    this.subtitle,

    required this.type,

    this.options = const [],

    required this.order,

    this.active = true,
  });
}


//==========================================================
// QUESTION OPTION
//==========================================================
//
// Represents one selectable answer.
//
// Example:
//
// 😊 Calm
// 😴 Tired
// 🧠 Busy mind
//
// M4 CONSTITUTION SUPPORT
// ---------------------------------------------------------
// Each option can optionally contain constitution scores.
//
// Example:
//
// {
//   "vatham": 1.0,
//   "pitham": 0.0,
//   "kapham": 0.0,
// }
//
// The Question UI does NOT need to know what these scores
// mean.
//
// The Constitution Engine reads them later.
//
// This keeps:
//
// Question Data
//      ↓
// Constitution Analysis
//
// separate.
//
// IMPORTANT
// ---------------------------------------------------------
// These scores are temporary sample values for architecture
// testing.
//
// Your final constitution methodology can change later
// without changing the Question UI.
//
//----------------------------------------------------------

class IraiQuestionOption {

  //----------------------------------------------------------
  // IDENTIFICATION
  //----------------------------------------------------------

  /// Unique option ID.
  final String id;


  //----------------------------------------------------------
  // DISPLAY
  //----------------------------------------------------------

  /// Main option text.
  final String title;


  //----------------------------------------------------------
  // SUPPORTING TEXT
  //----------------------------------------------------------

  /// Optional supporting text.
  final String? subtitle;


  //----------------------------------------------------------
  // EMOJI
  //----------------------------------------------------------

  /// Optional emoji displayed with the option.
  final String? emoji;


  //----------------------------------------------------------
  // CONSTITUTION SCORES
  //----------------------------------------------------------
  //
  // Stores optional scoring information for analysis.
  //
  // Example:
  //
  // {
  //   "vatham": 1.0,
  //   "pitham": 0.0,
  //   "kapham": 0.0,
  // }
  //
  // The key names remain data-driven.
  //
  // This means the Question Model does not contain
  // hard-coded constitution logic.
  //
  //----------------------------------------------------------

  final Map<String, double> scores;


  //----------------------------------------------------------
  // CONSTRUCTOR
  //----------------------------------------------------------

  const IraiQuestionOption({

    required this.id,

    required this.title,

    this.subtitle,

    this.emoji,

    this.scores = const {},
  });
}