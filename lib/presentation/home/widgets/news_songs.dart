import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gronk/common/helpers/is_dark.dart';
import 'package:gronk/core/configs/constants/app_urls.dart';
import 'package:gronk/core/configs/theme/app_colors.dart';
import 'package:gronk/doamin/entities/songs/song.dart';
import 'package:gronk/presentation/home/bloc/news_song_cubit.dart';
import 'package:gronk/presentation/home/bloc/news_song_state.dart';

class NewsSongs extends StatelessWidget {
  const NewsSongs({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewsSongCubit()..getNewsSongs(),
      child: SizedBox(
        height: 200,
        child: BlocBuilder <NewsSongCubit,NewsSongState> (
          builder: (context, state) {
            if (state is NewsSongsLoading) {
              return Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator()
                );
            }

            if (state is NewsSongsLoaded) {
              return _songs(
                state.songs
              );
            }

            return Container();
          }
        )

      ),
    );
  }


  Widget _songs(List<SongEntity> song) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context,index){
        return SizedBox(
          width: 160,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          '${AppUrls.firestorage}${song[index].title}.jpg?${AppUrls.media}'
                        )
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          height: 40,
                          width: 40,
                          transform: Matrix4.translationValues(10, 10, 0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.isDarkMode ? AppColors.darkGrey : const Color(0xffE6E6E6),
                          ),
                          child: Icon(
                            Icons.play_arrow_rounded,
                            color: context.isDarkMode ? const Color(0xff959595) : const Color(0xff555555),
                          ),
                        ),
                      ),
                    ),
                ),
                const SizedBox(height: 19,),
                Text(
                  song[index].title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16
                  ),
                ),
                const SizedBox(height: 5,),
                Text(
                  song[index].artist,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12
                  ),
                ),
              ]
            )
            );
      },
      separatorBuilder: (context,index) => const SizedBox(width: 14,),
      itemCount: song.length
    );
  }
}