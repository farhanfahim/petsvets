import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../services/audio/audio_service.dart';

class VoiceMessageController extends GetxController
    with GetTickerProviderStateMixin /*implements SpeechToTextHandler*/{
  final AudioRecordingService _audioRecordingService = AudioRecordingService();
  late AnimationController animController;
  // final mediaController=Get.put(MediaUploadController());


  RxInt seconds=0.obs;

  RxBool isRecording = false.obs;
  RxBool isPaused = false.obs;

   Timer? _timer;

  // final RxString speechStatus=SpeechToText.STATUS_STOPPED.obs;
  
  @override
  void onInit() {
    animController = AnimationController(vsync: this,duration: const Duration(seconds: 2));
    _audioRecordingService.init();
    super.onInit();
  }

  @override
  void onReady() {
    _timer=Timer.periodic(const Duration(seconds: 1), (timer) {
      seconds.value++;
    });
    startRecording();
    super.onReady();
  }

  void cancelTimer(){
    _timer?.cancel();
  }
  void pauseTimer(){
    _timer?.cancel();
  }
  void resumeTimer(){
    _timer=Timer.periodic(const Duration(seconds: 1), (timer) {
      seconds.value++;
    });
  }

  @override
  void onClose() {
    debugPrint("onClose called");
    animController.dispose();
    cancelTimer();
    super.onClose();
  }
  
  // @override
  // void onStatusChanged(String status) {
  //   speechStatus.value=status;
  //   if(status==SpeechToText.STATUS_LISTENING){
  //     animController.repeat();
  //   }
  //   else{
  //     stopAnimation();
  //   }
  // }

  void stopAnimation(){
    animController.stop();
    animController.reset();
  }

  @override
  void onResult(String result) {
    // TODO: implement onResult
  }

  void startRecording(){
    if(!_audioRecordingService.isRecording){
      isRecording.value=true;
      _audioRecordingService.startRecording();
      animController.repeat();
    }
  }
  Future<String?> stopRecording({bool isDeleteHit = false})async {
    if(_audioRecordingService.isRecording){
      isRecording.value=false;
      stopAnimation();
      await _audioRecordingService.stopRecording().then((path) async {
        // debugPrint("path is: $path");
        if(isDeleteHit){
          _audioRecordingService.deleteAudio();
        }else{
          Get.back(result: path);
        }
      });
    }
    return null;
  }

  void pauseRecording(){
    debugPrint("is paused: ${_audioRecordingService.isPaused}");
    if(!_audioRecordingService.isPaused){
      pauseTimer();
      isPaused.value=true;
      _audioRecordingService.pausedRecording();
      animController.stop();
    }
  }

  void resumeRecording(){
    if(_audioRecordingService.isPaused){
      resumeTimer();
      isPaused.value=false;
      _audioRecordingService.resumeRecording();
      animController.repeat();
    }
  }

  //
  // Future<dynamic> uploadToBucket(String path) async {
  //   Completer completer=Completer<String?>();
  //   if(path.isNotEmpty){
  //     await mediaController.s3SignedUrlAPI(filePath: path,title: "Voice Message" ,onDone: (val){
  //       debugPrint("val is: $val");
  //       completer.complete(val);
  //     });
  //   }
  //   else{
  //     completer.complete(null);
  //   }
  //   return completer.future;
  // }

}