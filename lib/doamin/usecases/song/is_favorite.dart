import 'package:gronk/core/usecase/usecase.dart';
import 'package:gronk/doamin/repositories/song/song.dart';

import '../../../service_locator.dart';

class IsFavoriteSongUseCase implements UseCase<bool,String> {
  @override
  Future<bool> call({String ? params}) async{
    return await sl<SongRepository>().isFavoriteSong(params!);
  }

}