import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/core/constants/app_colors.dart';

import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:emtelek/shared/widgets/text_field_widget.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  static const String id = 'ForgotPasswordView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              TextWidget(
                  text: S.of(context).ForgotPassword,
                  fontSize: 24,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold),
              16.toHeight,
              TextWidget(
                  color: Colors.grey,
                  text: S
                      .of(context)
                      .TheProcessIsSimpleEnterYourEmailAndWeWillSendYouALinkToCreateANewPassword,
                  fontSize: 18),
              16.toHeight,
              TextFieldWidget(
                hint: S.of(context).Email,
              ),
              16.toHeight,
              ButtonWidget(
                color: AppColors.primary,
                height: 0.07,
                width: 1,
                text: S.of(context).RestorePassword,
                colorText: Colors.white,
                fontSize: 18,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
