import 'dart:async';

import 'package:emtelek/core/constants/app_colors.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/core/utils/snackbar_utils.dart';
import 'package:emtelek/features/profile/data/models/change_password_request_model.dart';
import 'package:emtelek/features/profile/data/models/check_password_request_model.dart';
import 'package:emtelek/features/profile/domain/cubit/profile_cubit.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';

import 'package:emtelek/shared/widgets/appbar_widget.dart';
import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:emtelek/shared/widgets/loading_widget.dart';
import 'package:emtelek/shared/widgets/text_field_widget.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ChangePassPage extends StatefulWidget {
  const ChangePassPage({super.key});

  @override
  State<ChangePassPage> createState() => _ChangePassPageState();
}

class _ChangePassPageState extends State<ChangePassPage> {
  final oldPassController = TextEditingController();
  final newPassController = TextEditingController();
  final confirmNewPassController = TextEditingController();
  Timer? _debounce;

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
          } else if (state is ChangePassSuccess) {
            SnackbarUtils.showSnackbar(context, 'تم تغيير كلمة المرور بنجاح');
            Navigator.pop(context);
          } else if (state is ChangePassFailure) {
            SnackbarUtils.showSnackbar(context, 'فشل في تغيير كلمة المرور');
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state is ChangePassLoading,
            progressIndicator: const Center(child: LoadingWidget()),
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
                      if (_debounce?.isActive ?? false) _debounce!.cancel();

                      // نبدأ مؤقت جديد
                      _debounce = Timer(const Duration(seconds: 1), () {
                        // هنا ترسل الريكويست للتحقق من كلمة المرور
                        // مثلاً:
                        context.read<ProfileCubit>().checkPass(
                                checkPasswordRequestModel:
                                    CheckPasswordRequestModel(
                              password: value,
                            ));
                      });

                      // ممكن تحدّث الكنترولر لو تحب
                      oldPassController.text = value;
                    },
                  ),
                  12.toHeight,
                  TextFieldWidget(
                    label: TextWidget(
                      text: 'كلمه المرور الجديده',
                      fontSize: 16,
                    ),
                    controller: newPassController,
                  ),
                  12.toHeight,
                  TextFieldWidget(
                    label: TextWidget(
                      text: 'تاكيد كلمه المرور الجديده',
                      fontSize: 16,
                    ),
                    controller: confirmNewPassController,
                  ),
                  32.toHeight,
                  ButtonWidget(
                    onTap: () {
                      if (newPassController.text ==
                          confirmNewPassController.text) {
                        context.read<ProfileCubit>().changePass(
                              changePasswordRequestModel:
                                  ChangePasswordRequestModel(
                                oldPassword: oldPassController.text,
                                password: newPassController.text,
                              ),
                            );
                      } else {
                        SnackbarUtils.showSnackbar(
                            context, 'كلمة المرور غير متطابقة');
                      }
                    },
                    color: AppColors.primary,
                    borderRadius: 6,
                    height: 0.06,
                    text: 'تغيير كلمة المرور',
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
