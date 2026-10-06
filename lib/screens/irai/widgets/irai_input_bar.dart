import 'package:flutter/material.dart';

//==========================================================
// IRAI INPUT BAR
//==========================================================
//
// PURPOSE
// ---------------------------------------------------------
// Main free-input area for IRAI.
//
// User can:
// • Type anything
// • Tap microphone
//
// FUTURE:
// • Speech-to-text
// • AI conversation
// • Voice response
// • Context understanding
// • Personalization
// • Firebase conversation history
//
// IMPORTANT:
// This widget only handles UI input.
// It does NOT contain AI logic.
//
//==========================================================

class IraiInputBar extends StatefulWidget {
  final ValueChanged<String>? onTextSubmitted;

  final VoidCallback? onVoicePressed;

  const IraiInputBar({
    super.key,
    this.onTextSubmitted,
    this.onVoicePressed,
  });

  @override
  State<IraiInputBar> createState() => _IraiInputBarState();
}

class _IraiInputBarState extends State<IraiInputBar> {
  //----------------------------------------------------------
  // CONTROLLER
  //----------------------------------------------------------

  final TextEditingController _textController =
      TextEditingController();

  //----------------------------------------------------------
  // FOCUS
  //----------------------------------------------------------

  final FocusNode _focusNode = FocusNode();

  //----------------------------------------------------------
  // DISPOSE
  //----------------------------------------------------------

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();

    super.dispose();
  }

  //----------------------------------------------------------
  // SUBMIT TEXT
  //----------------------------------------------------------

  void _submitText() {
    final text = _textController.text.trim();

    if (text.isEmpty) {
      return;
    }

    widget.onTextSubmitted?.call(text);

    _textController.clear();

    _focusNode.unfocus();
  }

  //----------------------------------------------------------
  // BUILD
  //----------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    const accentColor = Color(0xFF2FA7B2);

    return Container(
      padding: const EdgeInsets.fromLTRB(
        14,
        8,
        8,
        8,
      ),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(22),

        border: Border.all(
          color: const Color(0xFFE5E8E7),
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.05,
            ),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [

          //----------------------------------------------------
          // TEXT FIELD
          //----------------------------------------------------

          Expanded(
            child: TextField(
              controller: _textController,

              focusNode: _focusNode,

              minLines: 1,

              maxLines: 4,

              textInputAction:
                  TextInputAction.newline,

              onSubmitted: (_) {
                _submitText();
              },

              decoration: const InputDecoration(
                hintText:
                    "Tell IRAI what's happening...",

                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),

                border: InputBorder.none,

                isDense: true,

                contentPadding:
                    EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 4,
                ),
              ),

              style: const TextStyle(
                fontSize: 15,
                height: 1.4,
              ),
            ),
          ),

          const SizedBox(width: 6),

          //----------------------------------------------------
          // VOICE BUTTON
          //----------------------------------------------------

          Material(
            color: Colors.transparent,

            child: InkWell(
              onTap: widget.onVoicePressed,

              borderRadius:
                  BorderRadius.circular(16),

              child: Container(
                width: 44,
                height: 44,

                decoration: BoxDecoration(
                  color:
                      const Color(0xFFE8F8F7),

                  borderRadius:
                      BorderRadius.circular(16),
                ),

                child: const Icon(
                  Icons.mic_none_rounded,

                  color: accentColor,

                  size: 23,
                ),
              ),
            ),
          ),

          const SizedBox(width: 5),

          //----------------------------------------------------
          // SEND BUTTON
          //----------------------------------------------------

          Material(
            color: Colors.transparent,

            child: InkWell(
              onTap: _submitText,

              borderRadius:
                  BorderRadius.circular(16),

              child: Container(
                width: 44,
                height: 44,

                decoration: BoxDecoration(
                  color: accentColor,

                  borderRadius:
                      BorderRadius.circular(16),
                ),

                child: const Icon(
                  Icons.arrow_upward_rounded,

                  color: Colors.white,

                  size: 23,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}