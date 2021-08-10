import 'package:volume/volume.dart';

class SoundService {
  Future<void> initAudioStreamType() async {
    await Volume.controlVolume(AudioManager.STREAM_RING);
  }
}
