import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gronk/common/helpers/is_dark.dart';
import 'package:gronk/common/widgets/appbar/app_bar.dart';
import 'package:gronk/common/widgets/button/basic_app_button.dart';
import 'package:gronk/core/configs/assets/app_vectors.dart';
import 'package:gronk/core/configs/theme/app_colors.dart';
import 'package:gronk/core/configs/theme/app_images.dart';
import 'package:gronk/presentation/authentication/pages/signin.dart';
import 'package:gronk/presentation/authentication/pages/signup.dart';


class SignupOrSignin extends StatelessWidget {
  const SignupOrSignin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BasicAppBar(),
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(
              AppVectors.topPattern
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SvgPicture.asset(
              AppVectors.bottomPattern
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(
              AppImages.authBG
            ),
            ),
          
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Enjoy Listening To Music',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),
                  ),
                  const SizedBox(
                    height: 21,
                  ),
                  const Text(
                    'Gronk is a Indian Music Player app that provides the music Service on the go, You can listen to your favoraite music any time anywhere',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: AppColors.grey
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: BasicAppButton(
                          title : 'Register',
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => Signup()
                                )
                              );
                          },
                          ),
                      ),
                      const SizedBox(width: 40,),
                      TextButton(
                        onPressed: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => const Signin()
                                )
                              );
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: context.isDarkMode ? Colors.white : Colors.black
                          ),
                        )
                      )
                    ],
                  )
                ],
              
              ),
            )
            )

        ],
      ),
    );
  }
}