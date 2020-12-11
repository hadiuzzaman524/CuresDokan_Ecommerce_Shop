class HttpException implements Exception {
  final msg;

  HttpException(this.msg);

  @override
  String toString() {
    return msg;
  }
}
