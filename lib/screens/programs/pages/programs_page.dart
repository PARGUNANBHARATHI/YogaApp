//----------------------------------------------------------
// IRAI PROGRAMS PAGE
//----------------------------------------------------------
//
// PURPOSE:
//
// Programs is the COMPLETE WELLNESS LIBRARY of IRAI.
//
// The page provides access to:
//
// 1. Siddha Guide
// 2. Asanas
// 3. Mudra
// 4. Meditation
// 5. Food
// 6. Body Care
// 7. Living Practices
// 8. Recovery
//
//----------------------------------------------------------
//
// IMPORTANT ARCHITECTURE:
//
// The PROGRAM TEMPLATE is common.
//
// The CONTENT inside every Program is personalized.
//
//
//                    PROGRAMS
//                        ↓
//                  Program Category
//                        ↓
//                  Program Details
//                        ↓
//                     Stages
//                        ↓
//              Personalized Content
//
//
// Example:
//
// Asanas
//    ↓
// Begin
// Asanas Practice
// Recovery
//    ↓
// User-specific videos/content
//
//----------------------------------------------------------
//
// DESIGN PHILOSOPHY:
//
// This page should feel like:
//
// • Premium
// • Calm
// • Modern
// • Siddha-inspired without looking old-fashioned
// • Clean
// • Spacious
// • Personalized
//
// It should NOT look like a generic 8-button menu.
//
//----------------------------------------------------------


//==========================================================
// IMPORTS
//==========================================================

import 'package:flutter/material.dart';

import '../controller/programs_controller.dart';
import '../models/program_model.dart';
import 'program_details_page.dart';


//==========================================================
// PROGRAMS PAGE
//==========================================================

class ProgramsPage extends StatefulWidget {

  const ProgramsPage({
    super.key,
  });

  @override
  State<ProgramsPage> createState() =>
      _ProgramsPageState();
}


//==========================================================
// PAGE STATE
//==========================================================

class _ProgramsPageState
    extends State<ProgramsPage> {

  //----------------------------------------------------------
  // CONTROLLER
  //----------------------------------------------------------
  //
  // The controller remains the single source for Program
  // information.
  //
  //----------------------------------------------------------

  final ProgramsController controller =
      ProgramsController();


  //----------------------------------------------------------
  // BUILD
  //----------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    //--------------------------------------------------------
    // GET PROGRAMS
    //--------------------------------------------------------

    final List<ProgramModel> programs =
        controller.getPrograms();


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
            // TOP HEADER
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

                child: _ProgramsHeader(
                  programCount:
                      programs.length,
                ),
              ),
            ),


            //------------------------------------------------
            // HERO LIBRARY CARD
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
                    const _LibraryHeroCard(),
              ),
            ),


            //------------------------------------------------
            // SECTION TITLE
            //------------------------------------------------

            SliverToBoxAdapter(

              child: Padding(

                padding:
                    const EdgeInsets.fromLTRB(
                  20,
                  32,
                  20,
                  14,
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

                            'Explore',

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
                            height: 4,
                          ),

                          Text(

                            'Your wellness practices',

                            style:
                                TextStyle(

                              fontSize: 13.5,

                              color:
                                  Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),


                    //------------------------------------------------
                    // PROGRAM COUNT
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

                        '${programs.length} paths',

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
            // PROGRAM GRID
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
                  SliverLayoutBuilder(

                builder:
                    (context, constraints) {

                  //------------------------------------------------
                  // RESPONSIVE GRID
                  //------------------------------------------------
                  //
                  // Desktop / wide screen:
                  // 3 columns
                  //
                  // Mobile:
                  // 2 columns
                  //
                  //------------------------------------------------

                  final int columns =
                      constraints.crossAxisExtent >= 850
                          ? 3
                          : 2;


                  return SliverGrid(

                    gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(

                      crossAxisCount:
                          columns,

                      crossAxisSpacing:
                          14,

                      mainAxisSpacing:
                          14,

                      childAspectRatio:
                          columns == 3
                              ? 1.12
                              : 0.94,
                    ),

                    //------------------------------------------------
                    // PROGRAM CARDS
                    //------------------------------------------------

                    delegate:
                        SliverChildBuilderDelegate(

                      (context, index) {

                        //------------------------------------------------
                        // CURRENT PROGRAM
                        //------------------------------------------------

                        final ProgramModel program =
                            programs[index];


                        //------------------------------------------------
                        // PROGRAM CARD
                        //------------------------------------------------

                        return _ProgramCard(

                          program:
                              program,

                          index:
                              index,

                          onTap: () {

                            //------------------------------------------------
                            // OPEN PROGRAM DETAILS
                            //------------------------------------------------
                            //
                            // The same details template is reused
                            // for every Program.
                            //
                            //------------------------------------------------

                            Navigator.push(

                              context,

                              MaterialPageRoute(

                                builder:
                                    (context) {

                                  return ProgramDetailsPage(
                                    program:
                                        program,
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },

                      childCount:
                          programs.length,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


//==========================================================
// PROGRAMS HEADER
//==========================================================
//
// PURPOSE:
//
// Main page identity.
//
// Kept simple and premium instead of using a large
// conventional app-bar.
//
//----------------------------------------------------------

class _ProgramsHeader
    extends StatelessWidget {

  final int programCount;


  const _ProgramsHeader({
    required this.programCount,
  });


  @override
  Widget build(BuildContext context) {

    return Row(

      crossAxisAlignment:
          CrossAxisAlignment.center,

      children: [

        //----------------------------------------------------
        // TITLE AREA
        //----------------------------------------------------

        const Expanded(

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              Text(

                'Programs',

                style:
                    TextStyle(

                  fontSize: 31,

                  fontWeight:
                      FontWeight.w800,

                  letterSpacing:
                      -0.9,
                ),
              ),

              SizedBox(
                height: 6,
              ),

              Text(

                'Your complete wellness library',

                style:
                    TextStyle(

                  fontSize: 14,

                  color:
                      Colors.black54,

                  height: 1.35,
                ),
              ),
            ],
          ),
        ),


        //----------------------------------------------------
        // LIBRARY ICON
        //----------------------------------------------------

        Container(

          width: 48,

          height: 48,

          decoration:
              BoxDecoration(

            color:
                Colors.white,

            borderRadius:
                BorderRadius.circular(
              17,
            ),

            boxShadow: [

              BoxShadow(

                color:
                    Colors.black.withValues(
                  alpha: .035,
                ),

                blurRadius: 14,

                offset:
                    const Offset(0, 6),
              ),
            ],
          ),

          child: const Icon(

            Icons.auto_awesome_rounded,

            size: 22,

            color:
                Color(0xFF2F7D6B),
          ),
        ),
      ],
    );
  }
}


//==========================================================
// LIBRARY HERO CARD
//==========================================================
//
// PURPOSE:
//
// Gives Programs its own identity.
//
// This is NOT another Program.
//
// It simply communicates:
//
// "This is your complete wellness library."
//
//----------------------------------------------------------

class _LibraryHeroCard
    extends StatelessWidget {

  const _LibraryHeroCard();


  @override
  Widget build(BuildContext context) {

    return Container(

      padding:
          const EdgeInsets.all(22),

      decoration:
          BoxDecoration(

        color:
            const Color(0xFFE6F2ED),

        borderRadius:
            BorderRadius.circular(
          28,
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

          //------------------------------------------------
          // DECORATIVE CIRCLE
          //------------------------------------------------

          Positioned(

            right: -22,

            top: -35,

            child: Container(

              width: 125,

              height: 125,

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


          //------------------------------------------------
          // CONTENT
          //------------------------------------------------

          Column(

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              //------------------------------------------------
              // LABEL
              //------------------------------------------------

              Container(

                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),

                decoration:
                    BoxDecoration(

                  color:
                      Colors.white.withValues(
                    alpha: .7,
                  ),

                  borderRadius:
                      BorderRadius.circular(
                    20,
                  ),
                ),

                child: const Row(

                  mainAxisSize:
                      MainAxisSize.min,

                  children: [

                    Icon(

                      Icons.auto_awesome_rounded,

                      size: 13,

                      color:
                          Color(0xFF2F7D6B),
                    ),

                    SizedBox(
                      width: 5,
                    ),

                    Text(

                      'PERSONALIZED LIBRARY',

                      style:
                          TextStyle(

                        fontSize: 10,

                        fontWeight:
                            FontWeight.w800,

                        letterSpacing:
                            .7,

                        color:
                            Color(0xFF2F7D6B),
                      ),
                    ),
                  ],
                ),
              ),


              const SizedBox(
                height: 16,
              ),


              //------------------------------------------------
              // MAIN TEXT
              //------------------------------------------------

              const Text(

                'A wellness library\nthat adapts to you.',

                style:
                    TextStyle(

                  fontSize: 23,

                  fontWeight:
                      FontWeight.w800,

                  height: 1.15,

                  letterSpacing:
                      -0.5,
                ),
              ),


              const SizedBox(
                height: 10,
              ),


              //------------------------------------------------
              // DESCRIPTION
              //------------------------------------------------

              const Text(

                'Explore practices for movement, stillness, nourishment, living and recovery.',

                style:
                    TextStyle(

                  fontSize: 13,

                  color:
                      Colors.black54,

                  height: 1.45,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


//==========================================================
// PROGRAM CARD
//==========================================================
//
// PURPOSE:
//
// Premium reusable Program card.
//
// IMPORTANT:
//
// The card itself is NOT personalized.
//
// The CONTENT inside the selected Program will be
// personalized later.
//
//----------------------------------------------------------

class _ProgramCard
    extends StatelessWidget {

  //----------------------------------------------------------
  // DATA
  //----------------------------------------------------------

  final ProgramModel program;

  final int index;

  final VoidCallback onTap;


  //----------------------------------------------------------
  // CONSTRUCTOR
  //----------------------------------------------------------

  const _ProgramCard({

    required this.program,

    required this.index,

    required this.onTap,
  });


  //----------------------------------------------------------
  // BUILD
  //----------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    //--------------------------------------------------------
    // PROGRAM COLOR
    //--------------------------------------------------------
    //
    // Very subtle variation prevents the page from feeling
    // like eight identical white boxes.
    //
    //--------------------------------------------------------

    final Color accent =
        _getProgramAccent(
      program.id,
    );


    return Material(

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

                blurRadius: 18,

                offset:
                    const Offset(0, 8),
              ),
            ],
          ),

          child: Padding(

            padding:
                const EdgeInsets.all(
              17,
            ),

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                //------------------------------------------------
                // TOP ROW
                //------------------------------------------------

                Row(

                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                  children: [

                    //------------------------------------------------
                    // ICON
                    //------------------------------------------------

                    Container(

                      width: 52,

                      height: 52,

                      decoration:
                          BoxDecoration(

                        color:
                            accent.withValues(
                          alpha: .10,
                        ),

                        borderRadius:
                            BorderRadius.circular(
                          17,
                        ),
                      ),

                      child: Icon(

                        _getProgramIcon(
                          program.id,
                        ),

                        size: 27,

                        color:
                            accent,
                      ),
                    ),


                    //------------------------------------------------
                    // SMALL ARROW
                    //------------------------------------------------

                    Container(

                      width: 31,

                      height: 31,

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

                        size: 17,

                        color:
                            Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),


                //------------------------------------------------
                // FLEXIBLE SPACE
                //------------------------------------------------

                const Spacer(),


                //------------------------------------------------
                // PROGRAM NUMBER
                //------------------------------------------------

                Text(

                  '${(index + 1).toString().padLeft(2, '0')}',

                  style:
                      TextStyle(

                    fontSize: 10,

                    fontWeight:
                        FontWeight.w800,

                    letterSpacing:
                        1.2,

                    color:
                        accent,
                  ),
                ),


                const SizedBox(
                  height: 6,
                ),


                //------------------------------------------------
                // TITLE
                //------------------------------------------------

                Text(

                  program.title,

                  maxLines: 1,

                  overflow:
                      TextOverflow.ellipsis,

                  style:
                      const TextStyle(

                    fontSize: 18,

                    fontWeight:
                        FontWeight.w800,

                    letterSpacing:
                        -0.3,
                  ),
                ),


                const SizedBox(
                  height: 5,
                ),


                //------------------------------------------------
                // SUBTITLE
                //------------------------------------------------

                Text(

                  program.subtitle,

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
        ),
      ),
    );
  }
}


//==========================================================
// PROGRAM ICON
//==========================================================
//
// PURPOSE:
//
// Central mapping between Program ID and icon.
//
//----------------------------------------------------------

IconData _getProgramIcon(
  String programId,
) {

  switch (programId) {

    //--------------------------------------------------------
    // SIDDHA GUIDE
    //--------------------------------------------------------

    case 'siddha_guide':
      return Icons.menu_book_rounded;


    //--------------------------------------------------------
    // ASANAS
    //--------------------------------------------------------

    case 'asanas':
      return Icons.self_improvement_rounded;


    //--------------------------------------------------------
    // MUDRA
    //--------------------------------------------------------

    case 'mudra':
      return Icons.pan_tool_rounded;


    //--------------------------------------------------------
    // MEDITATION
    //--------------------------------------------------------

    case 'meditation':
      return Icons.psychology_rounded;


    //--------------------------------------------------------
    // FOOD
    //--------------------------------------------------------

    case 'food':
      return Icons.restaurant_rounded;


    //--------------------------------------------------------
    // BODY CARE
    //--------------------------------------------------------

    case 'body_care':
      return Icons.spa_rounded;


    //--------------------------------------------------------
    // LIVING PRACTICES
    //--------------------------------------------------------

    case 'living_practices':
      return Icons.wb_sunny_rounded;


    //--------------------------------------------------------
    // RECOVERY
    //--------------------------------------------------------

    case 'recovery':
      return Icons.bedtime_rounded;


    //--------------------------------------------------------
    // DEFAULT
    //--------------------------------------------------------

    default:
      return Icons.apps_rounded;
  }
}


//==========================================================
// PROGRAM ACCENT
//==========================================================
//
// PURPOSE:
//
// Gives each category a subtle identity while maintaining
// the overall IRAI visual language.
//
// We intentionally keep the colors soft.
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