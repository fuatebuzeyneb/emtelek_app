import 'package:emtelek/features/profile/data/models/ads_model.dart';
import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:flutter/material.dart';

class FavoriteWidget extends StatelessWidget {
  const FavoriteWidget({
    super.key,
    required this.adsModel,
  });
  final AdsModel adsModel;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      left: 8,
      child: ButtonWidget(
        borderRadius: 18,
        showElevation: true,
        height: 0,
        width: 0,
        onTap: () {},
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
  }
}
