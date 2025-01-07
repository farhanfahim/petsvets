import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:voice_message_package/voice_message_package.dart';

import '../resources/app_colors.dart';
import '../resources/app_images.dart';
import 'mono_icons.dart';

class AudioPlayerWidget extends StatefulWidget {

  final String mediaUrl;
  final bool isFile;
  final void Function()? onClose;
  AudioPlayerWidget({Key? key, required this.mediaUrl, this.isFile = false, this.onClose,})
      : super(key: key);

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  late final VoiceController controller;

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = VoiceController(
      audioSrc: widget.mediaUrl,
      maxDuration: const Duration(seconds: 10),
      isFile: widget.isFile,
      onComplete: () {
        /// do something on complete
      },
      onPause: () {
        /// do something on pause
      },
      onPlaying: () {
        /// do something on playing
      },
      onError: (err) {
        /// do something on error
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double radius=15;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: AppColors.chatSenderColor2,borderRadius: BorderRadius.circular(radius)),
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: VoiceMessageView(
                  backgroundColor: AppColors.chatSenderColor2,
                  activeSliderColor: AppColors.primaryColor,
                  circlesColor: AppColors.primaryColor,
                  innerPadding: 10,
                  cornerRadius: 0,size: 38,
                  controller: controller


                  ),
            ),
          ),
        ],
      ),
    );
  }
}


class CustomIconButton extends StatelessWidget {
  final ResizableIcon icon;
  final void Function()? onTap;
  final EdgeInsets? padding;
  const CustomIconButton({
    Key? key,
    this.padding,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Material(
            color: AppColors.transparent,
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: padding??const EdgeInsets.all(8),
                child: buildIcon(),
              ),
            )));
  }

  Widget buildIcon() {
    return icon;
  }
}