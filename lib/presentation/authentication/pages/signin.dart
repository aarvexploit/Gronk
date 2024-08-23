import 'package:flutter/material.dart';
import 'package:gronk/common/widgets/appbar/app_bar.dart';
import 'package:gronk/common/widgets/button/basic_app_button.dart';
import 'package:gronk/data/models/auth/signin_user_req.dart';
import 'package:gronk/doamin/usecases/auth/signin.dart';
import 'package:gronk/presentation/authentication/pages/signup.dart';
import 'package:gronk/presentation/root/pages/root.dart';

import '../../../service_locator.dart';

class Signin extends StatelessWidget {
  Signin({super.key});

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      bottomNavigationBar: _createaccounttext(context),
      appBar: const BasicAppBar(),
      body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
          vertical: 50,
          horizontal: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _signintext(),
              const SizedBox( height: 50,),
              _emailField(context),
              const SizedBox( height: 50,),
              _passwordField(context),
              const SizedBox( height: 50,),
              BasicAppButton(
                onPressed: () async {
                  var result = await sl<SigninUseCase>().call(
                    params: SigninUserReq(
                      email: _email.text.toString(), 
                      password: _password.text.toString()
                      )
                  );
                  result.fold(
                    (l){
                      var snackbar = SnackBar(content: Text(l));
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    },
                    (r){
                      Navigator.pushAndRemoveUntil(
                        context, 
                        MaterialPageRoute(builder: (BuildContext context) => const RootPage()), 
                        (route) => false);
                    }
                    );
                }, 
                title: 'Sign In'
                )
            ],
          ),
        ),
      );
  }

  Widget _signintext(){
    return const Text(
      'Sign In',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25
      ),
    );
  }

  Widget _emailField(BuildContext context){
    return TextField(
      controller: _email,
      decoration: const InputDecoration(
        hintText: 'Email'
      ).applyDefaults(

        Theme.of(context).inputDecorationTheme
      ),
    );
  }

  Widget _passwordField(BuildContext context){
    return TextField(
      controller: _password,
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      decoration: const InputDecoration(
        hintText: 'Password'
      ).applyDefaults(

        Theme.of(context).inputDecorationTheme
      ),
    );
  }

  Widget _createaccounttext(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 30
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Dont't have a Account?",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14
            ),
          ),
          TextButton
          (onPressed: (){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => Signup()
                )
              );
          },
           child: const Text(
            'Register Now',
           )
           )
        ],
      ),
    );
  }
}