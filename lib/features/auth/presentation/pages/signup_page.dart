import 'package:emtelek/features/auth/data/models/sign_up_request_model.dart';
import 'package:emtelek/shared/widgets/bottom_nav_bar.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/features/auth/domain/auth_cubit/auth_cubit.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/core/utils/snackbar_utils.dart';
import 'package:emtelek/core/constants/app_colors.dart';

import 'package:emtelek/features/auth/presentation/pages/login_page.dart';
import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:emtelek/shared/widgets/loading_widget.dart';
import 'package:emtelek/shared/widgets/text_field_widget.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  static const String id = 'SignupView';

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignUpFailure) {
          SnackbarUtils.showSnackbar(context, state.errorMassage, 3);
        } else if (state is SignUpSuccuss) {
          Navigator.pushNamed(context, LoginPage.id);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is SignUpLoading,
          progressIndicator: const Center(child: LoadingWidget()),
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              title: Row(
                children: [
                  GestureDetector(
                      child:
                          const Icon(Icons.arrow_back_ios, color: Colors.black),
                      onTap: () {
                        Navigator.pop(context);
                      }),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    20.toHeight,
                    TextWidget(
                        text: S.of(context).CreateNewAccount,
                        fontSize: 24,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold),
                    20.toHeight,
                    TextFieldWidget(
                      hint: S.of(context).FirstName,
                      keyboardType: TextInputType.name,
                      controller: firstNameController,
                    ),
                    16.toHeight,
                    TextFieldWidget(
                      hint: S.of(context).LastName,
                      keyboardType: TextInputType.name,
                      controller: lastNameController,
                    ),
                    16.toHeight,
                    TextFieldWidget(
                      hint: S.of(context).PhoneNumber,
                      keyboardType: TextInputType.phone,
                      controller: phoneController,
                    ),
                    16.toHeight,
                    TextFieldWidget(
                      hint: S.of(context).Email,
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                    ),
                    16.toHeight,
                    TextFieldWidget(
                      hint: S.of(context).Password,
                      keyboardType: TextInputType.text,
                      controller: passwordController,
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
                        context.read<AuthCubit>().signUp(
                            signUpRequestModel: SignUpRequestModel(
                                firstName: firstNameController.text,
                                lastName: lastNameController.text,
                                phoneNumber: phoneController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                accountType: '1'));
                      },
                    ),
                    16.toHeight,
                    Row(
                      children: [
                        TextWidget(
                          color: Colors.grey,
                          text: S.of(context).ByContinuingYouAgreeTo,
                          fontSize: 12,
                        ), //
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
                        )
                      ],
                    )
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
