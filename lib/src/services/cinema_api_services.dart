import 'dart:convert';
import 'dart:io';

import 'package:cinema/src/models/api_response.dart';
import 'package:cinema/src/models/gender_model.dart';
import 'package:cinema/src/models/movie_model.dart';
import 'package:cinema/src/models/person_model.dart';
import 'package:cinema/src/models/user_model.dart';
import 'package:cinema/src/models/cinema_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;

class CinemaApiService {
  var _url = "";
  Future<ApiResponse> loginUser(UserModel user) async {
    var apiResponse = ApiResponse(statusResponse: 0);
    await FirebaseFirestore.instance
        .collection('User')
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((data) {
        if (data != null) {
          print(data.get('nickname').toString());
          if (user.password == data.get('password')) {
            apiResponse.body = 'true';
          } else {
            apiResponse.body = 'false';
          }
        }
      });
    });

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

  Future<ApiResponse> registrarUsuario(UserModel user) async {
    var apiResponse = ApiResponse(statusResponse: 0);
    var ref = await FirebaseFirestore.instance
        .collection('User')
        .add({'nickname': user.username, 'password': user.password});

    print(ref.id);
    apiResponse.body = ref.id;

    return apiResponse;
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

  Future<List<Movie>> getEnCines() async {
    List<Movie> movieList = new List();
    await FirebaseFirestore.instance
        .collection('Movie')
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((data) {
        if (data != null) {
          Movie movie = new Movie();

          movie.id = data.id;
          movie.titulo = data.get('titulo').toString();
          movie.portada = data.get('portada').toString();
          movie.duracion = data.get('duracion').toString();
          movie.genero = data.get('genero').toString();
          movie.idioma = data.get('idioma').toString();
          movie.sala = data.get('sala').toString();
          movieList.add(movie);
        }
      });
    });

    return movieList;
  }

  Future<dynamic> getPelicula(String id) async {
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
