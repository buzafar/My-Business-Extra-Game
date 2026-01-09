import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_business_extra/helpers/assets.dart';

class SoundsSevice {
  static final player = AudioPlayer();

  static void playCashEarned() async {
    await player.play(AssetSource(Assets.moneyEarnedSound));
  }
}
