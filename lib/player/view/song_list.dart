import 'package:anims/player/cubit/player_cubit.dart';
import 'package:anims/player/view/player_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SongList extends StatefulWidget {
  const SongList({super.key});

  @override
  State<SongList> createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  late final PlayerCubit playerCubit;
  @override
  void initState() {
    super.initState();
    playerCubit = PlayerCubit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Song List')),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: songs.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => PlayerView(
                              songs: songs,
                              currentSongIndex: index,
                              playerCubit: playerCubit,
                            ),
                      ),
                    );
                  },
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(songs[index]),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 10),
            ),
          ),
          // SafeArea(
          //   child: BlocBuilder<PlayerCubit, PlayerState>(
          //     bloc: playerCubit,
          //     builder: (context, state) {
          //       if (state.audioPlayer != null) {
          //         return StreamBuilder(
          //           stream: playerCubit.state.audioPlayer?.playerEventStream,
          //           builder: (context, snapshot) {
          //             if (snapshot.hasData && snapshot.data?.playing == true) {
          //               return Text('Playing');
          //             }
          //             return const SizedBox.shrink();
          //           },
          //         );
          //       }
          //       return const SizedBox.shrink();
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}

List<String> songs = [
  "https://commondatastorage.googleapis.com/codeskulptor-demos/DDR_assets/Kangaroo_MusiQue_-_The_Neverwritten_Role_Playing_Game.mp3",
];
