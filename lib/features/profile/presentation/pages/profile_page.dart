import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/core/utils/page_transitions.dart';
import 'package:emtelek/features/auth/domain/auth_cubit/auth_cubit.dart';
import 'package:emtelek/features/my_ads/domain/cubit/my_ads_cubit.dart';
import 'package:emtelek/features/my_searchs/presentation/pages/my_searches_page.dart';
import 'package:emtelek/features/profile/domain/cubit/profile_cubit.dart';
import 'package:emtelek/features/my_ads/presentation/pages/my_ads_page.dart';
import 'package:emtelek/features/profile/presentation/pages/change_pass_page.dart';
import 'package:emtelek/features/profile/presentation/pages/profile_settings_page.dart';
import 'package:emtelek/features/profile/presentation/widgets/circle_profile_image_widget.dart';
import 'package:emtelek/features/search_property/domain/property_cubit/property_cubit.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';
import 'package:emtelek/core/constants/app_colors.dart';

import 'package:emtelek/features/profile/presentation/widgets/bottom_sheets/currency_conversion_bottom_sheet.dart';
import 'package:emtelek/features/profile/presentation/widgets/bottom_sheets/language_bottom_sheet.dart';
import 'package:emtelek/features/profile/presentation/widgets/bottom_sheets/sign_out_bottom_sheet.dart';
import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:emtelek/shared/widgets/list_title_widget.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey[50],
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: context.height * 0.06),
                  ButtonWidget(
                    showElevation: true,
                    borderRadius: 4,
                    color: Colors.white,
                    height: 0.17,
                    width: 1,
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          CircleProfileImageWidget(
                            showEditImage: false,
                            heightAndWidth: context.height * 0.08,
                          ),
                          16.toWidth,
                          getIt<CacheHelper>().getDataString(key: 'token') !=
                                  null
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextWidget(
                                        text:
                                            '${getIt<CacheHelper>().getDataString(key: 'firstName')} ${getIt<CacheHelper>().getDataString(key: 'lastName')}',
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    2.toHeight,
                                    ButtonWidget(
                                        onTap: () {},
                                        height: 0.04,
                                        width: 0.35,
                                        borderRadius: 4,
                                        borderColor: Colors.grey,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            TextWidget(
                                                text: S.of(context).GetVerified,
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                            Image.asset(
                                              'assets/icons/verify.png',
                                              height: 20,
                                              width: 20,
                                            ),
                                          ],
                                        )),
                                    8.toHeight,
                                    TextWidget(
                                        text:
                                            '${S.of(context).JoinedOn} ${getIt<CacheHelper>().getDataString(key: 'joinDate')?.substring(0, 10) ?? ''}',
                                        fontSize: 14,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold),
                                  ],
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextWidget(
                                        text: S.of(context).Hello,
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    2.toHeight,
                                    TextWidget(
                                        text: S.of(context).SignInAndPost,
                                        fontSize: 14,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold),
                                    6.toHeight,
                                    ButtonWidget(
                                        onTap: () {},
                                        height: 0.04,
                                        width: 0.35,
                                        borderRadius: 4,
                                        borderColor: Colors.grey,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            TextWidget(
                                                text: S.of(context).GetVerified,
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ],
                                        )),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ),
                  16.toHeight,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ButtonWidget(
                        color: Colors.white,
                        showElevation: true,
                        onTap: () {
                          BlocProvider.of<MyAdsCubit>(context).getMyAds();
                          pageTransition(context, page: const MyAdsPage());
                        },
                        height: 0.1,
                        width: 0.45,
                        borderRadius: 8,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              'assets/icons/megaphone.png',
                              height: 30,
                              width: 30,
                              color: AppColors.primary,
                            ),
                            TextWidget(
                                text: S.of(context).MyAds,
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ],
                        ),
                      ),
                      ButtonWidget(
                        color: Colors.white,
                        showElevation: true,
                        onTap: () {
                          BlocProvider.of<PropertyCubit>(context)
                              .getSearchFilter();
                          pageTransition(context, page: const MySearchesPage());
                        },
                        height: 0.1,
                        width: 0.45,
                        borderRadius: 8,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icons/explore.png',
                              height: 30,
                              width: 30,
                              color: AppColors.primary,
                            ),
                            8.toHeight,
                            TextWidget(
                                text: S.of(context).MySearches,
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ],
                        ),
                      ),
                    ],
                  ),
                  20.toHeight,
                  getIt<CacheHelper>().getDataString(key: 'token') == null
                      ? const SizedBox()
                      : LitsTitleWidget(
                          image: 'assets/icons/setting.png',
                          title: S.of(context).AccountSettings,
                          onTap: () {
                            BlocProvider.of<ProfileCubit>(context)
                                .getAccountSettings();
                            pageTransition(context,
                                page: const ProfileSettingsPage());
                          },
                        ),
                  getIt<CacheHelper>().getDataString(key: 'token') == null
                      ? const SizedBox()
                      : LitsTitleWidget(
                          image: 'assets/icons/notification.png',
                          title: S.of(context).NotificationPreferences,
                        ),
                  LitsTitleWidget(
                    image: 'assets/icons/arabic.png',
                    title: S.of(context).Language,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        enableDrag: false,
                        builder: (context) {
                          return const LanguageBottomSheet();
                        },
                      );
                    },
                  ),
                  LitsTitleWidget(
                    image: 'assets/icons/money.png',
                    title: S.of(context).CurrencyConversion,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled:
                            true, // يسمح بالتحكم الكامل في الطول
                        enableDrag: false,

                        builder: (context) {
                          return const CurrencyConversionBottomSheet();
                        },
                      );
                    },
                  ),
                  LitsTitleWidget(
                    image: 'assets/icons/blog.png',
                    title: 'تغير كلمة المرور',
                    onTap: () {
                      pageTransition(context, page: const ChangePassPage());
                    },
                  ),
                  LitsTitleWidget(
                    image: 'assets/icons/blog.png',
                    title: S.of(context).Blog,
                  ),
                  LitsTitleWidget(
                    image: 'assets/icons/helpdesk.png',
                    title: S.of(context).Support,
                  ),
                  LitsTitleWidget(
                    image: 'assets/icons/telephone.png',
                    title: S.of(context).ContactUs,
                  ),
                  LitsTitleWidget(
                    image: 'assets/icons/condition.png',
                    title: S.of(context).TermsAndConditions,
                  ),
                  LitsTitleWidget(
                    image: 'assets/icons/advertising.png',
                    title: S.of(context).PrivacyPolicy,
                  ),
                  getIt<CacheHelper>().getDataString(key: 'token') == null
                      ? const SizedBox()
                      : LitsTitleWidget(
                          image: 'assets/icons/exit.png',
                          title: S.of(context).SignOut,
                          color: Colors.red,
                          isHaveArrow: false,
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled:
                                  true, // يسمح بالتحكم الكامل في الطول
                              enableDrag: false,

                              builder: (context) {
                                return const SignOutBottomSheet();
                              },
                            );
                          },
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
