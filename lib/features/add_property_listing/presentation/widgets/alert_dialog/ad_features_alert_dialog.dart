import 'package:emtelek/core/constants/app_colors.dart';
import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/features/add_property_listing/domain/cubit/property_add_ad_cubit.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:emtelek/shared/widgets/loading_widget.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdFeaturesAlertDialog extends StatelessWidget {
  const AdFeaturesAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final propertyAddAdCubit = context.read<PropertyAddAdCubit>();
    return AlertDialog(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget(
              text: 'اختر الميزات',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocBuilder<PropertyAddAdCubit, PropertyAddAdState>(
              builder: (context, state) {
                return SizedBox(
                  height: context.height * 0.3,
                  width: context.width * 0.6,
                  child: state is FeaturesAddAdLoading
                      ? const Center(child: LoadingWidget())
                      : state is FeaturesAddAdFailure
                          ? Center(child: Text(state.errorMassage))
                          : ListView.builder(
                              itemCount: propertyAddAdCubit.features.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ButtonWidget(
                                  paddingVertical: 4,
                                  width: 0,
                                  height: 0,
                                  onTap: () {},
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: context.height * 0.03,
                                        width: context.height * 0.03,
                                        child: Checkbox(
                                          activeColor: AppColors.primary,
                                          value: propertyAddAdCubit
                                              .featuresListId
                                              .contains(propertyAddAdCubit
                                                  .features[index].featureId),
                                          onChanged: (value) {
                                            final id = propertyAddAdCubit
                                                .features[index].featureId;
                                            propertyAddAdCubit
                                                .toggleFeatureIdList(
                                                    featureId: id);
                                          },
                                        ),
                                      ),
                                      8.toWidth,
                                      TextWidget(
                                          text: propertyAddAdCubit
                                              .features[index].featureName,
                                          fontSize: 16),
                                    ],
                                  ),
                                );
                              },
                            ),
                );
              },
            ),
            24.toHeight,
            ButtonWidget(
              paddingVertical: 12,
              height: 0,
              width: 0.4,
              color: Colors.grey.shade300,
              onTap: () {
                Navigator.pop(context);
              },
              text: S.current.Save,
              colorText: Colors.black,
              fontSize: 16,
            ),
          ],
        ));
  }
}
