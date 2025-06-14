import 'package:emtelek/core/constants/app_colors.dart';
import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/features/add_property_listing/domain/cubit/property_add_ad_cubit.dart';
import 'package:emtelek/features/my_searchs/presentation/widgets/search_filter_card_widget.dart';
import 'package:emtelek/features/property/domain/property_cubit/property_cubit.dart';
import 'package:emtelek/features/property_filter/domain/cubit/property_filter_cubit.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/shared/widgets/appbar_widget.dart';
import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:emtelek/shared/widgets/loading_widget.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MySearchesPage extends StatelessWidget {
  const MySearchesPage({super.key});

  static const String id = "MySearchesPage";

  @override
  Widget build(BuildContext context) {
    PropertyFilterCubit propertyFilterCubit =
        context.read<PropertyFilterCubit>();
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar:
          AppBarWidget(title: S.of(context).MySearches, isHaveBackButton: true),
      body: BlocBuilder<PropertyFilterCubit, PropertyFilterState>(
        builder: (context, state) {
          return state is GetSearchFilterLoading
              ? const Center(child: LoadingWidget())
              : state is GetSearchFilterFailure
                  ? Center(child: Text(state.errMessage))
                  : propertyFilterCubit.mySavedSearchFilterList == null
                      ? Center(
                          child: Text('NoSavedFiltersFound'),
                        )
                      : SizedBox(
                          width: context.width * 1,
                          height: context.height * 1,
                          child: ListView.builder(
                            itemCount: propertyFilterCubit
                                .mySavedSearchFilterList!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: SearchFilterCardWidget(
                                  itemContent: propertyFilterCubit
                                      .mySavedSearchFilterList![index],
                                ),
                              );
                            },
                          ),
                        );
        },
      ),
    );
  }
}
