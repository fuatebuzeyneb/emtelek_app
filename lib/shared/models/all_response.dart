class AllResponseModel {
  final String status;
  final String? msg;


  AllResponseModel({required this.status, this.msg, });

  // تحويل JSON إلى كائن AllResponseModel
  factory AllResponseModel.fromJson(Map<String, dynamic> json) {
    return AllResponseModel(
      status: json['status'],
      msg: json['msg'], // msg يمكن أن تكون null
 
    );
  }

  // تحويل الكائن إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'msg': msg,
    };
  }
}