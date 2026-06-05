import 'package:flutter/material.dart';

import 'home_page.dart';
import './widgets/programs_page.dart';
import './widgets/shorts_page.dart';
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() =>
      _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int currentIndex = 0;

  final pages = const [

    HomePage(),

    ProgramsPage(),

     ShortsPage(),

    Center(
      child: Text("Profile"),
    ),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: IndexedStack(

        index: currentIndex,

        children: pages,
      ),

      bottomNavigationBar:
          BottomNavigationBar(

        currentIndex: currentIndex,

        onTap: (index) {

          setState(() {

            currentIndex = index;
          });
        },

        selectedItemColor:
            const Color(0xFF2FA7B2),

        type:
            BottomNavigationBarType.fixed,

        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_rounded),
            label: "Programs",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_rounded),
            label: "Shorts",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}