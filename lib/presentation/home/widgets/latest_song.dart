import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gronk/core/configs/assets/app_vectors.dart';
import 'package:gronk/core/configs/constants/app_urls.dart';
import 'package:gronk/core/configs/theme/app_images.dart';
import 'package:gronk/doamin/entities/songs/song.dart';
import 'package:gronk/presentation/home/bloc/latest_song_cubit.dart';
import 'package:gronk/presentation/home/bloc/latest_song_state.dart';
import 'package:gronk/presentation/song_player/pages/song_player.dart';
import 'package:image_gradient/image_gradient.dart';

class LatestSong extends StatelessWidget {
  const LatestSong({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LatestSongCubit()..getLatestSong(),
      child: BlocBuilder<LatestSongCubit, LatestSongState>(
        builder: (context,state) {
          if(state is LatestSongLoading){
            return Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            );
          }

          if(state is LatestSongLoaded){
            return _song(state.songs, context);
          }

          if(state is LatestSongLoadFailure){
            return Container();
          }



          return Container();
        }
        )
        );
  }

  Widget _song(List<SongEntity> songs, BuildContext context){
          return GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (BuildContext context) => SongPlayerPage(
                  songEntity: songs[0],
                ))
                );
            },
            child: Center(
              child: SizedBox(
                height: 140,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SvgPicture.asset(
                          AppVectors.homeTopCard,
                          height: 500,
                          width: 500,

                        ),
                      ),

                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 60,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: ImageGradient.linear(
                                image: Image.network('${AppUrls.coverfirestorage}${songs[0].title}.jpg?${AppUrls.media}'),
                                colors: const [Colors.black, Colors.white],
                              ),
                            )
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 60,
                          ),

                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 8,
                          top: 18
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "New Release",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8,),
                            Text(
                              songs[0].title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white.withOpacity(0.9)
                              ),
                            ),
                            const SizedBox(height: 5, ),
                            Text(
                                songs[0].artist,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: Colors.white.withOpacity(0.9)
                                ),
                              ),
                            const SizedBox(height: 5, ),
                            Text(
                              songs[0].duration.toString().replaceAll('.', ':'),
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9)
                              ),
                                            ),
                          ],
                        ),
                      )
                        )
                    )
                  ],
                ),
                
            ),
          )
         );
              

  }

}
