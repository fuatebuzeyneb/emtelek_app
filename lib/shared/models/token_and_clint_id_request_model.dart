class TokenAndClintIdRequestModel {
  final int clientId;
  final String token;

  TokenAndClintIdRequestModel({
    required this.clientId,
    required this.token,
  });

  Map<String, dynamic> toJson() {
    return {
      'ClientId': clientId,
      'Token': token,
    };
  }

  @override
  String toString() {
    return 'TokenAndClintIdRequestModel(ClientId: $clientId, token: $token)';
  }
}
