//----------------------------------------------------------
// IRAI CONSTITUTION ENGINE
//----------------------------------------------------------
//
// M4 — CONSTITUTION ANALYSIS
//
// PURPOSE
// ---------------------------------------------------------
// Reads the user's answers from an IRAI Question Set and
// calculates the temporary:
//
// • Vatham
// • Pitham
// • Kapham
//
// constitution scores.
//
// IMPORTANT
// ---------------------------------------------------------
// This is currently a DEVELOPMENT / ARCHITECTURE prototype.
//
// The 5 questions and their scores are temporary.
//
// Later:
// • 5 questions → real 15 questions
// • Temporary scores → your final constitution methodology
//
// The Question UI and Question Engine do NOT need to change.
//
//----------------------------------------------------------
//
// FLOW
// ---------------------------------------------------------
//
// IRAI Question Set
//        ↓
// User Answers
//        ↓
// Selected Question Options
//        ↓
// Option Scores
//        ↓
// Constitution Engine
//        ↓
// Vatham / Pitham / Kapham
//        ↓
// Constitution Result
//
//----------------------------------------------------------
//
// EXAMPLE
// ---------------------------------------------------------
//
// Q1 → Vatham
// Q2 → Vatham
// Q3 → Vatham
// Q4 → Pitham
// Q5 → Kapham
//
// Result:
//
// Vatham = 3
// Pitham = 1
// Kapham = 1
//
// Dominant  = Vatham
// Secondary = Pitham
//
//----------------------------------------------------------
//
// IMPORTANT
// ---------------------------------------------------------
// This prototype is NOT a medical diagnosis and should not
// be treated as a clinically validated Siddha assessment.
//
//----------------------------------------------------------


import '../models/irai_question.dart';
import '../models/irai_question_set.dart';


//==========================================================
// CONSTITUTION RESULT
//==========================================================
//
// Contains the calculated constitution scores.
//
// This is a result object, not the analysis engine itself.
//
//==========================================================

class IraiConstitutionResult {

  //----------------------------------------------------------
  // RAW SCORES
  //----------------------------------------------------------

  /// Raw Vatham score.
  final double vatham;

  /// Raw Pitham score.
  final double pitham;

  /// Raw Kapham score.
  final double kapham;


  //----------------------------------------------------------
  // CONSTRUCTOR
  //----------------------------------------------------------

  const IraiConstitutionResult({

    required this.vatham,

    required this.pitham,

    required this.kapham,
  });


  //==========================================================
  // TOTAL SCORE
  //==========================================================

  double get total {

    return vatham +
        pitham +
        kapham;
  }


  //==========================================================
  // DOMINANT CONSTITUTION
  //==========================================================
  //
  // Returns the highest scoring pattern.
  //
  // Current tie behaviour:
  // Vatham wins if tied with another pattern.
  //
  // Later we can introduce a proper tie / dual-pattern
  // methodology when your final rules are defined.
  //
  //==========================================================

  String get dominant {

    if (vatham >= pitham &&
        vatham >= kapham) {

      return "vatham";
    }

    if (pitham >= vatham &&
        pitham >= kapham) {

      return "pitham";
    }

    return "kapham";
  }


  //==========================================================
  // SECONDARY CONSTITUTION
  //==========================================================

  String? get secondary {

    final scores =
        <String, double>{

      "vatham": vatham,

      "pitham": pitham,

      "kapham": kapham,
    };


    //--------------------------------------------------------
    // SORT FROM HIGHEST TO LOWEST
    //--------------------------------------------------------

    final sorted =
        scores.entries.toList()
          ..sort(
            (a, b) =>
                b.value.compareTo(
                  a.value,
                ),
          );


    //--------------------------------------------------------
    // NOT ENOUGH INFORMATION
    //--------------------------------------------------------

    if (sorted.length < 2) {

      return null;
    }


    //--------------------------------------------------------
    // SECONDARY MUST HAVE SOME SCORE
    //--------------------------------------------------------

    if (sorted[1].value <= 0) {

      return null;
    }


    return sorted[1].key;
  }


  //==========================================================
  // NORMALIZED SCORES
  //==========================================================
  //
  // Converts raw scores into proportions.
  //
  // Example:
  //
  // Vatham = 3
  // Pitham = 1
  // Kapham = 1
  //
  // Result:
  //
  // Vatham = 0.60
  // Pitham = 0.20
  // Kapham = 0.20
  //
  //==========================================================

  Map<String, double> get normalizedScores {

    //--------------------------------------------------------
    // NO SCORE
    //--------------------------------------------------------

    if (total <= 0) {

      return const {

        "vatham": 0.0,

        "pitham": 0.0,

        "kapham": 0.0,
      };
    }


    //--------------------------------------------------------
    // NORMALIZE
    //--------------------------------------------------------

    return {

      "vatham":
          vatham / total,

      "pitham":
          pitham / total,

      "kapham":
          kapham / total,
    };
  }


  //==========================================================
  // DOMINANT SCORE
  //==========================================================

  double get dominantScore {

    switch (dominant) {

      case "vatham":
        return vatham;

      case "pitham":
        return pitham;

      case "kapham":
        return kapham;

      default:
        return 0.0;
    }
  }


  //==========================================================
  // DOMINANT PERCENTAGE
  //==========================================================

  double get dominantPercentage {

    if (total <= 0) {

      return 0.0;
    }

    return dominantScore / total;
  }
}


//==========================================================
// IRAI CONSTITUTION ENGINE
//==========================================================
//
// This class performs the actual calculation.
//
//==========================================================

class IraiConstitutionEngine {

  //==========================================================
  // ANALYZE
  //==========================================================
  //
  // questionSet:
  // The complete question set used for the assessment.
  //
  // answers:
  // Map containing:
  //
  // questionId → selectedOptionId
  //
  // Example:
  //
  // {
  //   "constitution_q1": "q1_vatham",
  //   "constitution_q2": "q2_pitham",
  // }
  //
  //==========================================================

  IraiConstitutionResult analyze({

    required IraiQuestionSet questionSet,

    required Map<String, String> answers,

  }) {

    //--------------------------------------------------------
    // INITIAL SCORES
    //--------------------------------------------------------

    double vatham = 0.0;

    double pitham = 0.0;

    double kapham = 0.0;


    //--------------------------------------------------------
    // PROCESS QUESTIONS
    //--------------------------------------------------------

    for (final question
        in questionSet.questions) {

      //------------------------------------------------------
      // GET USER'S ANSWER
      //------------------------------------------------------

      final selectedOptionId =
          answers[question.id];


      //------------------------------------------------------
      // QUESTION NOT ANSWERED
      //------------------------------------------------------

      if (selectedOptionId == null) {

        continue;
      }


      //------------------------------------------------------
      // FIND SELECTED OPTION
      //------------------------------------------------------

      IraiQuestionOption? selectedOption;


      for (final option
          in question.options) {

        if (option.id ==
            selectedOptionId) {

          selectedOption =
              option;

          break;
        }
      }


      //------------------------------------------------------
      // OPTION NOT FOUND
      //------------------------------------------------------

      if (selectedOption == null) {

        continue;
      }


      //------------------------------------------------------
      // READ OPTION SCORES
      //------------------------------------------------------

      final scores =
          selectedOption.scores;


      //------------------------------------------------------
      // ADD VATHAM
      //------------------------------------------------------

      vatham +=
          scores["vatham"] ??
          0.0;


      //------------------------------------------------------
      // ADD PITHAM
      //------------------------------------------------------

      pitham +=
          scores["pitham"] ??
          0.0;


      //------------------------------------------------------
      // ADD KAPHAM
      //------------------------------------------------------

      kapham +=
          scores["kapham"] ??
          0.0;
    }


    //--------------------------------------------------------
    // RETURN FINAL RESULT
    //--------------------------------------------------------

    return IraiConstitutionResult(

      vatham:
          vatham,

      pitham:
          pitham,

      kapham:
          kapham,
    );
  }
}