// File: search_request_model.dart

class SearchRequestModel {
  final String token;
  final int clientId;
  final String searchQuery;
  final int page;
  final String orderBy;

  const SearchRequestModel({
    required this.token,
    required this.clientId,
    required this.searchQuery,
    required this.page,
    required this.orderBy,
  });

  Map<String, dynamic> toJson() {
    return {
      'Token': token,
      'ClientId': clientId,
      'SearchQuery': searchQuery,
      'Page': page,
      'OrderBy': orderBy,
    };
  }

  @override
  String toString() {
    return 'SearchRequestModel(token: $token, clientId: $clientId, searchQuery: $searchQuery, page: $page, orderBy: $orderBy)';
  }
}
