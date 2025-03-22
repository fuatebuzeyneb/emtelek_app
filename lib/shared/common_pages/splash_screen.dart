import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:emtelek/shared/widgets/bottom_nav_bar.dart';
import 'package:emtelek/shared/cubits/settings_cubit/settings_cubit.dart';
import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';
import 'package:emtelek/shared/services/shared_preferences_funs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  static String id = 'SplashView';
  @override
  Widget build(BuildContext context) {
    if (getIt<CacheHelper>().getDataString(key: 'Lang') == null) {
      saveLanguage('ar');
    } else {}
    BlocProvider.of<SettingsCubit>(context).openBox();
    return AnimatedSplashScreen(
      splash: 'assets/images/add_user.png',
      splashIconSize: 200,
      nextScreen: const BottomNavBar(),
      splashTransition: SplashTransition.slideTransition,
    );
  }
}
