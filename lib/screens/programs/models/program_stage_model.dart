//----------------------------------------------------------
// PROGRAM STAGE MODEL
//----------------------------------------------------------
//
// PURPOSE:
// This model represents a Stage inside a Program.
//
// A Program can contain one or more stages.
//
// Example:
//
// ASANAS
//     ↓
// Begin
// Asanas Practice
// Recovery
//
// MUDRA
//     ↓
// Begin
// Mudra Practice
// Recovery
//
// MEDITATION
//     ↓
// Begin
// Meditation Practice
// Recovery
//
// IMPORTANT:
// The stage structure is common.
// The content/videos inside the stage are personalized.
//
//----------------------------------------------------------


//==========================================================
// PROGRAM STAGE MODEL
//==========================================================

class ProgramStageModel {

  //----------------------------------------------------------
  // BASIC INFORMATION
  //----------------------------------------------------------

  // Unique ID of this stage.
  final String id;

  // ID of the Program this stage belongs to.
  //
  // Example:
  // "asanas"
  //
  final String programId;

  // Stage name displayed to the user.
  //
  // Example:
  // "Begin"
  //
  final String title;

  // Short explanation of the stage.
  final String subtitle;

  // Icon identifier used by the UI.
  final String icon;


  //----------------------------------------------------------
  // CONSTRUCTOR
  //----------------------------------------------------------

  const ProgramStageModel({
    required this.id,
    required this.programId,
    required this.title,
    required this.subtitle,
    required this.icon,
  });


  //----------------------------------------------------------
  // COPY WITH
  //----------------------------------------------------------
  //
  // Creates a modified copy of the current stage.
  //----------------------------------------------------------

  ProgramStageModel copyWith({
    String? id,
    String? programId,
    String? title,
    String? subtitle,
    String? icon,
  }) {
    return ProgramStageModel(
      id: id ?? this.id,
      programId: programId ?? this.programId,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      icon: icon ?? this.icon,
    );
  }
}