import 'package:flutter/foundation.dart';

import 'audio_manager.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

String getAssetPath(String fileName) {
  // 检查是否在Web环境且是否为release模式（即构建后的应用）
  if (kIsWeb && const bool.fromEnvironment('dart.vm.product')) {
    // 构建后的环境，使用调整后的路径
    return 'assets/assets/audio/$fileName';
  } else {
    // 开发环境，使用原始路径
    return 'assets/audio/$fileName';
  }
}

class AudioManagerWeb implements AudioManager {
  @override
  Future<html.AudioElement> playSound(String fileName) async {
    String filePath = getAssetPath(fileName);
    html.AudioElement audio = html.AudioElement(filePath);
    await audio.play();
    return audio;
  }

  @override
  void preloadSound(String fileName) {
    // 預加載在Web上可能不需要特別的處理，
    // 因為播放時會自動加載，或者可以通過添加到DOM來實現預加載
    html.AudioElement audio = html.AudioElement("assets/audio/$fileName");
    audio.preload = 'auto';
    html.document.body.children.add(audio);
    audio.load(); // 调用load方法触发预加载
  }

  @override
  Future<void> stopSound(dynamic player) async {
    if (player is html.AudioElement) {
      player.pause();
      player.src = '';
    }
  }
}

AudioManager getAudioManagerImpl() => AudioManagerWeb();
