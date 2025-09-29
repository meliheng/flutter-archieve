import 'package:anims/player/cubit/player_cubit.dart';
import 'package:flutter/material.dart';

class PlayerView extends StatefulWidget {
  const PlayerView({
    super.key,
    required this.songs,
    required this.currentSongIndex,
    required this.playerCubit,
  });
  final List<String> songs;
  final int currentSongIndex;
  final PlayerCubit playerCubit;

  @override
  State<PlayerView> createState() => _PlayerViewState();
}

class _PlayerViewState extends State<PlayerView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.playerCubit.setAudioSources(widget.songs, widget.currentSongIndex);
  }

  @override
  void dispose() {
    widget.playerCubit.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Player')),
      body: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: widget.playerCubit.play,
                icon: Icon(Icons.play_arrow),
              ),
              IconButton(
                onPressed: widget.playerCubit.pause,
                icon: Icon(Icons.pause),
              ),
              IconButton(
                onPressed: widget.playerCubit.stop,
                icon: Icon(Icons.stop),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
