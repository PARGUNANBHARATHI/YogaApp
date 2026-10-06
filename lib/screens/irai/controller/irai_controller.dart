//----------------------------------------------------------
// IRAI CONTROLLER
//----------------------------------------------------------
//
// M2 - CONVERSATIONAL INTERACTION + SESSION
//
// PURPOSE
// ---------------------------------------------------------
// The IRAI Controller manages the interaction between:
//
// User
//   ↓
// IRAI Page
//   ↓
// IRAI Controller
//   ↓
// Interaction / Session
//
// CURRENT VERSION
// ---------------------------------------------------------
// This is still a LOCAL Flutter prototype.
//
// It currently supports:
//
// • Sample questions
// • Card-based answers
// • Follow-up questions
// • Free-text answers
// • Voice input UI support
// • Local conversation session
// • Local answer history
//
// IMPORTANT
// ---------------------------------------------------------
// The UI should NOT decide:
//
// • Which question comes next
// • How an answer is stored
// • How a conversation is structured
//
// The controller manages these responsibilities.
//
// FUTURE
// ---------------------------------------------------------
// This controller will eventually connect to:
//
// • Dynamic Question Engine
// • Personal Discovery
// • 15-question assessment
// • Dynamic question sets
// • User Profile
// • Behavioral Learning
// • Observation Engine
// • Recommendation Engine
// • Firebase Repository
// • AI / Agentic IRAI
//
// IMPORTANT ARCHITECTURE PRINCIPLE
// ---------------------------------------------------------
//
// UI
//  ↓
// Controller
//  ↓
// Repository / Service
//  ↓
// Firebase
//
// We are NOT connecting Firebase yet.
//
// We are first making the Flutter architecture complete.
//
//----------------------------------------------------------


//==========================================================
// IMPORTS
//==========================================================

import '../models/irai_interaction.dart';
import '../models/irai_option.dart';
import '../models/irai_answer.dart';
import '../models/irai_session.dart';


//==========================================================
// IRAI CONTROLLER
//==========================================================

class IraiController {

  //----------------------------------------------------------
  // CURRENT SESSION
  //----------------------------------------------------------
  //
  // A session represents one continuous interaction
  // between the user and IRAI.
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
  //
  // Future:
  // This session can be stored in Firebase.
  //
  //----------------------------------------------------------

  late IraiSession session;


  //==========================================================
  // SESSION
  //==========================================================


  //----------------------------------------------------------
  // START SESSION
  //----------------------------------------------------------
  //
  // Creates a new local IRAI session.
  //
  // Currently:
  // The session exists only in memory.
  //
  // Future:
  //
  // startSession()
  //       ↓
  // Firebase session document
  //
  //----------------------------------------------------------

  void startSession() {

    final now = DateTime.now();

    session = IraiSession(
      id:
          "session_${now.millisecondsSinceEpoch}",

      startedAt: now,

      lastUpdatedAt: now,
    );
  }


  //----------------------------------------------------------
  // SAVE CARD ANSWER
  //----------------------------------------------------------
  //
  // Saves an answer selected from an IRAI option card.
  //
  // Example:
  //
  // User selects:
  //
  // 😴 Low Energy
  //
  // Stored locally as:
  //
  // type  = card
  // value = low_energy
  //
  // Future:
  // This answer will be saved to Firebase.
  //
  //----------------------------------------------------------

  void saveCardAnswer(
    IraiOption option,
    String interactionId,
  ) {

    session.addAnswer(
      IraiAnswer(

        id:
            "answer_${DateTime.now().millisecondsSinceEpoch}",

        interactionId:
            interactionId,

        type:
            IraiAnswerType.card,

        value:
            option.id,

        createdAt:
            DateTime.now(),
      ),
    );
  }


  //----------------------------------------------------------
  // SAVE TEXT ANSWER
  //----------------------------------------------------------
  //
  // Saves a free-text answer from the user.
  //
  // Example:
  //
  // User writes:
  //
  // "I feel tired after lunch."
  //
  // The actual text is preserved.
  //
  // Future:
  // This can be sent to the IRAI understanding engine.
  //
  //----------------------------------------------------------

  void saveTextAnswer(
    String text,
    String interactionId,
  ) {

    session.addAnswer(
      IraiAnswer(

        id:
            "answer_${DateTime.now().millisecondsSinceEpoch}",

        interactionId:
            interactionId,

        type:
            IraiAnswerType.text,

        value:
            text.trim(),

        createdAt:
            DateTime.now(),
      ),
    );
  }


  //==========================================================
  // INITIAL INTERACTION
  //==========================================================


  //----------------------------------------------------------
  // GET INITIAL INTERACTION
  //----------------------------------------------------------
  //
  // This is the first sample interaction shown when IRAI
  // starts.
  //
  // IMPORTANT:
  //
  // These are temporary sample questions.
  //
  // Later:
  //
  // Firebase / Question Engine
  //          ↓
  // Dynamic Question
  //          ↓
  // IraiInteraction
  //
  // Therefore the UI does not need to change when the
  // real questions are introduced.
  //
  //----------------------------------------------------------

  IraiInteraction getInitialInteraction() {

    return const IraiInteraction(

      id:
          "daily_checkin",

      type:
          IraiInteractionType.question,

      message:
          "How are you feeling today?",

      subtitle:
          "Choose what feels closest to you right now.",

      //------------------------------------------------------
      // QUICK ANSWER OPTIONS
      //------------------------------------------------------

      options: [

        IraiOption(
          id:
              "feeling_good",

          title:
              "I feel good",

          subtitle:
              "My body and mind feel okay.",

          emoji:
              "😊",
        ),

        IraiOption(
          id:
              "low_energy",

          title:
              "I feel low energy",

          subtitle:
              "I feel tired or less active.",

          emoji:
              "😴",
        ),

        IraiOption(
          id:
              "busy_mind",

          title:
              "My mind feels busy",

          subtitle:
              "I have many thoughts on my mind.",

          emoji:
              "🧠",
        ),

        IraiOption(
          id:
              "something_off",

          title:
              "Something feels different",

          subtitle:
              "I cannot clearly explain it.",

          emoji:
              "🌿",
        ),
      ],

      //------------------------------------------------------
      // FREE INPUT
      //------------------------------------------------------

      allowTextInput:
          true,

      allowVoiceInput:
          true,
    );
  }


  //==========================================================
  // HANDLE CARD OPTION
  //==========================================================


  //----------------------------------------------------------
  // HANDLE OPTION
  //----------------------------------------------------------
  //
  // Receives the option selected by the user.
  //
  // The selected option determines the next interaction.
  //
  // CURRENT:
  // Simple local switch logic.
  //
  // FUTURE:
  //
  // User Answer
  //      ↓
  // User Profile
  //      ↓
  // Previous Answers
  //      ↓
  // Current Context
  //      ↓
  // Question Engine
  //      ↓
  // Next Best Question
  //
  //----------------------------------------------------------

  IraiInteraction handleOption(
    IraiOption option,
  ) {

    switch (option.id) {


      //======================================================
      // LOW ENERGY
      //======================================================

      case "low_energy":

        return const IraiInteraction(

          id:
              "low_energy_when",

          type:
              IraiInteractionType.question,

          message:
              "When do you notice the low energy most?",

          subtitle:
              "This helps IRAI understand your daily pattern.",

          options: [

            //------------------------------------------------
            // MORNING
            //------------------------------------------------

            IraiOption(
              id:
                  "low_energy_morning",

              title:
                  "Morning",

              subtitle:
                  "I feel low after waking up.",

              emoji:
                  "🌅",
            ),

            //------------------------------------------------
            // AFTERNOON
            //------------------------------------------------

            IraiOption(
              id:
                  "low_energy_afternoon",

              title:
                  "Afternoon",

              subtitle:
                  "My energy drops later in the day.",

              emoji:
                  "☀️",
            ),

            //------------------------------------------------
            // EVENING
            //------------------------------------------------

            IraiOption(
              id:
                  "low_energy_evening",

              title:
                  "Evening",

              subtitle:
                  "I feel tired toward the evening.",

              emoji:
                  "🌇",
            ),

            //------------------------------------------------
            // ALL DAY
            //------------------------------------------------

            IraiOption(
              id:
                  "low_energy_all_day",

              title:
                  "Throughout the day",

              subtitle:
                  "My energy feels low most of the day.",

              emoji:
                  "🌿",
            ),
          ],

          allowTextInput:
              true,

          allowVoiceInput:
              true,
        );


      //======================================================
      // BUSY MIND
      //======================================================

      case "busy_mind":

        return const IraiInteraction(

          id:
              "busy_mind_pattern",

          type:
              IraiInteractionType.question,

          message:
              "What does your busy mind feel like?",

          subtitle:
              "Choose what feels closest right now.",

          options: [

            IraiOption(
              id:
                  "many_thoughts",

              title:
                  "Too many thoughts",

              subtitle:
                  "My mind keeps thinking.",

              emoji:
                  "💭",
            ),

            IraiOption(
              id:
                  "stress",

              title:
                  "Stress",

              subtitle:
                  "I feel mentally pressured.",

              emoji:
                  "🧠",
            ),

            IraiOption(
              id:
                  "focus_problem",

              title:
                  "Difficulty focusing",

              subtitle:
                  "I find it hard to stay focused.",

              emoji:
                  "🎯",
            ),

            IraiOption(
              id:
                  "not_sure_mind",

              title:
                  "I'm not sure",

              subtitle:
                  "It's difficult to explain.",

              emoji:
                  "🌿",
            ),
          ],

          allowTextInput:
              true,

          allowVoiceInput:
              true,
        );


      //======================================================
      // SOMETHING FEELS DIFFERENT
      //======================================================

      case "something_off":

        return const IraiInteraction(

          id:
              "something_off_area",

          type:
              IraiInteractionType.question,

          message:
              "Where do you notice the difference most?",

          subtitle:
              "You can also explain it in your own words.",

          options: [

            IraiOption(
              id:
                  "body_difference",

              title:
                  "My body",

              subtitle:
                  "Something physical feels different.",

              emoji:
                  "🌿",
            ),

            IraiOption(
              id:
                  "mind_difference",

              title:
                  "My mind",

              subtitle:
                  "My thoughts or feelings feel different.",

              emoji:
                  "🧠",
            ),

            IraiOption(
              id:
                  "routine_difference",

              title:
                  "My routine",

              subtitle:
                  "My normal daily rhythm has changed.",

              emoji:
                  "🕐",
            ),

            IraiOption(
              id:
                  "everything_difference",

              title:
                  "I can't explain it",

              subtitle:
                  "Something just feels different.",

              emoji:
                  "💬",
            ),
          ],

          allowTextInput:
              true,

          allowVoiceInput:
              true,
        );


      //======================================================
      // FEELING GOOD
      //======================================================

      case "feeling_good":

        return const IraiInteraction(

          id:
              "feeling_good_reason",

          type:
              IraiInteractionType.question,

          message:
              "That's good to hear. What feels best today?",

          subtitle:
              "IRAI is beginning to understand your positive patterns.",

          options: [

            IraiOption(
              id:
                  "good_energy",

              title:
                  "My energy",

              subtitle:
                  "I feel active and energetic.",

              emoji:
                  "⚡",
            ),

            IraiOption(
              id:
                  "good_mind",

              title:
                  "My mind",

              subtitle:
                  "I feel calm and clear.",

              emoji:
                  "🧘",
            ),

            IraiOption(
              id:
                  "good_body",

              title:
                  "My body",

              subtitle:
                  "I feel physically comfortable.",

              emoji:
                  "🌿",
            ),

            IraiOption(
              id:
                  "good_all",

              title:
                  "Everything feels good",

              subtitle:
                  "I feel balanced today.",

              emoji:
                  "✨",
            ),
          ],

          allowTextInput:
              true,

          allowVoiceInput:
              true,
        );


      //======================================================
      // LOW ENERGY - MORNING
      //======================================================

      case "low_energy_morning":

        return _finalInsight(
          "IRAI has noticed that your energy is lower in the morning.",
        );


      //======================================================
      // LOW ENERGY - AFTERNOON
      //======================================================

      case "low_energy_afternoon":

        return _finalInsight(
          "IRAI has noticed an afternoon energy pattern.",
        );


      //======================================================
      // LOW ENERGY - EVENING
      //======================================================

      case "low_energy_evening":

        return _finalInsight(
          "IRAI has noticed that your energy tends to reduce in the evening.",
        );


      //======================================================
      // LOW ENERGY - ALL DAY
      //======================================================

      case "low_energy_all_day":

        return _finalInsight(
          "IRAI has recorded that your energy feels low across much of the day.",
        );


      //======================================================
      // DEFAULT
      //======================================================

      default:

        return _finalInsight(
          "Thank you for sharing that with IRAI.",
        );
    }
  }


  //==========================================================
  // FINAL INSIGHT
  //==========================================================


  //----------------------------------------------------------
  // FINAL INSIGHT
  //----------------------------------------------------------
  //
  // This is currently a prototype response.
  //
  // It is NOT medical diagnosis or AI reasoning.
  //
  // Future:
  //
  // User Context
  //      +
  // User History
  //      +
  // Observations
  //      +
  // AI / Personalization Engine
  //      ↓
  // Personalized Insight
  //
  //----------------------------------------------------------

  IraiInteraction _finalInsight(
    String message,
  ) {

    return IraiInteraction(

      id:
          "insight_${DateTime.now().millisecondsSinceEpoch}",

      type:
          IraiInteractionType.insight,

      message:
          message,

      subtitle:
          "As you continue using IRAI, these patterns can help personalize your guidance.",

      options:
          const [],

      allowTextInput:
          true,

      allowVoiceInput:
          true,
    );
  }


  //==========================================================
  // HANDLE FREE TEXT
  //==========================================================


  //----------------------------------------------------------
  // HANDLE TEXT
  //----------------------------------------------------------
  //
  // Receives text typed by the user.
  //
  // CURRENT:
  // Saves the text into the local session and returns a
  // simple acknowledgement.
  //
  // FUTURE:
  //
  // Text
  //   ↓
  // Understanding Engine
  //   ↓
  // Context
  //   ↓
  // User Profile
  //   ↓
  // Observations
  //   ↓
  // Next Interaction
  //
  //----------------------------------------------------------

  IraiInteraction handleText(
    String text,
  ) {

    final cleanText =
        text.trim();


    //--------------------------------------------------------
    // EMPTY TEXT
    //--------------------------------------------------------

    if (cleanText.isEmpty) {

      return getInitialInteraction();
    }


    //--------------------------------------------------------
    // RETURN RESPONSE
    //--------------------------------------------------------

    return IraiInteraction(

      id:
          "text_${DateTime.now().millisecondsSinceEpoch}",

      type:
          IraiInteractionType.message,

      message:
          "I hear you.",

      subtitle:
          "IRAI has received what you shared. In the future, this will connect to the deeper IRAI understanding engine.",

      options:
          const [],

      allowTextInput:
          true,

      allowVoiceInput:
          true,
    );
  }
}