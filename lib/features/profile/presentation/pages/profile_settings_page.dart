import 'package:emtelek/core/constants/app_colors.dart';
import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/features/profile/data/models/edit_user_request_model.dart';
import 'package:emtelek/features/profile/domain/cubit/profile_cubit.dart';
import 'package:emtelek/features/profile/presentation/widgets/circle_profile_image_widget.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/shared/cubits/settings_cubit/settings_cubit.dart';
import 'package:emtelek/shared/models/token_and_clint_id_request_model.dart';
import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';
import 'package:emtelek/shared/widgets/appbar_widget.dart';
import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:emtelek/shared/widgets/loading_widget.dart';
import 'package:emtelek/shared/widgets/text_field_widget.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({super.key});

  static const String id = 'ProfileSettingsPage';

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    addressController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ProfileCubit profileCubit = BlocProvider.of<ProfileCubit>(context);
    return Scaffold(
      appBar: AppBarWidget(
          title: S.of(context).AccountSettings, isHaveBackButton: true),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is GetAccountSettingsSuccess) {
            firstNameController.text =
                context.read<ProfileCubit>().userData!.data.firstName;
            lastNameController.text =
                context.read<ProfileCubit>().userData!.data.lastName;
            phoneController.text = context
                .read<ProfileCubit>()
                .userData!
                .data
                .phoneNumber
                .toString();
            addressController.text =
                context.read<ProfileCubit>().userData!.addressData == null
                    ? ''
                    : context
                        .read<ProfileCubit>()
                        .userData!
                        .addressData!
                        .address;
          }
        },
        builder: (context, state) {
          return state is UserDataLoading
              ? const Center(
                  child: LoadingWidget(),
                )
              : state is UserDataFailure
                  ? Center(
                      child: Text(state.errorMassage),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: Column(
                        children: [
                          12.toHeight,
                          CircleProfileImageWidget(
                            showEditImage: true,
                            heightAndWidth: context.height * 0.1,
                          ),
                          12.toHeight,
                          TextFieldWidget(
                            label: TextWidget(
                              text: S.of(context).FirstName,
                              fontSize: 16,
                            ),
                            controller: firstNameController,
                          ),
                          12.toHeight,
                          TextFieldWidget(
                            controller: lastNameController,
                            label: TextWidget(
                              text: S.of(context).LastName,
                              fontSize: 16,
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
                                    text: '${S.of(context).Email}: ',
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                  TextWidget(
                                    text:
                                        '${profileCubit.userData!.data!.email}',
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          12.toHeight,
                          TextFieldWidget(
                            controller: phoneController,
                            label: TextWidget(
                              text: S.of(context).PhoneNumber,
                              fontSize: 16,
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
                                    text: profileCubit.userData!.addressData !=
                                            null
                                        ? BlocProvider.of<SettingsCubit>(
                                                context)
                                            .getCityNameByDistrictId(
                                                profileCubit
                                                        .userData!
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
                                    text: profileCubit.userData!.addressData !=
                                            null
                                        ? BlocProvider.of<SettingsCubit>(
                                                context)
                                            .getDistrictNameByDistrictId(
                                                profileCubit
                                                        .userData!
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
                            label: TextWidget(
                              text: S.of(context).Address,
                              fontSize: 16,
                            ),
                            maxLines: 3,
                            controller: addressController,
                          ),
                          12.toHeight,
                          ButtonWidget(
                            onTap: () {
                              profileCubit.editUserData(
                                editUserRequestModel: EditUserRequestModel(
                                  firstName: firstNameController.text,
                                  lastName: lastNameController.text,
                                  phoneNumber: phoneController.text,
                                  image: profileCubit.editImage, // هذا يكفي
                                  address: addressController.text,
                                  districtId: profileCubit.editDistrictId ==
                                          null
                                      ? profileCubit.userData!.addressData ==
                                              null
                                          ? null
                                          : profileCubit
                                              .userData!.addressData!.districtId
                                      : profileCubit.editDistrictId!, // 34,
                                  email: getIt<CacheHelper>()
                                      .getData(key: 'email'),
                                ),
                              );
                            },
                            color: AppColors.primary,
                            borderRadius: 6,
                            height: 0.06,
                            text: S.of(context).Save,
                            width: 1,
                            fontSize: 22,
                          ),
                          20.toHeight,
                          ButtonWidget(
                            onTap: () {
                              profileCubit.deleteUserAccount(
                                tokenAndClintIdRequestModel:
                                    TokenAndClintIdRequestModel(
                                        clientId: getIt<CacheHelper>()
                                            .getData(key: 'clientId'),
                                        token: getIt<CacheHelper>()
                                            .getDataString(key: 'token')!),
                              );
                            },
                            color: Colors.red,
                            borderRadius: 6,
                            height: 0.06,
                            text: 'delete account',
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
