import 'dart:async';
import 'dart:convert';
import 'package:cinema/src/Utils/alert_dialog.dart';
import 'package:cinema/src/models/api_response.dart';
import 'package:cinema/src/models/movie_model.dart';
import 'package:cinema/src/repository/cinema_api_repository.dart';
import 'package:flutter/material.dart';

class HomeBloc {
  final _repository = CinemaApiRepository();

  Future<List<dynamic>> peliculasEnCine(BuildContext context) async {
    var peliculas = [1, 2, 3];
    ApiResponse apiResponse = await _repository.getEnCines();

    if (apiResponse.statusResponse == 200) {
      final decodedData = json.decode(apiResponse.body);
      Movies.fromJsonList(decodedData);
      return decodedData;
    } else {
      AlertDialogCustom.showAlert(context, 'Problema al cargar las peliculas');
      return peliculas;
    }
  }
}
