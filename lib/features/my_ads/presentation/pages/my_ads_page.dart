import 'package:emtelek/core/constants/app_colors.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/core/utils/snackbar_utils.dart';
import 'package:emtelek/features/my_ads/domain/cubit/my_ads_cubit.dart';
import 'package:emtelek/features/profile/domain/cubit/profile_cubit.dart';
import 'package:emtelek/features/my_ads/presentation/widgets/my_ad_card_widget.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/shared/widgets/appbar_widget.dart';
import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:emtelek/shared/widgets/loading_widget.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAdsPage extends StatelessWidget {
  const MyAdsPage({super.key});

  static const String id = "MyAdsPage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBarWidget(title: S.of(context).MyAds, isHaveBackButton: true),
        body: BlocConsumer<MyAdsCubit, MyAdsState>(
          listener: (context, state) {
            if (state is PropertyDeleteAdSuccess) {
              BlocProvider.of<MyAdsCubit>(context).getMyAds();
              SnackbarUtils.showSnackbar(context, "تم الحذف بنجاح");
            }
          },
          builder: (context, state) {
            return state is GetMyAdsLoading || state is PropertyDeleteAdLoading
                ? const Center(
                    child: LoadingWidget(),
                  )
                : state is GetMyAdsFailure
                    ? Center(
                        child: Text(state.errorMassage),
                      )
                    : state is PropertyDeleteAdFailure
                        ? Center(
                            child: Text(state.errorMassage),
                          )
                        : ListView.builder(
                            itemCount: BlocProvider.of<MyAdsCubit>(context)
                                .myAdsX
                                .length,
                            itemBuilder: (BuildContext context, int index) {
                              return MyAdCardWidget(
                                index: index,
                                adDetails: BlocProvider.of<MyAdsCubit>(context)
                                    .myAdsX[index],
                              );
                            },
                          );
          },
        ));
  }
}
