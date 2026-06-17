import 'package:flutter/material.dart';

import 'home_page.dart';
import 'widgets/programs_page.dart';
import 'shorts_page.dart';
import 'ai_page.dart';


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int currentIndex = 0;

  final pages = const [

    HomePage(),

    ProgramsPage(),

    AiPage(),

    ShortsPage(),

    Center(
      child: Text("Profile"),
    ),
  ];

  Widget navItem(
    IconData icon,
    String label,
    int index,
  ) {

    final isSelected =
        currentIndex == index;

    return InkWell(

      onTap: () {

        setState(() {

          currentIndex = index;
        });
      },

      borderRadius:
          BorderRadius.circular(16),

      child: Column(

        mainAxisAlignment:
            MainAxisAlignment.center,

        children: [

          Icon(

            icon,

            size: 24,

            color: isSelected
                ? const Color(0xFF2FA7B2)
                : Colors.grey,
          ),

          const SizedBox(height: 4),

          Text(

            label,

            style: TextStyle(

              fontSize: 12,

              fontWeight:
                  FontWeight.w600,

              color: isSelected
                  ? const Color(0xFF2FA7B2)
                  : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      extendBody: true,

      body: IndexedStack(

        index: currentIndex,

        children: pages,
      ),

      // ================= AI FLOATING BUTTON =================

      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,

      floatingActionButton: Transform.translate(

        offset: const Offset(0, 0),

        child: Container(

          height: 62,
          width: 72,

          decoration: BoxDecoration(

            shape: BoxShape.circle,

            gradient: const LinearGradient(

              colors: [

                Color(0xFF2FA7B2),
                Color(0xFF58C4C9),
              ],
            ),

            boxShadow: [

              BoxShadow(

                color: const Color(
                  0xFF2FA7B2,
                ).withValues(
                  alpha: 0.35,
                ),

                blurRadius: 25,

                spreadRadius: 2,

                offset: const Offset(
                  0,
                  8,
                ),
              ),
            ],
          ),

          child: FloatingActionButton(

            heroTag: "ai",

            backgroundColor:
                Colors.transparent,

            elevation: 0,

            onPressed: () {

              setState(() {

                currentIndex = 2;
              });
            },

            child: const Icon(

              Icons.auto_awesome_rounded,

              size: 34,

              color: Colors.white,
            ),
          ),
        ),
      ),

      // ================= NAVIGATION =================

      bottomNavigationBar: Container(

        height: 78,

        margin: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 16,
        ),

        decoration: BoxDecoration(

          color: Colors.white,

          borderRadius:
              BorderRadius.circular(
            28,
          ),

          boxShadow: [

            BoxShadow(

              color:
                  Colors.black.withValues(
                alpha: 0.08,
              ),

              blurRadius: 20,

              offset: const Offset(
                0,
                5,
              ),
            ),
          ],
        ),

        child: Row(

          mainAxisAlignment:
              MainAxisAlignment.spaceAround,

          children: [

            navItem(
              Icons.home_rounded,
              "Home",
              0,
            ),

            navItem(
              Icons.dashboard_rounded,
              "Programs",
              1,
            ),

            const SizedBox(width: 80),

            navItem(
              Icons.play_circle_fill_rounded,
              "Shorts",
              3,
            ),

            navItem(
              Icons.person_rounded,
              "Profile",
              4,
            ),
          ],
        ),
      ),
    );
  }
}