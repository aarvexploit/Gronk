import 'package:gronk/doamin/entities/songs/song.dart';

abstract class PlaylistState {

}

class PlaylistsLoading extends PlaylistState {}

class PlaylistsLoaded extends PlaylistState {
  final List<SongEntity> songs;
  PlaylistsLoaded({required this.songs});
}

class PlaylistsLoadFailure extends PlaylistState {}