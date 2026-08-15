//----------------------------------------------------------
// IRAI STAGE CONTENT PAGE
//----------------------------------------------------------
//
// PURPOSE:
//
// This page displays the actual content inside a selected
// Program Stage.
//
//----------------------------------------------------------
//
// FLOW:
//
// Programs
//     ↓
// Program
//     ↓
// Stage
//     ↓
// StageContentPage
//     ↓
// Personalized Content
//     ↓
// Video / Practice
//
//----------------------------------------------------------
//
// IMPORTANT ARCHITECTURE:
//
// The UI is COMMON.
//
// The content is DYNAMIC.
//
// Example:
//
// User A
// Asanas Practice
//     ↓
// Content A
//
// User B
// Asanas Practice
//     ↓
// Content B
//
// The page does NOT decide which user gets which content.
//
// That responsibility belongs to ContentController / data
// layer.
//
//----------------------------------------------------------


//==========================================================
// IMPORTS
//==========================================================

import 'package:flutter/material.dart';

import '../controller/content_controller.dart';
import '../models/content_model.dart';
import '../models/program_stage_model.dart';
import '../widgets/content_card.dart';

//----------------------------------------------------------
// VIDEO VIEWER
//----------------------------------------------------------
//
// This page opens when the selected content is a video.
//
//----------------------------------------------------------

import 'video_viewer_page.dart';


//==========================================================
// STAGE CONTENT PAGE
//==========================================================

class StageContentPage extends StatelessWidget {

  //----------------------------------------------------------
  // STAGE
  //----------------------------------------------------------
  //
  // The stage selected by the user.
  //
  //----------------------------------------------------------

  final ProgramStageModel stage;


  //----------------------------------------------------------
  // CONSTRUCTOR
  //----------------------------------------------------------

  const StageContentPage({

    super.key,

    required this.stage,
  });


  //----------------------------------------------------------
  // BUILD
  //----------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    //--------------------------------------------------------
    // CONTENT CONTROLLER
    //--------------------------------------------------------
    //
    // The controller is responsible for providing content.
    //
    //--------------------------------------------------------

    final ContentController controller =
        ContentController();


    //--------------------------------------------------------
    // GET CONTENT
    //--------------------------------------------------------
    //
    // IMPORTANT:
    //
    // Content is filtered using BOTH:
    //
    // 1. Program ID
    // 2. Stage ID
    //
    // This keeps the content architecture centralized.
    //
    //--------------------------------------------------------

    final List<ContentModel> content =
        controller.getContentByStage(
      stage.programId,
      stage.id,
    );


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

                        Navigator.pop(
                          context,
                        );
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

                        stage.title,

                        maxLines: 1,

                        overflow:
                            TextOverflow.ellipsis,

                        style:
                            const TextStyle(

                          fontSize: 24,

                          fontWeight:
                              FontWeight.w800,

                          letterSpacing:
                              -0.6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),


            //------------------------------------------------
            // STAGE HERO
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

                child: _StageHero(

                  stage:
                      stage,

                  contentCount:
                      content.length,
                ),
              ),
            ),


            //------------------------------------------------
            // SECTION HEADER
            //------------------------------------------------

            SliverToBoxAdapter(

              child: Padding(

                padding:
                    const EdgeInsets.fromLTRB(
                  20,
                  32,
                  20,
                  15,
                ),

                child: Row(

                  crossAxisAlignment:
                      CrossAxisAlignment.end,

                  children: [

                    //------------------------------------------------
                    // SECTION TITLE
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

                            'Practices available for this stage',

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
                    // CONTENT COUNT
                    //------------------------------------------------

                    if (content.isNotEmpty)

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

                          '${content.length} available',

                          style:
                              const TextStyle(

                            fontSize: 11,

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
            // CONTENT LIST
            //------------------------------------------------
            //
            // We continue using your existing ContentCard.
            //
            // The ContentCard remains reusable and does not
            // contain navigation logic.
            //
            //------------------------------------------------

            if (content.isNotEmpty)

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
                      // CURRENT CONTENT
                      //------------------------------------------------

                      final ContentModel item =
                          content[index];


                      //------------------------------------------------
                      // CONTENT CARD
                      //------------------------------------------------

                      return Padding(

                        padding:
                            const EdgeInsets.only(
                          bottom: 14,
                        ),

                        child: ContentCard(

                          content:
                              item,


                          //------------------------------------------------
                          // CONTENT ACTION
                          //------------------------------------------------
                          //
                          // The card itself remains generic.
                          //
                          // StageContentPage decides what viewer
                          // should open based on ContentType.
                          //
                          //------------------------------------------------

                          onTap: () {

                            //------------------------------------------------
                            // VIDEO
                            //------------------------------------------------
                            //
                            // ContentCard
                            //      ↓
                            // VideoViewerPage
                            //      ↓
                            // content.mediaUrl
                            //      ↓
                            // Video Player
                            //
                            //------------------------------------------------

                            if (item.type ==
                                ContentType.video) {

                              Navigator.push(

                                context,

                                MaterialPageRoute(

                                  builder: (_) =>
                                      VideoViewerPage(

                                    content:
                                        item,
                                  ),
                                ),
                              );
                            }


                            //------------------------------------------------
                            // OTHER CONTENT TYPES
                            //------------------------------------------------
                            //
                            // These will get dedicated viewers later:
                            //
                            // Article
                            // Audio
                            // Guide
                            // Recipe
                            // Checklist
                            //
                            //------------------------------------------------

                            else {

                              // Future content viewers.
                            }
                          },
                        ),
                      );
                    },

                    childCount:
                        content.length,
                  ),
                ),
              )


            //------------------------------------------------
            // EMPTY STATE
            //------------------------------------------------

            else

              const SliverFillRemaining(

                hasScrollBody:
                    false,

                child:
                    _EmptyContentState(),
              ),
          ],
        ),
      ),
    );
  }
}


//==========================================================
// STAGE HERO
//==========================================================
//
// PURPOSE:
//
// Gives the selected stage a strong visual identity.
//
// The actual personalized content comes below.
//
//----------------------------------------------------------

class _StageHero
    extends StatelessWidget {

  final ProgramStageModel stage;

  final int contentCount;


  const _StageHero({

    required this.stage,

    required this.contentCount,
  });


  @override
  Widget build(BuildContext context) {

    //--------------------------------------------------------
    // STAGE ACCENT
    //--------------------------------------------------------

    final Color accent =
        _getStageAccent(
      stage.id,
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

              width: 145,

              height: 145,

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
          // MAIN CONTENT
          //--------------------------------------------------

          Column(

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              //------------------------------------------------
              // ICON
              //------------------------------------------------

              Container(

                width: 60,

                height: 60,

                decoration:
                    BoxDecoration(

                  color:
                      Colors.white.withValues(
                    alpha: .82,
                  ),

                  borderRadius:
                      BorderRadius.circular(
                    19,
                  ),
                ),

                child: Icon(

                  _getStageIcon(
                    stage.id,
                  ),

                  size: 30,

                  color:
                      accent,
                ),
              ),


              const SizedBox(
                height: 18,
              ),


              //------------------------------------------------
              // PERSONALIZATION LABEL
              //------------------------------------------------

              Text(

                'PERSONALIZED PRACTICE',

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
                height: 6,
              ),


              //------------------------------------------------
              // STAGE TITLE
              //------------------------------------------------

              Text(

                stage.title,

                maxLines: 2,

                overflow:
                    TextOverflow.ellipsis,

                style:
                    const TextStyle(

                  fontSize: 25,

                  fontWeight:
                      FontWeight.w800,

                  letterSpacing:
                      -0.6,

                  height: 1.1,
                ),
              ),


              const SizedBox(
                height: 9,
              ),


              //------------------------------------------------
              // STAGE DESCRIPTION
              //------------------------------------------------

              Text(

                stage.subtitle,

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
                height: 17,
              ),


              //------------------------------------------------
              // INFORMATION CHIPS
              //------------------------------------------------

              Row(

                children: [

                  _InfoChip(

                    icon:
                        Icons.auto_awesome_rounded,

                    text:
                        'Personalized',
                  ),


                  const SizedBox(
                    width: 8,
                  ),


                  _InfoChip(

                    icon:
                        Icons.video_library_outlined,

                    text:
                        contentCount == 0
                            ? 'Preparing'
                            : '$contentCount practices',
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
// INFORMATION CHIP
//==========================================================

class _InfoChip
    extends StatelessWidget {

  final IconData icon;

  final String text;


  const _InfoChip({

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
          alpha: .68,
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
// EMPTY CONTENT STATE
//==========================================================
//
// Temporary state.
//
// Later, when Firebase/content data is connected,
// personalized content will normally appear here.
//
//----------------------------------------------------------

class _EmptyContentState
    extends StatelessWidget {

  const _EmptyContentState();


  @override
  Widget build(BuildContext context) {

    return Center(

      child: Padding(

        padding:
            const EdgeInsets.symmetric(
          horizontal: 40,
        ),

        child: Column(

          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [

            //------------------------------------------------
            // ICON
            //------------------------------------------------

            Container(

              width: 76,

              height: 76,

              decoration:
                  BoxDecoration(

                color:
                    const Color(0xFFE6F2ED),

                borderRadius:
                    BorderRadius.circular(
                  23,
                ),
              ),

              child: const Icon(

                Icons.video_library_outlined,

                size: 35,

                color:
                    Color(0xFF2F7D6B),
              ),
            ),


            const SizedBox(
              height: 18,
            ),


            //------------------------------------------------
            // TITLE
            //------------------------------------------------

            const Text(

              'Your practices are being prepared',

              textAlign:
                  TextAlign.center,

              style:
                  TextStyle(

                fontSize: 18,

                fontWeight:
                    FontWeight.w800,

                letterSpacing:
                    -0.2,
              ),
            ),


            const SizedBox(
              height: 8,
            ),


            //------------------------------------------------
            // DESCRIPTION
            //------------------------------------------------

            Text(

              'Personalized practices for this stage will appear here.',

              textAlign:
                  TextAlign.center,

              style:
                  TextStyle(

                fontSize: 13.5,

                color:
                    Colors.grey.shade600,

                height: 1.45,
              ),
            ),
          ],
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
// STAGE ICON
//==========================================================
//
// Converts Stage ID into an appropriate icon.
//
//----------------------------------------------------------

IconData _getStageIcon(
  String stageId,
) {

  switch (stageId) {

    //--------------------------------------------------------
    // BEGIN
    //--------------------------------------------------------

    case 'begin':

      return Icons
          .play_circle_outline_rounded;


    //--------------------------------------------------------
    // ASANAS
    //--------------------------------------------------------

    case 'asanas_practice':

      return Icons
          .self_improvement_rounded;


    //--------------------------------------------------------
    // MUDRA
    //--------------------------------------------------------

    case 'mudra_practice':

      return Icons
          .pan_tool_rounded;


    //--------------------------------------------------------
    // MEDITATION
    //--------------------------------------------------------

    case 'meditation_practice':

      return Icons
          .psychology_rounded;


    //--------------------------------------------------------
    // RECOVERY
    //--------------------------------------------------------

    case 'recovery':

      return Icons
          .spa_rounded;


    //--------------------------------------------------------
    // DEFAULT
    //--------------------------------------------------------

    default:

      return Icons
          .play_circle_outline_rounded;
  }
}


//==========================================================
// STAGE ACCENT
//==========================================================
//
// Subtle accent variations help differentiate stages while
// keeping the IRAI design language consistent.
//
//----------------------------------------------------------

Color _getStageAccent(
  String stageId,
) {

  switch (stageId) {

    case 'begin':

      return const Color(
        0xFFB17A3A,
      );


    case 'asanas_practice':

      return const Color(
        0xFF2F7D6B,
      );


    case 'mudra_practice':

      return const Color(
        0xFF557A95,
      );


    case 'meditation_practice':

      return const Color(
        0xFF6C63A8,
      );


    case 'recovery':

      return const Color(
        0xFF536B82,
      );


    default:

      return const Color(
        0xFF2F7D6B,
      );
  }
}