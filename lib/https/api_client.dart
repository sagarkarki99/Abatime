import 'package:dio/dio.dart';

class ApiClient {
  static ApiClient instance;
  static const _baseUrl = 'https://yts.mx/api/v2';
  static ApiClient getInstance() => ApiClient();

  get(String endpoint, Map<String, dynamic> queryParam) async {
    final url = _baseUrl + endpoint;
    try {
      final response = await Dio().get(
        url,
        queryParameters: queryParam,
      );
      return response.data;
    } on DioError catch (error) {
      throw HttpException.dioError(error);
    }
  }
}

class HttpException implements Exception {
  String errorMessage;

  @override
  String toString() {
    return errorMessage;
  }

  HttpException.dioError(DioError error) {
    switch (error.type) {
      case DioErrorType.RESPONSE:
        errorMessage = error.response.data;
        break;
      case DioErrorType.SEND_TIMEOUT:
        errorMessage = "Connection Time out!";
        break;
      default:
        errorMessage = "Error! Something went wrong!";
    }
  }
}
