//----------------------------------------------------------
// IRAI USER PROFILE MODEL
//----------------------------------------------------------
//
// M4.1 — USER UNDERSTANDING
//
// PURPOSE
// ---------------------------------------------------------
// Represents the stable information IRAI knows about the
// user.
//
// This model is the foundation for the future IRAI
// personalization system.
//
// IMPORTANT
// ---------------------------------------------------------
// This model should contain USER-PROVIDED profile information.
//
// It should NOT contain:
//
// • AI assumptions
// • Body constitution conclusions
// • Mind pattern conclusions
// • Behavioral observations
// • Recommendations
//
// Those belong to separate M4 models.
//
//----------------------------------------------------------
//
// ARCHITECTURE
// ---------------------------------------------------------
//
// User
//   ↓
// User Profile
//   ↓
// Understanding Engine
//   ↓
// Personalization
//
// FUTURE
// ---------------------------------------------------------
// The profile will eventually be stored in Firebase.
//
// Current:
//
// Flutter
//   ↓
// Local Model
//
// Future:
//
// Flutter
//   ↓
// Repository
//   ↓
// Firebase
//
//----------------------------------------------------------


//==========================================================
// USER PROFILE MODEL
//==========================================================

class UserProfileModel {

  //----------------------------------------------------------
  // USER IDENTIFICATION
  //----------------------------------------------------------
  //
  // Unique identifier for the user.
  //
  // Current:
  // Can be a local ID.
  //
  // Future:
  // Firebase Authentication / Firebase user ID.
  //
  //----------------------------------------------------------

  final String userId;


  //----------------------------------------------------------
  // BASIC INFORMATION
  //----------------------------------------------------------

  /// User's display name.
  final String? name;


  /// User's age.
  ///
  /// Optional because the user may not provide it initially.
  final int? age;


  //----------------------------------------------------------
  // WAKE TIME
  //----------------------------------------------------------
  //
  // Wake time is already used by the Today Schedule Engine.
  //
  // We keep the profile representation simple here.
  //
  // Example:
  //
  // "06:00"
  //
  // The existing WakeTimeController remains responsible
  // for managing the actual wake-time selection.
  //
  //----------------------------------------------------------

  final int? wakeHour;

  final int? wakeMinute;


  //----------------------------------------------------------
  // GOALS
  //----------------------------------------------------------
  //
  // User-selected wellness goals.
  //
  // Examples:
  //
  // • Better energy
  // • Better sleep
  // • Stress management
  // • Fitness
  //
  // These are IDs rather than hard-coded objects.
  //
  //----------------------------------------------------------

  final List<String> goalIds;


  //----------------------------------------------------------
  // PREFERENCES
  //----------------------------------------------------------
  //
  // User preferences.
  //
  // Examples:
  //
  // • Short practices
  // • Morning practice
  // • Voice interaction
  //
  // These will later connect to UserPreferenceModel.
  //
  //----------------------------------------------------------

  final List<String> preferenceIds;


  //----------------------------------------------------------
  // CREATED TIME
  //----------------------------------------------------------

  final DateTime createdAt;


  //----------------------------------------------------------
  // UPDATED TIME
  //----------------------------------------------------------

  final DateTime updatedAt;


  //----------------------------------------------------------
  // CONSTRUCTOR
  //----------------------------------------------------------

  const UserProfileModel({

    required this.userId,

    this.name,

    this.age,

    this.wakeHour,

    this.wakeMinute,

    this.goalIds = const [],

    this.preferenceIds = const [],

    required this.createdAt,

    required this.updatedAt,
  });


  //==========================================================
  // HELPERS
  //==========================================================


  //----------------------------------------------------------
  // HAS NAME
  //----------------------------------------------------------

  bool get hasName {

    return name != null &&
        name!.trim().isNotEmpty;
  }


  //----------------------------------------------------------
  // HAS AGE
  //----------------------------------------------------------

  bool get hasAge {

    return age != null;
  }


  //----------------------------------------------------------
  // HAS WAKE TIME
  //----------------------------------------------------------

  bool get hasWakeTime {

    return wakeHour != null &&
        wakeMinute != null;
  }


  //----------------------------------------------------------
  // WAKE TIME IN MINUTES
  //----------------------------------------------------------
  //
  // Useful for connecting the profile with the existing
  // Today Schedule Engine later.
  //
  //----------------------------------------------------------

  int? get wakeTimeInMinutes {

    if (!hasWakeTime) {
      return null;
    }

    return wakeHour! * 60 +
        wakeMinute!;
  }


  //----------------------------------------------------------
  // HAS GOALS
  //----------------------------------------------------------

  bool get hasGoals {

    return goalIds.isNotEmpty;
  }


  //----------------------------------------------------------
  // HAS PREFERENCES
  //----------------------------------------------------------

  bool get hasPreferences {

    return preferenceIds.isNotEmpty;
  }
}