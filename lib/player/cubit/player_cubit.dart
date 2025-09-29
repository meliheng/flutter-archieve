import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';

part 'player_state.dart';

class PlayerCubit extends Cubit<PlayerState> {
  PlayerCubit() : super(const PlayerState()) {
    setAudioPlayer(AudioPlayer());
  }

  void setAudioPlayer(AudioPlayer audioPlayer) {
    emit(state.copyWith(audioPlayer: audioPlayer));
  }

  Future<void> setAudioSources(List<String> urls, int initialIndex) async {
    initStreams();
    final audioSources =
        urls.map((url) => AudioSource.uri(Uri.parse(url))).toList();
    await state.audioPlayer?.setAudioSource(
      audioSources.first,
      initialIndex: initialIndex,
    );
    play();
    emit(state.copyWith(audioSources: audioSources));
  }

  void initStreams() {
    state.audioPlayer?.durationStream.listen((event) {
      print(event);
    });
  }

  void play() {
    state.audioPlayer?.play();
  }

  void pause() {
    state.audioPlayer?.pause();
  }

  Future<void> stop() async {
    await state.audioPlayer?.stop();
  }
}
