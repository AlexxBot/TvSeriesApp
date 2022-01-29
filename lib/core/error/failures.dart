import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
abstract class Failure extends Equatable {
  String message;
  Failure({this.message = 'Failure'});

  @override
  List<Object?> get props => [message];
}

// ignore: must_be_immutable
class ServerFailure extends Failure {
  ServerFailure({message = 'Server Failure'}) : super(message: message);
}

// ignore: must_be_immutable
class CacheFailure extends Failure {
  CacheFailure({message = 'Cache Failure'}) : super(message: message);
}

// ignore: must_be_immutable
class TimeOutFailure extends Failure {
  TimeOutFailure({message = "Timeout"}) : super(message: message);
}

// ignore: must_be_immutable
class ApiResponseFailure extends Failure {
  ApiResponseFailure({message = 'Api response Failure'})
      : super(message: message);
}
