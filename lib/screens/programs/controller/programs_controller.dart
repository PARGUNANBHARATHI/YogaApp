//----------------------------------------------------------
// PROGRAMS CONTROLLER
//----------------------------------------------------------
//
// PURPOSE:
// This controller manages the Programs module.
//
// The Programs Page should only be responsible for UI.
// The controller is responsible for providing program data.
//
// IMPORTANT IRAI ARCHITECTURE:
//
// Programs
//     ↓
// Programs Controller
//     ↓
// Programs Page
//
// Later:
//
// User Personalization
//     ↓
// Personalization Engine
//     ↓
// Programs Controller
//     ↓
// Personalized Programs
//
//----------------------------------------------------------


//----------------------------------------------------------
// IMPORTS
//----------------------------------------------------------

import '../models/program_model.dart';


//==========================================================
// PROGRAMS CONTROLLER
//==========================================================

class ProgramsController {

  //----------------------------------------------------------
  // PROGRAM LIST
  //----------------------------------------------------------
  //
  // This list contains the main IRAI Wellness Programs.
  //
  // IMPORTANT:
  //
  // These 8 Programs are common for all users.
  //
  // The structure does NOT change.
  //
  // The content inside each Program will be personalized
  // later.
  //
  // Current Programs:
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

  final List<ProgramModel> _programs = const [

    //--------------------------------------------------------
    // 1. SIDDHA GUIDE
    //--------------------------------------------------------

    ProgramModel(
      id: 'siddha_guide',
      title: 'Siddha Guide',
      subtitle: 'Personalized Siddha-inspired guidance',
      icon: 'book',
      image: '',
    ),

    //--------------------------------------------------------
    // 2. ASANAS
    //--------------------------------------------------------

    ProgramModel(
      id: 'asanas',
      title: 'Asanas',
      subtitle: 'Personalized movement and asana practice',
      icon: 'self_improvement',
      image: '',
    ),

    //--------------------------------------------------------
    // 3. MUDRA
    //--------------------------------------------------------

    ProgramModel(
      id: 'mudra',
      title: 'Mudra',
      subtitle: 'Personalized mudra practices',
      icon: 'pan_tool',
      image: '',
    ),

    //--------------------------------------------------------
    // 4. MEDITATION
    //--------------------------------------------------------

    ProgramModel(
      id: 'meditation',
      title: 'Meditation',
      subtitle: 'Personalized meditation practices',
      icon: 'psychology',
      image: '',
    ),

    //--------------------------------------------------------
    // 5. FOOD
    //--------------------------------------------------------

    ProgramModel(
      id: 'food',
      title: 'Food',
      subtitle: 'Personalized food and nutrition guidance',
      icon: 'restaurant',
      image: '',
    ),

    //--------------------------------------------------------
    // 6. BODY CARE
    //--------------------------------------------------------

    ProgramModel(
      id: 'body_care',
      title: 'Body Care',
      subtitle: 'Personalized daily body care practices',
      icon: 'spa',
      image: '',
    ),

    //--------------------------------------------------------
    // 7. LIVING PRACTICES
    //--------------------------------------------------------

    ProgramModel(
      id: 'living_practices',
      title: 'Living Practices',
      subtitle: 'Personalized everyday wellness practices',
      icon: 'wb_sunny',
      image: '',
    ),

    //--------------------------------------------------------
    // 8. RECOVERY
    //--------------------------------------------------------

    ProgramModel(
      id: 'recovery',
      title: 'Recovery',
      subtitle: 'Personalized rest and recovery practices',
      icon: 'bedtime',
      image: '',
    ),
  ];


  //----------------------------------------------------------
  // GET ALL PROGRAMS
  //----------------------------------------------------------
  //
  // Returns the complete IRAI Programs library.
  //
  // At this stage, every user receives the same 8 program
  // categories.
  //
  // Later, the content inside these programs will be
  // personalized.
  //
  //----------------------------------------------------------

  List<ProgramModel> getPrograms() {

    return List.unmodifiable(_programs);
  }


  //----------------------------------------------------------
  // GET PROGRAM BY ID
  //----------------------------------------------------------
  //
  // Finds one specific Program using its unique ID.
  //
  // Example:
  //
  // getProgramById('asanas')
  //
  // returns the Asanas Program.
  //
  //----------------------------------------------------------

  ProgramModel? getProgramById(
    String programId,
  ) {

    for (final program in _programs) {

      if (program.id == programId) {
        return program;
      }
    }

    return null;
  }


  //----------------------------------------------------------
  // GET PROGRAM COUNT
  //----------------------------------------------------------
  //
  // Returns the number of Programs available.
  //
  // Current value:
  // 8
  //
  //----------------------------------------------------------

  int get programCount {

    return _programs.length;
  }


  //----------------------------------------------------------
  // CHECK PROGRAM EXISTS
  //----------------------------------------------------------
  //
  // Checks whether a Program exists using its ID.
  //
  // Example:
  //
  // hasProgram('asanas')
  //
  // returns true.
  //
  //----------------------------------------------------------

  bool hasProgram(
    String programId,
  ) {

    return _programs.any(
      (program) => program.id == programId,
    );
  }
}