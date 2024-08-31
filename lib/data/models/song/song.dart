
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gronk/doamin/entities/songs/song.dart';

class SongModel {

  String ? title;
  String ? artist;
  num ? duration;
  Timestamp ? release;
  bool ? isFavorite;
  String ? songID;

  SongModel({
    required this.title,
    required this.artist,
    required this.duration,
    required this.release,
    required this.isFavorite
  });

  SongModel.fromJson(Map<String,dynamic> data) {
    title = data['title'];
    artist = data['artist'];
    duration = data['duration'];
    release = data['release'];

  }

}


extension SongModelX on SongModel {
  SongEntity toEntity() {
    return SongEntity(
      title: title!,
      artist: artist!,
      duration: duration!,
      release: release!,
      isFavorite: isFavorite!, 
      songID: songID!
      );
  }
}