import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gronk/data/models/auth/create_user_req.dart';

abstract class AuthFirebaseServices {

  Future<Either> signup(CreateUserReq createUserReq);

  Future<void> signin();

}


class AuthFirebaseServicesImpl extends AuthFirebaseServices {
  @override
  Future<void> signin() {
    throw UnimplementedError();
  }

  @override
  Future<Either> signup(CreateUserReq createUserReq) async {
    try {

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: createUserReq.email, 
        password: createUserReq.password
        );

        return const Right('Signed up Succesfully');

    }on FirebaseAuthException catch(e) {
      String message = "";

      if(e.code == 'weak-password'){
        message = 'Password is Weak';
      } else if(e.code == 'emil-already-in-use'){
        message = 'Account alreasy Registered with email';
      }

      return left(message);
    }
  }
  
}