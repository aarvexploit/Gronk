import 'package:dartz/dartz.dart';
import 'package:gronk/data/models/auth/create_user_req.dart';
import 'package:gronk/data/models/auth/signin_user_req.dart';
import 'package:gronk/data/sources/auth/auth_firebase_services.dart';
import 'package:gronk/doamin/repositories/auth/auth.dart';

import '../../../service_locator.dart';

class AuthRepoImpl extends AuthRepository {
  @override
  Future<Either> signin(SigninUserReq signinUserReq) {
    return sl<AuthFirebaseServices>().signin(signinUserReq);
  }

  @override
  Future<Either> signup(CreateUserReq createUserReq) async {
    return sl<AuthFirebaseServices>().signup(createUserReq);
  }

}