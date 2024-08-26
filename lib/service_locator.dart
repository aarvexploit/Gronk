import 'package:get_it/get_it.dart';
import 'package:gronk/data/repository/auth/auth_repo_impl.dart';
import 'package:gronk/data/repository/song/song_repo_impl.dart';
import 'package:gronk/data/sources/auth/auth_firebase_services.dart';
import 'package:gronk/data/sources/songs/song.dart';
import 'package:gronk/doamin/repositories/auth/auth.dart';
import 'package:gronk/doamin/repositories/song/song.dart';
import 'package:gronk/doamin/usecases/auth/signin.dart';
import 'package:gronk/doamin/usecases/auth/signup.dart';
import 'package:gronk/doamin/usecases/song/get_news_song.dart';
import 'package:gronk/doamin/usecases/song/get_playlist.dart';

final sl = GetIt.instance;


Future<void> initializeDependencies() async{

  sl.registerSingleton<AuthFirebaseServices>(
    AuthFirebaseServicesImpl()
  );

  sl.registerSingleton<AuthRepository>(
    AuthRepoImpl()
  );

  sl.registerSingleton<SongFirebaseService>(
    SongFirebaseServiceImpl()
  );

  sl.registerSingleton<SongRepository>(
    SongRepositoryImpl()
  );

  
  sl.registerSingleton<SignupUseCase>(
    SignupUseCase()
  );
  
  sl.registerSingleton<SigninUseCase>(
    SigninUseCase()
  );

  sl.registerSingleton<GetNewsSongUseCase>(
    GetNewsSongUseCase()
  );

  sl.registerSingleton<GetPlaylistUseCase>(
    GetPlaylistUseCase()
  );

}