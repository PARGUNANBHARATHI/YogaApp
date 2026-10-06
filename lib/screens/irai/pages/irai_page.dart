//----------------------------------------------------------
// IRAI PAGE
//----------------------------------------------------------
//
// IRAI HEALTH SYSTEMS
//
// M2
// ---------------------------------------------------------
// • IRAI conversation
// • Card answers
// • Text answers
// • Voice interaction
//
// M3
// ---------------------------------------------------------
// • Personal Discovery
// • Dynamic Question Set
// • Question Engine
// • Assessment Result
//
// M4
// ---------------------------------------------------------
// • Constitution Engine
// • Vatham
// • Pitham
// • Kapham
// • Dominant / Secondary pattern
//
// IMPORTANT
// ---------------------------------------------------------
// UI does not calculate constitution.
// Constitution calculation remains inside:
//     IraiConstitutionEngine
//
//----------------------------------------------------------

import 'package:flutter/material.dart';


//==========================================================
// M2
//==========================================================

import '../controller/irai_controller.dart';

import '../models/irai_interaction.dart';
import '../models/irai_option.dart';


//==========================================================
// M3
//==========================================================

import '../controller/irai_question_engine.dart';

import '../data/irai_question_data.dart';

import '../models/irai_assessment_result.dart';
import '../models/irai_question.dart';


//==========================================================
// M4
//==========================================================

import '../services/constitution_engine.dart';


//==========================================================
// IRAI WIDGETS
//==========================================================

import '../widgets/irai_input_bar.dart';
import '../widgets/irai_option_card.dart';


//==========================================================
// IRAI PAGE
//==========================================================

class IraiPage extends StatefulWidget {

  const IraiPage({
    super.key,
  });

  @override
  State<IraiPage> createState() =>
      _IraiPageState();
}


//==========================================================
// IRAI PAGE STATE
//==========================================================

class _IraiPageState extends State<IraiPage> {

  //========================================================
  // M2 — IRAI CONTROLLER
  //========================================================

  final IraiController _controller =
      IraiController();


  //========================================================
  // M2 — CURRENT INTERACTION
  //========================================================

  late IraiInteraction _interaction;


  //========================================================
  // M2 — SELECTED OPTION
  //========================================================

  String? _selectedOptionId;


  //========================================================
  // M3 — QUESTION ENGINE
  //========================================================

  late IraiQuestionEngine _questionEngine;


  //========================================================
  // M3 — DISCOVERY MODE
  //========================================================

  bool _discoveryMode = false;


  //========================================================
  // M3 — ASSESSMENT RESULT
  //========================================================

  IraiAssessmentResult? _assessmentResult;


  //========================================================
  // M4 — CONSTITUTION RESULT
  //========================================================

  IraiConstitutionResult? _constitutionResult;


  //========================================================
  // INITIALIZATION
  //========================================================

  @override
  void initState() {

    super.initState();


    //--------------------------------------------------------
    // START IRAI SESSION
    //--------------------------------------------------------

    _controller.startSession();


    //--------------------------------------------------------
    // INITIAL IRAI INTERACTION
    //--------------------------------------------------------

    _interaction =
        _controller.getInitialInteraction();
  }


  //==========================================================
  // M2 — CARD OPTION SELECTED
  //==========================================================

  void _onOptionSelected(
    IraiOption option,
  ) {

    //--------------------------------------------------------
    // SAVE ANSWER
    //--------------------------------------------------------

    _controller.saveCardAnswer(
      option,
      _interaction.id,
    );


    //--------------------------------------------------------
    // NEXT INTERACTION
    //--------------------------------------------------------

    final nextInteraction =
        _controller.handleOption(
      option,
    );


    //--------------------------------------------------------
    // UPDATE UI
    //--------------------------------------------------------

    setState(() {

      _selectedOptionId =
          option.id;

      _interaction =
          nextInteraction;
    });
  }


  //==========================================================
  // M2 — TEXT SUBMITTED
  //==========================================================

  void _onTextSubmitted(
    String text,
  ) {

    //--------------------------------------------------------
    // IGNORE EMPTY TEXT
    //--------------------------------------------------------

    if (text.trim().isEmpty) {
      return;
    }


    //--------------------------------------------------------
    // SAVE TEXT
    //--------------------------------------------------------

    _controller.saveTextAnswer(
      text,
      _interaction.id,
    );


    //--------------------------------------------------------
    // NEXT INTERACTION
    //--------------------------------------------------------

    final nextInteraction =
        _controller.handleText(
      text,
    );


    //--------------------------------------------------------
    // UPDATE UI
    //--------------------------------------------------------

    setState(() {

      _selectedOptionId =
          null;

      _interaction =
          nextInteraction;
    });
  }


  //==========================================================
  // M2 — VOICE
  //==========================================================

  void _onVoicePressed() {

    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content: Text(
          "Voice interaction will be added next.",
        ),
      ),
    );
  }


  //==========================================================
  // M3 — START PERSONAL DISCOVERY
  //==========================================================

  void _startPersonalDiscovery() {

    //--------------------------------------------------------
    // CREATE QUESTION ENGINE
    //--------------------------------------------------------

    _questionEngine =
        IraiQuestionEngine(
      questionSet:
          samplePersonalDiscovery,
    );


    //--------------------------------------------------------
    // RESET RESULTS
    //--------------------------------------------------------

    setState(() {

      _discoveryMode =
          true;

      _assessmentResult =
          null;

      _constitutionResult =
          null;
    });
  }


  //==========================================================
  // M3 — ANSWER DISCOVERY QUESTION
  //==========================================================
  //
  // IMPORTANT FINAL-QUESTION FIX
  //
  // We check answeredCount rather than isComplete.
  //
  // This allows Q5 to complete immediately after its answer
  // is saved.
  //
  //==========================================================

  void _answerDiscoveryQuestion(
    IraiQuestionOption option,
  ) {

    //--------------------------------------------------------
    // SAVE ANSWER
    //--------------------------------------------------------

    _questionEngine.answer(
      option.id,
    );


    //--------------------------------------------------------
    // CHECK FINAL QUESTION
    //--------------------------------------------------------

    if (_questionEngine.answeredCount >=
        _questionEngine.totalQuestions) {

      //------------------------------------------------------
      // COMPLETE M3 + M4
      //------------------------------------------------------

      _completeDiscovery();

      return;
    }


    //--------------------------------------------------------
    // MOVE TO NEXT QUESTION
    //--------------------------------------------------------

    _questionEngine.next();


    //--------------------------------------------------------
    // REFRESH UI
    //--------------------------------------------------------

    if (!mounted) {
      return;
    }

    setState(() {});
  }


  //==========================================================
  // M3 + M4 — COMPLETE DISCOVERY
  //==========================================================
  //
  // M3:
  //
  // Questions
  //    ↓
  // Answers
  //    ↓
  // Assessment Result
  //
  // M4:
  //
  // Assessment Result
  //    ↓
  // Constitution Engine
  //    ↓
  // Constitution Result
  //
  //==========================================================

  void _completeDiscovery() {

    //--------------------------------------------------------
    // CURRENT TIME
    //--------------------------------------------------------

    final now =
        DateTime.now();


    //--------------------------------------------------------
    // CREATE M3 ASSESSMENT RESULT
    //--------------------------------------------------------

    final result =
        IraiAssessmentResult(

      id:
          "assessment_${now.millisecondsSinceEpoch}",

      questionSetId:
          samplePersonalDiscovery.id,

      questionSetVersion:
          samplePersonalDiscovery.version,

      answers:
          Map<String, String>.from(
        _questionEngine.answers,
      ),

      completedAt:
          now,
    );


    //--------------------------------------------------------
    // M4 — CONSTITUTION ENGINE
    //--------------------------------------------------------

    final constitutionEngine =
        IraiConstitutionEngine();


    //--------------------------------------------------------
    // ANALYZE ANSWERS
    //--------------------------------------------------------

    final constitutionResult =
        constitutionEngine.analyze(

      questionSet:
          samplePersonalDiscovery,

      answers:
          result.answers,
    );


    //--------------------------------------------------------
    // STORE RESULTS
    //--------------------------------------------------------

    if (!mounted) {
      return;
    }


    setState(() {

      //------------------------------------------------------
      // M3 RESULT
      //------------------------------------------------------

      _assessmentResult =
          result;


      //------------------------------------------------------
      // M4 RESULT
      //------------------------------------------------------

      _constitutionResult =
          constitutionResult;
    });
  }


  //==========================================================
  // EXIT DISCOVERY
  //==========================================================

  void _exitDiscovery() {

    setState(() {

      _discoveryMode =
          false;

      _assessmentResult =
          null;

      _constitutionResult =
          null;
    });
  }


  //==========================================================
  // BUILD
  //==========================================================

  @override
  Widget build(
    BuildContext context,
  ) {

    return Scaffold(

      backgroundColor:
          const Color(0xFFF6F7F3),

      body:
          SafeArea(

        child:
            _discoveryMode

                ? _buildDiscovery()

                : _buildNormalIrai(),
      ),
    );
  }


  //==========================================================
  // M2 — NORMAL IRAI
  //==========================================================

  Widget _buildNormalIrai() {

    return Column(

      children: [

        //----------------------------------------------------
        // HEADER
        //----------------------------------------------------

        _buildHeader(),


        //----------------------------------------------------
        // CONTENT
        //----------------------------------------------------

        Expanded(

          child:
              SingleChildScrollView(

            padding:
                const EdgeInsets.fromLTRB(
              20,
              20,
              20,
              20,
            ),

            child:
                Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                const Text(
                  "A moment with IRAI",

                  style:
                      TextStyle(
                    fontSize: 13,
                    fontWeight:
                        FontWeight.w600,
                    color:
                        Color(0xFF2FA7B2),
                  ),
                ),


                const SizedBox(
                  height: 12,
                ),


                //------------------------------------------------
                // MESSAGE
                //------------------------------------------------

                Text(
                  _interaction.message,

                  style:
                      const TextStyle(
                    fontSize: 28,
                    height: 1.18,
                    fontWeight:
                        FontWeight.w800,
                    color:
                        Color(0xFF182020),
                  ),
                ),


                //------------------------------------------------
                // SUBTITLE
                //------------------------------------------------

                if (_interaction.subtitle !=
                    null) ...[

                  const SizedBox(
                    height: 10,
                  ),

                  Text(
                    _interaction.subtitle!,

                    style:
                        const TextStyle(
                      fontSize: 15,
                      height: 1.45,
                      color:
                          Colors.grey,
                    ),
                  ),
                ],


                const SizedBox(
                  height: 26,
                ),


                //------------------------------------------------
                // OPTIONS
                //------------------------------------------------

                if (_interaction.options
                    .isNotEmpty)

                  ..._interaction.options.map(
                    (
                      option,
                    ) {

                      return IraiOptionCard(

                        option:
                            option,

                        selected:
                            _selectedOptionId ==
                                option.id,

                        onTap: () {

                          _onOptionSelected(
                            option,
                          );
                        },
                      );
                    },
                  ),


                const SizedBox(
                  height: 20,
                ),


                //------------------------------------------------
                // PERSONAL DISCOVERY
                //------------------------------------------------

                _buildPersonalDiscoveryButton(),


                const SizedBox(
                  height: 18,
                ),


                const Text(
                  "You can also tell IRAI in your own words.",

                  style:
                      TextStyle(
                    fontSize: 13,
                    color:
                        Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),


        //----------------------------------------------------
        // INPUT
        //----------------------------------------------------

        Padding(

          padding:
              const EdgeInsets.fromLTRB(
            16,
            8,
            16,
            14,
          ),

          child:
              IraiInputBar(

            onTextSubmitted:
                _onTextSubmitted,

            onVoicePressed:
                _onVoicePressed,
          ),
        ),
      ],
    );
  }


  //==========================================================
  // M2 — HEADER
  //==========================================================

  Widget _buildHeader() {

    return Padding(

      padding:
          const EdgeInsets.fromLTRB(
        20,
        16,
        20,
        10,
      ),

      child:
          Row(

        children: [

          //--------------------------------------------------
          // IRAI ICON
          //--------------------------------------------------

          Container(

            width:
                46,

            height:
                46,

            decoration:
                BoxDecoration(

              gradient:
                  const LinearGradient(
                colors: [
                  Color(0xFF2FA7B2),
                  Color(0xFF65C7C1),
                ],
              ),

              borderRadius:
                  BorderRadius.circular(
                16,
              ),

              boxShadow: [

                BoxShadow(

                  color:
                      const Color(
                    0xFF2FA7B2,
                  ).withValues(
                    alpha: .20,
                  ),

                  blurRadius:
                      14,

                  offset:
                      const Offset(
                    0,
                    6,
                  ),
                ),
              ],
            ),

            child:
                const Icon(

              Icons.auto_awesome_rounded,

              color:
                  Colors.white,

              size:
                  24,
            ),
          ),


          const SizedBox(
            width: 12,
          ),


          //--------------------------------------------------
          // TITLE
          //--------------------------------------------------

          const Expanded(

            child:
                Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  "IRAI",

                  style:
                      TextStyle(
                    fontSize: 20,
                    fontWeight:
                        FontWeight.w800,
                    color:
                        Color(0xFF182020),
                  ),
                ),

                SizedBox(
                  height: 2,
                ),

                Text(
                  "Your personal wellness companion",

                  style:
                      TextStyle(
                    fontSize: 12,
                    color:
                        Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  //==========================================================
  // M3 — PERSONAL DISCOVERY BUTTON
  //==========================================================

  Widget _buildPersonalDiscoveryButton() {

    return SizedBox(

      width:
          double.infinity,

      height:
          56,

      child:
          OutlinedButton.icon(

        onPressed:
            _startPersonalDiscovery,

        icon:
            const Icon(

          Icons.psychology_rounded,

          color:
              Color(0xFF2FA7B2),
        ),

        label:
            const Text(

          "Start Personal Discovery",

          style:
              TextStyle(
            fontSize: 15,
            fontWeight:
                FontWeight.w700,
            color:
                Color(0xFF2FA7B2),
          ),
        ),

        style:
            OutlinedButton.styleFrom(

          side:
              const BorderSide(
            color:
                Color(0xFF2FA7B2),
          ),

          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(
              18,
            ),
          ),
        ),
      ),
    );
  }


  //==========================================================
  // M3 — DISCOVERY
  //==========================================================

  Widget _buildDiscovery() {

    //--------------------------------------------------------
    // RESULT SCREEN
    //--------------------------------------------------------

    if (_assessmentResult !=
        null) {

      return _buildAssessmentComplete();
    }


    //--------------------------------------------------------
    // CURRENT QUESTION
    //--------------------------------------------------------

    final question =
        _questionEngine.currentQuestion;


    //--------------------------------------------------------
    // SAFETY
    //--------------------------------------------------------

    if (question == null) {

      return const Center(

        child:
            Text(
          "No question available.",
        ),
      );
    }


    //--------------------------------------------------------
    // QUESTION SCREEN
    //--------------------------------------------------------

    return Column(

      children: [

        //----------------------------------------------------
        // HEADER
        //----------------------------------------------------

        _buildDiscoveryHeader(),


        //----------------------------------------------------
        // PROGRESS
        //----------------------------------------------------

        _buildDiscoveryProgress(),


        //----------------------------------------------------
        // QUESTION CONTENT
        //----------------------------------------------------

        Expanded(

          child:
              SingleChildScrollView(

            padding:
                const EdgeInsets.all(
              24,
            ),

            child:
                Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                const SizedBox(
                  height: 20,
                ),


                //------------------------------------------------
                // CONTEXT
                //------------------------------------------------

                const Text(
                  "IRAI wants to understand you",

                  style:
                      TextStyle(
                    fontSize: 13,
                    fontWeight:
                        FontWeight.w600,
                    color:
                        Color(0xFF2FA7B2),
                  ),
                ),


                const SizedBox(
                  height: 12,
                ),


                //------------------------------------------------
                // QUESTION
                //------------------------------------------------

                Text(
                  question.question,

                  style:
                      const TextStyle(
                    fontSize: 27,
                    height: 1.2,
                    fontWeight:
                        FontWeight.w800,
                    color:
                        Color(0xFF182020),
                  ),
                ),


                //------------------------------------------------
                // SUBTITLE
                //------------------------------------------------

                if (question.subtitle !=
                    null) ...[

                  const SizedBox(
                    height: 12,
                  ),

                  Text(
                    question.subtitle!,

                    style:
                        const TextStyle(
                      fontSize: 15,
                      height: 1.45,
                      color:
                          Colors.grey,
                    ),
                  ),
                ],


                const SizedBox(
                  height: 28,
                ),


                //------------------------------------------------
                // OPTIONS
                //------------------------------------------------

                ...question.options.map(
                  (
                    option,
                  ) {

                    return _buildDiscoveryOption(
                      option,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }


  //==========================================================
  // M3 — DISCOVERY HEADER
  //==========================================================

  Widget _buildDiscoveryHeader() {

    return Padding(

      padding:
          const EdgeInsets.fromLTRB(
        12,
        10,
        20,
        10,
      ),

      child:
          Row(

        children: [

          IconButton(

            onPressed:
                _exitDiscovery,

            icon:
                const Icon(
              Icons.arrow_back_rounded,
            ),
          ),


          const Expanded(

            child:
                Text(

              "Personal Discovery",

              textAlign:
                  TextAlign.center,

              style:
                  TextStyle(
                fontSize: 19,
                fontWeight:
                    FontWeight.w800,
                color:
                    Color(0xFF182020),
              ),
            ),
          ),


          const SizedBox(
            width: 48,
          ),
        ],
      ),
    );
  }


  //==========================================================
  // M3 — PROGRESS
  //==========================================================

  Widget _buildDiscoveryProgress() {

    return Padding(

      padding:
          const EdgeInsets.symmetric(
        horizontal: 24,
      ),

      child:
          Column(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Text(

            "${_questionEngine.currentQuestionNumber}"
            " / "
            "${_questionEngine.totalQuestions}",

            style:
                const TextStyle(
              fontSize: 13,
              fontWeight:
                  FontWeight.w600,
              color:
                  Colors.grey,
            ),
          ),


          const SizedBox(
            height: 8,
          ),


          ClipRRect(

            borderRadius:
                BorderRadius.circular(
              20,
            ),

            child:
                LinearProgressIndicator(

              value:
                  _questionEngine.progress,

              minHeight:
                  7,

              backgroundColor:
                  const Color(
                0xFFE5E8E7,
              ),

              valueColor:
                  const AlwaysStoppedAnimation<
                      Color>(
                Color(
                  0xFF2FA7B2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  //==========================================================
  // M3 — DISCOVERY OPTION
  //==========================================================

  Widget _buildDiscoveryOption(
    IraiQuestionOption option,
  ) {

    return Container(

      margin:
          const EdgeInsets.only(
        bottom: 12,
      ),

      decoration:
          BoxDecoration(

        color:
            Colors.white,

        borderRadius:
            BorderRadius.circular(
          20,
        ),

        border:
            Border.all(
          color:
              const Color(
            0xFFE5E8E7,
          ),
        ),

        boxShadow: [

          BoxShadow(

            color:
                Colors.black.withValues(
              alpha: .04,
            ),

            blurRadius:
                14,

            offset:
                const Offset(
              0,
              5,
            ),
          ),
        ],
      ),

      child:
          Material(

        color:
            Colors.transparent,

        child:
            InkWell(

          onTap: () {

            _answerDiscoveryQuestion(
              option,
            );
          },

          borderRadius:
              BorderRadius.circular(
            20,
          ),

          child:
              Padding(

            padding:
                const EdgeInsets.all(
              16,
            ),

            child:
                Row(

              children: [

                //------------------------------------------------
                // EMOJI
                //------------------------------------------------

                Container(

                  width:
                      48,

                  height:
                      48,

                  decoration:
                      BoxDecoration(

                    color:
                        const Color(
                      0xFFF6F7F3,
                    ),

                    borderRadius:
                        BorderRadius.circular(
                      15,
                    ),
                  ),

                  alignment:
                      Alignment.center,

                  child:
                      Text(

                    option.emoji ??
                        "•",

                    style:
                        const TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),


                const SizedBox(
                  width: 14,
                ),


                //------------------------------------------------
                // OPTION TEXT
                //------------------------------------------------

                Expanded(

                  child:
                      Column(

                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      Text(

                        option.title,

                        style:
                            const TextStyle(
                          fontSize: 16,
                          fontWeight:
                              FontWeight.w700,
                        ),
                      ),


                      if (option.subtitle !=
                          null) ...[

                        const SizedBox(
                          height: 4,
                        ),

                        Text(

                          option.subtitle!,

                          style:
                              const TextStyle(
                            fontSize: 13,
                            height: 1.3,
                            color:
                                Colors.grey,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),


                //------------------------------------------------
                // ARROW
                //------------------------------------------------

                const Icon(

                  Icons.arrow_forward_ios_rounded,

                  size:
                      15,

                  color:
                      Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  //==========================================================
  // M3 + M4 — RESULT SCREEN
  //==========================================================

  Widget _buildAssessmentComplete() {

    final result =
        _assessmentResult!;


    final constitution =
        _constitutionResult;


    return Center(

      child:
          Padding(

        padding:
            const EdgeInsets.all(
          28,
        ),

        child:
            SingleChildScrollView(

          child:
              Column(

            mainAxisAlignment:
                MainAxisAlignment.center,

            children: [

              //------------------------------------------------
              // SUCCESS ICON
              //------------------------------------------------

              Container(

                width:
                    90,

                height:
                    90,

                decoration:
                    BoxDecoration(

                  color:
                      const Color(
                    0xFFE8F8F7,
                  ),

                  borderRadius:
                      BorderRadius.circular(
                    30,
                  ),
                ),

                child:
                    const Icon(

                  Icons.check_rounded,

                  size:
                      50,

                  color:
                      Color(
                    0xFF2FA7B2,
                  ),
                ),
              ),


              const SizedBox(
                height: 28,
              ),


              //------------------------------------------------
              // TITLE
              //------------------------------------------------

              const Text(

                "Thank you for sharing.",

                textAlign:
                    TextAlign.center,

                style:
                    TextStyle(
                  fontSize: 28,
                  fontWeight:
                      FontWeight.w800,
                  color:
                      Color(0xFF182020),
                ),
              ),


              const SizedBox(
                height: 12,
              ),


              //------------------------------------------------
              // DESCRIPTION
              //------------------------------------------------

              Text(

                "IRAI has collected "
                "${result.answerCount} "
                "responses for your personal discovery.",

                textAlign:
                    TextAlign.center,

                style:
                    const TextStyle(
                  fontSize: 15,
                  height: 1.5,
                  color:
                      Colors.grey,
                ),
              ),


              //------------------------------------------------
              // M4 CONSTITUTION
              //------------------------------------------------

              if (constitution != null) ...[

                const SizedBox(
                  height: 24,
                ),

                _buildConstitutionCard(
                  constitution,
                ),
              ],


              const SizedBox(
                height: 35,
              ),


              //------------------------------------------------
              // CONTINUE
              //------------------------------------------------

              SizedBox(

                width:
                    double.infinity,

                height:
                    56,

                child:
                    ElevatedButton(

                  onPressed:
                      _exitDiscovery,

                  style:
                      ElevatedButton.styleFrom(

                    backgroundColor:
                        const Color(
                      0xFF2FA7B2,
                    ),

                    elevation:
                        0,

                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                        18,
                      ),
                    ),
                  ),

                  child:
                      const Text(

                    "Continue with IRAI",

                    style:
                        TextStyle(
                      fontSize: 17,
                      color:
                          Colors.white,
                      fontWeight:
                          FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  //==========================================================
  // M4 — CONSTITUTION CARD
  //==========================================================

  Widget _buildConstitutionCard(
    IraiConstitutionResult constitution,
  ) {

    return Container(

      width:
          double.infinity,

      padding:
          const EdgeInsets.all(
        20,
      ),

      decoration:
          BoxDecoration(

        color:
            Colors.white,

        borderRadius:
            BorderRadius.circular(
          22,
        ),

        boxShadow: [

          BoxShadow(

            color:
                Colors.black.withValues(
              alpha: .05,
            ),

            blurRadius:
                16,

            offset:
                const Offset(
              0,
              5,
            ),
          ),
        ],
      ),

      child:
          Column(

        children: [

          //----------------------------------------------------
          // TITLE
          //----------------------------------------------------

          const Text(

            "Current Constitution Pattern",

            textAlign:
                TextAlign.center,

            style:
                TextStyle(
              fontSize: 16,
              fontWeight:
                  FontWeight.w700,
            ),
          ),


          const SizedBox(
            height: 20,
          ),


          //----------------------------------------------------
          // SCORES
          //----------------------------------------------------

          _buildConstitutionScore(
            "Vatham",
            constitution.vatham,
          ),


          const SizedBox(
            height: 10,
          ),


          _buildConstitutionScore(
            "Pitham",
            constitution.pitham,
          ),


          const SizedBox(
            height: 10,
          ),


          _buildConstitutionScore(
            "Kapham",
            constitution.kapham,
          ),


          const SizedBox(
            height: 20,
          ),


          //----------------------------------------------------
          // DOMINANT
          //----------------------------------------------------

          Text(

            "Dominant: "
            "${constitution.dominant.toUpperCase()}",

            textAlign:
                TextAlign.center,

            style:
                const TextStyle(
              fontSize: 19,
              fontWeight:
                  FontWeight.w800,
              color:
                  Color(
                0xFF2FA7B2,
              ),
            ),
          ),


          //----------------------------------------------------
          // SECONDARY
          //----------------------------------------------------

          if (constitution.secondary !=
              null) ...[

            const SizedBox(
              height: 6,
            ),

            Text(

              "Secondary: "
              "${constitution.secondary!.toUpperCase()}",

              style:
                  const TextStyle(
                fontSize: 14,
                color:
                    Colors.grey,
              ),
            ),
          ],


          const SizedBox(
            height: 18,
          ),


          //----------------------------------------------------
          // PERCENTAGE
          //----------------------------------------------------

          Text(

            "Dominant score: "
            "${(constitution.dominantPercentage * 100).toStringAsFixed(0)}%",

            style:
                const TextStyle(
              fontSize: 13,
              color:
                  Colors.grey,
            ),
          ),
        ],
      ),
    );
  }


  //==========================================================
  // M4 — CONSTITUTION SCORE ROW
  //==========================================================

  Widget _buildConstitutionScore(
    String name,
    double score,
  ) {

    return Row(

      children: [

        //------------------------------------------------------
        // NAME
        //------------------------------------------------------

        Expanded(

          child:
              Text(

            name,

            style:
                const TextStyle(
              fontSize: 15,
              fontWeight:
                  FontWeight.w600,
            ),
          ),
        ),


        //------------------------------------------------------
        // SCORE
        //------------------------------------------------------

        Text(

          score.toStringAsFixed(0),

          style:
              const TextStyle(
            fontSize: 16,
            fontWeight:
                FontWeight.w800,
          ),
        ),
      ],
    );
  }
}