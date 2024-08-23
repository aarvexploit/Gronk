import 'package:get_it/get_it.dart';
import 'package:gronk/data/repository/auth/auth_repo_impl.dart';
import 'package:gronk/data/sources/auth/auth_firebase_services.dart';
import 'package:gronk/doamin/repositories/auth/auth.dart';
import 'package:gronk/doamin/usecases/auth/signin.dart';
import 'package:gronk/doamin/usecases/auth/signup.dart';

final sl = GetIt.instance;


Future<void> initializeDependencies() async{

  sl.registerSingleton<AuthFirebaseServices>(
    AuthFirebaseServicesImpl()
  );

  sl.registerSingleton<AuthRepository>(
    AuthRepoImpl()
  );
  
  sl.registerSingleton<SignupUseCase>(
    SignupUseCase()
  );
  
  sl.registerSingleton<SigninUseCase>(
    SigninUseCase()
  );

}