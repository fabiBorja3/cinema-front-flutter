import 'dart:ffi';

import 'package:cinema/src/models/user_model.dart';
import 'package:cinema/src/repository/cinema_api_repository.dart';

class CinemaApiService {
  UserModel userModel;
  CinemaApiRepository cinemaApiRepository = CinemaApiRepository();

  Future<String> getLogin(UserModel userModel) => cinemaApiRepository.loginUser(userModel);
  Future<String> getPassword(UserModel userModel) => cinemaApiRepository.getPassword(userModel);
  Future<String> updatePassword(UserModel userModel) => cinemaApiRepository.updatePassword(userModel);

  Future<dynamic> getEnCines() => cinemaApiRepository.getEnCines();
  Future<dynamic> getPelicula(int id) => cinemaApiRepository.getPelicula(id);

}
