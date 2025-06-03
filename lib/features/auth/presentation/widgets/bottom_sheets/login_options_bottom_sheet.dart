import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/core/utils/snackbar_utils.dart';
import 'package:emtelek/features/auth/domain/auth_cubit/auth_cubit.dart';
import 'package:emtelek/core/utils/page_transitions.dart';
import 'package:emtelek/features/auth/presentation/pages/login_page.dart';
import 'package:emtelek/features/auth/presentation/pages/signup_page.dart';
import 'package:emtelek/shared/widgets/bottom_nav_bar.dart';
import 'package:emtelek/shared/widgets/bottom_sheet_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/core/constants/app_colors.dart';

import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginOptionsBottomSheet extends StatelessWidget {
  const LoginOptionsBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignInFailure) {
          SnackbarUtils.showSnackbar(context, state.errorMassage, 3);
        } else if (state is SignInSuccuss) {
          Navigator.pushNamed(context, BottomNavBar.id);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is SignInLoading,
          child: BottomSheetWidget(
            height: 1,
            widgetBody: Column(
              children: [
                SizedBox(height: context.height * 0.05),
                Row(
                  children: [
                    GestureDetector(
                        child: const Icon(Icons.close),
                        onTap: () {
                          Navigator.pop(context);
                        }),
                    SizedBox(width: context.width * 0.37),
                    const TextWidget(
                      text: 'Logo',
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                12.toHeight,
                Image.asset(
                  'assets/images/add_user.png',
                  height: context.height * 0.2,
                  width: context.width * 1,
                ),
                20.toHeight,
                Row(
                  children: [
                    TextWidget(
                      text: S.of(context).LogInToAccessAllFeatures,
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                // 20.toHeight,
                // ButtonWidget(
                //   borderColor: Colors.black54,
                //   color: Colors.white,
                //   height: 0.06,
                //   width: 1,
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
                //     child: Row(
                //       children: [
                //         Image.asset('assets/icons/facebook.png',
                //             height: 20, width: 20),
                //         const SizedBox(width: 10),
                //         TextWidget(
                //             text: S.of(context).LoginWithFacebook,
                //             fontSize: 16),
                //       ],
                //     ),
                //   ),
                //   onTap: () async {
                //    // await authCubit.signInWithFacebook();
                //   },
                // ),
                20.toHeight,
                ButtonWidget(
                  borderColor: Colors.black54,
                  color: Colors.white,
                  height: 0.06,
                  width: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        Image.asset('assets/icons/google.png',
                            height: 20, width: 20),
                        const SizedBox(width: 10),
                        TextWidget(
                            text: S.of(context).LoginWithGoogle, fontSize: 16),
                      ],
                    ),
                  ),
                  onTap: () async {
                    await authCubit.signInWithGoogle();
                  },
                ),
                // 10.toHeight,
                // ButtonWidget(
                //   borderColor: Colors.black54,
                //   color: Colors.white,
                //   height: 0.06,
                //   width: 1,
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
                //     child: Row(
                //       children: [
                //         Image.asset('assets/icons/apple.png',
                //             height: 20, width: 20),
                //         const SizedBox(width: 10),
                //         TextWidget(
                //             text: S.of(context).LoginWithApple, fontSize: 16),
                //       ],
                //     ),
                //   ),
                //   onTap: () {},
                // ),
                10.toHeight,
                ButtonWidget(
                  borderColor: Colors.black54,
                  color: Colors.white,
                  height: 0.06,
                  width: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        Icon(Icons.email, color: AppColors.primary),
                        const SizedBox(width: 10),
                        TextWidget(
                            text: S.of(context).LoginWithEmail, fontSize: 16),
                      ],
                    ),
                  ),
                  onTap: () {
                    pageTransition(context, page: const LoginPage());
                  },
                ),
                20.toHeight,
                GestureDetector(
                  onTap: () {
                    pageTransition(context, page: const SignupPage());
                  },
                  child: TextWidget(
                      text: S.of(context).DontHaveAnEmtelekAccountCreateOne,
                      color: AppColors.primary,
                      fontSize: 16),
                ),
                16.toHeight,
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    TextWidget(
                      color: Colors.grey,
                      text: S.of(context).ByLoggingInYouAgreeTo,
                      fontSize: 12,
                    ),
                    GestureDetector(
                      child: TextWidget(
                        color: Colors.blue,
                        isHaveUnderline: true,
                        text: S.of(context).TermsAndConditions,
                        fontSize: 12,
                      ),
                    ),
                    TextWidget(
                      color: Colors.grey,
                      text: S.of(context).And,
                      fontSize: 12,
                    ),
                    GestureDetector(
                      child: TextWidget(
                        color: Colors.blue,
                        isHaveUnderline: true,
                        text: S.of(context).PrivacyPolicy,
                        fontSize: 12,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
