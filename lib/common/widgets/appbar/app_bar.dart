import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gronk/common/helpers/is_dark.dart';
import 'package:gronk/presentation/choose_mode/bloc/theme_cubit.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {

  final Widget ? title;
  final Widget ? action;
  final Color ? backgroundColor;
  final bool hideBack;

  const BasicAppBar({
    this.title,
    this.action,
    this.hideBack = false,
    this.backgroundColor,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: title ?? const Text(''),
      actions: [
        action ?? Container()
      ],
      leading: hideBack ? _changeTheme(context) : _backButton(context)
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);


  Widget _changeTheme(BuildContext context) {
    return IconButton(
        onPressed: (){
          context.isDarkMode ? context.read<ThemeCubit>().updateTheme(ThemeMode.light) : context.read<ThemeCubit>().updateTheme(ThemeMode.dark);
        },
        // icon: Container(
        //   height: 50,
        //   width: 50,
        //   // decoration: BoxDecoration(
        //   //   color:context.isDarkMode ? Colors.white.withOpacity(0.03) : Colors.black.withOpacity(0.03),
        //   //   shape: BoxShape.circle
        //   // ),
        //   child:
        icon: Icon(
            context.isDarkMode ? Icons.sunny : Icons.mode_night_outlined,
            size: 15,
            color: context.isDarkMode ? Colors.white : Colors.black,
          ),
        );
    }

    Widget _backButton(BuildContext context) {
      return IconButton(
        onPressed: (){
          Navigator.pop(context);
        },
        icon: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color:context.isDarkMode ? Colors.white.withOpacity(0.03) : Colors.black.withOpacity(0.03),
            shape: BoxShape.circle
          ),
          child: Icon(
            Icons.arrow_back_ios_new,
            size: 15,
            color: context.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      );
    }
  }