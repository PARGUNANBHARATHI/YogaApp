//----------------------------------------------------------
// IRAI UNDERSTANDING ENGINE
//----------------------------------------------------------
//
// M4.4 — USER UNDERSTANDING
//
// PURPOSE
// ---------------------------------------------------------
// Converts available IRAI information into a structured
// UserUnderstandingModel.
//
// CURRENT INPUTS
// ---------------------------------------------------------
// • User Profile
// • Signals
// • Assessment information
//
// CURRENT ROLE
// ---------------------------------------------------------
// This is the first local understanding layer.
//
// It does NOT attempt to make a final medical or
// constitutional conclusion.
//
// Instead, it:
//
// • Collects signals
// • Organizes signals
// • Updates confidence
// • Builds the current understanding state
//
//----------------------------------------------------------
//
// IMPORTANT ARCHITECTURE
// ---------------------------------------------------------
//
// M3
// Assessment
//     ↓
// Signals
//     ↓
// Understanding Engine
//     ↓
// User Understanding
//
// FUTURE
// ---------------------------------------------------------
//
// More evidence can continuously enter the engine:
//
// Assessment
// Interaction
// Behaviour
// Programs
// Today
// Wearable
// User feedback
//     ↓
// Understanding Engine
//     ↓
// Updated Understanding
//
//----------------------------------------------------------
//
// VERY IMPORTANT
// ---------------------------------------------------------
// The actual constitution/body-pattern methodology is NOT
// hard-coded here yet.
//
// When your final 15 questions and interpretation rules are
// ready, the relevant analysis logic can be added without
// changing the UserUnderstandingModel or UI.
//
//----------------------------------------------------------


import '../models/signal_model.dart';
import '../models/user_profile_model.dart';
import '../models/user_understanding_model.dart';


//==========================================================
// IRAI UNDERSTANDING ENGINE
//==========================================================

class IraiUnderstandingEngine {

  //==========================================================
  // BUILD INITIAL UNDERSTANDING
  //==========================================================
  //
  // Creates the first understanding state for a user.
  //
  // Usually called after profile creation or the first
  // meaningful interaction.
  //
  //----------------------------------------------------------

  UserUnderstandingModel buildInitialUnderstanding({

    required UserProfileModel profile,

  }) {

    return UserUnderstandingModel(

      userId:
          profile.userId,

      //------------------------------------------------------
      // No body signals yet.
      //------------------------------------------------------

      bodySignals:
          const {},

      //------------------------------------------------------
      // No mind signals yet.
      //------------------------------------------------------

      mindSignals:
          const {},

      //------------------------------------------------------
      // No lifestyle signals yet.
      //------------------------------------------------------

      lifestyleSignals:
          const {},

      //------------------------------------------------------
      // Copy known goals.
      //------------------------------------------------------

      goals:
          List.unmodifiable(
        profile.goalIds,
      ),

      //------------------------------------------------------
      // Copy known preferences.
      //------------------------------------------------------

      preferences:
          List.unmodifiable(
        profile.preferenceIds,
      ),

      //------------------------------------------------------
      // Initial state.
      //------------------------------------------------------

      status:
          IraiUnderstandingStatus.initial,

      //------------------------------------------------------
      // No evidence yet.
      //------------------------------------------------------

      confidence:
          0.0,

      //------------------------------------------------------
      // Timestamp.
      //------------------------------------------------------

      updatedAt:
          DateTime.now(),
    );
  }


  //==========================================================
  // APPLY SIGNALS
  //==========================================================
  //
  // Adds new signals to the current understanding.
  //
  // This is the main entry point for gradually updating
  // the user's understanding.
  //
  //----------------------------------------------------------

  UserUnderstandingModel applySignals({

    required UserUnderstandingModel current,

    required List<IraiSignalModel> signals,

  }) {

    //--------------------------------------------------------
    // COPY CURRENT SIGNAL MAPS
    //--------------------------------------------------------

    final bodySignals =
        Map<String, double>.from(
      current.bodySignals,
    );

    final mindSignals =
        Map<String, double>.from(
      current.mindSignals,
    );

    final lifestyleSignals =
        Map<String, double>.from(
      current.lifestyleSignals,
    );


    //--------------------------------------------------------
    // PROCESS SIGNALS
    //--------------------------------------------------------

    for (final signal in signals) {

      //------------------------------------------------------
      // CURRENT VERSION
      //------------------------------------------------------
      //
      // We classify signals by a simple naming convention.
      //
      // Example:
      //
      // body.morning_energy
      // mind.busy_thoughts
      // lifestyle.sleep_pattern
      //
      // This is intentionally simple.
      //
      // Future:
      // A dedicated analysis/rules system can replace this.
      //
      //------------------------------------------------------

      final key =
          signal.key;


      //------------------------------------------------------
      // BODY SIGNAL
      //------------------------------------------------------

      if (key.startsWith("body.")) {

        bodySignals[
              key.substring(5)
            ] =
            _signalValue(
          signal,
        );

        continue;
      }


      //------------------------------------------------------
      // MIND SIGNAL
      //------------------------------------------------------

      if (key.startsWith("mind.")) {

        mindSignals[
              key.substring(5)
            ] =
            _signalValue(
          signal,
        );

        continue;
      }


      //------------------------------------------------------
      // LIFESTYLE SIGNAL
      //------------------------------------------------------

      if (key.startsWith("lifestyle.")) {

        lifestyleSignals[
              key.substring(10)
            ] =
            _signalValue(
          signal,
        );

        continue;
      }
    }


    //--------------------------------------------------------
    // CALCULATE CONFIDENCE
    //--------------------------------------------------------

    final confidence =
        _calculateConfidence(
      signals,
    );


    //--------------------------------------------------------
    // DETERMINE STATUS
    //--------------------------------------------------------

    final status =
        _determineStatus(
      bodySignals:
          bodySignals,

      mindSignals:
          mindSignals,

      lifestyleSignals:
          lifestyleSignals,

      confidence:
          confidence,
    );


    //--------------------------------------------------------
    // RETURN UPDATED UNDERSTANDING
    //--------------------------------------------------------

    return UserUnderstandingModel(

      userId:
          current.userId,

      bodySignals:
          Map.unmodifiable(
        bodySignals,
      ),

      mindSignals:
          Map.unmodifiable(
        mindSignals,
      ),

      lifestyleSignals:
          Map.unmodifiable(
        lifestyleSignals,
      ),

      goals:
          List.unmodifiable(
        current.goals,
      ),

      preferences:
          List.unmodifiable(
        current.preferences,
      ),

      status:
          status,

      confidence:
          confidence,

      updatedAt:
          DateTime.now(),
    );
  }


  //==========================================================
  // SIGNAL VALUE
  //==========================================================
  //
  // Converts signal confidence into a simple numerical
  // value for the current understanding layer.
  //
  // IMPORTANT
  // ---------------------------------------------------------
  // This is NOT a constitution score.
  //
  // It is only a temporary confidence/evidence value.
  //
  //----------------------------------------------------------

  double _signalValue(
    IraiSignalModel signal,
  ) {

    switch (signal.confidence) {

      case IraiSignalConfidence.low:
        return 0.25;

      case IraiSignalConfidence.medium:
        return 0.50;

      case IraiSignalConfidence.high:
        return 1.0;
    }
  }


  //==========================================================
  // CONFIDENCE
  //==========================================================
  //
  // Calculates the current understanding confidence from
  // the incoming evidence.
  //
  //----------------------------------------------------------

  double _calculateConfidence(
    List<IraiSignalModel> signals,
  ) {

    if (signals.isEmpty) {
      return 0.0;
    }


    double total =
        0.0;


    for (final signal in signals) {

      total +=
          _signalValue(
        signal,
      );
    }


    final average =
        total /
        signals.length;


    //--------------------------------------------------------
    // Keep value between 0 and 1.
    //--------------------------------------------------------

    if (average < 0.0) {
      return 0.0;
    }

    if (average > 1.0) {
      return 1.0;
    }

    return average;
  }


  //==========================================================
  // STATUS
  //==========================================================
  //
  // Determines how developed the current understanding is.
  //
  //----------------------------------------------------------

  IraiUnderstandingStatus _determineStatus({

    required Map<String, double> bodySignals,

    required Map<String, double> mindSignals,

    required Map<String, double> lifestyleSignals,

    required double confidence,

  }) {

    final signalCount =
        bodySignals.length +
        mindSignals.length +
        lifestyleSignals.length;


    //--------------------------------------------------------
    // NO INFORMATION
    //--------------------------------------------------------

    if (signalCount == 0) {

      return IraiUnderstandingStatus.initial;
    }


    //--------------------------------------------------------
    // EARLY UNDERSTANDING
    //--------------------------------------------------------

    if (signalCount < 3) {

      return IraiUnderstandingStatus.developing;
    }


    //--------------------------------------------------------
    // STRONGER UNDERSTANDING
    //--------------------------------------------------------

    if (confidence >= 0.7) {

      return IraiUnderstandingStatus.established;
    }


    //--------------------------------------------------------
    // CONTINUOUSLY EVOLVING
    //--------------------------------------------------------

    return IraiUnderstandingStatus.evolving;
  }
}