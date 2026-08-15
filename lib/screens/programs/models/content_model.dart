//----------------------------------------------------------
// CONTENT MODEL
//----------------------------------------------------------
//
// PURPOSE:
// This model represents the actual content inside a
// Program Stage.
//
// This is where IRAI becomes flexible.
//
// Content can be:
//
// • Video
// • Article
// • Audio
// • Guide
// • Recipe
// • Checklist
//
// IMPORTANT:
//
// Program
//    ↓
// Stage
//    ↓
// Content
//
// Example:
//
// Asanas
//    ↓
// Asanas Practice
//    ↓
// Personalized Video 1
// Personalized Video 2
// Personalized Video 3
//
// The Program and Stage structure can remain the same,
// while the actual content can change based on
// personalization.
//
//----------------------------------------------------------


//==========================================================
// CONTENT TYPE
//==========================================================
//
// Defines what kind of content the user is opening.
//

enum ContentType {

  // Video content.
  video,

  // Written information.
  article,

  // Audio content.
  audio,

  // General educational/guidance content.
  guide,

  // Food-related content.
  recipe,

  // User action/checklist content.
  checklist,
}


//==========================================================
// CONTENT MODEL
//==========================================================

class ContentModel {

  //----------------------------------------------------------
  // IDENTIFICATION
  //----------------------------------------------------------

  // Unique ID of this content.
  final String id;

  // ID of the Program.
  //
  // Example:
  // "asanas"
  //
  final String programId;

  // ID of the Stage.
  //
  // Example:
  // "asanas_practice"
  //
  final String stageId;


  //----------------------------------------------------------
  // DISPLAY INFORMATION
  //----------------------------------------------------------

  // Content title.
  final String title;

  // Short description.
  final String subtitle;


  //----------------------------------------------------------
  // CONTENT TYPE
  //----------------------------------------------------------

  // Defines whether this is a video, article, audio, etc.
  final ContentType type;


  //----------------------------------------------------------
  // MEDIA
  //----------------------------------------------------------

  // Thumbnail image.
  //
  // Optional because some content may not need an image.
  final String? thumbnail;

  // Video/audio/content URL.
  //
  // Optional because articles or checklists may not
  // require a media URL.
  final String? mediaUrl;


  //----------------------------------------------------------
  // DURATION
  //----------------------------------------------------------

  // Duration in minutes.
  //
  // Example:
  // Video = 15 minutes
  //
  // Optional because an article or guide may not have
  // a duration.
  final int? durationMinutes;


  //----------------------------------------------------------
  // CONSTRUCTOR
  //----------------------------------------------------------

  const ContentModel({
    required this.id,
    required this.programId,
    required this.stageId,
    required this.title,
    required this.subtitle,
    required this.type,
    this.thumbnail,
    this.mediaUrl,
    this.durationMinutes,
  });


  //----------------------------------------------------------
  // COPY WITH
  //----------------------------------------------------------
  //
  // Creates a modified copy of the content.
  //
  // This will be useful when content becomes personalized
  // or when content information changes.
  //----------------------------------------------------------

  ContentModel copyWith({
    String? id,
    String? programId,
    String? stageId,
    String? title,
    String? subtitle,
    ContentType? type,
    String? thumbnail,
    String? mediaUrl,
    int? durationMinutes,
  }) {
    return ContentModel(
      id: id ?? this.id,
      programId: programId ?? this.programId,
      stageId: stageId ?? this.stageId,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      type: type ?? this.type,
      thumbnail: thumbnail ?? this.thumbnail,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      durationMinutes:
          durationMinutes ?? this.durationMinutes,
    );
  }
}