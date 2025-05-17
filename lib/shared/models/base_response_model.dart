class BaseResponseModel {
  final String status;
  final String? msg;

  BaseResponseModel({
    required this.status,
    this.msg,
  });

  factory BaseResponseModel.fromJson(Map<String, dynamic> json) {
    return BaseResponseModel(
      status: json['status'] as String,
      msg: json['msg'] as String?, // `msg` may be absent
    );
  }

  bool get isSuccess => status == 'success';
}
