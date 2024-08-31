import 'package:dartz/dartz.dart';
import 'package:gronk/doamin/repositories/auth/auth.dart';
import 'package:gronk/service_locator.dart';

import '../../../core/usecase/usecase.dart';

class GetUserUserCase implements UseCase<Either,dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<AuthRepository>().getUser();
  }

}