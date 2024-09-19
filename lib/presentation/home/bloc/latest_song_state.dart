import 'package:gronk/doamin/entities/songs/song.dart';

abstract class LatestSongState {

}

class LatestSongLoading extends LatestSongState {}

class LatestSongLoaded extends LatestSongState {
  final List<SongEntity> songs;
  LatestSongLoaded({required this.songs});
}

class LatestSongLoadFailure extends LatestSongState {}