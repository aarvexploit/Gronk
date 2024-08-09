import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:gronk/common/widgets/button/basic_app_button.dart';
// import 'package:gronk/core/configs/assets/app_vectors.dart';
import 'package:gronk/core/configs/theme/app_colors.dart';
import 'package:gronk/core/configs/theme/app_images.dart';


class ChooseModePage extends StatelessWidget {
  const ChooseModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 40,
              horizontal: 40
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  AppImages.choosemodebg,
                )
              )
            ),
          ),

          Container(
            color: Colors.black.withOpacity(0.15),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 80,
              horizontal: 80
            ),
            child: Column(
                children: [
                  // Align(
                  //   alignment: Alignment.topCenter,
                  //   child: SvgPicture.asset(
                  //     AppVectors.darklogo
                  //   ),
                  // ),
                  const Spacer(),
                  const Text(
                    'Enjoy Your Favoraite Music',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18
                    ),
                  ),
                  const SizedBox(height: 21,),
                  const Text(
                    'Listen to your Music anytime anywhere just the music on your fingertips ready toburst your ears with the stunning tunes and your favoraite lyrics.',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey,
                      fontSize: 13
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20,),
                  BasicAppButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => const ChooseModePage()
                          )
                        );
                    },
                     title: 'Get Started'
                     )
                ],
              ),
          )
        ],
        ),
    );
  }
}