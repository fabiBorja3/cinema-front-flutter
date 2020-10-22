import 'dart:convert';
import 'dart:io';

import 'package:cinema/src/Utils/alert_dialog.dart';
import 'package:cinema/src/models/movie_model.dart';
import 'package:cinema/src/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;

class HomeProvider {
  final String _url = 'https://cinema-spring-boot-heroku.herokuapp.com/cinema';

  //final String _url = 'http://cinema7.herokuapp.com/cinema';

  Future<List<dynamic>> getEnCines() async {
    final url = '$_url/api/v1/movie/';
    String token = await FlutterSession().get("token");
    //final response = await http.post(url, body: userModelToJson(user));
    final response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    final decodedData = json.decode(response.body);

    Movies.fromJsonList(decodedData);
    
    return decodedData;
  }

    Future<dynamic> getPelicula(int id) async {
    final url = '$_url/api/v1/movie/$id';
    String token = await FlutterSession().get("token");
    //final response = await http.post(url, body: userModelToJson(user));
    final response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    final decodedData = json.decode(response.body);
    
    return decodedData;
  }


}
