//----------------------------------------------------------
// IRAI ASSESSMENT RESULT MODEL
//----------------------------------------------------------
//
// M3 - DYNAMIC PERSONAL DISCOVERY
//
// PURPOSE
// ---------------------------------------------------------
// Represents the result produced after the user completes
// a Question Set.
//
// IMPORTANT
// ---------------------------------------------------------
// This is NOT the final body/constitution calculation.
//
// It is the STRUCTURED RESULT layer.
//
// Current:
// • Stores answers
// • Stores question set information
// • Stores completion time
//
// Future:
// • Constitution analysis
// • Body pattern analysis
// • Mind pattern analysis
// • Lifestyle pattern analysis
// • AI interpretation
// • Firebase persistence
//
//----------------------------------------------------------

class IraiAssessmentResult {

  //----------------------------------------------------------
  // IDENTIFICATION
  //----------------------------------------------------------

  final String id;


  //----------------------------------------------------------
  // QUESTION SET
  //----------------------------------------------------------

  final String questionSetId;

  final int questionSetVersion;


  //----------------------------------------------------------
  // ANSWERS
  //----------------------------------------------------------
  //
  // questionId → answer
  //
  //----------------------------------------------------------

  final Map<String, String> answers;


  //----------------------------------------------------------
  // COMPLETION
  //----------------------------------------------------------

  final DateTime completedAt;


  //----------------------------------------------------------
  // CONSTRUCTOR
  //----------------------------------------------------------

  const IraiAssessmentResult({

    required this.id,

    required this.questionSetId,

    required this.questionSetVersion,

    required this.answers,

    required this.completedAt,
  });


  //----------------------------------------------------------
  // ANSWER COUNT
  //----------------------------------------------------------

  int get answerCount {

    return answers.length;
  }
}