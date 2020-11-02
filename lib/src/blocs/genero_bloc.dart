import 'dart:async';

import 'package:cinema/src/Utils/alert_dialog.dart';
import 'package:cinema/src/blocs/validators.dart';
import 'package:cinema/src/models/api_response.dart';
import 'package:cinema/src/models/gender_model.dart';
import 'package:cinema/src/repository/cinema_api_repository.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class RegistroGeneroBloc with Validators {
  final _generoController = BehaviorSubject<String>();
  final _repository = CinemaApiRepository();


//Recuperar datos
  Stream<String> get generoStream => _generoController.stream.transform(validarString);

  //Insertar valores
  Function(String) get changeGenero => _generoController.sink.add;

  //Obtener ultimos valores ingresados

  String get nombre => _generoController.value;

    void registrarGenero(BuildContext context, GeneroModel generoModel) async {

          var apiResponse = await _repository.registrarGenero(generoModel);

        if (apiResponse.statusResponse == 200) {
          AlertDialogCustom.showAlert(context, 'Se registro correctamente el género.');
        } else {
          AlertDialogCustom.showAlert(context, 'Existe un problema con la creacion del genero.');
        }
    }

  void dispose() {
    _generoController?.close();
  }

  
}