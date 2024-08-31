import 'package:dartz/dartz.dart';

abstract class SongRepository {
  
  Future<Either> getNewsSongs();
  Future<Either> getPlaylist();
  Future<Either> addOrRemoveFavoriteSong(String songId);
  Future<bool> isFavoriteSong(String songId);
  Future<Either> getUserFavoriteSongs();

}