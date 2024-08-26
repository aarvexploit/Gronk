import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gronk/common/helpers/is_dark.dart';
import 'package:gronk/core/configs/theme/app_colors.dart';
import 'package:gronk/doamin/entities/songs/song.dart';
import 'package:gronk/presentation/home/bloc/playlist_cubit.dart';
import 'package:gronk/presentation/home/bloc/playlist_state.dart';

class Playlist extends StatelessWidget {
  const Playlist({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PlaylistCubit()..getPlaylists(),
      child: BlocBuilder<PlaylistCubit, PlaylistState>(
        builder: (context,state) {
          if(state is PlaylistsLoading){
            return Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            );
          }
          if(state is PlaylistsLoaded){
            return  Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 40,
                horizontal: 16
              ),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Latest',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                        ),
                      ),
                      Text(
                        'See more',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Color(0xffC6C6C6)
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20,),
                  _songs(state.songs)
                ],
              ),
            );
          }

          return Container();
        },
      ),
    );
  }

  Widget _songs(List<SongEntity> songs){
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context,index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.isDarkMode ? AppColors.darkGrey : const Color(0xffE6E6E6)
                  ),
                child: Icon(
                  Icons.play_arrow_rounded,
                  color: context.isDarkMode ? const Color(0xff959595) : const Color(0xff555555),
                ),
                ),
                const SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      songs[index].title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      songs[index].artist,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12
                      ),
                    ),
                  ],
                )
              ],
            ),
            Row(
              children: [
                Text(
                  songs[index].duration.toString().replaceAll('.', ':')
                ),
                const SizedBox(width: 29,),
                IconButton(
                  onPressed: (){}, 
                  icon: const Icon(
                    Icons.favorite_rounded,
                    color: AppColors.darkGrey,
                  )
                  )
              ],
            )
          ],
        );
      }, 
      separatorBuilder: (context, index) => const SizedBox(height: 20,), 
      itemCount: songs.length
      );
  }
}