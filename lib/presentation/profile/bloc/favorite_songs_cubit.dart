
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gronk/doamin/entities/songs/song.dart';
import 'package:gronk/doamin/usecases/song/get_favorite_songs.dart';
import 'package:gronk/presentation/profile/bloc/favorite_songs_state.dart';

import '../../../service_locator.dart';

class FavoriteSongsCubit extends Cubit<FavoriteSongsState> {
  FavoriteSongsCubit() : super(FavoriteSongsLoading());

  List<SongEntity> favoriteSongs = [];

  Future<void> getFavoriteSongs() async{

    var result = await sl<GetFavoriteSongsUseCase>().call();

    result.fold(
      (l){
        emit(FavoriteSongsFailure());
      },
      (r){
        favoriteSongs = r;
        emit(FavoriteSongsLoaded(favoriteSongs: favoriteSongs));
      }
    );

  }

  void removeSong(int index){
    favoriteSongs.removeAt(index);
    emit(
      FavoriteSongsLoaded(favoriteSongs: favoriteSongs)
    );
  }
}