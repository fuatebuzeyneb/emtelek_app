class AllResponseModel {
  final String status;
  final String? msg;

  AllResponseModel({required this.status, this.msg});

  factory AllResponseModel.fromJson(Map<String, dynamic> json) {
    return AllResponseModel(
      status: json['status'],
      msg: json['msg'],
    );
  }

  // دالة مساعدة للنجاح
  bool get isSuccess => status.toLowerCase() == 'success';

  // دالة مساعدة للفشل
  bool get isFailed => status.toLowerCase() == 'failed';
}
