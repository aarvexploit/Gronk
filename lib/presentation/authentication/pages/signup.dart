import 'package:flutter/material.dart';
import 'package:gronk/common/widgets/appbar/app_bar.dart';
import 'package:gronk/common/widgets/button/basic_app_button.dart';
import 'package:gronk/presentation/authentication/pages/signin.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      bottomNavigationBar: _signintext(context),
      appBar: const BasicAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 50,
          horizontal: 50
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _registertext(),
            const SizedBox( height: 50,),
            _fullNameField(context),
            const SizedBox( height: 50,),
            _emailField(context),
            const SizedBox( height: 50,),
            _passwordField(context),
            const SizedBox( height: 42,),
            BasicAppButton(
              onPressed: (){}, 
              title: 'Create Account'
              )
          ],
        ),
      ),
    );
  }

  Widget _registertext(){
    return const Text(
      'Register',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25
      ),
    );
  }

  Widget _fullNameField(BuildContext context){
    return TextField(
      decoration: const InputDecoration(
        hintText: 'Full Name'
      ).applyDefaults(

        Theme.of(context).inputDecorationTheme
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

  Widget _signintext(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 30
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Do you have an Account? ',
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
                builder: (BuildContext context) => const Signin()
                )
              );
          },
           child: const Text(
            'Sign in',
           )
           )
        ],
      ),
    );
  }
}