import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gronk/common/widgets/appbar/app_bar.dart';
import 'package:gronk/common/widgets/favorite_button/favorite_button.dart';
import 'package:gronk/core/configs/constants/app_urls.dart';
import 'package:gronk/core/configs/theme/app_colors.dart';
import 'package:gronk/doamin/entities/songs/song.dart';
import 'package:gronk/presentation/song_player/bloc/song_player_cubit.dart';
import 'package:gronk/presentation/song_player/bloc/song_player_state.dart';
// ignore: unused_import
import 'package:just_audio/just_audio.dart';

class SongPlayerPage extends StatelessWidget {
  final SongEntity songEntity;
  const SongPlayerPage({
    required this.songEntity,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: const Text(
            'Now Playing',
            style: TextStyle(
              fontSize: 18
            ),
          ),
          action: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert_rounded
            )
          ),
      ),
      body: BlocProvider(
        create: (_) => SongPlayerCubit()..loadSong(
          '${AppUrls.songfirestorage}${songEntity.title}.mp3?${AppUrls.media}'
        ),        
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 16
            ),
            child: Column(
              children: [
                _songCover(context),
                const SizedBox(height: 20, ),
                _songDetail(),
                const SizedBox(height: 35,),
                _songPlayer(context)
              ],
            ),
        ),
      ),
    );
  }

  Widget _songCover(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            '${AppUrls.coverfirestorage}${songEntity.title}.jpg?${AppUrls.media}'
          )
        )
      ),
    );
  }

  Widget _songDetail() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                songEntity.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22
                ),
              ),
              const SizedBox(height: 5, ),
                Text(
                  songEntity.artist,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14
                  ),
                ),
            ],
          ),
          FavoriteButton(
            songEntity: songEntity,
          )
        ],
      ),
    );
  }

  Widget _songPlayer(BuildContext context){
    return BlocBuilder<SongPlayerCubit,SongPlayerState>(
      builder: (context, state){
        if(state is SongPlayerLoading){
          return const CircularProgressIndicator();
        }
        if(state is SongPlayerLoaded){
          return Column(
            children: [
              Slider(
                value: context.read<SongPlayerCubit>().songPosition.inSeconds.toDouble(),
                min: 0.0,
                max: context.read<SongPlayerCubit>().songDuration.inSeconds.toDouble(), 
                thumbColor: const Color(0xff10df97),
                onChanged: (value){
                  int newpos = value.toInt();
                  context.read < SongPlayerCubit > ().setPosition(newpos);
                }
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formatDuration(
                        context.read<SongPlayerCubit>().songPosition
                      )
                    ),

                    Text(
                      formatDuration(
                        context.read<SongPlayerCubit>().songDuration
                      )
                    )
                  ],
                ),
                const SizedBox(height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          context.read < SongPlayerCubit > ().playOrPauseSong();
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primary,
                            ),
                            child: const Icon(
                              Icons.skip_previous,
                              color: Colors.black,
                              size: 25,
                            ),
                        ),
                      ),
                      const SizedBox(width: 25,),
                      GestureDetector(
                        onTap: () {
                          context.read < SongPlayerCubit > ().playOrPauseSong();
                        },
                        child: Container(
                          height: 70,
                          width: 70,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primary,
                            ),
                            child: Icon(
                              context.read < SongPlayerCubit > ().audioPlayer.playing ? Icons.pause : Icons.play_arrow_rounded,
                              color: Colors.black,
                              size: 40,
                            ),
                        ),
                      ),
                      const SizedBox(width: 25,),
                      GestureDetector(
                        onTap: () {
                          context.read < SongPlayerCubit > ().playOrPauseSong();
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primary,
                            ),
                            child: const Icon(
                              Icons.skip_next,
                              color: Colors.black,
                              size: 25,
                            ),
                        ),
                      )
                
                  ],
                )
            ],
          );
        }
        return Container();
      },
    );
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2,'0')}:${seconds.toString().padLeft(2,'0')}';
  }
}