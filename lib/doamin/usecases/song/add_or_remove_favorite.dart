import 'package:dartz/dartz.dart';
import 'package:gronk/core/usecase/usecase.dart';
import 'package:gronk/doamin/repositories/song/song.dart';

import '../../../service_locator.dart';

class AddOrRemoveFavoriteSongUsecase implements UseCase<Either,String> {
  @override
  Future<Either> call({String ? params}) async{
    return await sl<SongRepository>().addOrRemoveFavoriteSong(params!);
  }

}