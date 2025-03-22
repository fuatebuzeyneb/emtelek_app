import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/features/auth/domain/auth_cubit/auth_cubit.dart';
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

class SignOutBottomSheet extends StatelessWidget {
  const SignOutBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomSheetWidget(
      circularRadius: 12,
      height: 0.24,
      widgetBody: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  text: S.of(context).SignOutFromApp,
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
          8.toHeight,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                TextWidget(
                  text: S.of(context).AreYouSureSignOut,
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
          20.toHeight,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ButtonWidget(
                text: S.of(context).Agree,
                color: Colors.black,
                colorText: Colors.white,
                fontSize: 16,
                width: 0.4,
                onTap: () {
                  context.read<AuthCubit>().signOut();
                  Navigator.pop(context);
                },
              ),
              ButtonWidget(
                text: S.of(context).Cancel,
                color: Colors.white,
                colorText: Colors.black,
                borderColor: Colors.black,
                fontSize: 16,
                width: 0.4,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
