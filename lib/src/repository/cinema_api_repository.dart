import 'dart:convert';
import 'dart:io';

import 'package:cinema/src/models/movie_model.dart';
import 'package:cinema/src/models/user_model.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;

class CinemaApiRepository {
  final String _url = 'https://cinema-spring-boot-heroku.herokuapp.com/cinema';
  //final String _url = 'http://cinema7.herokuapp.com/cinema';

  Future<String> loginUser(UserModel user) async {
    final url = '$_url/auth/token';

    //final response = await http.post(url, body: userModelToJson(user));
    final response = await http
        .post('$url/?username=${user.username}&password=${user.password}');

    if (response.body.contains('token')) {
      return 'invalido';
      //AlertDialogCustom.showAlert(context, 'Autorizacion Invalida');
    } else {
      var session = FlutterSession();
      await session.set('token', response.body);
      //Navigator.pushReplacementNamed(context, 'home');
    }

    return response.body;
  }

  Future<String> registrarUser(UserModel user) async {
    final url = '$_url/user';
    var data = {
      'id': 'null',
      'password': user.password,
      'nickname': user.username,
      'token': 1
    };

    //encode Map to JSON
    var body = json.encode(data);
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);

    if (response.body.contains('token')) {
      //AlertDialogCustom.showAlert(context, 'Autorizacion Invalida');
    } else {
      var session = FlutterSession();
      await session.set('token', response.body);
      //Navigator.pushReplacementNamed(context, 'home');
    }

    return response.body;
  }

  Future<String> getPassword(UserModel user) async {
    final url = '$_url/token';

    //final response = await http.post(url, body: userModelToJson(user));
    final response = await http
        .post('$url/?username=${user.username}&password=${user.password}');

    if (response.body.contains('token')) {
      //AlertDialogCustom.showAlert(context, 'Autorizacion Invalida');
    } else {
      var session = FlutterSession();
      await session.set('token', response.body);
      //Navigator.pushReplacementNamed(context, 'home');
    }

    return response.body;
  }

  Future<String> updatePassword(UserModel user) async {
    final url = '$_url/token';

    //final response = await http.post(url, body: userModelToJson(user));
    final response = await http
        .post('$url/?username=${user.username}&password=${user.password}');

    if (response.body.contains('token')) {
      //AlertDialogCustom.showAlert(context, 'Autorizacion Invalida');
    } else {
      var session = FlutterSession();
      await session.set('token', response.body);
      //Navigator.pushReplacementNamed(context, 'home');
    }

    return response.body;
  }

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
