import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gronk/doamin/usecases/song/get_news_song.dart';
import 'package:gronk/presentation/home/bloc/news_song_state.dart';

import '../../../service_locator.dart';

class NewsSongCubit extends Cubit<NewsSongState> {
  
  NewsSongCubit() : super(NewsSongsLoading());
  
  Future<void> getNewsSongs() async {

    var returnedSongs = await sl<GetNewsSongUseCase>().call();

    returnedSongs.fold(
      (l) {
        emit(NewsSongsLoadFailure());
      },
      (data) {
        emit(NewsSongsLoaded(songs: data));
      }
    );
  }

}