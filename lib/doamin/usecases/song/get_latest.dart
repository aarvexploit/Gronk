import 'package:dartz/dartz.dart';
import 'package:gronk/core/usecase/usecase.dart';
import 'package:gronk/doamin/repositories/song/song.dart';

import '../../../service_locator.dart';

class GetLatestUseCase implements UseCase<Either,dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<SongRepository>().getLatestSongs();
  }

}