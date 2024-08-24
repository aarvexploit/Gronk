import 'package:gronk/doamin/entities/songs/song.dart';

abstract class NewsSongState {

}

class NewsSongsLoading extends NewsSongState {}

class NewsSongsLoaded extends NewsSongState {
  final List<SongEntity> songs;
  NewsSongsLoaded({required this.songs});
}

class NewsSongsLoadFailure extends NewsSongState {}