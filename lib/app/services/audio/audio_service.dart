// ignore_for_file: constant_identifier_names, depend_on_referenced_packages

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class AudioRecordingService {
  static const AUDIO_FILE = "random";

  static AudioRecordingService? _instance;
  final AudioRecorder _record = AudioRecorder();
  late String _path;

  final RxBool _isRecording = false.obs;
  final RxBool _isPaused = false.obs;

  AudioRecordingService._();

  factory AudioRecordingService() {
    return _instance ??= AudioRecordingService._();
  }

  Future<void> init() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    // _path="${directory.path}/$AUDIO_FILE${Platform.isIOS?".m4a":".wav"}";
    _path = "${directory.path}/$AUDIO_FILE${Platform.isIOS ? ".m4a" : ".m4a"}";
    debugPrint("path is: $_path");
  }

  Future<void> deleteAudio() async {
    try {
      File f = File(_path);
      await f.delete();
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }

  Future<void> startRecording() async {
    debugPrint("requesting mic permission");
    // var status = await Permission.microphone.request();
    // debugPrint("mic permission: $status");
    if (await _record.hasPermission()) {
      if (!_isRecording.value) {
        _isRecording.value = true;
        await _record.start(
          RecordConfig(
            encoder: Platform.isIOS ? AudioEncoder.aacLc : AudioEncoder.wav,
          ),
          path: _path,
        );

      }
    }
  }

  Future<void> pausedRecording() async {
    debugPrint("requesting mic permission");
    // var status = await Permission.microphone.request();
    // debugPrint("mic permission: $status");
    if (await _record.hasPermission()) {
      if (!_isPaused.value) {
        _isPaused.value = true;
        await _record.pause();
        /*    _rec.start(_path, (type) {
          print("type: $type");
        });*/
      }
    }
  }

  Future<void> resumeRecording() async {
    debugPrint("requesting mic permission");
    // var status = await Permission.microphone.request();
    // debugPrint("mic permission: $status");
    if (await _record.hasPermission()) {
      if (_isPaused.value) {
        _isPaused.value = false;
        await _record.resume();
        /*    _rec.start(_path, (type) {
          print("type: $type");
        });*/
      }
    }
  }


  Future<String> stopRecording() async {
    if (_isRecording.value) {
      String? path = await _record.stop();
      debugPrint("record path: $path");
      //   await _rec.stop();
      _isRecording.value = false;
      _isPaused.value = false;
    }
    return _path;
  }

  bool get isRecording => _isRecording.value;

  bool get isPaused => _isPaused.value;
}
