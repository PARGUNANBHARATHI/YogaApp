//----------------------------------------------------------
// IRAI USER UNDERSTANDING MODEL
//----------------------------------------------------------
//
// M4.3 — USER UNDERSTANDING
//
// PURPOSE
// ---------------------------------------------------------
// Represents what IRAI currently understands about a user.
//
// This model sits between:
//
// M3
// Assessment / Answers / Signals
//          ↓
// M4
// User Understanding
//          ↓
// Personalization
//
// IMPORTANT
// ---------------------------------------------------------
// This is NOT a medical diagnosis model.
//
// It represents the current personalization understanding
// available to IRAI.
//
// The understanding can change as IRAI receives more:
//
// • Assessment answers
// • User interactions
// • Behaviour signals
// • Preferences
// • Goals
// • Future wearable information
//
//----------------------------------------------------------
//
// ARCHITECTURE PRINCIPLE
// ---------------------------------------------------------
//
// We intentionally keep Body, Mind and Lifestyle inside
// ONE model for now.
//
// This avoids unnecessary files while the architecture
// is still evolving.
//
// If one area becomes complex enough later, it can be
// separated without changing the overall system.
//
//----------------------------------------------------------
//
// CURRENT
// ---------------------------------------------------------
//
// M3 Assessment
//      ↓
// Signals
//      ↓
// UserUnderstandingModel
//
// FUTURE
// ---------------------------------------------------------
//
// UserUnderstandingModel
//      ↓
// Personalization Engine
//      ↓
// Today / Programs / IRAI
//
//----------------------------------------------------------


//==========================================================
// IRAI UNDERSTANDING STATUS
//==========================================================

enum IraiUnderstandingStatus {

  //----------------------------------------------------------
  // IRAI has very little information about the user.
  //----------------------------------------------------------

  initial,

  //----------------------------------------------------------
  // IRAI has started collecting information.
  //----------------------------------------------------------

  developing,

  //----------------------------------------------------------
  // IRAI has enough information to begin personalization.
  //----------------------------------------------------------

  established,

  //----------------------------------------------------------
  // Understanding continues to evolve with new evidence.
  //----------------------------------------------------------

  evolving,
}


//==========================================================
// USER UNDERSTANDING MODEL
//==========================================================

class UserUnderstandingModel {

  //----------------------------------------------------------
  // USER
  //----------------------------------------------------------

  /// User this understanding belongs to.
  final String userId;


  //----------------------------------------------------------
  // BODY / CONSTITUTION SIGNALS
  //----------------------------------------------------------
  //
  // Flexible signal storage.
  //
  // Example:
  //
  // {
  //   "morning_energy": 0.7,
  //   "temperature_sensitivity": 0.4
  // }
  //
  // IMPORTANT:
  // These are signals/evidence, NOT a final diagnosis.
  //
  //----------------------------------------------------------

  final Map<String, double> bodySignals;


  //----------------------------------------------------------
  // MIND SIGNALS
  //----------------------------------------------------------
  //
  // Examples:
  //
  // focus
  // thought_activity
  // stress_response
  //
  //----------------------------------------------------------

  final Map<String, double> mindSignals;


  //----------------------------------------------------------
  // LIFESTYLE SIGNALS
  //----------------------------------------------------------
  //
  // Examples:
  //
  // sleep_pattern
  // activity_pattern
  // routine_consistency
  //
  //----------------------------------------------------------

  final Map<String, double> lifestyleSignals;


  //----------------------------------------------------------
  // GOALS
  //----------------------------------------------------------
  //
  // User-selected goals.
  //
  // Example:
  //
  // [
  //   "better_energy",
  //   "better_sleep"
  // ]
  //
  //----------------------------------------------------------

  final List<String> goals;


  //----------------------------------------------------------
  // PREFERENCES
  //----------------------------------------------------------
  //
  // Known user preferences.
  //
  // Example:
  //
  // [
  //   "short_sessions",
  //   "morning_practice"
  // ]
  //
  //----------------------------------------------------------

  final List<String> preferences;


  //----------------------------------------------------------
  // STATUS
  //----------------------------------------------------------

  final IraiUnderstandingStatus status;


  //----------------------------------------------------------
  // OVERALL CONFIDENCE
  //----------------------------------------------------------
  //
  // Value between 0.0 and 1.0.
  //
  // This represents how much supporting information IRAI
  // currently has.
  //
  // It does NOT represent medical certainty.
  //
  //----------------------------------------------------------

  final double confidence;


  //----------------------------------------------------------
  // LAST UPDATED
  //----------------------------------------------------------

  final DateTime updatedAt;


  //----------------------------------------------------------
  // CONSTRUCTOR
  //----------------------------------------------------------

  const UserUnderstandingModel({

    required this.userId,

    this.bodySignals = const {},

    this.mindSignals = const {},

    this.lifestyleSignals = const {},

    this.goals = const [],

    this.preferences = const [],

    this.status =
        IraiUnderstandingStatus.initial,

    this.confidence = 0.0,

    required this.updatedAt,
  });


  //==========================================================
  // HELPERS
  //==========================================================


  //----------------------------------------------------------
  // HAS BODY INFORMATION
  //----------------------------------------------------------

  bool get hasBodyInformation {

    return bodySignals.isNotEmpty;
  }


  //----------------------------------------------------------
  // HAS MIND INFORMATION
  //----------------------------------------------------------

  bool get hasMindInformation {

    return mindSignals.isNotEmpty;
  }


  //----------------------------------------------------------
  // HAS LIFESTYLE INFORMATION
  //----------------------------------------------------------

  bool get hasLifestyleInformation {

    return lifestyleSignals.isNotEmpty;
  }


  //----------------------------------------------------------
  // HAS GOALS
  //----------------------------------------------------------

  bool get hasGoals {

    return goals.isNotEmpty;
  }


  //----------------------------------------------------------
  // HAS PREFERENCES
  //----------------------------------------------------------

  bool get hasPreferences {

    return preferences.isNotEmpty;
  }


  //----------------------------------------------------------
  // HAS UNDERSTANDING
  //----------------------------------------------------------

  bool get hasUnderstanding {

    return hasBodyInformation ||
        hasMindInformation ||
        hasLifestyleInformation ||
        hasGoals ||
        hasPreferences;
  }


  //----------------------------------------------------------
  // IS READY FOR PERSONALIZATION
  //----------------------------------------------------------
  //
  // This is deliberately simple for now.
  //
  // The actual readiness rules will eventually belong to
  // the Understanding Engine.
  //
  //----------------------------------------------------------

  bool get isReadyForPersonalization {

    return confidence > 0.0 &&
        hasUnderstanding;
  }


  //----------------------------------------------------------
  // CONFIDENCE NORMALIZATION
  //----------------------------------------------------------
  //
  // Keeps confidence safely between 0.0 and 1.0.
  //
  //----------------------------------------------------------

  double get normalizedConfidence {

    if (confidence < 0.0) {
      return 0.0;
    }

    if (confidence > 1.0) {
      return 1.0;
    }

    return confidence;
  }
}