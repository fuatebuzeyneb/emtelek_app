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
  const SplashPage({super.key});
  static String id = 'SplashPage';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<void> _initializeApp() async {
    if (getIt<CacheHelper>().getDataString(key: 'Lang') == null) {
      saveLanguage('ar'); // اجعلها await حتى تنتظر انتهاء التنفيذ
    }
    await BlocProvider.of<HomeCubit>(context).getHomeData();
    await BlocProvider.of<SettingsCubit>(context).openBox();

    return Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeApp(), // استدعاء الدالة
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // عند اكتمال التحميل، انتقل إلى الشاشة التالية
          return const BottomNavBar();
        }
        // أثناء التحميل، اعرض شاشة السبلاش
        return AnimatedSplashScreen(
          splash: 'assets/images/add_user.png',
          splashIconSize: 200,
          nextScreen: const SizedBox(), // لا تعرض أي شيء حتى ينتهي التحميل
          splashTransition: SplashTransition.slideTransition,
        );
      },
    );
  }
}
