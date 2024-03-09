import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'audio_manager.dart';

class AudioManagerMobile implements AudioManager {
  final AudioCache _audioCache = AudioCache();
  // final AudioPlayer advancedPlayer = AudioPlayer();

  @override
  Future<AudioPlayer> playSound(String fileName) async {
    AudioPlayer audioPlayer = await _audioCache.play("audio/$fileName");
    return audioPlayer;
  }

  @override
  void preloadSound(String fileName) async {
    await _audioCache.load("audio/$fileName");
  }

  @override
  Future<void> stopSound(dynamic player) async {
    if (player is AudioPlayer) {
      await player.stop(); // 停止播放
    }
  }
}

AudioManager getAudioManagerImpl() => AudioManagerMobile();
