import 'package:emtelek/features/add_property_listing/presentation/pages/finish_page.dart';
import 'package:emtelek/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:emtelek/features/auth/presentation/pages/login_page.dart';
import 'package:emtelek/features/auth/presentation/pages/signup_page.dart';
import 'package:emtelek/features/my_ads/presentation/pages/my_ads_page.dart';
import 'package:emtelek/features/my_searches/presentation/pages/my_searches_page.dart';
import 'package:emtelek/features/profile/presentation/pages/profile_settings_page.dart';
import 'package:emtelek/shared/common_pages/search_text_page.dart';
import 'package:emtelek/shared/common_pages/splash_page.dart';
import 'package:emtelek/shared/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  //---------------flight ticket-------------------
  BottomNavBar.id: (context) => const BottomNavBar(),
  LoginPage.id: (context) => const LoginPage(),
  SplashPage.id: (context) => const SplashPage(),

  ForgotPasswordPage.id: (context) => const ForgotPasswordPage(),
  SignupPage.id: (context) => const SignupPage(),
//  FinishPage.id: (context) => const FinishPage(),
  ProfileSettingsPage.id: (context) => const ProfileSettingsPage(),
  MyAdsPage.id: (context) => const MyAdsPage(),
  MySearchesPage.id: (context) => const MySearchesPage(),
};
