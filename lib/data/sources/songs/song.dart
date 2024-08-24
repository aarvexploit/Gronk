import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:gronk/data/models/song/song_firebase_service.dart';
import 'package:gronk/doamin/entities/songs/song.dart';

abstract class SongFirebaseService {
  Future < Either > getNewsSongs();
}


class SongFirebaseServiceImpl extends SongFirebaseService {
  @override
  Future < Either > getNewsSongs() async {

    try {
      List < SongEntity > songs = [];
      var data = await FirebaseFirestore.instance.collection('Songs').orderBy('release', descending: true).limit(3).get();

      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        songs.add(
          songModel.toEntity()
        );
      }

      return Right(songs);
    } catch (e) {
      return const Left('An Error occurred, Please Try Again');
    }

  }


}