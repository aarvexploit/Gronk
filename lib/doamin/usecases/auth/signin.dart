import 'package:dartz/dartz.dart';
import 'package:gronk/core/usecase/usecase.dart';
import 'package:gronk/data/models/auth/signin_user_req.dart';
import 'package:gronk/doamin/repositories/auth/auth.dart';

import '../../../service_locator.dart';

class SigninUseCase implements UseCase<Either,SigninUserReq> {
  @override
  Future<Either> call({SigninUserReq ? params}) {
    return sl<AuthRepository>().signin(params!);
  }

}