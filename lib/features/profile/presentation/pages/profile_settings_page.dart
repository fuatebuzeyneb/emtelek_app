import 'package:emtelek/core/constants/app_colors.dart';
import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/features/profile/domain/cubit/profile_cubit.dart';
import 'package:emtelek/features/profile/presentation/widgets/circle_profile_image_widget.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/shared/cubits/settings_cubit/settings_cubit.dart';
import 'package:emtelek/shared/widgets/appbar_widget.dart';
import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:emtelek/shared/widgets/loading_widget.dart';
import 'package:emtelek/shared/widgets/text_field_widget.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileSettingsPage extends StatelessWidget {
  const ProfileSettingsPage({super.key});

  static const String id = 'ProfileSettingsPage';

  @override
  Widget build(BuildContext context) {
    ProfileCubit profileCubit = BlocProvider.of<ProfileCubit>(context);
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.white,
        elevation: 2,
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: false,
        title: AppBarWidget(
          title: S.of(context).AccountSettings,
          onTap: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: AppColors.appBarBackground,
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return state is GetAccountSettingsLoading ||
                  state is EditAccountSettingsLoading
              ? const Center(
                  child: LoadingWidget(),
                )
              : state is GetAccountSettingsFailure
                  ? Center(
                      child: Text(state.errorMassage),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: Column(
                        children: [
                          12.toHeight,
                          CircleProfileImageWidget(),
                          12.toHeight,
                          TextFieldWidget(
                            initialValue:
                                profileCubit.accountData!.data!.firstName,
                            label: TextWidget(
                              text: S.of(context).FirstName,
                              fontSize: 16,
                            ),
                            onChanged: (value) {
                              profileCubit.editFirstName = value;
                            },
                          ),
                          12.toHeight,
                          TextFieldWidget(
                            initialValue:
                                profileCubit.accountData!.data!.lastName,
                            label: TextWidget(
                              text: S.of(context).LastName,
                              fontSize: 16,
                            ),
                            onChanged: (value) {
                              profileCubit.editLastName = value;
                            },
                          ),
                          12.toHeight,
                          ButtonWidget(
                            onTap: () {},
                            color: Colors.white,
                            borderColor: Colors.black54,
                            width: 1,
                            borderRadius: 6,
                            height: 0.06,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                children: [
                                  TextWidget(
                                    text: '${S.of(context).Email}: ',
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                  TextWidget(
                                    text:
                                        '${profileCubit.accountData!.data!.email}',
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          12.toHeight,
                          ButtonWidget(
                            onTap: () {},
                            color: Colors.white,
                            borderColor: Colors.black54,
                            width: 1,
                            borderRadius: 6,
                            height: 0.06,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                children: [
                                  TextWidget(
                                    text: '${S.of(context).Password}: ',
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                  TextWidget(
                                    text: '***************',
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.edit,
                                    color: Colors.grey,
                                    size: 22,
                                  )
                                ],
                              ),
                            ),
                          ),
                          12.toHeight,
                          ButtonWidget(
                            onTap: () {},
                            color: Colors.white,
                            borderColor: Colors.black54,
                            width: 1,
                            borderRadius: 6,
                            height: 0.06,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                children: [
                                  TextWidget(
                                    text: '${S.of(context).City}: ',
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                  TextWidget(
                                    text:
                                        profileCubit.accountData!.addressData !=
                                                null
                                            ? BlocProvider.of<SettingsCubit>(
                                                    context)
                                                .getCityNameByDistrictId(
                                                    profileCubit
                                                            .accountData!
                                                            .addressData!
                                                            .districtId ??
                                                        99999999)
                                            : '',
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.edit,
                                    color: Colors.grey,
                                    size: 22,
                                  )
                                ],
                              ),
                            ),
                          ),
                          12.toHeight,
                          ButtonWidget(
                            onTap: () {},
                            color: Colors.white,
                            borderColor: Colors.black54,
                            width: 1,
                            borderRadius: 6,
                            height: 0.06,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                children: [
                                  TextWidget(
                                    text: '${S.of(context).Region}: ',
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                  TextWidget(
                                    text:
                                        profileCubit.accountData!.addressData !=
                                                null
                                            ? BlocProvider.of<SettingsCubit>(
                                                    context)
                                                .getDistrictNameByDistrictId(
                                                    profileCubit
                                                            .accountData!
                                                            .addressData!
                                                            .districtId ??
                                                        99999999)
                                            : '',
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.edit,
                                    color: Colors.grey,
                                    size: 22,
                                  )
                                ],
                              ),
                            ),
                          ),
                          12.toHeight,
                          TextFieldWidget(
                            initialValue: profileCubit
                                        .accountData!.addressData !=
                                    null
                                ? '${profileCubit.accountData!.addressData!.address}'
                                : '',
                            label: TextWidget(
                              text: S.of(context).Address,
                              fontSize: 16,
                            ),
                            maxLines: 3,
                            onChanged: (value) {
                              profileCubit.editAddress = value;
                            },
                          ),
                          12.toHeight,
                          ButtonWidget(
                            onTap: () {
                              profileCubit.editAccountSettings(
                                firstName: profileCubit.editFirstName,
                                lastName: profileCubit.editLastName,
                                phoneNumber: profileCubit.editPhoneNumber,
                                image: profileCubit.editImage,
                                address: profileCubit.editAddress,
                                districtId: profileCubit.editDistrictId,
                              );
                            },
                            color: AppColors.primary,
                            borderRadius: 6,
                            height: 0.06,
                            text: S.of(context).Save,
                            width: 1,
                            fontSize: 22,
                          )
                        ],
                      ),
                    );
        },
      ),
    );
  }
}
