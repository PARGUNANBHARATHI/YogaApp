import 'package:flutter/material.dart';

import '../today/today_page.dart';
import '../programs/pages/programs_page.dart';
import '../irai/pages/irai_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  //----------------------------------------------------------
  // CURRENT PAGE
  //----------------------------------------------------------

  int currentIndex = 0;

  //----------------------------------------------------------
  // PAGES
  //----------------------------------------------------------

  final List<Widget> pages = const [
    TodayPage(),
    IraiPage(),
    ProgramsPage(),
  ];

  //----------------------------------------------------------
  // NORMAL NAVIGATION ITEM
  //----------------------------------------------------------

  Widget navItem(
    IconData icon,
    String label,
    int index,
  ) {
    final isSelected = currentIndex == index;

    return InkWell(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },

      borderRadius: BorderRadius.circular(16),

      child: SizedBox(
        width: 70,
        height: 65,

        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [

            Icon(
              icon,
              size: 23,

              color: isSelected
                  ? const Color(0xFF2FA7B2)
                  : Colors.grey,
            ),

            const SizedBox(height: 4),

            Text(
              label,

              style: TextStyle(
                fontSize: 11,

                fontWeight:
                    FontWeight.w600,

                color: isSelected
                    ? const Color(0xFF2FA7B2)
                    : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  //----------------------------------------------------------
  // IRAI CENTER BUTTON
  //----------------------------------------------------------

  Widget iraiNavItem() {

    final isSelected =
        currentIndex == 1;

    return InkWell(
      onTap: () {
        setState(() {
          currentIndex = 1;
        });
      },

      borderRadius:
          BorderRadius.circular(40),

      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,

        children: [

          AnimatedContainer(
            duration:
                const Duration(
              milliseconds: 220,
            ),

            width: isSelected
                ? 56
                : 52,

            height: isSelected
                ? 56
                : 52,

            decoration: BoxDecoration(
              gradient:
                  const LinearGradient(
                begin:
                    Alignment.topLeft,

                end:
                    Alignment.bottomRight,

                colors: [
                  Color(0xFF2FA7B2),
                  Color(0xFF65C7C1),
                ],
              ),

              shape: BoxShape.circle,

              boxShadow: [
                BoxShadow(
                  color:
                      const Color(
                    0xFF2FA7B2,
                  ).withValues(
                    alpha: .28,
                  ),

                  blurRadius: 16,

                  offset:
                      const Offset(0, 6),
                ),
              ],
            ),

            child: const Icon(
              Icons.auto_awesome_rounded,

              color: Colors.white,

              size: 25,
            ),
          ),

          const SizedBox(height: 2),

          Text(
            "IRAI",

            style: TextStyle(
              fontSize: 11,

              fontWeight:
                  FontWeight.w700,

              color: isSelected
                  ? const Color(
                      0xFF2FA7B2,
                    )
                  : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  //----------------------------------------------------------
  // BUILD
  //----------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      extendBody: true,

      //--------------------------------------------------------
      // CURRENT PAGE
      //--------------------------------------------------------

      body: IndexedStack(
        index: currentIndex,

        children: pages,
      ),

      //--------------------------------------------------------
      // BOTTOM NAVIGATION
      //--------------------------------------------------------

      bottomNavigationBar:
          Container(

        height: 76,

        margin:
            const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 16,
        ),

        decoration:
            BoxDecoration(

          color: Colors.white,

          borderRadius:
              BorderRadius.circular(
            28,
          ),

          boxShadow: [
            BoxShadow(
              color:
                  Colors.black.withValues(
                alpha: .08,
              ),

              blurRadius: 20,

              offset:
                  const Offset(0, 5),
            ),
          ],
        ),

        child: Row(

          mainAxisAlignment:
              MainAxisAlignment.spaceAround,

          children: [

            //------------------------------------------------
            // TODAY
            //------------------------------------------------

            navItem(
              Icons.calendar_today_rounded,
              "Today",
              0,
            ),

            //------------------------------------------------
            // IRAI
            //------------------------------------------------

            iraiNavItem(),

            //------------------------------------------------
            // PROGRAMS
            //------------------------------------------------

            navItem(
              Icons.dashboard_rounded,
              "Programs",
              2,
            ),
          ],
        ),
      ),
    );
  }
}