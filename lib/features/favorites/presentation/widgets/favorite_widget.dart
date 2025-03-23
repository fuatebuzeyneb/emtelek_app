import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:flutter/material.dart';

class FavoriteWidget extends StatelessWidget {
  const FavoriteWidget({
    super.key,
  });

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
        child: const Padding(
          padding: EdgeInsets.all(4.0),
          child: Icon(
            Icons.favorite_border,
            size: 20,
          ),
        ),
      ),
    );
  }
}
