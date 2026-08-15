//----------------------------------------------------------
// CONTENT CONTROLLER
//----------------------------------------------------------
//
// PURPOSE:
// This controller manages the actual content inside
// each Program Stage.
//
// CURRENT PURPOSE:
// We are using SAMPLE CONTENT only to test the UI and
// navigation.
//
// LATER:
// This local sample content will be replaced by the
// centralized personalized content system.
//
//----------------------------------------------------------
//
// IRAI CONTENT FLOW:
//
// Program
//    ↓
// Stage
//    ↓
// Personalized Content
//    ↓
// Video / Guide / Audio / etc.
//
// Example:
//
// Asanas
//    ↓
// Asanas Practice
//    ↓
// Personalized Asana Videos
//
//----------------------------------------------------------


//----------------------------------------------------------
// IMPORTS
//----------------------------------------------------------

import '../models/content_model.dart';


//==========================================================
// CONTENT CONTROLLER
//==========================================================

class ContentController {

  //----------------------------------------------------------
  // SAMPLE CONTENT
  //----------------------------------------------------------
  //
  // IMPORTANT:
  //
  // These are NOT final IRAI recommendations.
  //
  // They are only temporary sample items so we can
  // verify that our Programs architecture is working.
  //
  //----------------------------------------------------------

  final List<ContentModel> _content = const [

    //========================================================
    // ASANAS
    // ASANAS PRACTICE
    //========================================================

    ContentModel(
      id: 'asanas_video_01',
      programId: 'asanas',
      stageId: 'asanas_practice',

      title: 'Gentle Morning Asanas',

      subtitle:
          'A calm sequence to begin your practice.',

      type: ContentType.video,

      thumbnail: '',

      mediaUrl:  'https://interactive-examples.mdn.mozilla.net/media/cc0-videos/friday.mp4',

      durationMinutes: 12,
    ),

    ContentModel(
      id: 'asanas_video_02',
      programId: 'asanas',
      stageId: 'asanas_practice',

      title: 'Spinal Mobility Practice',

      subtitle:
          'Gentle movements for comfortable mobility.',

      type: ContentType.video,

      thumbnail: '',

      mediaUrl:  'https://interactive-examples.mdn.mozilla.net/media/cc0-videos/friday.mp4',

      durationMinutes: 15,
    ),

    ContentModel(
      id: 'asanas_video_03',
      programId: 'asanas',
      stageId: 'asanas_practice',

      title: 'Balanced Asana Flow',

      subtitle:
          'A steady practice for your daily routine.',

      type: ContentType.video,

      thumbnail: '',

      mediaUrl: '',

      durationMinutes: 20,
    ),


    //========================================================
    // ASANAS
    // BEGIN
    //========================================================

    ContentModel(
      id: 'asanas_begin_01',
      programId: 'asanas',
      stageId: 'begin',

      title: 'Prepare for Your Practice',

      subtitle:
          'Settle your body and prepare before beginning.',

      type: ContentType.video,

      thumbnail: '',

      mediaUrl: '',

      durationMinutes: 5,
    ),


    //========================================================
    // ASANAS
    // RECOVERY
    //========================================================

    ContentModel(
      id: 'asanas_recovery_01',
      programId: 'asanas',
      stageId: 'recovery',

      title: 'Post Practice Relaxation',

      subtitle:
          'A gentle transition after your asana practice.',

      type: ContentType.video,

      thumbnail: '',

      mediaUrl: '',

      durationMinutes: 7,
    ),


    //========================================================
    // MUDRA
    // MUDRA PRACTICE
    //========================================================

    ContentModel(
      id: 'mudra_video_01',
      programId: 'mudra',
      stageId: 'mudra_practice',

      title: 'Foundational Mudra Practice',

      subtitle:
          'A simple guided mudra session.',

      type: ContentType.video,

      thumbnail: '',

      mediaUrl: '',

      durationMinutes: 8,
    ),

    ContentModel(
      id: 'mudra_video_02',
      programId: 'mudra',
      stageId: 'mudra_practice',

      title: 'Focused Mudra Practice',

      subtitle:
          'A guided practice for a calm routine.',

      type: ContentType.video,

      thumbnail: '',

      mediaUrl: '',

      durationMinutes: 10,
    ),


    //========================================================
    // MEDITATION
    // MEDITATION PRACTICE
    //========================================================

    ContentModel(
      id: 'meditation_video_01',
      programId: 'meditation',
      stageId: 'meditation_practice',

      title: 'Guided Meditation',

      subtitle:
          'A simple guided session for settling the mind.',

      type: ContentType.video,

      thumbnail: '',

      mediaUrl: '',

      durationMinutes: 10,
    ),

    ContentModel(
      id: 'meditation_video_02',
      programId: 'meditation',
      stageId: 'meditation_practice',

      title: 'Quiet Awareness',

      subtitle:
          'A gentle meditation practice for stillness.',

      type: ContentType.video,

      thumbnail: '',

      mediaUrl: '',

      durationMinutes: 15,
    ),
  ];


  //----------------------------------------------------------
  // GET ALL CONTENT
  //----------------------------------------------------------
  //
  // Returns every available content item.
  //
  //----------------------------------------------------------

  List<ContentModel> getAllContent() {

    return List.unmodifiable(
      _content,
    );
  }


  //----------------------------------------------------------
  // GET CONTENT BY PROGRAM
  //----------------------------------------------------------
  //
  // Example:
  //
  // getContentByProgram('asanas')
  //
  // Returns all content belonging to Asanas.
  //
  //----------------------------------------------------------

  List<ContentModel> getContentByProgram(
    String programId,
  ) {

    return _content
        .where(
          (content) =>
              content.programId == programId,
        )
        .toList();
  }


  //----------------------------------------------------------
  // GET CONTENT BY STAGE
  //----------------------------------------------------------
  //
  // This is the most important method for our current
  // Programs architecture.
  //
  // We use BOTH:
  //
  // programId
  // AND
  // stageId
  //
  // so that only the correct content is displayed.
  //
  // Example:
  //
  // Asanas
  //    ↓
  // Asanas Practice
  //    ↓
  // only Asanas Practice videos
  //
  //----------------------------------------------------------

  List<ContentModel> getContentByStage(
    String programId,
    String stageId,
  ) {

    return _content
        .where(
          (content) =>
              content.programId == programId &&
              content.stageId == stageId,
        )
        .toList();
  }


  //----------------------------------------------------------
  // GET CONTENT BY TYPE
  //----------------------------------------------------------
  //
  // Allows filtering by content type.
  //
  // Example:
  //
  // video
  // article
  // audio
  // guide
  // recipe
  // checklist
  //
  //----------------------------------------------------------

  List<ContentModel> getContentByType(
    ContentType type,
  ) {

    return _content
        .where(
          (content) =>
              content.type == type,
        )
        .toList();
  }


  //----------------------------------------------------------
  // GET VIDEOS BY STAGE
  //----------------------------------------------------------
  //
  // Returns only videos belonging to a particular
  // Program Stage.
  //
  //----------------------------------------------------------

  List<ContentModel> getVideosByStage(
    String programId,
    String stageId,
  ) {

    return _content
        .where(
          (content) =>
              content.programId == programId &&
              content.stageId == stageId &&
              content.type ==
                  ContentType.video,
        )
        .toList();
  }


  //----------------------------------------------------------
  // CHECK CONTENT EXISTS
  //----------------------------------------------------------
  //
  // Returns TRUE if content exists for the requested stage.
  //
  //----------------------------------------------------------

  bool hasContentForStage(
    String programId,
    String stageId,
  ) {

    return _content.any(
      (content) =>
          content.programId == programId &&
          content.stageId == stageId,
    );
  }
}