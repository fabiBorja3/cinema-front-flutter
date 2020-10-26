import 'dart:async';

import 'package:cinema/src/blocs/validators.dart';
import 'package:rxdart/rxdart.dart';

class RegistroGeneroBloc with Validators {
  final _generoController = BehaviorSubject<String>();

//Recuperar datos
  Stream<String> get generoStream => _generoController.stream.transform(validarString);

  //Insertar valores
  Function(String) get changeGenero => _generoController.sink.add;

  //Obtener ultimos valores ingresados

  String get nombre => _generoController.value;

  dispose() {
    _generoController?.close();
  }

  
}