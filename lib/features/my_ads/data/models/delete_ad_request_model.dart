class DeleteAdRequestModel {
  final int adId;
  final String token;
  final int clientId;

  DeleteAdRequestModel({
    required this.adId,
    required this.token,
    required this.clientId,
  });

  Map<String, dynamic> toJson() {
    return {
      'AdId': adId,
      'Token': token,
      'ClientId': clientId,
    };
  }
}
