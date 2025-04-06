import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:emtelek/features/home/domain/cubit/home_cubit.dart';
import 'package:emtelek/shared/widgets/bottom_nav_bar.dart';
import 'package:emtelek/shared/cubits/settings_cubit/settings_cubit.dart';
import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';
import 'package:emtelek/shared/services/shared_preferences_funs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget {
  static const String id = 'SplashPage';
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool isInitialized = false;

  late final HomeCubit homeCubit;
  late final SettingsCubit settingsCubit;

  @override
  void initState() {
    super.initState();
    homeCubit = context.read<HomeCubit>();
    settingsCubit = context.read<SettingsCubit>();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    if (getIt<CacheHelper>().getDataString(key: 'Lang') == null) {
      saveLanguage('ar');
    }

    await homeCubit.getHomeData();
    await settingsCubit.openBox();

    if (!mounted) return;
    setState(() {
      isInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: 'assets/images/add_user.png',
      splashIconSize: 200,
      backgroundColor: Colors.white,
      splashTransition: SplashTransition.fadeTransition,
      nextScreen:
          isInitialized ? const BottomNavBar() : const SplashPage(), // trick
      duration: 500, // صغير لأنه سيتم التحكم من خلال الحالة
      //splashIcon: Image.asset('assets/images/add_user.png'),
    );
  }
}
