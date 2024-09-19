import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gronk/doamin/usecases/song/get_latest.dart';
import 'package:gronk/presentation/home/bloc/latest_song_state.dart';


import '../../../service_locator.dart';

class LatestSongCubit extends Cubit<LatestSongState> {
  
  LatestSongCubit() : super(LatestSongLoading());
  
  Future<void> getLatestSong() async {

    var returnedSongs = await sl<GetLatestUseCase>().call();

    returnedSongs.fold(
      (l) {
        emit(LatestSongLoadFailure());
      },
      (data) {
        emit(LatestSongLoaded(songs: data));
      }
    );
  }

}