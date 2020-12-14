import 'dart:async';
import 'package:cinema/src/models/cine.dart';
import 'package:cinema/src/repository/cinema_api_repository.dart';

class CineBloc {
  final _repository = CinemaApiRepository();

  Future<List<Cine>> getCines() async {
    List<Cine> cineList = await _repository.getCines();

      return cineList;
  }
}
