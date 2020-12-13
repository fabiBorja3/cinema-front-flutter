import 'dart:async';
import 'dart:convert';
import 'package:cinema/src/Utils/alert_dialog.dart';
import 'package:cinema/src/models/Sala.dart';
import 'package:cinema/src/models/api_response.dart';
import 'package:cinema/src/models/cine.dart';
import 'package:cinema/src/models/movie_model.dart';
import 'package:cinema/src/repository/cinema_api_repository.dart';
import 'package:flutter/material.dart';

class CineBloc {
  final _repository = CinemaApiRepository();

   Future<List<Cine>> getCines() async {
    return await _repository.getCines();
  }
}
