import 'dart:async';

import 'package:cinema/src/Utils/alert_dialog.dart';
import 'package:cinema/src/blocs/validators.dart';
import 'package:cinema/src/models/user_model.dart';
import 'package:cinema/src/repository/cinema_api_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _repository = CinemaApiRepository();

//Recuperar datos
  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validarPassword);

  Stream<bool> get formValidStream =>
      Observable.combineLatest2(emailStream, passwordStream, (a, b) => true);

  //Insertar valores
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  //Obtener ultimos valores ingresados

  String get email => _emailController.value;
  String get password => _passwordController.value;

  void getLogin(BuildContext context, UserModel userModel) async {
    var apiResponse = await _repository.getLogin(userModel);

    if (apiResponse.body == 'true') {
      dispose();
      //Navigator.pushReplacementNamed(context, 'home');
      Navigator.pushReplacementNamed(context, 'cine');
    } else {
      AlertDialogCustom.showAlert(context, 'Autorizacion Invalida');
    }
  }

  void registro(BuildContext context) {
      dispose();
      Navigator.pushReplacementNamed(context, 'registro');
  }

  void dispose() {
    _emailController?.close();
    _passwordController?.close();
  }
}

//PRUEBA
