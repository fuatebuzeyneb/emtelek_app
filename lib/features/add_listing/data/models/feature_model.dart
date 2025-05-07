// class FeatureModel {
//   final int featureId;
//   final String featureName;
//   final String? featureIcon;

//   FeatureModel({
//     required this.featureId,
//     required this.featureName,
//     this.featureIcon,
//   });

//   factory FeatureModel.fromJson(Map<String, dynamic> json) {
//     return FeatureModel(
//       featureId: json['FeatureId'],
//       featureName: json['FeatureName'],
//       featureIcon: json['FeatureIcon'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'FeatureId': featureId,
//       'FeatureName': featureName,
//       'FeatureIcon': featureIcon,
//     };
//   }
// }
