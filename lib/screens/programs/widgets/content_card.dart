//----------------------------------------------------------
// IRAI CONTENT CARD
//----------------------------------------------------------
//
// PURPOSE:
//
// This is the COMMON reusable content card for the IRAI
// Programs library.
//
// The same card can represent:
//
// • Video
// • Audio
// • Guide
// • Article
// • Recipe
// • Checklist
//
//----------------------------------------------------------
//
// FUTURE-FIRST ARCHITECTURE:
//
// The card does NOT decide:
//
// • Body type
// • Siddha profile
// • User goals
// • Teacher recommendation
// • Personalization
// • AI ranking
//
// Those decisions belong to the data / personalization
// layer.
//
//
//
// Personalization Engine
//          ↓
//      ContentModel
//          ↓
//      ContentCard
//          ↓
//   Content Viewer
//
//----------------------------------------------------------
//
// IMPORTANT:
//
// We are intentionally using ONLY the fields currently
// available in your ContentModel.
//
// Future fields such as:
//
// • recommendation reason
// • difficulty
// • category
// • personalized score
// • teacher selected
// • AI selected
//
// can be added to ContentModel later without changing
// this overall architecture.
//
//----------------------------------------------------------


import 'package:flutter/material.dart';

import '../models/content_model.dart';


//==========================================================
// CONTENT CARD
//==========================================================

class ContentCard extends StatelessWidget {

  //----------------------------------------------------------
  // CONTENT
  //----------------------------------------------------------
  //
  // The ContentModel contains the information that this
  // card should display.
  //
  //----------------------------------------------------------

  final ContentModel content;


  //----------------------------------------------------------
  // TAP ACTION
  //----------------------------------------------------------
  //
  // The parent decides what happens when the card is opened.
  //
  // Example future flow:
  //
  // ContentCard
  //     ↓
  // Video Player
  //
  //----------------------------------------------------------

  final VoidCallback onTap;


  //----------------------------------------------------------
  // CONSTRUCTOR
  //----------------------------------------------------------

  const ContentCard({

    super.key,

    required this.content,

    required this.onTap,
  });


  //----------------------------------------------------------
  // BUILD
  //----------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    return Material(

      color: Colors.transparent,

      child: InkWell(

        onTap: onTap,

        borderRadius:
            BorderRadius.circular(26),

        child: Container(

          margin:
              const EdgeInsets.only(
            bottom: 18,
          ),

          decoration: BoxDecoration(

            color:
                Colors.white,

            borderRadius:
                BorderRadius.circular(26),

            boxShadow: [

              BoxShadow(

                color:
                    Colors.black.withValues(
                  alpha: 0.045,
                ),

                blurRadius: 20,

                offset:
                    const Offset(0, 8),
              ),
            ],
          ),

          child: ClipRRect(

            borderRadius:
                BorderRadius.circular(26),

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                //------------------------------------------------
                // MEDIA / THUMBNAIL
                //------------------------------------------------
                //
                // This is intentionally large.
                //
                // In the future, this becomes the main visual
                // entry point for video content.
                //
                //------------------------------------------------

                _ContentThumbnail(

                  content:
                      content,

                  onTap:
                      onTap,
                ),


                //------------------------------------------------
                // CONTENT INFORMATION
                //------------------------------------------------

                Padding(

                  padding:
                      const EdgeInsets.fromLTRB(
                    18,
                    17,
                    16,
                    17,
                  ),

                  child: Row(

                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      //------------------------------------------------
                      // TITLE / SUBTITLE / DURATION
                      //------------------------------------------------

                      Expanded(

                        child: Column(

                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          children: [

                            //------------------------------------------------
                            // CONTENT TYPE
                            //------------------------------------------------

                            _ContentTypeLabel(

                              type:
                                  content.type,
                            ),


                            const SizedBox(
                              height: 8,
                            ),


                            //------------------------------------------------
                            // TITLE
                            //------------------------------------------------

                            Text(

                              content.title,

                              maxLines: 2,

                              overflow:
                                  TextOverflow.ellipsis,

                              style:
                                  const TextStyle(

                                fontSize: 17,

                                fontWeight:
                                    FontWeight.w800,

                                letterSpacing:
                                    -0.25,

                                height: 1.15,
                              ),
                            ),


                            const SizedBox(
                              height: 6,
                            ),


                            //------------------------------------------------
                            // SUBTITLE
                            //------------------------------------------------

                            Text(

                              content.subtitle,

                              maxLines: 2,

                              overflow:
                                  TextOverflow.ellipsis,

                              style: TextStyle(

                                fontSize: 13,

                                color:
                                    Colors.grey.shade600,

                                height: 1.4,
                              ),
                            ),


                            //------------------------------------------------
                            // DURATION
                            //------------------------------------------------

                            if (content.durationMinutes !=
                                null) ...[

                              const SizedBox(
                                height: 11,
                              ),

                              Row(

                                children: [

                                  Icon(

                                    Icons
                                        .schedule_rounded,

                                    size: 14,

                                    color:
                                        Colors.grey.shade600,
                                  ),

                                  const SizedBox(
                                    width: 5,
                                  ),

                                  Text(

                                    '${content.durationMinutes} min',

                                    style: TextStyle(

                                      fontSize: 11.5,

                                      fontWeight:
                                          FontWeight.w600,

                                      color:
                                          Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),


                      const SizedBox(
                        width: 12,
                      ),


                      //------------------------------------------------
                      // OPEN BUTTON
                      //------------------------------------------------
                      //
                      // Kept visually simple.
                      //
                      // The whole card is tappable, so this is only
                      // a visual navigation cue.
                      //
                      //------------------------------------------------

                      _OpenButton(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


//==========================================================
// CONTENT THUMBNAIL
//==========================================================
//
// Displays the main visual area.
//
// If thumbnail exists:
//     → network image
//
// If thumbnail doesn't exist:
//     → intelligent placeholder
//
//----------------------------------------------------------

class _ContentThumbnail
    extends StatelessWidget {

  final ContentModel content;

  final VoidCallback onTap;


  const _ContentThumbnail({

    required this.content,

    required this.onTap,
  });


  @override
  Widget build(BuildContext context) {

    //--------------------------------------------------------
    // CHECK THUMBNAIL
    //--------------------------------------------------------

    final bool hasThumbnail =
        content.thumbnail != null &&
        content.thumbnail!.trim().isNotEmpty;


    //--------------------------------------------------------
    // IMAGE AVAILABLE
    //--------------------------------------------------------

    if (hasThumbnail) {

      return GestureDetector(

        onTap:
            onTap,

        child: ClipRRect(

          borderRadius:
              const BorderRadius.vertical(
            top: Radius.circular(26),
          ),

          child: AspectRatio(

            aspectRatio:
                16 / 9,

            child: Stack(

              fit:
                  StackFit.expand,

              children: [

                //------------------------------------------------
                // IMAGE
                //------------------------------------------------

                Image.network(

                  content.thumbnail!,

                  fit:
                      BoxFit.cover,

                  errorBuilder:
                      (context, error, stackTrace) {

                    return _PlaceholderThumbnail(

                      content:
                          content,

                      onTap:
                          onTap,
                    );
                  },
                ),


                //------------------------------------------------
                // IMAGE OVERLAY
                //------------------------------------------------
                //
                // Gives the image more premium depth and makes
                // the play button readable.
                //
                //------------------------------------------------

                Positioned.fill(

                  child: DecoratedBox(

                    decoration:
                        BoxDecoration(

                      gradient:
                          LinearGradient(

                        begin:
                            Alignment.topCenter,

                        end:
                            Alignment.bottomCenter,

                        stops: const [
                          0.45,
                          1.0,
                        ],

                        colors: [

                          Colors.transparent,

                          Colors.black.withValues(
                            alpha: 0.28,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),


                //------------------------------------------------
                // PLAY BUTTON
                //------------------------------------------------

                Center(

                  child:
                      _PlayButton(
                    onTap:
                        onTap,
                  ),
                ),


                //------------------------------------------------
                // DURATION BADGE
                //------------------------------------------------

                if (content.durationMinutes !=
                    null)

                  Positioned(

                    right: 12,

                    bottom: 12,

                    child:
                        _DurationBadge(

                      minutes:
                          content.durationMinutes!,
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    }


    //--------------------------------------------------------
    // NO IMAGE
    //--------------------------------------------------------

    return _PlaceholderThumbnail(

      content:
          content,

      onTap:
          onTap,
    );
  }
}


//==========================================================
// PLACEHOLDER THUMBNAIL
//==========================================================
//
// Used while actual media thumbnails are not available.
//
// This is especially useful during development before
// Firebase/media storage is connected.
//
//----------------------------------------------------------

class _PlaceholderThumbnail
    extends StatelessWidget {

  final ContentModel content;

  final VoidCallback onTap;


  const _PlaceholderThumbnail({

    required this.content,

    required this.onTap,
  });


  @override
  Widget build(BuildContext context) {

    return GestureDetector(

      onTap:
          onTap,

      child: SizedBox(

        height: 190,

        child: Stack(

          fit:
              StackFit.expand,

          children: [

            //------------------------------------------------
            // BACKGROUND
            //------------------------------------------------

            Container(

              decoration:
                  const BoxDecoration(

                color:
                    Color(0xFFE8F4F1),

                borderRadius:
                    BorderRadius.vertical(
                  top: Radius.circular(26),
                ),
              ),
            ),


            //------------------------------------------------
            // DECORATIVE CIRCLE
            //------------------------------------------------

            Positioned(

              right: -45,

              top: -55,

              child: Container(

                width: 160,

                height: 160,

                decoration:
                    BoxDecoration(

                  color:
                      Colors.white.withValues(
                    alpha: 0.25,
                  ),

                  shape:
                      BoxShape.circle,
                ),
              ),
            ),


            //------------------------------------------------
            // SECOND DECORATIVE CIRCLE
            //------------------------------------------------

            Positioned(

              left: -60,

              bottom: -70,

              child: Container(

                width: 150,

                height: 150,

                decoration:
                    BoxDecoration(

                  color:
                      Colors.white.withValues(
                    alpha: 0.20,
                  ),

                  shape:
                      BoxShape.circle,
                ),
              ),
            ),


            //------------------------------------------------
            // CONTENT TYPE ICON
            //------------------------------------------------

            Center(

              child: _PlayButton(

                onTap:
                    onTap,

                icon:
                    _getContentIcon(
                  content.type,
                ),
              ),
            ),


            //------------------------------------------------
            // TYPE BADGE
            //------------------------------------------------

            Positioned(

              left: 14,

              top: 14,

              child:
                  _MediaTypeBadge(

                type:
                    content.type,
              ),
            ),


            //------------------------------------------------
            // DURATION
            //------------------------------------------------

            if (content.durationMinutes !=
                null)

              Positioned(

                right: 14,

                bottom: 14,

                child:
                    _DurationBadge(

                  minutes:
                      content.durationMinutes!,
                ),
              ),
          ],
        ),
      ),
    );
  }
}


//==========================================================
// PLAY BUTTON
//==========================================================
//
// Main interaction visual for media.
//
// For Video:
//     play icon
//
// For other content:
//     content-specific icon
//
//----------------------------------------------------------

class _PlayButton
    extends StatelessWidget {

  final VoidCallback onTap;

  final IconData? icon;


  const _PlayButton({

    required this.onTap,

    this.icon,
  });


  @override
  Widget build(BuildContext context) {

    return Material(

      color:
          Colors.transparent,

      child: InkWell(

        onTap:
            onTap,

        customBorder:
            const CircleBorder(),

        child: Ink(

          width: 62,

          height: 62,

          decoration:
              BoxDecoration(

            color:
                Colors.white.withValues(
              alpha: 0.92,
            ),

            shape:
                BoxShape.circle,

            boxShadow: [

              BoxShadow(

                color:
                    Colors.black.withValues(
                  alpha: 0.12,
                ),

                blurRadius: 16,

                offset:
                    const Offset(0, 6),
              ),
            ],
          ),

          child: Icon(

            icon ??
                Icons.play_arrow_rounded,

            size: 31,

            color:
                const Color(0xFF2F7D6B),
          ),
        ),
      ),
    );
  }
}


//==========================================================
// DURATION BADGE
//==========================================================

class _DurationBadge
    extends StatelessWidget {

  final int minutes;


  const _DurationBadge({

    required this.minutes,
  });


  @override
  Widget build(BuildContext context) {

    return Container(

      padding:
          const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 6,
      ),

      decoration:
          BoxDecoration(

        color:
            Colors.black.withValues(
          alpha: 0.65,
        ),

        borderRadius:
            BorderRadius.circular(10),
      ),

      child: Row(

        mainAxisSize:
            MainAxisSize.min,

        children: [

          const Icon(

            Icons.schedule_rounded,

            size: 12,

            color:
                Colors.white,
          ),

          const SizedBox(
            width: 4,
          ),

          Text(

            '$minutes min',

            style:
                const TextStyle(

              fontSize: 10.5,

              fontWeight:
                  FontWeight.w700,

              color:
                  Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}


//==========================================================
// CONTENT TYPE LABEL
//==========================================================
//
// Small semantic label shown above the title.
//
// This gives the user immediate context about what they
// are about to open.
//
//----------------------------------------------------------

class _ContentTypeLabel
    extends StatelessWidget {

  final ContentType type;


  const _ContentTypeLabel({

    required this.type,
  });


  @override
  Widget build(BuildContext context) {

    return Row(

      mainAxisSize:
          MainAxisSize.min,

      children: [

        Icon(

          _getContentIcon(type),

          size: 13,

          color:
              const Color(0xFF2F7D6B),
        ),

        const SizedBox(
          width: 5,
        ),

        Text(

          _getContentTypeName(type)
              .toUpperCase(),

          style:
              const TextStyle(

            fontSize: 9.5,

            fontWeight:
                FontWeight.w800,

            letterSpacing:
                0.9,

            color:
                Color(0xFF2F7D6B),
          ),
        ),
      ],
    );
  }
}


//==========================================================
// MEDIA TYPE BADGE
//==========================================================

class _MediaTypeBadge
    extends StatelessWidget {

  final ContentType type;


  const _MediaTypeBadge({

    required this.type,
  });


  @override
  Widget build(BuildContext context) {

    return Container(

      padding:
          const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 6,
      ),

      decoration:
          BoxDecoration(

        color:
            Colors.white.withValues(
          alpha: 0.88,
        ),

        borderRadius:
            BorderRadius.circular(10),
      ),

      child: Row(

        mainAxisSize:
            MainAxisSize.min,

        children: [

          Icon(

            _getContentIcon(type),

            size: 12,

            color:
                const Color(0xFF2F7D6B),
          ),

          const SizedBox(
            width: 4,
          ),

          Text(

            _getContentTypeName(type),

            style:
                const TextStyle(

              fontSize: 9.5,

              fontWeight:
                  FontWeight.w700,

              color:
                  Color(0xFF315D54),
            ),
          ),
        ],
      ),
    );
  }
}


//==========================================================
// OPEN BUTTON
//==========================================================

class _OpenButton
    extends StatelessWidget {

  const _OpenButton();


  @override
  Widget build(BuildContext context) {

    return Container(

      width: 44,

      height: 44,

      decoration:
          BoxDecoration(

        color:
            const Color(0xFFE8F4F1),

        borderRadius:
            BorderRadius.circular(15),
      ),

      child: const Icon(

        Icons.arrow_forward_ios_rounded,

        size: 16,

        color:
            Color(0xFF2F7D6B),
      ),
    );
  }
}


//==========================================================
// CONTENT ICON
//==========================================================
//
// Selects the correct icon based on ContentType.
//
//----------------------------------------------------------

IconData _getContentIcon(
  ContentType type,
) {

  switch (type) {

    //--------------------------------------------------------
    // VIDEO
    //--------------------------------------------------------

    case ContentType.video:

      return Icons.play_arrow_rounded;


    //--------------------------------------------------------
    // ARTICLE
    //--------------------------------------------------------

    case ContentType.article:

      return Icons.article_outlined;


    //--------------------------------------------------------
    // AUDIO
    //--------------------------------------------------------

    case ContentType.audio:

      return Icons.headphones_rounded;


    //--------------------------------------------------------
    // GUIDE
    //--------------------------------------------------------

    case ContentType.guide:

      return Icons.menu_book_rounded;


    //--------------------------------------------------------
    // RECIPE
    //--------------------------------------------------------

    case ContentType.recipe:

      return Icons.restaurant_menu_rounded;


    //--------------------------------------------------------
    // CHECKLIST
    //--------------------------------------------------------

    case ContentType.checklist:

      return Icons.check_circle_outline_rounded;
  }
}


//==========================================================
// CONTENT TYPE NAME
//==========================================================
//
// Converts ContentType into user-friendly text.
//
//----------------------------------------------------------

String _getContentTypeName(
  ContentType type,
) {

  switch (type) {

    case ContentType.video:
      return 'Video';

    case ContentType.article:
      return 'Article';

    case ContentType.audio:
      return 'Audio';

    case ContentType.guide:
      return 'Guide';

    case ContentType.recipe:
      return 'Recipe';

    case ContentType.checklist:
      return 'Checklist';
  }
}