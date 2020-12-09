import 'dart:ffi';

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
  Future<ApiResponse> registrarUser(UserModel userModel) => cinemaApiService.registrarUsuario(userModel);
  Future<ApiResponse> registrarPersona(PersonModel personModel) => cinemaApiService.registrarUsuario(userModel);
  Future<ApiResponse> registrarGenero(GeneroModel generoModel) => cinemaApiService.registrarGenero(generoModel);
  Future<ApiResponse> registrarCinema(CinemaModel cinemaModel) => cinemaApiService.registrarCinema(cinemaModel);

  Future<dynamic> getEnCines() => cinemaApiService.getEnCines();
  Future<dynamic> getPelicula(int id) => cinemaApiService.getPelicula(id);



 
}
