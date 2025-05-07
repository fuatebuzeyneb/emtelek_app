// class Feature {
//   final int featureId;
//   final String featureName;
//   final String featureIcon;

//   Feature({
//     required this.featureId,
//     required this.featureName,
//     required this.featureIcon,
//   });

//   factory Feature.fromJson(Map<String, dynamic> json) {
//     return Feature(
//       featureId: json['FeatureId'] ?? 0,
//       featureName: json['FeatureName'] ?? '',
//       featureIcon: json['FeatureIcon'] ?? '',
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
