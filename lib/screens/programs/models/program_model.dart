//----------------------------------------------------------
// PROGRAM MODEL
//----------------------------------------------------------
//
// PURPOSE:
// This model represents one main Program in the IRAI
// Wellness Library.
//
// PROGRAMS ARE THE COMPLETE WELLNESS LIBRARY.
//
// Current Programs:
// 1. Siddha Guide
// 2. Asanas
// 3. Mudra
// 4. Meditation
// 5. Food
// 6. Body Care
// 7. Living Practices
// 8. Recovery
//
// IMPORTANT:
// The Program structure is common for all users.
//
// The CONTENT inside each Program will later be
// personalized according to the user's personalized
// recommendations.
//
// Example:
//
// Asanas
//     ↓
// Personalized Asanas Content
//
// User A and User B can have different content while
// using the same Asanas Program structure.
//
//----------------------------------------------------------


//==========================================================
// PROGRAM MODEL
//==========================================================

class ProgramModel {

  //----------------------------------------------------------
  // BASIC INFORMATION
  //----------------------------------------------------------
  //
  // id:
  // Unique identifier for this Program.
  //
  // title:
  // Name shown to the user.
  //
  // subtitle:
  // Short explanation shown below the title.
  //
  // icon:
  // Icon identifier used by the UI.
  //
  // image:
  // Image used for the Program card.
  //----------------------------------------------------------

  final String id;

  final String title;

  final String subtitle;

  final String icon;

  final String image;


  //----------------------------------------------------------
  // CONSTRUCTOR
  //----------------------------------------------------------
  //
  // All basic Program information is required.
  //----------------------------------------------------------

  const ProgramModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.image,
  });


  //----------------------------------------------------------
  // COPY WITH
  //----------------------------------------------------------
  //
  // Creates a new ProgramModel while allowing selected
  // values to be changed.
  //
  // This will be useful later when personalized data
  // modifies a Program.
  //----------------------------------------------------------

  ProgramModel copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? icon,
    String? image,
  }) {
    return ProgramModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      icon: icon ?? this.icon,
      image: image ?? this.image,
    );
  }
}