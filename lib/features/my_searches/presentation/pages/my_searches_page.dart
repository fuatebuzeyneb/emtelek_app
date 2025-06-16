import 'package:emtelek/core/constants/app_colors.dart';
import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/features/add_property_listing/domain/cubit/property_add_ad_cubit.dart';
import 'package:emtelek/features/my_searches/domain/cubit/my_searches_cubit.dart';
import 'package:emtelek/features/my_searches/presentation/widgets/my_search_card_widget.dart';
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
    MySearchesCubit mySearchesCubit = context.read<MySearchesCubit>();
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar:
          AppBarWidget(title: S.of(context).MySearches, isHaveBackButton: true),
      body: BlocBuilder<MySearchesCubit, MySearchesState>(
        builder: (context, state) {
          return state is MySearchesLoading
              ? const Center(child: LoadingWidget())
              : state is MySearchesFailure
                  ? Center(child: Text(state.errMessage))
                  : mySearchesCubit.mySavedSearchFilterList == null
                      ? Center(
                          child: Text('NoSavedFiltersFound'),
                        )
                      : SizedBox(
                          width: context.width * 1,
                          height: context.height * 1,
                          child: ListView.builder(
                            itemCount:
                                mySearchesCubit.mySavedSearchFilterList!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: MySearchCardWidget(
                                  itemContent: mySearchesCubit
                                      .mySavedSearchFilterList![index],
                                  index: index,
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
