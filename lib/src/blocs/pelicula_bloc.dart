   
   import 'package:cinema/src/blocs/validators.dart';
import 'package:cinema/src/repository/cinema_api_repository.dart';
import 'package:rxdart/rxdart.dart';

class PeliculaBloc with Validators {
  final _repository = CinemaApiRepository();

     final _cantidadController = BehaviorSubject<String>();
    Stream<String> get cantidadStream =>
      _cantidadController.stream.transform(validarString);

   Function(String) get changeCantidad => _cantidadController.sink.add;

   final _horarioController = BehaviorSubject<String>();
       Stream<String> get horarioStream =>
      _horarioController.stream.transform(validarString);

   Function(String) get changeHorario => _horarioController.sink.add;

     Stream<bool> get formValidStream =>
      Observable.combineLatest2(cantidadStream, horarioStream, (a, b) => true);


}
   
   
