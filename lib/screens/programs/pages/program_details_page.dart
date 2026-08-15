//----------------------------------------------------------
// IRAI PROGRAM DETAILS PAGE
//----------------------------------------------------------
//
// PURPOSE:
//
// This is the COMMON DETAILS TEMPLATE for IRAI Programs.
//
// The same template is reused for:
//
// • Asanas
// • Mudra
// • Meditation
//
// The program data changes,
// but the screen structure remains common.
//
//----------------------------------------------------------
//
// FINAL STRUCTURE:
//
// Asanas
//    ↓
// Begin
// Asanas Practice
// Recovery
//
// Mudra
//    ↓
// Begin
// Mudra Practice
// Recovery
//
// Meditation
//    ↓
// Begin
// Meditation Practice
// Recovery
//
//----------------------------------------------------------
//
// IMPORTANT:
//
// THIS PAGE DOES NOT DECIDE PERSONALIZATION.
//
// Personalization happens inside the content layer.
//
// Program Details
//      ↓
// Stage
//      ↓
// Stage Content Page
//      ↓
// Personalized videos / content
//
//----------------------------------------------------------


//==========================================================
// IMPORTS
//==========================================================

import 'package:flutter/material.dart';

import '../models/program_model.dart';
import '../models/program_stage_model.dart';
import 'stage_content_page.dart';


//==========================================================
// PROGRAM DETAILS PAGE
//==========================================================

class ProgramDetailsPage extends StatelessWidget {

  //----------------------------------------------------------
  // PROGRAM
  //----------------------------------------------------------
  //
  // The program selected from the Programs page.
  //
  //----------------------------------------------------------

  final ProgramModel program;


  //----------------------------------------------------------
  // CONSTRUCTOR
  //----------------------------------------------------------

  const ProgramDetailsPage({

    super.key,

    required this.program,
  });


  //----------------------------------------------------------
  // BUILD
  //----------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    //--------------------------------------------------------
    // GET STAGES
    //--------------------------------------------------------
    //
    // The current stage structure is local.
    //
    // Later this can come from the centralized data layer.
    //
    //--------------------------------------------------------

    final List<ProgramStageModel> stages =
        _getStages(program.id);


    //--------------------------------------------------------
    // PAGE
    //--------------------------------------------------------

    return Scaffold(

      //------------------------------------------------------
      // BACKGROUND
      //------------------------------------------------------

      backgroundColor:
          const Color(0xFFF6F7F3),


      //------------------------------------------------------
      // BODY
      //------------------------------------------------------

      body: SafeArea(

        child: CustomScrollView(

          physics:
              const BouncingScrollPhysics(),

          slivers: [

            //------------------------------------------------
            // TOP NAVIGATION
            //------------------------------------------------

            SliverToBoxAdapter(

              child: Padding(

                padding:
                    const EdgeInsets.fromLTRB(
                  20,
                  18,
                  20,
                  0,
                ),

                child: Row(

                  children: [

                    //------------------------------------------------
                    // BACK BUTTON
                    //------------------------------------------------

                    _BackButton(
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),

                    const SizedBox(
                      width: 14,
                    ),


                    //------------------------------------------------
                    // PAGE TITLE
                    //------------------------------------------------

                    Expanded(

                      child: Text(

                        program.title,

                        maxLines: 1,

                        overflow:
                            TextOverflow.ellipsis,

                        style:
                            const TextStyle(

                          fontSize: 24,

                          fontWeight:
                              FontWeight.w800,

                          letterSpacing:
                              -0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),


            //------------------------------------------------
            // PROGRAM HERO
            //------------------------------------------------

            SliverToBoxAdapter(

              child: Padding(

                padding:
                    const EdgeInsets.fromLTRB(
                  20,
                  24,
                  20,
                  0,
                ),

                child:
                    _ProgramHero(
                  program: program,
                ),
              ),
            ),


            //------------------------------------------------
            // PRACTICE SECTION HEADER
            //------------------------------------------------

            SliverToBoxAdapter(

              child: Padding(

                padding:
                    const EdgeInsets.fromLTRB(
                  20,
                  32,
                  20,
                  16,
                ),

                child: Row(

                  crossAxisAlignment:
                      CrossAxisAlignment.end,

                  children: [

                    //------------------------------------------------
                    // TITLE
                    //------------------------------------------------

                    const Expanded(

                      child: Column(

                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [

                          Text(

                            'Your Practice',

                            style:
                                TextStyle(

                              fontSize: 22,

                              fontWeight:
                                  FontWeight.w800,

                              letterSpacing:
                                  -0.4,
                            ),
                          ),

                          SizedBox(
                            height: 5,
                          ),

                          Text(

                            'Move through your practice at your own pace',

                            style:
                                TextStyle(

                              fontSize: 13,

                              color:
                                  Colors.black54,

                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                    ),


                    //------------------------------------------------
                    // STAGE COUNT
                    //------------------------------------------------

                    Container(

                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 11,
                        vertical: 7,
                      ),

                      decoration:
                          BoxDecoration(

                        color:
                            Colors.white,

                        borderRadius:
                            BorderRadius.circular(
                          20,
                        ),
                      ),

                      child: Text(

                        '${stages.length} steps',

                        style:
                            const TextStyle(

                          fontSize: 11.5,

                          fontWeight:
                              FontWeight.w700,

                          color:
                              Color(0xFF2F7D6B),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),


            //------------------------------------------------
            // STAGE LIST
            //------------------------------------------------

            SliverPadding(

              padding:
                  const EdgeInsets.fromLTRB(
                20,
                0,
                20,
                40,
              ),

              sliver:
                  SliverList(

                delegate:
                    SliverChildBuilderDelegate(

                  (context, index) {

                    //------------------------------------------------
                    // CURRENT STAGE
                    //------------------------------------------------

                    final ProgramStageModel stage =
                        stages[index];


                    //------------------------------------------------
                    // STAGE CARD
                    //------------------------------------------------

                    return _StageCard(

                      stage:
                          stage,

                      index:
                          index,

                      isLast:
                          index ==
                              stages.length - 1,

                      onTap: () {

                        //------------------------------------------------
                        // OPEN CONTENT PAGE
                        //------------------------------------------------
                        //
                        // The selected Stage is passed to the common
                        // StageContentPage.
                        //
                        // Personalization will happen further down.
                        //
                        //------------------------------------------------

                        Navigator.push(

                          context,

                          MaterialPageRoute(

                            builder:
                                (context) {

                              return StageContentPage(
                                stage:
                                    stage,
                              );
                            },
                          ),
                        );
                      },
                    );
                  },

                  childCount:
                      stages.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


//==========================================================
// PROGRAM HERO
//==========================================================
//
// PURPOSE:
//
// Gives the selected Program a premium identity.
//
// This is NOT the personalized content.
//
// It simply introduces the selected wellness path.
//
//----------------------------------------------------------

class _ProgramHero
    extends StatelessWidget {

  final ProgramModel program;


  const _ProgramHero({
    required this.program,
  });


  @override
  Widget build(BuildContext context) {

    //--------------------------------------------------------
    // PROGRAM ACCENT
    //--------------------------------------------------------

    final Color accent =
        _getProgramAccent(
      program.id,
    );


    return Container(

      padding:
          const EdgeInsets.all(22),

      decoration:
          BoxDecoration(

        color:
            const Color(0xFFE6F2ED),

        borderRadius:
            BorderRadius.circular(
          30,
        ),

        border:
            Border.all(

          color:
              const Color(0xFFD5E8E0),

          width: 1,
        ),
      ),

      child: Stack(

        children: [

          //--------------------------------------------------
          // DECORATIVE CIRCLE
          //--------------------------------------------------

          Positioned(

            right: -30,

            top: -45,

            child: Container(

              width: 150,

              height: 150,

              decoration:
                  BoxDecoration(

                color:
                    Colors.white.withValues(
                  alpha: .25,
                ),

                shape:
                    BoxShape.circle,
              ),
            ),
          ),


          //--------------------------------------------------
          // CONTENT
          //--------------------------------------------------

          Column(

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              //------------------------------------------------
              // ICON + CATEGORY
              //------------------------------------------------

              Row(

                children: [

                  //------------------------------------------------
                  // ICON
                  //------------------------------------------------

                  Container(

                    width: 62,

                    height: 62,

                    decoration:
                        BoxDecoration(

                      color:
                          Colors.white.withValues(
                        alpha: .82,
                      ),

                      borderRadius:
                          BorderRadius.circular(
                        20,
                      ),
                    ),

                    child: Icon(

                      _getProgramIcon(
                        program.id,
                      ),

                      size: 31,

                      color:
                          accent,
                    ),
                  ),


                  const SizedBox(
                    width: 15,
                  ),


                  //------------------------------------------------
                  // LABEL
                  //------------------------------------------------

                  Expanded(

                    child: Column(

                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        Text(

                          'PERSONALIZED PATH',

                          style:
                              TextStyle(

                            fontSize: 10,

                            fontWeight:
                                FontWeight.w800,

                            letterSpacing:
                                1.0,

                            color:
                                accent,
                          ),
                        ),

                        const SizedBox(
                          height: 5,
                        ),

                        Text(

                          program.title,

                          maxLines: 1,

                          overflow:
                              TextOverflow.ellipsis,

                          style:
                              const TextStyle(

                            fontSize: 21,

                            fontWeight:
                                FontWeight.w800,

                            letterSpacing:
                                -0.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 18,
              ),


              //------------------------------------------------
              // DESCRIPTION
              //------------------------------------------------

              Text(

                program.subtitle,

                maxLines: 3,

                overflow:
                    TextOverflow.ellipsis,

                style:
                    const TextStyle(

                  fontSize: 13.5,

                  color:
                      Colors.black54,

                  height: 1.45,
                ),
              ),


              const SizedBox(
                height: 18,
              ),


              //------------------------------------------------
              // SMALL INFORMATION ROW
              //------------------------------------------------

              Row(

                children: [

                  _HeroInfoChip(

                    icon:
                        Icons.auto_awesome_rounded,

                    text:
                        'Personalized',
                  ),

                  const SizedBox(
                    width: 8,
                  ),

                  _HeroInfoChip(

                    icon:
                        Icons.layers_outlined,

                    text:
                        '3 stages',
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}


//==========================================================
// HERO INFO CHIP
//==========================================================

class _HeroInfoChip
    extends StatelessWidget {

  final IconData icon;

  final String text;


  const _HeroInfoChip({

    required this.icon,

    required this.text,
  });


  @override
  Widget build(BuildContext context) {

    return Container(

      padding:
          const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 7,
      ),

      decoration:
          BoxDecoration(

        color:
            Colors.white.withValues(
          alpha: .65,
        ),

        borderRadius:
            BorderRadius.circular(
          18,
        ),
      ),

      child: Row(

        mainAxisSize:
            MainAxisSize.min,

        children: [

          Icon(

            icon,

            size: 13,

            color:
                const Color(0xFF2F7D6B),
          ),

          const SizedBox(
            width: 5,
          ),

          Text(

            text,

            style:
                const TextStyle(

              fontSize: 10.5,

              fontWeight:
                  FontWeight.w700,

              color:
                  Color(0xFF315D54),
            ),
          ),
        ],
      ),
    );
  }
}


//==========================================================
// STAGE CARD
//==========================================================
//
// PURPOSE:
//
// Displays one stage of the Program.
//
// FINAL STRUCTURE:
//
// 01  Begin
//
// 02  Asanas Practice
//
// 03  Recovery
//
// The same component works for Mudra and Meditation.
//
//----------------------------------------------------------

class _StageCard
    extends StatelessWidget {

  final ProgramStageModel stage;

  final int index;

  final bool isLast;

  final VoidCallback onTap;


  const _StageCard({

    required this.stage,

    required this.index,

    required this.isLast,

    required this.onTap,
  });


  @override
  Widget build(BuildContext context) {

    //--------------------------------------------------------
    // STAGE COLOR
    //--------------------------------------------------------

    final Color accent =
        _getStageAccent(
      stage.id,
    );


    return Padding(

      padding:
          EdgeInsets.only(
        bottom:
            isLast ? 0 : 14,
      ),

      child: Material(

        color:
            Colors.transparent,

        child: InkWell(

          onTap:
              onTap,

          borderRadius:
              BorderRadius.circular(
            25,
          ),

          child: Ink(

            decoration:
                BoxDecoration(

              color:
                  Colors.white,

              borderRadius:
                  BorderRadius.circular(
                25,
              ),

              border:
                  Border.all(

                color:
                    Colors.black.withValues(
                  alpha: .035,
                ),
              ),

              boxShadow: [

                BoxShadow(

                  color:
                      Colors.black.withValues(
                    alpha: .035,
                  ),

                  blurRadius: 17,

                  offset:
                      const Offset(0, 7),
                ),
              ],
            ),

            child: Padding(

              padding:
                  const EdgeInsets.all(
                17,
              ),

              child: Row(

                children: [

                  //------------------------------------------------
                  // STAGE ICON
                  //------------------------------------------------

                  Container(

                    width: 57,

                    height: 57,

                    decoration:
                        BoxDecoration(

                      color:
                          accent.withValues(
                        alpha: .10,
                      ),

                      borderRadius:
                          BorderRadius.circular(
                        18,
                      ),
                    ),

                    child: Icon(

                      _getStageIcon(
                        stage.id,
                      ),

                      size: 27,

                      color:
                          accent,
                    ),
                  ),


                  const SizedBox(
                    width: 15,
                  ),


                  //------------------------------------------------
                  // STAGE INFORMATION
                  //------------------------------------------------

                  Expanded(

                    child: Column(

                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        //------------------------------------------------
                        // STAGE NUMBER
                        //------------------------------------------------

                        Text(

                          'STEP ${(index + 1).toString().padLeft(2, '0')}',

                          style:
                              TextStyle(

                            fontSize: 9.5,

                            fontWeight:
                                FontWeight.w800,

                            letterSpacing:
                                1.0,

                            color:
                                accent,
                          ),
                        ),


                        const SizedBox(
                          height: 5,
                        ),


                        //------------------------------------------------
                        // TITLE
                        //------------------------------------------------

                        Text(

                          stage.title,

                          maxLines: 1,

                          overflow:
                              TextOverflow.ellipsis,

                          style:
                              const TextStyle(

                            fontSize: 17,

                            fontWeight:
                                FontWeight.w800,

                            letterSpacing:
                                -0.2,
                          ),
                        ),


                        const SizedBox(
                          height: 4,
                        ),


                        //------------------------------------------------
                        // SUBTITLE
                        //------------------------------------------------

                        Text(

                          stage.subtitle,

                          maxLines: 2,

                          overflow:
                              TextOverflow.ellipsis,

                          style:
                              TextStyle(

                            fontSize: 12.5,

                            color:
                                Colors.grey.shade600,

                            height: 1.35,
                          ),
                        ),
                      ],
                    ),
                  ),


                  const SizedBox(
                    width: 10,
                  ),


                  //------------------------------------------------
                  // ARROW
                  //------------------------------------------------

                  Container(

                    width: 36,

                    height: 36,

                    decoration:
                        BoxDecoration(

                      color:
                          const Color(
                        0xFFF7F8F6,
                      ),

                      shape:
                          BoxShape.circle,
                    ),

                    child: Icon(

                      Icons
                          .arrow_forward_rounded,

                      size: 18,

                      color:
                          Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


//==========================================================
// BACK BUTTON
//==========================================================

class _BackButton
    extends StatelessWidget {

  final VoidCallback onTap;


  const _BackButton({
    required this.onTap,
  });


  @override
  Widget build(BuildContext context) {

    return Material(

      color:
          Colors.transparent,

      child: InkWell(

        onTap:
            onTap,

        borderRadius:
            BorderRadius.circular(
          16,
        ),

        child: Ink(

          width: 46,

          height: 46,

          decoration:
              BoxDecoration(

            color:
                Colors.white,

            borderRadius:
                BorderRadius.circular(
              16,
            ),

            boxShadow: [

              BoxShadow(

                color:
                    Colors.black.withValues(
                  alpha: .035,
                ),

                blurRadius: 12,

                offset:
                    const Offset(0, 5),
              ),
            ],
          ),

          child: const Icon(

            Icons.arrow_back_ios_new_rounded,

            size: 18,
          ),
        ),
      ),
    );
  }
}


//==========================================================
// GET PROGRAM STAGES
//==========================================================
//
// IMPORTANT:
//
// THIS IS OUR FINALIZED TEMPLATE.
//
// ASANAS:
//
// Begin
// Asanas Practice
// Recovery
//
// MUDRA:
//
// Begin
// Mudra Practice
// Recovery
//
// MEDITATION:
//
// Begin
// Meditation Practice
// Recovery
//
//----------------------------------------------------------

List<ProgramStageModel> _getStages(
  String programId,
) {

  //--------------------------------------------------------
  // ASANAS
  //--------------------------------------------------------

  if (programId == 'asanas') {

    return const [

      ProgramStageModel(

        id: 'begin',

        programId: 'asanas',

        title: 'Begin',

        subtitle:
            'Prepare yourself before your practice',

        icon: 'play',
      ),


      ProgramStageModel(

        id: 'asanas_practice',

        programId: 'asanas',

        title: 'Asanas Practice',

        subtitle:
            'Your personalized asana practice',

        icon: 'self_improvement',
      ),


      ProgramStageModel(

        id: 'recovery',

        programId: 'asanas',

        title: 'Recovery',

        subtitle:
            'Relax and complete your practice',

        icon: 'spa',
      ),
    ];
  }


  //--------------------------------------------------------
  // MUDRA
  //--------------------------------------------------------

  if (programId == 'mudra') {

    return const [

      ProgramStageModel(

        id: 'begin',

        programId: 'mudra',

        title: 'Begin',

        subtitle:
            'Prepare yourself before your practice',

        icon: 'play',
      ),


      ProgramStageModel(

        id: 'mudra_practice',

        programId: 'mudra',

        title: 'Mudra Practice',

        subtitle:
            'Your personalized mudra practice',

        icon: 'pan_tool',
      ),


      ProgramStageModel(

        id: 'recovery',

        programId: 'mudra',

        title: 'Recovery',

        subtitle:
            'Relax and complete your practice',

        icon: 'spa',
      ),
    ];
  }


  //--------------------------------------------------------
  // MEDITATION
  //--------------------------------------------------------

  if (programId == 'meditation') {

    return const [

      ProgramStageModel(

        id: 'begin',

        programId: 'meditation',

        title: 'Begin',

        subtitle:
            'Prepare your mind and settle in',

        icon: 'play',
      ),


      ProgramStageModel(

        id: 'meditation_practice',

        programId: 'meditation',

        title: 'Meditation Practice',

        subtitle:
            'Your personalized meditation practice',

        icon: 'psychology',
      ),


      ProgramStageModel(

        id: 'recovery',

        programId: 'meditation',

        title: 'Recovery',

        subtitle:
            'Relax and complete your practice',

        icon: 'spa',
      ),
    ];
  }


  //--------------------------------------------------------
  // DEFAULT
  //--------------------------------------------------------
  //
  // Food, Body Care, Living Practices, Siddha Guide etc.
  // will receive their own structure later.
  //
  //--------------------------------------------------------

  return const [];
}


//==========================================================
// PROGRAM ICON
//==========================================================

IconData _getProgramIcon(
  String programId,
) {

  switch (programId) {

    case 'siddha_guide':
      return Icons.menu_book_rounded;

    case 'asanas':
      return Icons.self_improvement_rounded;

    case 'mudra':
      return Icons.pan_tool_rounded;

    case 'meditation':
      return Icons.psychology_rounded;

    case 'food':
      return Icons.restaurant_rounded;

    case 'body_care':
      return Icons.spa_rounded;

    case 'living_practices':
      return Icons.wb_sunny_rounded;

    case 'recovery':
      return Icons.bedtime_rounded;

    default:
      return Icons.apps_rounded;
  }
}


//==========================================================
// PROGRAM ACCENT
//==========================================================
//
// Keeps the same soft IRAI visual language used on the
// Programs page.
//
//----------------------------------------------------------

Color _getProgramAccent(
  String programId,
) {

  switch (programId) {

    case 'siddha_guide':
      return const Color(0xFF6B705C);

    case 'asanas':
      return const Color(0xFF2F7D6B);

    case 'mudra':
      return const Color(0xFF557A95);

    case 'meditation':
      return const Color(0xFF6C63A8);

    case 'food':
      return const Color(0xFF7A8B45);

    case 'body_care':
      return const Color(0xFF9A6B5B);

    case 'living_practices':
      return const Color(0xFFB17A3A);

    case 'recovery':
      return const Color(0xFF536B82);

    default:
      return const Color(0xFF2F7D6B);
  }
}


//==========================================================
// STAGE ACCENT
//==========================================================
//
// Each stage gets a subtle visual identity.
//
//----------------------------------------------------------

Color _getStageAccent(
  String stageId,
) {

  switch (stageId) {

    case 'begin':
      return const Color(0xFFB17A3A);

    case 'asanas_practice':
      return const Color(0xFF2F7D6B);

    case 'mudra_practice':
      return const Color(0xFF557A95);

    case 'meditation_practice':
      return const Color(0xFF6C63A8);

    case 'recovery':
      return const Color(0xFF536B82);

    default:
      return const Color(0xFF2F7D6B);
  }
}


//==========================================================
// STAGE ICON
//==========================================================

IconData _getStageIcon(
  String stageId,
) {

  switch (stageId) {

    //--------------------------------------------------------
    // BEGIN
    //--------------------------------------------------------

    case 'begin':
      return Icons.play_circle_outline_rounded;


    //--------------------------------------------------------
    // ASANAS
    //--------------------------------------------------------

    case 'asanas_practice':
      return Icons.self_improvement_rounded;


    //--------------------------------------------------------
    // MUDRA
    //--------------------------------------------------------

    case 'mudra_practice':
      return Icons.pan_tool_rounded;


    //--------------------------------------------------------
    // MEDITATION
    //--------------------------------------------------------

    case 'meditation_practice':
      return Icons.psychology_rounded;


    //--------------------------------------------------------
    // RECOVERY
    //--------------------------------------------------------

    case 'recovery':
      return Icons.spa_rounded;


    //--------------------------------------------------------
    // DEFAULT
    //--------------------------------------------------------

    default:
      return Icons.play_circle_outline_rounded;
  }
}