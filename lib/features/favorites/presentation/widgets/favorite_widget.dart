import 'dart:math';

import 'package:emtelek/features/auth/presentation/widgets/bottom_sheets/login_options_bottom_sheet.dart';
import 'package:emtelek/features/favorites/domain/cubit/favorites_cubit.dart';
import 'package:emtelek/features/profile/data/models/ads_model.dart';
import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';
import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteWidget extends StatelessWidget {
  const FavoriteWidget({
    super.key,
    required this.adModel,
  });
  final AdModel adModel;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        return ButtonWidget(
          borderRadius: 18,
          showElevation: true,
          height: 0,
          width: 0,
          onTap: () {
            if (getIt<CacheHelper>().getDataString(key: 'token') != null) {
              adModel.isFavorite = !adModel.isFavorite!;
              if (adModel.isFavorite == true) {
                BlocProvider.of<FavoritesCubit>(context)
                    .addFavorite(adId: adModel.adId!);
              } else {
                BlocProvider.of<FavoritesCubit>(context)
                    .removeFavorite(adId: adModel.adId!);
              }
            } else {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                enableDrag: false,
                builder: (context) => const LoginOptionsBottomSheet(),
              );
            }
          },
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(6.0),
            child: Icon(
              adModel.isFavorite == true
                  ? Icons.favorite
                  : Icons.favorite_border,
              size: 22,
            ),
          ),
        );
      },
    );
  }
}
