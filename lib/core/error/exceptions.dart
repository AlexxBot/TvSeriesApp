class ServerException implements Exception {
  final String message;
  ServerException({this.message = 'Server Exception'});
}

class TimeOutException implements Exception {
  final String message;
  TimeOutException({this.message = 'Time out Exception'});
}

class ApiResponseException implements Exception {
  final int statusCode;
  final String message;
  ApiResponseException({this.statusCode = 500, this.message = 'Api Exception'});
}

class CacheException implements Exception {
  final String message;
  CacheException({this.message = 'Local Storage Exception'});
}
