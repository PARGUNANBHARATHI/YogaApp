import 'package:flutter/material.dart';

import '../controller/wake_time_controller.dart';

class WakeTimePage extends StatefulWidget {
  const WakeTimePage({super.key});

  @override
  State<WakeTimePage> createState() => _WakeTimePageState();
}

class _WakeTimePageState extends State<WakeTimePage> {

  final WakeTimeController controller =
      WakeTimeController();

  TimeOfDay selectedTime = const TimeOfDay(
    hour: 6,
    minute: 0,
  );

  @override
  void initState() {
    super.initState();
    _loadWakeTime();
  }

  Future<void> _loadWakeTime() async {
    final time = await controller.getTimeOfDay();

    if (!mounted) return;

    setState(() {
      selectedTime = time;
    });
  }

  Future<void> _pickTime() async {
    final result = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (result != null) {
      setState(() {
        selectedTime = result;
      });
    }
  }

  String get formattedTime {
    final hour =
        selectedTime.hourOfPeriod == 0
            ? 12
            : selectedTime.hourOfPeriod;

    final minute =
        selectedTime.minute.toString().padLeft(2, '0');

    final period =
        selectedTime.period == DayPeriod.am
            ? "AM"
            : "PM";

    return "$hour:$minute $period";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F3),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Wake Time",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme:
            const IconThemeData(
          color: Colors.black,
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),

        child: Column(
          children: [

            const SizedBox(height: 20),

            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                color: const Color(0xFFE8F8F7),
                borderRadius:
                    BorderRadius.circular(28),
              ),
              child: const Icon(
                Icons.wb_sunny_rounded,
                size: 56,
                color: Color(0xFF2FA7B2),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "What time do you usually wake up?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              "IRAI will personalize your morning rhythm based on this time.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 50),

            InkWell(
              onTap: _pickTime,
              borderRadius:
                  BorderRadius.circular(24),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 22,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          .withValues(alpha: .05),
                      blurRadius: 18,
                    ),
                  ],
                ),
                child: Text(
                  formattedTime,
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight:
                        FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton(
                onPressed: () async {

                  await controller.saveWakeTime(
                    selectedTime,
                  );

                  if (!mounted) return;

                  Navigator.pop(context, true);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF2FA7B2),
                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                      18,
                    ),
                  ),
                ),
                child: const Text(
                  "Save Wake Time",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}