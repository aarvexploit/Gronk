import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gronk/data/models/song/song.dart';
import 'package:gronk/doamin/entities/songs/song.dart';
import 'package:gronk/doamin/usecases/song/is_favorite.dart';
import 'package:gronk/service_locator.dart';

abstract class SongFirebaseService {
  Future < Either > getNewsSongs();
  Future < Either > getPlaylist();
  Future < Either > addOrRemoveFavoriteSong(String songId);
  Future<bool> isFavoriteSong(String songId);
  Future<Either> getUserFavoriteSongs();
  Future<Either> getLatestSongs();
}


class SongFirebaseServiceImpl extends SongFirebaseService {
  @override
  Future < Either > getNewsSongs() async {

    try {
      List < SongEntity > songs = [];
      var data = await FirebaseFirestore.instance.collection('Songs').orderBy('release', descending: true).limit(3).get();

      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        bool isFavorite = await sl<IsFavoriteSongUseCase>().call(
          params: element.reference.id
        );
        songModel.isFavorite = isFavorite;
        songModel.songID = element.reference.id;
        songs.add(
          songModel.toEntity()
        );
      }

      return Right(songs);
    } catch (e) {
      return const Left('An Error occurred, Please Try Again');
    }

  }

  @override
  Future < Either > getPlaylist() async {
    try {
      List < SongEntity > songs = [];
      var data = await FirebaseFirestore.instance.collection('Songs').orderBy('release', descending: false).get();

      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        bool isFavorite = await sl<IsFavoriteSongUseCase>().call(
          params: element.reference.id
        );
        songModel.isFavorite = isFavorite;
        songModel.songID = element.reference.id;
        songs.add(
          songModel.toEntity()
        );
      }

      return Right(songs);
    } catch (e) {
      return const Left('An Error occurred, Please Try Again');
    }
  }

  @override
  Future < Either > addOrRemoveFavoriteSong(String songId) async {

    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      late bool isFavorite;

      var user = firebaseAuth.currentUser;
      String uId = user!.uid;

      QuerySnapshot favorite = await firebaseFirestore.collection('Users').doc(uId).collection('Favorite').where(
        'songId', isEqualTo: songId
      ).get();

      if (favorite.docs.isNotEmpty) {
        await favorite.docs.first.reference.delete();
        isFavorite = false;
      } else {
        await firebaseFirestore.collection('Users').doc(uId).collection('Favorite').add({
          'songId': songId,
          'addedDate': Timestamp.now()
        }
        );
        isFavorite = true;
      }

      return Right(isFavorite);
    } catch (e) {
      return const Left('An Error Occurred');
    }
  }
  
  @override
  Future<bool> isFavoriteSong(String songId) async{
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;


      var user = firebaseAuth.currentUser;
      String uId = user!.uid;

      QuerySnapshot favorite = await firebaseFirestore.collection('Users').doc(uId).collection('Favorite').where(
        'songId', isEqualTo: songId
      ).get();

      if (favorite.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
  
  @override
  Future < Either > getUserFavoriteSongs() async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;


      var user = firebaseAuth.currentUser;
      List<SongEntity> favoriteSongs = [];
      String uId = user!.uid;

      QuerySnapshot favoriteSnapshot = await firebaseFirestore.collection('Users').doc(uId).collection('Favorite').get();


      for(var element in favoriteSnapshot.docs) { 
        String songId = element['songId'];
        var song = await firebaseFirestore.collection('Songs').doc(songId).get();
        SongModel songModel = SongModel.fromJson(song.data()!);
        songModel.songID = songId;
        songModel.isFavorite = true;
        favoriteSongs.add(songModel.toEntity());
      }

      return Right(favoriteSongs);

    } catch (e) {
      return const Left(
        'An Error Occurred'
      );
    }
  }
  
  @override
  Future<Either> getLatestSongs() async{
    try {
      List < SongEntity > songs = [];
      var data = await FirebaseFirestore.instance.collection('Songs').orderBy('release', descending: true).limit(1).get();

      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        bool isFavorite = await sl<IsFavoriteSongUseCase>().call(
          params: element.reference.id
        );
        songModel.isFavorite = isFavorite;
        songModel.songID = element.reference.id;
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