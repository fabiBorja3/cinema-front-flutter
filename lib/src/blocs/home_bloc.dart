import 'dart:async';
import 'dart:convert';
import 'package:cinema/src/Utils/alert_dialog.dart';
import 'package:cinema/src/models/Sala.dart';
import 'package:cinema/src/models/api_response.dart';
import 'package:cinema/src/models/movie_model.dart';
import 'package:cinema/src/repository/cinema_api_repository.dart';
import 'package:flutter/material.dart';

class HomeBloc {
  final _repository = CinemaApiRepository();

  Future<List<Movie>> peliculasEnCine(BuildContext context) async {
    List<Movie> moviesList = await _repository.getEnCines();

    if (moviesList.isNotEmpty) {
      return moviesList;
    } else {
      AlertDialogCustom.showAlert(context, 'Problema al cargar las peliculas');
    }
  }

   Future<List<Sala>> getSalas() async {
    return await _repository.getSalas();
  }
}
