//----------------------------------------------------------
// IRAI QUESTION DATA
//----------------------------------------------------------
//
// M3 + M4 DEVELOPMENT TEST DATA
//
// PURPOSE
// ---------------------------------------------------------
// Temporary 5-question constitution test.
//
// These questions are ONLY for architecture testing.
//
// They are NOT the final IRAI constitution assessment.
//
// Later:
// • Replace with the real 15 questions
// • Replace the temporary scoring
// • Keep the Question Engine
// • Keep the Constitution Engine
//
//----------------------------------------------------------
//
// SCORING
// ---------------------------------------------------------
//
// Each selected option currently contributes:
//
// Vatham = 1
// Pitham = 1
// Kapham = 1
//
// depending on the selected answer.
//
//----------------------------------------------------------

import '../models/irai_question.dart';
import '../models/irai_question_set.dart';


//==========================================================
// SAMPLE PERSONAL DISCOVERY
//==========================================================

final IraiQuestionSet samplePersonalDiscovery =
    IraiQuestionSet(
  id: "constitution_assessment_test_v1",

  version: 1,

  name: "Personal Discovery",

  questions: [

    //--------------------------------------------------------
    // QUESTION 1 — ENERGY
    //--------------------------------------------------------

    IraiQuestion(
      id: "constitution_q1",

      questionSetId:
          "constitution_assessment_test_v1",

      version: 1,

      question:
          "How does your energy usually feel during the day?",

      subtitle:
          "Choose the description that feels most familiar.",

      type:
          IraiQuestionType.singleChoice,

      order: 1,

      options: [

        IraiQuestionOption(
          id: "q1_vatham",

          title:
              "It changes quickly or feels irregular",

          emoji: "🌬️",

          scores: {
            "vatham": 1.0,
          },
        ),

        IraiQuestionOption(
          id: "q1_pitham",

          title:
              "It is strong and intense",

          emoji: "🔥",

          scores: {
            "pitham": 1.0,
          },
        ),

        IraiQuestionOption(
          id: "q1_kapham",

          title:
              "It is steady and consistent",

          emoji: "🌿",

          scores: {
            "kapham": 1.0,
          },
        ),
      ],
    ),


    //--------------------------------------------------------
    // QUESTION 2 — TEMPERATURE
    //--------------------------------------------------------

    IraiQuestion(
      id: "constitution_q2",

      questionSetId:
          "constitution_assessment_test_v1",

      version: 1,

      question:
          "How does your body usually respond to temperature?",

      subtitle:
          "Think about your usual tendency.",

      type:
          IraiQuestionType.singleChoice,

      order: 2,

      options: [

        IraiQuestionOption(
          id: "q2_vatham",

          title:
              "I often feel cold",

          emoji: "❄️",

          scores: {
            "vatham": 1.0,
          },
        ),

        IraiQuestionOption(
          id: "q2_pitham",

          title:
              "I often feel warm or hot",

          emoji: "🔥",

          scores: {
            "pitham": 1.0,
          },
        ),

        IraiQuestionOption(
          id: "q2_kapham",

          title:
              "I usually feel comfortable",

          emoji: "🌿",

          scores: {
            "kapham": 1.0,
          },
        ),
      ],
    ),


    //--------------------------------------------------------
    // QUESTION 3 — MIND
    //--------------------------------------------------------

    IraiQuestion(
      id: "constitution_q3",

      questionSetId:
          "constitution_assessment_test_v1",

      version: 1,

      question:
          "How does your mind usually behave?",

      subtitle:
          "Think about your normal mental rhythm.",

      type:
          IraiQuestionType.singleChoice,

      order: 3,

      options: [

        IraiQuestionOption(
          id: "q3_vatham",

          title:
              "Fast-moving with many changing thoughts",

          emoji: "💨",

          scores: {
            "vatham": 1.0,
          },
        ),

        IraiQuestionOption(
          id: "q3_pitham",

          title:
              "Focused, intense and goal-oriented",

          emoji: "🎯",

          scores: {
            "pitham": 1.0,
          },
        ),

        IraiQuestionOption(
          id: "q3_kapham",

          title:
              "Calm, steady and relaxed",

          emoji: "🌱",

          scores: {
            "kapham": 1.0,
          },
        ),
      ],
    ),


    //--------------------------------------------------------
    // QUESTION 4 — APPETITE
    //--------------------------------------------------------

    IraiQuestion(
      id: "constitution_q4",

      questionSetId:
          "constitution_assessment_test_v1",

      version: 1,

      question:
          "How would you describe your usual appetite?",

      subtitle:
          "Choose the pattern that is most familiar to you.",

      type:
          IraiQuestionType.singleChoice,

      order: 4,

      options: [

        IraiQuestionOption(
          id: "q4_vatham",

          title:
              "It is irregular and changes often",

          emoji: "🔄",

          scores: {
            "vatham": 1.0,
          },
        ),

        IraiQuestionOption(
          id: "q4_pitham",

          title:
              "It is strong and I get hungry regularly",

          emoji: "🍽️",

          scores: {
            "pitham": 1.0,
          },
        ),

        IraiQuestionOption(
          id: "q4_kapham",

          title:
              "It is generally slow or moderate",

          emoji: "🌿",

          scores: {
            "kapham": 1.0,
          },
        ),
      ],
    ),


    //--------------------------------------------------------
    // QUESTION 5 — STRESS RESPONSE
    //--------------------------------------------------------

    IraiQuestion(
      id: "constitution_q5",

      questionSetId:
          "constitution_assessment_test_v1",

      version: 1,

      question:
          "What usually happens when you have a stressful day?",

      subtitle:
          "Choose the response that feels most familiar.",

      type:
          IraiQuestionType.singleChoice,

      order: 5,

      options: [

        IraiQuestionOption(
          id: "q5_vatham",

          title:
              "I become restless or overthink",

          emoji: "🌪️",

          scores: {
            "vatham": 1.0,
          },
        ),

        IraiQuestionOption(
          id: "q5_pitham",

          title:
              "I become irritated or intense",

          emoji: "🔥",

          scores: {
            "pitham": 1.0,
          },
        ),

        IraiQuestionOption(
          id: "q5_kapham",

          title:
              "I become quiet or slow down",

          emoji: "🌿",

          scores: {
            "kapham": 1.0,
          },
        ),
      ],
    ),
  ],
);