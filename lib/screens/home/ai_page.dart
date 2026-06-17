import 'package:flutter/material.dart';

class AiPage extends StatelessWidget {
  const AiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: const Color(0xFFF5F1EA),

      appBar: AppBar(

        backgroundColor: Colors.transparent,
        elevation: 0,

        title: const Text(
          "Yoga AI",
          style: TextStyle(
            color: Color(0xFF2B2927),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            Container(

              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(24),
              ),

              child: const Column(

                children: [

                  Icon(
                    Icons.auto_awesome_rounded,
                    size: 60,
                    color: Color(0xFF2FA7B2),
                  ),

                  SizedBox(height: 16),

                  Text(

                    "Ask Yoga AI",

                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    "Get yoga recommendations, meditation guidance, breathing exercises and wellness advice.",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            TextField(

              decoration: InputDecoration(

                hintText:
                    "Ask anything about yoga...",

                filled: true,

                fillColor: Colors.white,

                border:
                    OutlineInputBorder(

                  borderRadius:
                      BorderRadius.circular(20),

                  borderSide:
                      BorderSide.none,
                ),

                suffixIcon: IconButton(

                  onPressed: () {},

                  icon: const Icon(
                    Icons.send_rounded,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}