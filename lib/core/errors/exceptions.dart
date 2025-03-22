import 'package:dio/dio.dart';
import 'package:emtelek/core/errors/error_model.dart';

class ServerException implements Exception {
  final ErrorModel errorModel;

  ServerException({required this.errorModel});
}

void handleDioExceptions(DioException e) {
  if (e.response == null) {
    throw ServerException(
      errorModel: ErrorModel(
        errorMessage:
            "تعذر الاتصال بالسيرفر. يرجى التحقق من الإنترنت والمحاولة لاحقًا.",
        status: 'failed',
      ),
    );
  }

  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.cancel:
    case DioExceptionType.badCertificate:
    case DioExceptionType.unknown:
    case DioExceptionType.connectionError:
      throw ServerException(
        errorModel: ErrorModel(
          errorMessage: "حدث خطأ في الاتصال. يرجى المحاولة لاحقًا.",
          status: 'failed',
        ),
      );

    case DioExceptionType.badResponse:
      switch (e.response?.statusCode) {
        case 400:
        case 401:
        case 403:
        case 404:
        case 409:
        case 422:
        case 504:
          throw ServerException(
            errorModel: ErrorModel.fromJson(e.response!.data),
          );
        default:
          throw ServerException(
            errorModel: ErrorModel(
              status: 'failed',
              errorMessage: "حدث خطأ غير متوقع. يرجى المحاولة لاحقًا.",
            ),
          );
      }
  }
}
