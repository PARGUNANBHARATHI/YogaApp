//----------------------------------------------------------
// IRAI SIGNAL MODEL
//----------------------------------------------------------
//
// M4.2 — USER UNDERSTANDING
//
// PURPOSE
// ---------------------------------------------------------
// A Signal represents a meaningful piece of information
// extracted from something the user has said, selected,
// or demonstrated through interaction.
//
// IMPORTANT
// ---------------------------------------------------------
// A Signal is NOT a final conclusion.
//
// Example:
//
// User Answer
//      ↓
// "I feel slow in the morning"
//      ↓
// Signal
//      ↓
// "morning_low_energy"
//      ↓
// Later analysis
//      ↓
// Possible pattern
//
// This separation is important because IRAI's understanding
// system will evolve over time.
//
//----------------------------------------------------------
//
// SIGNAL SOURCES
// ---------------------------------------------------------
//
// A signal can come from:
//
// • User answer
// • User profile
// • User interaction
// • User behaviour
// • Assessment
// • Future wearable data
// • Future AI analysis
//
//----------------------------------------------------------
//
// FUTURE
// ---------------------------------------------------------
//
// Signal
//    ↓
// Evidence
//    ↓
// Pattern
//    ↓
// User Understanding
//    ↓
// Personalization
//
//----------------------------------------------------------


//==========================================================
// SIGNAL SOURCE
//==========================================================

enum IraiSignalSource {

  //----------------------------------------------------------
  // Information directly provided by the user.
  //----------------------------------------------------------

  user,

  //----------------------------------------------------------
  // Information collected from an assessment.
  //----------------------------------------------------------

  assessment,

  //----------------------------------------------------------
  // Pattern observed from user behaviour.
  //----------------------------------------------------------

  behavior,

  //----------------------------------------------------------
  // Information from the user's profile.
  //----------------------------------------------------------

  profile,

  //----------------------------------------------------------
  // Future AI-generated signal.
  //----------------------------------------------------------

  ai,

  //----------------------------------------------------------
  // Future wearable / sensor information.
  //----------------------------------------------------------

  wearable,
}


//==========================================================
// SIGNAL CONFIDENCE
//==========================================================
//
// Confidence represents how strongly IRAI should trust the
// signal.
//
// IMPORTANT
// ---------------------------------------------------------
// Confidence does NOT mean medical certainty.
//
// It only describes the reliability of the information
// available to the personalization system.
//
//----------------------------------------------------------

enum IraiSignalConfidence {

  //----------------------------------------------------------
  // Very little evidence.
  //----------------------------------------------------------

  low,

  //----------------------------------------------------------
  // Some supporting evidence.
  //----------------------------------------------------------

  medium,

  //----------------------------------------------------------
  // Strong supporting evidence.
  //----------------------------------------------------------

  high,
}


//==========================================================
// IRAI SIGNAL MODEL
//==========================================================

class IraiSignalModel {

  //----------------------------------------------------------
  // IDENTIFICATION
  //----------------------------------------------------------

  /// Unique ID of this signal.
  final String id;


  //----------------------------------------------------------
  // USER
  //----------------------------------------------------------
  //
  // Identifies the user this signal belongs to.
  //
  //----------------------------------------------------------

  final String userId;


  //----------------------------------------------------------
  // SIGNAL KEY
  //----------------------------------------------------------
  //
  // Machine-readable name.
  //
  // Examples:
  //
  // morning_low_energy
  // busy_mind
  // prefers_short_sessions
  //
  //----------------------------------------------------------

  final String key;


  //----------------------------------------------------------
  // VALUE
  //----------------------------------------------------------
  //
  // Actual value associated with the signal.
  //
  // Example:
  //
  // key:
  // morning_energy
  //
  // value:
  // low
  //
  //----------------------------------------------------------

  final String value;


  //----------------------------------------------------------
  // SOURCE
  //----------------------------------------------------------

  final IraiSignalSource source;


  //----------------------------------------------------------
  // CONFIDENCE
  //----------------------------------------------------------

  final IraiSignalConfidence confidence;


  //----------------------------------------------------------
  // EVIDENCE ID
  //----------------------------------------------------------
  //
  // Identifies where the signal came from.
  //
  // Examples:
  //
  // Question ID
  // Assessment ID
  // Interaction ID
  // Behaviour event ID
  //
  //----------------------------------------------------------

  final String? evidenceId;


  //----------------------------------------------------------
  // CREATED TIME
  //----------------------------------------------------------

  final DateTime createdAt;


  //----------------------------------------------------------
  // UPDATED TIME
  //----------------------------------------------------------

  final DateTime updatedAt;


  //----------------------------------------------------------
  // CONSTRUCTOR
  //----------------------------------------------------------

  const IraiSignalModel({

    required this.id,

    required this.userId,

    required this.key,

    required this.value,

    required this.source,

    required this.confidence,

    this.evidenceId,

    required this.createdAt,

    required this.updatedAt,
  });


  //==========================================================
  // HELPERS
  //==========================================================


  //----------------------------------------------------------
  // IS USER PROVIDED
  //----------------------------------------------------------

  bool get isUserProvided {

    return source ==
        IraiSignalSource.user;
  }


  //----------------------------------------------------------
  // IS ASSESSMENT SIGNAL
  //----------------------------------------------------------

  bool get isAssessmentSignal {

    return source ==
        IraiSignalSource.assessment;
  }


  //----------------------------------------------------------
  // IS BEHAVIOR SIGNAL
  //----------------------------------------------------------

  bool get isBehaviorSignal {

    return source ==
        IraiSignalSource.behavior;
  }


  //----------------------------------------------------------
  // IS HIGH CONFIDENCE
  //----------------------------------------------------------

  bool get isHighConfidence {

    return confidence ==
        IraiSignalConfidence.high;
  }
}