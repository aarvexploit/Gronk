import 'package:dartz/dartz.dart';
import 'package:gronk/core/usecase/usecase.dart';
import 'package:gronk/data/models/auth/create_user_req.dart';
import 'package:gronk/doamin/repositories/auth/auth.dart';

import '../../../service_locator.dart';

class SignupUseCase implements UseCase<Either,CreateUserReq> {
  @override
  Future<Either> call({CreateUserReq ? params}) {
    return sl<AuthRepository>().signup(params!);
  }

}