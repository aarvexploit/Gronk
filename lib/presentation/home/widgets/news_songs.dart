import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gronk/core/configs/constants/app_urls.dart';
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
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          '${AppUrls.firestorage}${song[index].title}.jpg${AppUrls.media}'
                        )
                        ),
                      ),
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