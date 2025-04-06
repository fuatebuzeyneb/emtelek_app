import 'dart:math';

import 'package:emtelek/features/favorites/domain/cubit/favorites_cubit.dart';
import 'package:emtelek/features/profile/data/models/ads_model.dart';
import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteWidget extends StatelessWidget {
  const FavoriteWidget({
    super.key,
    required this.adsModel,
  });
  final AdsModel adsModel;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        return Positioned(
          top: 10,
          left: 8,
          child: ButtonWidget(
            borderRadius: 18,
            showElevation: true,
            height: 0,
            width: 0,
            onTap: () {
              adsModel.isFavorite = !adsModel.isFavorite!;
              if (adsModel.isFavorite == true) {
                BlocProvider.of<FavoritesCubit>(context)
                    .addFavorite(adId: adsModel.adId);
              } else {
                BlocProvider.of<FavoritesCubit>(context)
                    .removeFavorite(adId: adsModel.adId);
              }
            },
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(
                adsModel.isFavorite == true
                    ? Icons.favorite
                    : Icons.favorite_border,
                size: 20,
              ),
            ),
          ),
        );
      },
    );
  }
}
