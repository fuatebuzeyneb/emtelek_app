class ExchangeRateModel {
  final int exchangeId;
  final double sypRate;
  final double tryRate;
  final String updatedDate;

  ExchangeRateModel({
    required this.exchangeId,
    required this.sypRate,
    required this.tryRate,
    required this.updatedDate,
  });

  factory ExchangeRateModel.fromJson(Map<String, dynamic> json) {
    return ExchangeRateModel(
      exchangeId: json['ExchangeId'],
      sypRate: json['SYP'],
      tryRate: json['TRY'],
      updatedDate: json['UpdatedDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ExchangeId': exchangeId,
      'SYP': sypRate,
      'TRY': tryRate,
      'UpdatedDate': updatedDate,
    };
  }
}
