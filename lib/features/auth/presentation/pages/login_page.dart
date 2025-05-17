import 'dart:math';

import 'package:emtelek/features/auth/data/models/login_request_model.dart';
import 'package:emtelek/shared/widgets/bottom_nav_bar.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/features/auth/domain/auth_cubit/auth_cubit.dart';
import 'package:emtelek/shared/cubits/settings_cubit/settings_cubit.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/core/utils/page_transitions.dart';
import 'package:emtelek/core/utils/snackbar_utils.dart';
import 'package:emtelek/core/constants/app_colors.dart';

import 'package:emtelek/features/auth/presentation/pages/forgot_password_page.dart';

import 'package:emtelek/features/auth/presentation/widgets/bottom_sheets/login_options_bottom_sheet.dart';
import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:emtelek/shared/widgets/text_field_widget.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const String id = 'LoginView';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignInFailure) {
          SnackbarUtils.showSnackbar(context, state.errorMassage, 2);
        } else if (state is SignInSuccuss) {
          Navigator.pushNamed(context, BottomNavBar.id);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is SignInLoading,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              title: GestureDetector(
                  child: const Icon(Icons.arrow_back_ios, color: Colors.black),
                  onTap: () {
                    Navigator.pop(context);
                  }),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    30.toHeight,
                    TextWidget(text: S.of(context).Login, fontSize: 20),
                    20.toHeight,
                    TextFieldWidget(
                      keyboardType: TextInputType.emailAddress,
                      hint: S.of(context).Email,
                      controller: emailController,
                    ),
                    16.toHeight,
                    TextFieldWidget(
                      keyboardType: TextInputType.text,
                      hint: S.of(context).Password,
                      controller: passwordController,
                    ),
                    16.toHeight,
                    GestureDetector(
                      child: TextWidget(
                          text: S.of(context).DidYouForgetYourPassword,
                          fontSize: 16,
                          color: AppColors.primary),
                      onTap: () {
                        pageTransition(context,
                            page: const ForgotPasswordPage());
                      },
                    ),
                    16.toHeight,
                    ButtonWidget(
                      color: AppColors.primary,
                      height: 0.07,
                      width: 1,
                      text: S.of(context).Login,
                      colorText: Colors.white,
                      fontSize: 18,
                      onTap: () {
                        // context.read<AuthCubit>().email =
                        //     context.read<AuthCubit>().email;
                        // context.read<AuthCubit>().password =
                        //     context.read<AuthCubit>().password;
                        context.read<AuthCubit>().signIn(
                              loginRequestModel: LoginRequestModel(
                                  email: emailController.text,
                                  password: passwordController.text),
                            );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
