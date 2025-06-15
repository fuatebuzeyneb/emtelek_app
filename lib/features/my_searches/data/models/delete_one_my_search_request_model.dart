class DeleteOneMySearchRequestModel {
  final int clientId;
  final String token;
  final int searchId;

  DeleteOneMySearchRequestModel({
    required this.clientId,
    required this.token,
    required this.searchId,
  });

  Map<String, dynamic> toJson() {
    return {
      'ClientId': clientId,
      'Token': token,
      'SearchId': searchId,
    };
  }
}
