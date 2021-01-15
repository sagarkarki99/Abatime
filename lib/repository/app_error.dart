class AppError {
  String errorMessage;
  AppError(this.errorMessage);

  @override
  String toString() {
    return errorMessage;
  }
}
