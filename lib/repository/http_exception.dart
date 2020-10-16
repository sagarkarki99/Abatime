class HttpException implements Exception {
  String errorMessage;
  HttpException(this.errorMessage);

  @override
  String toString() {
    return errorMessage;
  }
}
