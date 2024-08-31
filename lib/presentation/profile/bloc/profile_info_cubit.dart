import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gronk/doamin/usecases/auth/get_user.dart';
import 'package:gronk/presentation/profile/bloc/profile_info_state.dart';

import '../../../service_locator.dart';

class ProfileInfoCubit extends Cubit<ProfileInfoState> {

  ProfileInfoCubit() : super(ProfileInfoLoading());

  Future<void> getUser() async {
    var user = await sl<GetUserUserCase>().call();

    user.fold(
      (l){
        emit(ProfileInfoFailure());
      },
      (userEntity){
        emit(ProfileInfoLoaded(userEntity: userEntity));
      }
    );
  }

}