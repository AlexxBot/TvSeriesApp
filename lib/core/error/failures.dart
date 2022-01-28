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
  ServerFailure({message = 'Error en el servidor'}) : super(message: message);
}

// ignore: must_be_immutable
class CacheFailure extends Failure {
  CacheFailure({message = 'Error al recuperar datos locales'})
      : super(message: message);
}

// ignore: must_be_immutable
class TimeOutFailure extends Failure {
  TimeOutFailure({message = "Se agoto el tiempo de espera, intente de nuevo"})
      : super(message: message);
}

// ignore: must_be_immutable
class ApiResponseFailure extends Failure {
  ApiResponseFailure({message = 'Error en la respuesta del servicio'})
      : super(message: message);
}

class FormFailure extends Failure {
  FormFailure({message = 'Error en el formulario'}) : super(message: message);
}

class DataFailure extends Failure {
  DataFailure({message = 'Error en el proceso de procesamiento de datos'})
      : super(message: message);
}
