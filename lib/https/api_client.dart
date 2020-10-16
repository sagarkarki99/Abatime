import 'package:AbaTime/repository/http_exception.dart';
import 'package:dio/dio.dart';

class ApiClient {
  static ApiClient instance;
  static const _baseUrl = 'https://yts.mx/api/v2';
  static ApiClient getInstance() => instance ?? ApiClient();

  get(String endpoint, Map<String, dynamic> queryParam) async {
    final url = _baseUrl + endpoint;
    try {
      final response = await Dio().get(
        url,
        queryParameters: queryParam,
      );
      return response.data;
    } on DioError catch (error) {
      switch (error.type) {
        case DioErrorType.RESPONSE:
          throw HttpException(error.response.data);
        case DioErrorType.SEND_TIMEOUT:
          throw HttpException("Connection Time out!");
        default:
          throw HttpException("Error! Something went wrong!");
      }
    }
  }
}
