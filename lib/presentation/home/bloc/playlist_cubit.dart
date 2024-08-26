import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gronk/doamin/usecases/song/get_playlist.dart';
import 'package:gronk/presentation/home/bloc/playlist_state.dart';

import '../../../service_locator.dart';

class PlaylistCubit extends Cubit<PlaylistState> {
  
  PlaylistCubit() : super(PlaylistsLoading());
  
  Future<void> getPlaylists() async {

    var returnedSongs = await sl<GetPlaylistUseCase>().call();

    returnedSongs.fold(
      (l) {
        emit(PlaylistsLoadFailure());
      },
      (data) {
        emit(PlaylistsLoaded(songs: data));
      }
    );
  }

}