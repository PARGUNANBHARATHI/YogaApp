//----------------------------------------------------------
// IRAI INTERACTION MODEL
//----------------------------------------------------------
//
// Represents one interaction between IRAI and the user.
//
// This is the foundation of the future IRAI interaction
// engine.
//
// The same model can later handle:
//
// • Personal Discovery
// • 15-question body/mind assessment
// • Daily check-ins
// • User problems
// • Follow-up questions
// • Text interaction
// • Voice interaction
// • Personalized insights
// • Recommendations
// • Agentic AI conversations
//
// IMPORTANT:
// The IRAI page should display the interaction.
// It should NOT decide what the interaction means.
//
//----------------------------------------------------------

import 'irai_option.dart';

//==========================================================
// INTERACTION TYPE
//==========================================================
//
// Defines the kind of interaction IRAI is presenting.
//
// More types can be added later without rebuilding the
// entire IRAI page.
//==========================================================

enum IraiInteractionType {

  // IRAI is asking the user a question.
  question,

  // IRAI is simply giving information/message.
  message,

  // IRAI is showing an insight.
  insight,

  // IRAI is recommending an action/content.
  recommendation,
}


//==========================================================
// IRAI INTERACTION
//==========================================================

class IraiInteraction {

  //----------------------------------------------------------
  // IDENTIFICATION
  //----------------------------------------------------------

  final String id;


  //----------------------------------------------------------
  // TYPE
  //----------------------------------------------------------

  final IraiInteractionType type;


  //----------------------------------------------------------
  // MAIN MESSAGE
  //----------------------------------------------------------

  final String message;


  //----------------------------------------------------------
  // SUPPORTING MESSAGE
  //----------------------------------------------------------

  final String? subtitle;


  //----------------------------------------------------------
  // CARD OPTIONS
  //----------------------------------------------------------
  //
  // Example:
  //
  // 😊 I feel good
  // 😴 Low energy
  // 🧠 Busy mind
  //
  //----------------------------------------------------------

  final List<IraiOption> options;


  //----------------------------------------------------------
  // TEXT INPUT
  //----------------------------------------------------------
  //
  // Allows the user to type their own problem or answer.
  //
  //----------------------------------------------------------

  final bool allowTextInput;


  //----------------------------------------------------------
  // VOICE INPUT
  //----------------------------------------------------------
  //
  // Allows the user to speak to IRAI.
  //
  // The actual speech recognition will be added later.
  //
  //----------------------------------------------------------

  final bool allowVoiceInput;


  //----------------------------------------------------------
  // CONSTRUCTOR
  //----------------------------------------------------------

  const IraiInteraction({

    required this.id,

    required this.type,

    required this.message,

    this.subtitle,

    this.options = const [],

    this.allowTextInput = false,

    this.allowVoiceInput = false,
  });
}