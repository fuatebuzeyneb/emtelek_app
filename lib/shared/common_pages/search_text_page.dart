import 'package:emtelek/core/constants/app_colors.dart';
import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/features/home/domain/cubit/home_cubit.dart';
import 'package:emtelek/features/property/presentation/widgets/property_card.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/shared/widgets/appbar_widget.dart';
import 'package:emtelek/shared/widgets/loading_widget.dart';
import 'package:emtelek/shared/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchTextPage extends StatelessWidget {
  const SearchTextPage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = BlocProvider.of<HomeCubit>(context);
    return Scaffold(
        appBar: AppBarWidget(
            title: S.of(context).Search,
            isHaveBackButton: true), //     homeCubit.searchTextAds = [];
        body: Padding(
          padding: EdgeInsets.only(top: 20, bottom: 12, left: 12, right: 12),
          child: Column(
            children: [
              TextFieldWidget(
                onChanged: (value) {
                  if (value.length >= 2) {
                    homeCubit.getSearchTextData(searchText: value);
                  }
                },
                hint: S.of(context).WriteThreeCharacters,
                prefixIcon: Icon(Icons.search, color: Colors.grey),
              ),
              20.toHeight,
              // BlocBuilder<HomeCubit, HomeState>(
              //   builder: (context, state) {
              //     return state is HomeTextSearchAdsLoading
              //         ? const Center(
              //             child: LoadingWidget(),
              //           )
              //         : state is HomeTextSearchAdsFailure
              //             ? Center(
              //                 child: Text(state.errorMassage),
              //               )
              //             : SizedBox(
              //                 height: context.height * 0.7,
              //                 width: context.width * 1,
              //                 child: ListView.builder(
              //                   itemCount: homeCubit.searchTextAds.length,
              //                   itemBuilder: (BuildContext context, int index) {
              //                     return Padding(
              //                       padding: const EdgeInsets.only(bottom: 16),
              //                       child: PropertyCard(
              //                           index: index,
              //                           adDetails: homeCubit.searchTextAds),
              //                     );
              //                   },
              //                 ),
              //               );
              //   },
              // )
            ],
          ),
        ));
  }
}
