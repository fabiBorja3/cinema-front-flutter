import 'dart:async';

import 'package:cinema/src/Utils/alert_dialog.dart';
import 'package:cinema/src/blocs/validators.dart';
import 'package:cinema/src/models/api_response.dart';
import 'package:cinema/src/models/person_model.dart';
import 'package:cinema/src/repository/cinema_api_repository.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class RegistrarPersonasBloc with Validators {

  final _nombreController = BehaviorSubject<String>();
  final _apellidoController = BehaviorSubject<String>();
  final _direccionController = BehaviorSubject<String>();
  final _telefonoController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _repository = CinemaApiRepository();



//Recuperar datos
 
  Stream<String> get nombreStream     => _nombreController.stream.transform(validarString);
  Stream<String> get apellidoStream   => _apellidoController.stream.transform(validarString);
  Stream<String> get direccionStream  => _direccionController.stream.transform(validarString);
  Stream<String> get telefonoStream   => _telefonoController.stream.transform(validarString);
  Stream<String> get emailStream      => _emailController.stream.transform(validarEmail);


  Stream<bool> get formValidStream => Observable.combineLatest5(nombreStream, apellidoStream, direccionStream, telefonoStream, emailStream, (a, b, c, d, e) => true);

  //Insertar valores
  Function(String) get changeNombre => _nombreController.sink.add;
  Function(String) get changeApellido => _apellidoController.sink.add;
  Function(String) get changeDireccion => _direccionController.sink.add;
  Function(String) get changeTelefono => _telefonoController.sink.add;
  Function(String) get changeEmail => _emailController.sink.add;

  //Obtener ultimos valores ingresados

  String get nombre => _nombreController.value;
  String get apellido => _apellidoController.value;
  String get direccion => _direccionController.value;
  String get telefono => _telefonoController.value;
  String get email => _emailController.value;

    void  registrarUsuario(BuildContext context, PersonModel personModel) async{
    var apiResponse = await _repository.registrarPersona(personModel);

      if (apiResponse.statusResponse == 200) {
        AlertDialogCustom.showAlert(context, 'Se ingreso un usuario.');
      } else {
        AlertDialogCustom.showAlert(context, 'Existe un problema con la creacion del usuario.');
      }

  }

  void dispose() {
    _nombreController?.close();
    _apellidoController?.close();
    _telefonoController?.close();
    _direccionController?.close();
    _emailController?.close();
  }
}
