// audio_manager.dart
import 'audio_manager_stub.dart'
if (dart.library.io) 'audio_manager_mobile.dart'
if (dart.library.html) 'audio_manager_web.dart';

abstract class AudioManager {
  Future<dynamic> playSound(String fileName);
  void preloadSound(String fileName);
  Future<void> stopSound(dynamic player);
}

AudioManager getAudioManager() => getAudioManagerImpl();
