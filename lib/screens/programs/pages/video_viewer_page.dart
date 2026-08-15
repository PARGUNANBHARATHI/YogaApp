//----------------------------------------------------------
// IRAI VIDEO VIEWER PAGE
//----------------------------------------------------------
//
// PURPOSE:
//
// This page is the actual playback experience for IRAI
// video-based content.
//
// FLOW:
//
// ContentCard
//      ↓
// VideoViewerPage
//      ↓
// ContentModel
//      ↓
// mediaUrl
//      ↓
// VideoPlayerController
//      ↓
// Video Playback
//
//----------------------------------------------------------
//
// FUTURE-FIRST ARCHITECTURE:
//
// Today:
//
// ContentModel
//     ↓
// mediaUrl
//     ↓
// Video Player
//
// Future:
//
// Firebase / CDN
//     ↓
// ContentModel
//     ↓
// Personalization Engine
//     ↓
// Selected Content
//     ↓
// Video Viewer
//
// The Video Viewer does NOT decide which video should be
// recommended.
//
// It only plays the content it receives.
//
//----------------------------------------------------------


import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../models/content_model.dart';


//==========================================================
// VIDEO VIEWER PAGE
//==========================================================

class VideoViewerPage extends StatefulWidget {

  //----------------------------------------------------------
  // CONTENT
  //----------------------------------------------------------
  //
  // The complete content object selected by the user.
  //
  //----------------------------------------------------------

  final ContentModel content;


  //----------------------------------------------------------
  // CONSTRUCTOR
  //----------------------------------------------------------

  const VideoViewerPage({

    super.key,

    required this.content,
  });


  @override
  State<VideoViewerPage> createState() =>
      _VideoViewerPageState();
}


//==========================================================
// STATE
//==========================================================

class _VideoViewerPageState
    extends State<VideoViewerPage> {

  //----------------------------------------------------------
  // VIDEO CONTROLLER
  //----------------------------------------------------------

  VideoPlayerController? _controller;


  //----------------------------------------------------------
  // INITIALIZATION STATE
  //----------------------------------------------------------

  bool _isInitializing = true;


  //----------------------------------------------------------
  // ERROR STATE
  //----------------------------------------------------------

  String? _errorMessage;


  //----------------------------------------------------------
  // INITIALIZE VIDEO
  //----------------------------------------------------------

  @override
  void initState() {

    super.initState();

    _initializeVideo();
  }


  //----------------------------------------------------------
  // INITIALIZE VIDEO
  //----------------------------------------------------------
  //
  // The video source comes directly from:
  //
  // content.mediaUrl
  //
  //----------------------------------------------------------

  Future<void> _initializeVideo() async {

    final String? mediaUrl =
        widget.content.mediaUrl;


    //--------------------------------------------------------
    // CHECK MEDIA URL
    //--------------------------------------------------------

    if (mediaUrl == null ||
        mediaUrl.trim().isEmpty) {

      setState(() {

        _isInitializing = false;

        _errorMessage =
            'Video is not available yet.';
      });

      return;
    }


    try {

      //------------------------------------------------------
      // CREATE CONTROLLER
      //------------------------------------------------------

      final controller =
          VideoPlayerController.networkUrl(
        Uri.parse(
          mediaUrl,
        ),
      );


      //------------------------------------------------------
      // SAVE CONTROLLER
      //------------------------------------------------------

      _controller =
          controller;


      //------------------------------------------------------
      // INITIALIZE
      //------------------------------------------------------

      await controller.initialize();


      //------------------------------------------------------
      // START WITH PAUSED VIDEO
      //------------------------------------------------------
      //
      // We intentionally DO NOT autoplay.
      //
      // The user chooses when to begin.
      //
      //------------------------------------------------------

      await controller.pause();


      //------------------------------------------------------
      // UPDATE UI
      //------------------------------------------------------

      if (!mounted) {
        return;
      }

      setState(() {

        _isInitializing =
            false;
      });


    } catch (e) {

      //------------------------------------------------------
      // PLAYER ERROR
      //------------------------------------------------------

      if (!mounted) {
        return;
      }

      setState(() {

        _isInitializing =
            false;

        _errorMessage =
            'Unable to load this video.';
      });
    }
  }


  //----------------------------------------------------------
  // DISPOSE
  //----------------------------------------------------------

  @override
  void dispose() {

    _controller?.dispose();

    super.dispose();
  }


  //----------------------------------------------------------
  // BUILD
  //----------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(0xFFF6F7F3),


      body: SafeArea(

        child: Column(

          children: [

            //------------------------------------------------
            // TOP BAR
            //------------------------------------------------

            _buildTopBar(context),


            //------------------------------------------------
            // MAIN CONTENT
            //------------------------------------------------

            Expanded(

              child: SingleChildScrollView(

                physics:
                    const BouncingScrollPhysics(),

                padding:
                    const EdgeInsets.only(
                  bottom: 35,
                ),

                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    //------------------------------------------------
                    // VIDEO PLAYER
                    //------------------------------------------------

                    _buildVideoArea(),


                    //------------------------------------------------
                    // CONTENT INFORMATION
                    //------------------------------------------------

                    _buildContentInformation(),


                    //------------------------------------------------
                    // FUTURE PERSONALIZATION AREA
                    //------------------------------------------------

                    _buildPersonalizationHint(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  //========================================================
  // TOP BAR
  //========================================================

  Widget _buildTopBar(
    BuildContext context,
  ) {

    return Padding(

      padding:
          const EdgeInsets.fromLTRB(
        18,
        14,
        18,
        12,
      ),

      child: Row(

        children: [

          //------------------------------------------------
          // BACK BUTTON
          //------------------------------------------------

          _RoundButton(

            icon:
                Icons.arrow_back_ios_new_rounded,

            onTap: () {

              Navigator.pop(
                context,
              );
            },
          ),


          const SizedBox(
            width: 14,
          ),


          //------------------------------------------------
          // TITLE
          //------------------------------------------------

          const Expanded(

            child: Text(

              'Practice',

              style:
                  TextStyle(

                fontSize: 20,

                fontWeight:
                    FontWeight.w800,

                letterSpacing:
                    -0.4,
              ),
            ),
          ),
        ],
      ),
    );
  }


  //========================================================
  // VIDEO AREA
  //========================================================

  Widget _buildVideoArea() {

    //------------------------------------------------------
    // INITIALIZING
    //------------------------------------------------------

    if (_isInitializing) {

      return _buildVideoContainer(

        child:
            const Center(

          child:
              CircularProgressIndicator(
            strokeWidth: 2.5,
          ),
        ),
      );
    }


    //------------------------------------------------------
    // ERROR
    //------------------------------------------------------

    if (_errorMessage != null) {

      return _buildVideoContainer(

        child:
            _buildVideoError(),
      );
    }


    //------------------------------------------------------
    // CONTROLLER NOT READY
    //------------------------------------------------------

    if (_controller == null ||
        !_controller!.value.isInitialized) {

      return _buildVideoContainer(

        child:
            _buildVideoError(),
      );
    }


    //------------------------------------------------------
    // ACTUAL VIDEO
    //------------------------------------------------------

    return _VideoPlayerSection(

      controller:
          _controller!,
    );
  }


  //========================================================
  // VIDEO CONTAINER
  //========================================================

  Widget _buildVideoContainer({

    required Widget child,
  }) {

    return AspectRatio(

      aspectRatio:
          16 / 9,

      child: Container(

        color:
            Colors.black,

        child:
            child,
      ),
    );
  }


  //========================================================
  // VIDEO ERROR
  //========================================================

  Widget _buildVideoError() {

    return Container(

      color:
          const Color(0xFFE8F4F1),

      child: Center(

        child: Padding(

          padding:
              const EdgeInsets.all(25),

          child: Column(

            mainAxisSize:
                MainAxisSize.min,

            children: [

              //------------------------------------------------
              // ICON
              //------------------------------------------------

              Container(

                width: 58,

                height: 58,

                decoration:
                    BoxDecoration(

                  color:
                      Colors.white,

                  shape:
                      BoxShape.circle,
                ),

                child: const Icon(

                  Icons
                      .video_library_outlined,

                  color:
                      Color(0xFF2F7D6B),

                  size: 27,
                ),
              ),


              const SizedBox(
                height: 13,
              ),


              //------------------------------------------------
              // MESSAGE
              //------------------------------------------------

              Text(

                _errorMessage ??
                    'Video unavailable',

                textAlign:
                    TextAlign.center,

                style:
                    const TextStyle(

                  fontSize: 14,

                  fontWeight:
                      FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  //========================================================
  // CONTENT INFORMATION
  //========================================================

  Widget _buildContentInformation() {

    return Padding(

      padding:
          const EdgeInsets.fromLTRB(
        20,
        24,
        20,
        0,
      ),

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          //------------------------------------------------
          // TYPE
          //------------------------------------------------

          Row(

            children: [

              const Icon(

                Icons
                    .play_circle_outline_rounded,

                size: 15,

                color:
                    Color(0xFF2F7D6B),
              ),

              const SizedBox(
                width: 6,
              ),

              Text(

                widget.content.type
                    .name
                    .toUpperCase(),

                style:
                    const TextStyle(

                  fontSize: 10,

                  fontWeight:
                      FontWeight.w800,

                  letterSpacing:
                      1.0,

                  color:
                      Color(0xFF2F7D6B),
                ),
              ),
            ],
          ),


          const SizedBox(
            height: 9,
          ),


          //------------------------------------------------
          // TITLE
          //------------------------------------------------

          Text(

            widget.content.title,

            style:
                const TextStyle(

              fontSize: 25,

              fontWeight:
                  FontWeight.w800,

              letterSpacing:
                  -0.7,

              height: 1.12,
            ),
          ),


          const SizedBox(
            height: 9,
          ),


          //------------------------------------------------
          // SUBTITLE
          //------------------------------------------------

          Text(

            widget.content.subtitle,

            style:
                TextStyle(

              fontSize: 14,

              color:
                  Colors.grey.shade600,

              height: 1.5,
            ),
          ),


          //------------------------------------------------
          // DURATION
          //------------------------------------------------

          if (widget.content.durationMinutes !=
              null) ...[

            const SizedBox(
              height: 14,
            ),

            _InfoPill(

              icon:
                  Icons.schedule_rounded,

              text:
                  '${widget.content.durationMinutes} min',
            ),
          ],
        ],
      ),
    );
  }


  //========================================================
  // FUTURE PERSONALIZATION HINT
  //========================================================
  //
  // IMPORTANT:
  //
  // We are NOT claiming that this particular content is
  // personalized yet.
  //
  // This section is intentionally kept subtle.
  //
  // Later, the personalization engine can supply a real
  // recommendation reason.
  //
  // Example future data:
  //
  // "Recommended for your morning routine"
  //
  // "Selected by your teacher"
  //
  // "Suggested for your current recovery phase"
  //
  // "Matches your practice history"
  //
  // "Suggested based on wearable recovery data"
  //
  // Those values should come from the data layer.
  //
  //========================================================

  Widget _buildPersonalizationHint() {

    return Container(

      margin:
          const EdgeInsets.fromLTRB(
        20,
        26,
        20,
        0,
      ),

      padding:
          const EdgeInsets.all(17),

      decoration:
          BoxDecoration(

        color:
            const Color(0xFFE8F4F1),

        borderRadius:
            BorderRadius.circular(21),
      ),

      child: Row(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          //------------------------------------------------
          // ICON
          //------------------------------------------------

          Container(

            width: 38,

            height: 38,

            decoration:
                BoxDecoration(

              color:
                  Colors.white,

              borderRadius:
                  BorderRadius.circular(12),
            ),

            child: const Icon(

              Icons.auto_awesome_rounded,

              size: 19,

              color:
                  Color(0xFF2F7D6B),
            ),
          ),


          const SizedBox(
            width: 12,
          ),


          //------------------------------------------------
          // TEXT
          //------------------------------------------------

          const Expanded(

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(

                  'IRAI Practice',

                  style:
                      TextStyle(

                    fontSize: 13,

                    fontWeight:
                        FontWeight.w800,

                    color:
                        Color(0xFF245C50),
                  ),
                ),

                SizedBox(
                  height: 4,
                ),

                Text(

                  'Your practice library will become increasingly personalized as your IRAI journey grows.',

                  style:
                      TextStyle(

                    fontSize: 11.5,

                    color:
                        Color(0xFF54736C),

                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


//==========================================================
// VIDEO PLAYER SECTION
//==========================================================
//
// This widget manages:
//
// • Video display
// • Play / pause
// • Progress
// • Duration
// • Fullscreen-ready button
//
//----------------------------------------------------------

class _VideoPlayerSection
    extends StatefulWidget {

  final VideoPlayerController controller;


  const _VideoPlayerSection({

    required this.controller,
  });


  @override
  State<_VideoPlayerSection> createState() =>
      _VideoPlayerSectionState();
}


//==========================================================
// VIDEO PLAYER STATE
//==========================================================

class _VideoPlayerSectionState
    extends State<_VideoPlayerSection> {

  //----------------------------------------------------------
  // SHOW CONTROLS
  //----------------------------------------------------------

  bool _showControls = true;


  //----------------------------------------------------------
  // BUILD
  //----------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    return GestureDetector(

      onTap: () {

        setState(() {

          _showControls =
              !_showControls;
        });
      },

      child: AspectRatio(

        aspectRatio:
            widget.controller.value.aspectRatio,

        child: Stack(

          fit:
              StackFit.expand,

          children: [

            //------------------------------------------------
            // VIDEO
            //------------------------------------------------

            VideoPlayer(
              widget.controller,
            ),


            //------------------------------------------------
            // CONTROLS
            //------------------------------------------------

            if (_showControls)

              _buildControls(),
          ],
        ),
      ),
    );
  }


  //========================================================
  // CONTROLS
  //========================================================

  Widget _buildControls() {

    return Container(

      decoration:
          BoxDecoration(

        gradient:
            LinearGradient(

          begin:
              Alignment.topCenter,

          end:
              Alignment.bottomCenter,

          colors: [

            Colors.black.withValues(
              alpha: 0.25,
            ),

            Colors.transparent,

            Colors.black.withValues(
              alpha: 0.55,
            ),
          ],
        ),
      ),

      child: Column(

        children: [

          //------------------------------------------------
          // TOP SPACE
          //------------------------------------------------

          const Expanded(
            child: SizedBox(),
          ),


          //------------------------------------------------
          // PLAY BUTTON
          //------------------------------------------------

          Center(

            child: GestureDetector(

              onTap: () {

                if (widget.controller
                    .value
                    .isPlaying) {

                  widget.controller.pause();

                } else {

                  widget.controller.play();
                }

                setState(() {});
              },

              child: Container(

                width: 66,

                height: 66,

                decoration:
                    BoxDecoration(

                  color:
                      Colors.white.withValues(
                    alpha: 0.94,
                  ),

                  shape:
                      BoxShape.circle,
                ),

                child: Icon(

                  widget.controller
                          .value
                          .isPlaying
                      ? Icons.pause_rounded
                      : Icons.play_arrow_rounded,

                  size: 34,

                  color:
                      const Color(0xFF2F7D6B),
                ),
              ),
            ),
          ),


          //------------------------------------------------
          // BOTTOM CONTROLS
          //------------------------------------------------

          const Expanded(
            child: SizedBox(),
          ),


          //------------------------------------------------
          // PROGRESS BAR
          //------------------------------------------------

          VideoProgressIndicator(

            widget.controller,

            allowScrubbing:
                true,

            padding:
                const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 7,
            ),

            colors:
                const VideoProgressColors(

              playedColor:
                  Color(0xFF70B5A5),

              bufferedColor:
                  Colors.white54,

              backgroundColor:
                  Colors.white30,
            ),
          ),
        ],
      ),
    );
  }
}


//==========================================================
// ROUND BUTTON
//==========================================================

class _RoundButton
    extends StatelessWidget {

  final IconData icon;

  final VoidCallback onTap;


  const _RoundButton({

    required this.icon,

    required this.onTap,
  });


  @override
  Widget build(BuildContext context) {

    return Material(

      color:
          Colors.transparent,

      child: InkWell(

        onTap:
            onTap,

        borderRadius:
            BorderRadius.circular(15),

        child: Ink(

          width: 45,

          height: 45,

          decoration:
              BoxDecoration(

            color:
                Colors.white,

            borderRadius:
                BorderRadius.circular(15),

            boxShadow: [

              BoxShadow(

                color:
                    Colors.black.withValues(
                  alpha: 0.035,
                ),

                blurRadius: 12,

                offset:
                    const Offset(0, 5),
              ),
            ],
          ),

          child: Icon(

            icon,

            size: 17,
          ),
        ),
      ),
    );
  }
}


//==========================================================
// INFO PILL
//==========================================================

class _InfoPill
    extends StatelessWidget {

  final IconData icon;

  final String text;


  const _InfoPill({

    required this.icon,

    required this.text,
  });


  @override
  Widget build(BuildContext context) {

    return Container(

      padding:
          const EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 7,
      ),

      decoration:
          BoxDecoration(

        color:
            Colors.white,

        borderRadius:
            BorderRadius.circular(14),
      ),

      child: Row(

        mainAxisSize:
            MainAxisSize.min,

        children: [

          Icon(

            icon,

            size: 14,

            color:
                const Color(0xFF2F7D6B),
          ),

          const SizedBox(
            width: 5,
          ),

          Text(

            text,

            style:
                const TextStyle(

              fontSize: 11,

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