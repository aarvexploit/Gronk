import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gronk/common/helpers/is_dark.dart';
import 'package:gronk/common/widgets/appbar/app_bar.dart';
import 'package:gronk/common/widgets/favorite_button/favorite_button.dart';
import 'package:gronk/core/configs/constants/app_urls.dart';
import 'package:gronk/presentation/profile/bloc/favorite_songs_cubit.dart';
import 'package:gronk/presentation/profile/bloc/favorite_songs_state.dart';
import 'package:gronk/presentation/profile/bloc/profile_info_cubit.dart';
import 'package:gronk/presentation/profile/bloc/profile_info_state.dart';
import 'package:gronk/presentation/song_player/pages/song_player.dart';
import 'package:gronk/presentation/splash/pages/splash.dart';

// ignore: must_be_immutable
class Profile extends StatelessWidget {
  Profile({super.key});

  var auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: const Text(
          'Profile'
        ),
        backgroundColor: const Color(0xff2C2B2B),
        action: IconButton(
          onPressed: (){
            Navigator.pushReplacement(
              context, 
              MaterialPageRoute(builder: (BuildContext context) => const SplashPage())
              );
            auth.signOut(); 
          }, 
          icon: const Icon(
            Icons.logout
          )
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _profileInfo(context),
              const SizedBox(height: 30,),
              _favoriteSongs()
          
            ],
          ),
        ),
    );
  }

  Widget _profileInfo(BuildContext context){
    return BlocProvider(
      create: (context) => ProfileInfoCubit()..getUser(),
      child: Container(
        height: MediaQuery.of(context).size.height / 3.5,
        width: double.infinity,
        decoration: BoxDecoration(
          color: context.isDarkMode ? const Color(0xff2C2B2B) : Colors.white,
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(30),
            bottomLeft: Radius.circular(30)
          )
        ),

        child: BlocBuilder<ProfileInfoCubit,ProfileInfoState>(
          builder: (context, state){
            if(state is ProfileInfoLoading) {
              return Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator()
                );
            }


            if(state is ProfileInfoLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          state.userEntity.imageURL!
                        )
                      )
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Text(
                    state.userEntity.email!
                  ),
                  const SizedBox(height: 20,),
                  Text(
                    state.userEntity.fullName!,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              );
            }

            if(state is ProfileInfoFailure) {
              return const Text(
                'Please Try Again'
              );
            }

            return Container();
          },
        ),
      ),
    );
  }

  Widget _favoriteSongs() {
    return BlocProvider(
      create: (context) => FavoriteSongsCubit()..getFavoriteSongs(),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Favorite Songs',
                ),
                const SizedBox(height: 20,),
                BlocBuilder<FavoriteSongsCubit,FavoriteSongsState>(
                  builder: (context, state) {
                    if(state is FavoriteSongsLoading){
                      return const CircularProgressIndicator();
                    }
            
                    if(state is FavoriteSongsLoaded) {
                      return ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context,index){
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => SongPlayerPage(songEntity: state.favoriteSongs[index])
                                )
                                );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 75,
                                      width: 75,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                          '${AppUrls.coverfirestorage}${state.favoriteSongs[index].title}.jpg?${AppUrls.media}'
                                          ))
                                      ),
                                    ),
                                    const SizedBox(width: 10, ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            state.favoriteSongs[index].title,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16
                                            ),
                                          ),
                                          const SizedBox(height: 5, ),
                                            Text(
                                              state.favoriteSongs[index].artist,
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
                                       state.favoriteSongs[index].duration.toString().replaceAll('.', ':')
                                     ),
                                     const SizedBox(width: 29, ),
                                       FavoriteButton(
                                         songEntity: state.favoriteSongs[index],
                                         key: UniqueKey(),
                                         function: (){
                                          context.read<FavoriteSongsCubit>().removeSong(index);
                                         },
                                       )
                            
                                   ],
                                 )
                              ],
                            ),
                          );
                        }, 
                        separatorBuilder: (context,index) => const SizedBox(height: 20,), 
                        itemCount: state.favoriteSongs.length
                        );
            
                        
                    }
            
                    if(state is FavoriteSongsFailure){
                      return const Text(
                        'Please Try Again'
                      );
                    }
            
                    return Container();
                  },
                )
              ],
            ),
          ),
      );
      }
}