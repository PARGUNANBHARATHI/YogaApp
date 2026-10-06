//----------------------------------------------------------
// IRAI PERSONALIZATION ENGINE
//----------------------------------------------------------
//
// M4.5 — PERSONALIZATION
//
// PURPOSE
// ---------------------------------------------------------
// Converts IRAI's current understanding of a user into
// structured personalization information.
//
// IMPORTANT
// ---------------------------------------------------------
// This engine does NOT directly control the Today Page,
// Programs Page, or IRAI UI.
//
// It produces personalization decisions/data that those
// parts of the application can consume.
//
//----------------------------------------------------------
//
// CURRENT ARCHITECTURE
// ---------------------------------------------------------
//
// User Profile
//      +
// User Signals
//      +
// User Understanding
//      ↓
// Personalization Engine
//      ↓
// Personalization Result
//      ↓
// Today / Programs / IRAI
//
//----------------------------------------------------------
//
// FUTURE ARCHITECTURE
// ---------------------------------------------------------
//
// Assessment
// Interaction
// Behaviour
// Wearable
// Schedule
// User Feedback
//      ↓
// Understanding Engine
//      ↓
// User Understanding
//      ↓
// Personalization Engine
//      ↓
// Recommendation
//
//----------------------------------------------------------
//
// IMPORTANT FUTURE PRINCIPLE
// ---------------------------------------------------------
// Personalization should NOT be based on only one answer.
//
// Example:
//
// One answer
//     ↓
// Signal
//     ↓
// More evidence
//     ↓
// Pattern
//     ↓
// Personalization
//
// This allows IRAI to gradually understand the user.
//
//----------------------------------------------------------


import '../models/user_profile_model.dart';
import '../models/user_understanding_model.dart';


//==========================================================
// IRAI PERSONALIZATION RESULT
//==========================================================
//
// This is kept in the same file for now to avoid creating
// another unnecessary model file.
//
// If this becomes complex later, it can be moved into its
// own model file without changing the engine architecture.
//
//==========================================================

class IraiPersonalizationResult {

  //----------------------------------------------------------
  // USER
  //----------------------------------------------------------

  final String userId;


  //----------------------------------------------------------
  // MORNING APPROACH
  //----------------------------------------------------------
  //
  // Example future values:
  //
  // gentle
  // active
  // balanced
  //
  //----------------------------------------------------------

  final String morningApproach;


  //----------------------------------------------------------
  // SESSION APPROACH
  //----------------------------------------------------------
  //
  // Example:
  //
  // short
  // moderate
  // extended
  //
  //----------------------------------------------------------

  final String sessionApproach;


  //----------------------------------------------------------
  // COMMUNICATION STYLE
  //----------------------------------------------------------
  //
  // Example:
  //
  // concise
  // supportive
  // detailed
  //
  //----------------------------------------------------------

  final String communicationStyle;


  //----------------------------------------------------------
  // PRIORITY AREAS
  //----------------------------------------------------------
  //
  // Examples:
  //
  // sleep
  // energy
  // movement
  // routine
  //
  //----------------------------------------------------------

  final List<String> priorityAreas;


  //----------------------------------------------------------
  // PERSONALIZATION CONFIDENCE
  //----------------------------------------------------------

  final double confidence;


  //----------------------------------------------------------
  // CREATED TIME
  //----------------------------------------------------------

  final DateTime createdAt;


  //----------------------------------------------------------
  // CONSTRUCTOR
  //----------------------------------------------------------

  const IraiPersonalizationResult({

    required this.userId,

    required this.morningApproach,

    required this.sessionApproach,

    required this.communicationStyle,

    required this.priorityAreas,

    required this.confidence,

    required this.createdAt,
  });
}


//==========================================================
// PERSONALIZATION ENGINE
//==========================================================

class IraiPersonalizationEngine {

  //==========================================================
  // BUILD PERSONALIZATION
  //==========================================================
  //
  // Creates a personalization result from the information
  // IRAI currently knows.
  //
  //----------------------------------------------------------

  IraiPersonalizationResult build({

    required UserProfileModel profile,

    required UserUnderstandingModel understanding,

  }) {

    //--------------------------------------------------------
    // DETERMINE MORNING APPROACH
    //--------------------------------------------------------

    final morningApproach =
    _determineMorningApproach(
  understanding,
);


    //--------------------------------------------------------
    // DETERMINE SESSION APPROACH
    //--------------------------------------------------------

    final sessionApproach =
    _determineSessionApproach(
  profile: profile,
  understanding: understanding,
);


    //--------------------------------------------------------
    // DETERMINE COMMUNICATION STYLE
    //--------------------------------------------------------

    final communicationStyle =
        _determineCommunicationStyle(
      profile,
      understanding,
    );


    //--------------------------------------------------------
    // DETERMINE PRIORITIES
    //--------------------------------------------------------

    final priorityAreas =
        _determinePriorityAreas(
      profile,
      understanding,
    );


    //--------------------------------------------------------
    // CALCULATE CONFIDENCE
    //--------------------------------------------------------

    final confidence =
        _calculateConfidence(
      understanding,
    );


    //--------------------------------------------------------
    // CREATE RESULT
    //--------------------------------------------------------

    return IraiPersonalizationResult(

      userId:
          profile.userId,

      morningApproach:
          morningApproach,

      sessionApproach:
          sessionApproach,

      communicationStyle:
          communicationStyle,

      priorityAreas:
          List.unmodifiable(
        priorityAreas,
      ),

      confidence:
          confidence,

      createdAt:
          DateTime.now(),
    );
  }


  //==========================================================
  // MORNING APPROACH
  //==========================================================
  //
  // This is intentionally simple.
  //
  // It demonstrates how IRAI can eventually personalize the
  // Today Page without locking us into a final wellness
  // methodology.
  //
  //----------------------------------------------------------

  String _determineMorningApproach(
    UserUnderstandingModel understanding,
  ) {

    //--------------------------------------------------------
    // CURRENT FOUNDATION
    //--------------------------------------------------------
    //
    // We do not yet have final constitution logic.
    //
    // Therefore we use available lifestyle evidence only.
    //
    //--------------------------------------------------------

    final morningEnergy =
        understanding
            .lifestyleSignals[
              "morning_energy"
            ];


    if (morningEnergy != null) {

      if (morningEnergy < 0.4) {
        return "gentle";
      }

      if (morningEnergy > 0.7) {
        return "active";
      }
    }


    //--------------------------------------------------------
    // DEFAULT
    //--------------------------------------------------------

    return "balanced";
  }


  //==========================================================
  // SESSION APPROACH
  //==========================================================
  //
  // Determines the general size of practices IRAI should
  // prefer.
  //
  //----------------------------------------------------------

  String _determineSessionApproach({

    required UserProfileModel profile,

    required UserUnderstandingModel understanding,

  }) {

    //--------------------------------------------------------
    // CURRENT FOUNDATION
    //--------------------------------------------------------
    //
    // If the user has explicitly selected a short-session
    // preference, prioritize it.
    //
    //--------------------------------------------------------

    final shortSessionPreference =
        profile.preferenceIds.contains(
      "short_sessions",
    );


    if (shortSessionPreference) {
      return "short";
    }


    //--------------------------------------------------------
    // FUTURE
    //--------------------------------------------------------
    //
    // Behaviour signals can later influence this:
    //
    // completion rate
    // available time
    // preferred duration
    //
    //--------------------------------------------------------

    if (understanding
        .lifestyleSignals
        .containsKey(
          "time_availability",
        )) {

      final availability =
          understanding
              .lifestyleSignals[
                "time_availability"
              ]!;

      if (availability < 0.4) {
        return "short";
      }
    }


    //--------------------------------------------------------
    // DEFAULT
    //--------------------------------------------------------

    return "moderate";
  }


  //==========================================================
  // COMMUNICATION STYLE
  //==========================================================
  //
  // Determines how IRAI should communicate.
  //
  //----------------------------------------------------------

  String _determineCommunicationStyle(

    UserProfileModel profile,

    UserUnderstandingModel understanding,

  ) {

    //--------------------------------------------------------
    // VOICE PREFERENCE
    //--------------------------------------------------------

    if (profile.preferenceIds.contains(
      "voice",
    )) {

      return "supportive";
    }


    //--------------------------------------------------------
    // DEFAULT
    //--------------------------------------------------------

    return "concise";
  }


  //==========================================================
  // PRIORITY AREAS
  //==========================================================
  //
  // Combines explicit user goals with useful understanding
  // signals.
  //
  //----------------------------------------------------------

  List<String> _determinePriorityAreas(

    UserProfileModel profile,

    UserUnderstandingModel understanding,

  ) {

    final priorities =
        <String>[];


    //--------------------------------------------------------
    // USER GOALS HAVE PRIORITY
    //--------------------------------------------------------

    priorities.addAll(
      profile.goalIds,
    );


    //--------------------------------------------------------
    // LIFESTYLE SIGNALS
    //--------------------------------------------------------
    //
    // These are only added if they are not already present.
    //
    //--------------------------------------------------------

    for (final key in understanding
        .lifestyleSignals
        .keys) {

      if (!priorities.contains(key)) {

        priorities.add(key);
      }
    }


    //--------------------------------------------------------
    // BODY SIGNALS
    //--------------------------------------------------------

    for (final key in understanding
        .bodySignals
        .keys) {

      if (!priorities.contains(key)) {

        priorities.add(key);
      }
    }


    //--------------------------------------------------------
    // MIND SIGNALS
    //--------------------------------------------------------

    for (final key in understanding
        .mindSignals
        .keys) {

      if (!priorities.contains(key)) {

        priorities.add(key);
      }
    }


    return priorities;
  }


  //==========================================================
  // PERSONALIZATION CONFIDENCE
  //==========================================================
  //
  // Currently based on the Understanding Engine confidence.
  //
  // Future:
  //
  // • Evidence quantity
  // • Evidence quality
  // • Behaviour consistency
  // • Assessment confidence
  // • User feedback
  // • Time stability
  //
  //----------------------------------------------------------

  double _calculateConfidence(
    UserUnderstandingModel understanding,
  ) {

    final value =
        understanding.normalizedConfidence;


    if (value < 0.0) {
      return 0.0;
    }

    if (value > 1.0) {
      return 1.0;
    }

    return value;
  }
}