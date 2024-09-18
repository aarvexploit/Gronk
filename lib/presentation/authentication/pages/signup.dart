import 'package:flutter/material.dart';
import 'package:gronk/common/helpers/is_dark.dart';
import 'package:gronk/common/widgets/appbar/app_bar.dart';
import 'package:gronk/common/widgets/button/basic_app_button.dart';
import 'package:gronk/core/configs/assets/app_vectors.dart';
import 'package:gronk/core/configs/theme/app_colors.dart';
import 'package:gronk/data/models/auth/create_user_req.dart';
import 'package:gronk/doamin/usecases/auth/signup.dart';
import 'package:gronk/presentation/authentication/pages/signin.dart';
import 'package:gronk/presentation/home/pages/home.dart';
import 'package:gronk/service_locator.dart';

class Signup extends StatelessWidget {
  Signup({super.key});

  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      bottomNavigationBar: _signintext(context),
      appBar: BasicAppBar(
        title: Padding(
            // alignment: Alignment.topCenter,
          padding: const EdgeInsets.all(0),
          child: Image.asset(
            context.isDarkMode ? AppVectors.lightlogo : AppVectors.darklogo,
            height: 42,
            width: 193,
          )
        ),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
          vertical: 50,
          horizontal: 50),
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
              const SizedBox( height: 35,),
              BasicAppButton(
                onPressed: () async {
                  var result = await sl<SignupUseCase>().call(
                    params: CreateUserReq(
                      fullName: _fullName.text.toString(), 
                      email: _email.text.toString(), 
                      password: _password.text.toString()
                      )
                  );
                  result.fold(
                    (l){
                      var snackbar = SnackBar(content: const Text(
                        "Something went Wrong, please try later",
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ), 
                      behavior: SnackBarBehavior.floating, 
                      backgroundColor: AppColors.darkGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    },
                    (r){
                      Navigator.pushAndRemoveUntil(
                        context, 
                        MaterialPageRoute(builder: (BuildContext context) => const HomePage()), 
                        (route) => false);
                    }
                    );
                }, 
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
      controller: _fullName,
      decoration: const InputDecoration(
        hintText: 'Full Name'
      ).applyDefaults(

        Theme.of(context).inputDecorationTheme
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
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      controller: _password,
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
                builder: (BuildContext context) => Signin()
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