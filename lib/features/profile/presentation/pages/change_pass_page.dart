import 'package:emtelek/core/constants/app_colors.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/core/utils/snackbar_utils.dart';
import 'package:emtelek/features/profile/domain/cubit/profile_cubit.dart';
import 'package:emtelek/generated/l10n.dart';

import 'package:emtelek/shared/widgets/appbar_widget.dart';
import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:emtelek/shared/widgets/text_field_widget.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePassPage extends StatefulWidget {
  const ChangePassPage({super.key});

  @override
  State<ChangePassPage> createState() => _ChangePassPageState();
}

class _ChangePassPageState extends State<ChangePassPage> {
  final oldPassController = TextEditingController();
  final newPassController = TextEditingController();
  final confirmNewPassController = TextEditingController();

  bool isChecking = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'Change Password',
        isHaveBackButton: true,
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is CheckPassFailure) {
            SnackbarUtils.showSnackbar(
                context, 'كلمة المرور القديمة غير صحيحة');
          } else if (state is CheckPassSuccess) {
            setState(() {
              isChecking = false;
            });
            context.read<ProfileCubit>().changePass(
                  password: newPassController.text,
                  oldPassword: oldPassController.text,
                );
          } else if (state is ChangePassSuccess) {
            SnackbarUtils.showSnackbar(context, 'تم تغيير كلمة المرور بنجاح');
            Navigator.pop(context);
          } else if (state is ChangePassFailure) {
            SnackbarUtils.showSnackbar(context, 'فشل في تغيير كلمة المرور');
          }
        },
        builder: (context, state) {
          final isLoading =
              state is CheckPassLoading || state is ChangePassLoading;

          return AbsorbPointer(
            absorbing: isLoading,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24),
              child: Column(
                children: [
                  TextFieldWidget(
                    label: TextWidget(
                      text: 'كلمه المرور القديمه',
                      fontSize: 16,
                    ),
                    onChanged: (value) {
                      oldPassController.text = value;
                    },
                  ),
                  12.toHeight,
                  TextFieldWidget(
                    label: TextWidget(
                      text: 'كلمه المرور الجديده',
                      fontSize: 16,
                    ),
                    onChanged: (value) {
                      newPassController.text = value;
                    },
                  ),
                  12.toHeight,
                  TextFieldWidget(
                    label: TextWidget(
                      text: 'تاكيد كلمه المرور الجديده',
                      fontSize: 16,
                    ),
                    onChanged: (value) {
                      confirmNewPassController.text = value;
                    },
                  ),
                  32.toHeight,
                  ButtonWidget(
                    onTap: () {
                      final oldPass = oldPassController.text.trim();
                      final newPass = newPassController.text.trim();
                      final confirmPass = confirmNewPassController.text.trim();

                      if (newPass != confirmPass) {
                        SnackbarUtils.showSnackbar(
                            context, 'كلمتا المرور غير متطابقتين');

                        return;
                      }

                      setState(() {
                        isChecking = true;
                      });

                      context.read<ProfileCubit>().checkPass(password: oldPass);
                    },
                    color: AppColors.primary,
                    borderRadius: 6,
                    height: 0.06,
                    text: isLoading ? '...جاري المعالجة' : 'تغيير كلمة المرور',
                    width: 1,
                    fontSize: 20,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
