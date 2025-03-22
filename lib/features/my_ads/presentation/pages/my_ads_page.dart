import 'package:emtelek/core/constants/app_colors.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
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

  static String id = "MyAdsPage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.white,
          elevation: 2,
          surfaceTintColor: Colors.white,
          automaticallyImplyLeading: false,
          title: AppBarWidget(
            title: S.of(context).MyAds,
            onTap: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: AppColors.appBarBackground,
        ),
        body: BlocConsumer<MyAdsCubit, MyAdsState>(
          listener: (context, state) {},
          builder: (context, state) {
            return state is GetMyAdsLoading
                ? const Center(
                    child: LoadingWidget(),
                  )
                : state is GetMyAdsFailure
                    ? Center(
                        child: Text(state.errorMassage),
                      )
                    : ListView.builder(
                        itemCount:
                            BlocProvider.of<MyAdsCubit>(context).myAds.length,
                        itemBuilder: (BuildContext context, int index) {
                          return MyAdCardWidget(
                            index: index,
                            myAdsList:
                                BlocProvider.of<MyAdsCubit>(context).myAds,
                          );
                        },
                      );
          },
        ));
  }
}
