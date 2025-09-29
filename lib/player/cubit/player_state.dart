part of 'player_cubit.dart';

class PlayerState extends Equatable {
  const PlayerState({this.audioPlayer, this.audioSources = const []});

  final AudioPlayer? audioPlayer;
  final List<AudioSource> audioSources;
  @override
  List<Object?> get props => [audioPlayer, audioSources];

  PlayerState copyWith({
    AudioPlayer? audioPlayer,
    List<AudioSource>? audioSources,
  }) {
    return PlayerState(
      audioPlayer: audioPlayer ?? this.audioPlayer,
      audioSources: audioSources ?? this.audioSources,
    );
  }
}
