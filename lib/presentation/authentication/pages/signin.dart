import 'package:flutter/material.dart';
import 'package:gronk/common/widgets/appbar/app_bar.dart';
import 'package:gronk/common/widgets/button/basic_app_button.dart';
import 'package:gronk/presentation/authentication/pages/signup.dart';

class Signin extends StatelessWidget {
  const Signin({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      bottomNavigationBar: _createaccounttext(context),
      appBar: const BasicAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 50,
          horizontal: 50
        ),
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
              onPressed: (){}, 
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
      decoration: const InputDecoration(
        hintText: 'Email'
      ).applyDefaults(

        Theme.of(context).inputDecorationTheme
      ),
    );
  }

  Widget _passwordField(BuildContext context){
    return TextField(
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