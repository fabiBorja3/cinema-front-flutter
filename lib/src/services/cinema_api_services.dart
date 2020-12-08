import 'dart:convert';
import 'dart:io';

import 'package:cinema/src/models/api_response.dart';
import 'package:cinema/src/models/gender_model.dart';
import 'package:cinema/src/models/person_model.dart';
import 'package:cinema/src/models/user_model.dart';
import 'package:cinema/src/models/cinema_model.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;

class CinemaApiService {
  //final String _url = 'https://cinema-spring-boot-heroku.herokuapp.com/cinema';
  final String _url = 'http://192.168.1.2:9040/actives/api/v1';

 Future<ApiResponse> loginUser(UserModel user) async {
    final url = '$_url/loginUser';
    var apiResponse = ApiResponse(statusResponse: 0);

    //final response = await http.post(url, body: userModelToJson(user));
    final response = await http
        .get('$url/?nickname=${user.username}&password=${user.password}');

    apiResponse.statusResponse = response.statusCode;
    apiResponse.body = response.body;
    return apiResponse;
  }

    Future<ApiResponse> registerUser(UserModel user) async {
    final url = '$_url/auth/token';
    var apiResponse = ApiResponse(statusResponse: 0);

    //final response = await http.post(url, body: userModelToJson(user));
    final response = await http
        .post('$url/?username=${user.username}&password=${user.password}');

    apiResponse.statusResponse = response.statusCode;
    apiResponse.body = response.body;
    return apiResponse;
  }


  Future<ApiResponse> registrarPersona(PersonModel person) async {
    final url = '$_url/api/v1/person';
    var apiResponse = ApiResponse(statusResponse: 0);
    String token = await FlutterSession().get('token');
    var data = {
      'address': person.address,
      'id': 0,
      'lastname': person.lastname,
      'mail': person.mail,
      'name': person.name,
      'phone': person.phone
    };

    //encode Map to JSON
    var body = json.encode(data);
    var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body);

    apiResponse.statusResponse = response.statusCode;
    apiResponse.body = response.body;
    return apiResponse;

/*
    if (response.body.contains('exception')) {
      return 'invalido';
    } else {
      return 'correcto';
    }

*/
    //return response.body;
  }

  Future<ApiResponse> registrarGenero(GeneroModel generoModel) async {
    final url = '$_url/api/v1/gender';
    var apiResponse = ApiResponse(statusResponse: 0);
    String token = await FlutterSession().get('token');
    var data = {
      'id': 0,
      'name': generoModel.name,
    };

    //encode Map to JSON
    var body = json.encode(data);
    var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body);

    apiResponse.statusResponse = response.statusCode;
    apiResponse.body = response.body;
    return apiResponse;

/*
    //return response.body;
    if (response.body.contains('exception')) {
      return 'invalido';
    } else {
      return 'correcto';
    }

    */
  }

  Future<ApiResponse> getEnCines() async {
    final url = '$_url/api/v1/movie/';
    var apiResponse = ApiResponse(statusResponse: 0);
    String token = await FlutterSession().get('token');
    //final response = await http.post(url, body: userModelToJson(user));
    final response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
      });

    apiResponse.statusResponse = response.statusCode;
    apiResponse.body = response.body;
    return apiResponse;


    
  }

  Future<dynamic> getPelicula(int id) async {
    final url = '$_url/api/v1/movie/$id';
    String token = await FlutterSession().get('token');
    //final response = await http.post(url, body: userModelToJson(user));
    final response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });
    final decodedData = json.decode(response.body);

    return decodedData;
  }

  Future<ApiResponse> registrarCinema(CinemaModel cinema) async {
    final url = '$_url/api/v1/cinema';
    var apiResponse = ApiResponse(statusResponse: 0);
    String token = await FlutterSession().get('token');
    var data = {
      'address': cinema.address,
      'id': 0,
      'name': cinema.name,
      'phone': cinema.phone,
      'id_city': 1
    };

    //encode Map to JSON
    var body = json.encode(data);
    var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body);

    apiResponse.statusResponse = response.statusCode;
    apiResponse.body = response.body;
    return apiResponse;
    /*
    apiResponse.statusResponse = response.statusCode;
    if (apiResponse.statusResponse == 201) {
      return 'correcto';
    } else {
      return 'invalido';
    }
    */
  }
}
