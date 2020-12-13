import 'dart:ffi';

import 'package:cinema/src/models/Sala.dart';
import 'package:cinema/src/models/api_response.dart';
import 'package:cinema/src/models/gender_model.dart';
import 'package:cinema/src/models/person_model.dart';
import 'package:cinema/src/models/user_model.dart';
import 'package:cinema/src/models/cinema_model.dart';
import 'package:cinema/src/services/cinema_api_services.dart';

class CinemaApiRepository {

  UserModel userModel;
  CinemaApiService cinemaApiService = CinemaApiService();

  Future<ApiResponse> getLogin(UserModel userModel) => cinemaApiService.loginUser(userModel);
  Future<List<Sala>> getSalas() => cinemaApiService.getInformacionCinema();
  Future<ApiResponse> registrarUser(UserModel userModel) => cinemaApiService.registrarUsuario(userModel);
  Future<ApiResponse> registrarPersona(PersonModel personModel) => cinemaApiService.registrarUsuario(userModel);
  Future<ApiResponse> registrarCinema(CinemaModel cinemaModel) => cinemaApiService.registrarCinema(cinemaModel);
  Future<dynamic> getCines() => cinemaApiService.getCines();
  Future<dynamic> getEnCines() => cinemaApiService.getEnCines();
  Future<dynamic> getPelicula(String id) => cinemaApiService.getPelicula(id);



 
}
