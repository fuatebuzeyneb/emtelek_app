import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/features/auth/domain/auth_cubit/auth_cubit.dart';
import 'package:emtelek/shared/cubits/settings_cubit/settings_cubit.dart';
import 'package:emtelek/core/utils/page_transitions.dart';
import 'package:emtelek/features/auth/presentation/pages/login_page.dart';
import 'package:emtelek/features/auth/presentation/pages/signup_page.dart';
import 'package:emtelek/shared/widgets/bottom_sheet_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/core/constants/app_colors.dart';

import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SettingsCubit settingsCubit = BlocProvider.of<SettingsCubit>(context);
    return BlocConsumer<SettingsCubit, SettingsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return BottomSheetWidget(
          circularRadius: 12,
          height: 0.26,
          widgetBody: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, right: 8.0, top: 8.0, bottom: 2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      text: S.of(context).SelectLanguage,
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    GestureDetector(
                        child: const Icon(Icons.close),
                        onTap: () {
                          Navigator.pop(context);
                        }),
                  ],
                ),
              ),
              Divider(
                thickness: 2,
                color: Colors.grey[300],
              ),
              12.toHeight,
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      settingsCubit.selectLanguageFunction(value: 'ar');
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(
                            text: S.of(context).Arabic,
                            fontSize: 16,
                            color: settingsCubit.locale == 'ar'
                                ? Colors.black
                                : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                          settingsCubit.locale == 'ar'
                              ? Icon(
                                  Icons.check,
                                  size: 20,
                                  color: AppColors.primary,
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                    child: Divider(
                      color: Colors.grey[300],
                    ),
                  ),
                  6.toHeight,
                  GestureDetector(
                    onTap: () {
                      settingsCubit.selectLanguageFunction(value: 'en');
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(
                            text: S.of(context).English,
                            fontSize: 16,
                            color: settingsCubit.locale == 'en'
                                ? Colors.black
                                : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                          settingsCubit.locale == 'en'
                              ? Icon(
                                  Icons.check,
                                  size: 20,
                                  color: AppColors.primary,
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                    child: Divider(
                      color: Colors.grey[300],
                    ),
                  ),
                  6.toHeight,
                  GestureDetector(
                    onTap: () {
                      settingsCubit.selectLanguageFunction(value: 'tr');
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(
                            text: S.of(context).Turkish,
                            fontSize: 16,
                            color: settingsCubit.locale == 'tr'
                                ? Colors.black
                                : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                          settingsCubit.locale == 'tr'
                              ? Icon(
                                  Icons.check,
                                  size: 20,
                                  color: AppColors.primary,
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                    child: Divider(
                      color: Colors.grey[300],
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
