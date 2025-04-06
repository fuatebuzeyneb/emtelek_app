import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/features/favorites/domain/cubit/favorites_cubit.dart';
import 'package:emtelek/features/search_property/domain/property_cubit/property_cubit.dart';
import 'package:emtelek/features/search_property/presentation/widgets/property_card.dart';
import 'package:emtelek/shared/cubits/settings_cubit/settings_cubit.dart';
import 'package:emtelek/core/constants/app_colors.dart';

import 'package:emtelek/shared/widgets/loading_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsCubit settingsCubit = BlocProvider.of<SettingsCubit>(context);
    FavoritesCubit favoritesCubit = BlocProvider.of<FavoritesCubit>(context);

    if (favoritesCubit.myFavoriteAds.isEmpty) {
      favoritesCubit.getFavoritesData();
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.appBarBackground,
          title: const Text('Favorite'),
        ),
        body: BlocConsumer<FavoritesCubit, FavoritesState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return state is FavoritesLoading
                ? LoadingWidget()
                : state is FavoritesFailure
                    ? Center(
                        child: Text(state.errorMassage),
                      )
                    : SizedBox(
                        height: context.height * 1,
                        width: context.width * 1,
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          itemCount: favoritesCubit.myFavoriteAds.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 16),
                              child: PropertyCard(
                                index: index,
                                adsModel: favoritesCubit.myFavoriteAds,
                              ),
                            );
                          },
                        ),
                      );
          },
        ));
  }
}
