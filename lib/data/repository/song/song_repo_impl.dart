import 'package:dartz/dartz.dart';
import 'package:gronk/data/sources/songs/song.dart';
import 'package:gronk/doamin/repositories/song/song.dart';

import '../../../service_locator.dart';

class SongRepositoryImpl extends SongRepository{
  @override
  Future<Either> getNewsSongs() async{
    return await sl<SongFirebaseService>().getNewsSongs();
  }
  
  @override
  Future<Either> getPlaylist() async {
    return await sl<SongFirebaseService>().getPlaylist();
  }
  
}