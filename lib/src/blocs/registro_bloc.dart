import 'dart:async';

import 'package:cinema/src/Utils/alert_dialog.dart';
import 'package:cinema/src/blocs/validators.dart';
import 'package:cinema/src/models/api_response.dart';
import 'package:cinema/src/models/user_model.dart';
import 'package:cinema/src/repository/cinema_api_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class RegistroBloc with Validators {
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

  void registrarUser(BuildContext context, UserModel userModel) async{
    var apiResponse = await _repository.registrarUser(userModel);

      if (apiResponse.statusResponse == 200) {
        AlertDialogCustom.showAlert(context, 'Se ingreso un administrador.');
      } else {
        AlertDialogCustom.showAlert(context, 'Existe un problema con la creacion del administrador.');
      }

  }

  void dispose() {
    _emailController?.close();
    _passwordController?.close();
  }
}