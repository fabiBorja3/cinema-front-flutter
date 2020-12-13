import 'dart:convert';
//import 'package:cinema/src/models/actor_model.dart';
import 'package:cinema/src/models/Sala.dart';
import 'package:cinema/src/models/api_response.dart';
import 'package:cinema/src/models/cine.dart';
import 'package:cinema/src/models/gender_model.dart';
import 'package:cinema/src/models/movie_model.dart';
import 'package:cinema/src/models/user_model.dart';
import 'package:cinema/src/models/cinema_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class CinemaApiService {
  var _url = "";
  Future<ApiResponse> loginUser(UserModel user) async {
    var apiResponse = ApiResponse(statusResponse: 0);
    var dato = await FirebaseFirestore.instance
        .collection('User')
        .where('nickname', isEqualTo: user.username)
        .get()
        .then((snapshot) {
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

  Future<List<Sala>> getInformacionCinema() async {
    var salasList = <Sala>[];
    await FirebaseFirestore.instance
        .collection('Sala')
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((data) {
        var sala = Sala();
        sala.id = data.id;
        sala.nombre = data.get('nombre');
        sala.sillas = data.get('sillas');
        sala.libres = data.get('libres');
        sala.ocupadas = data.get('ocupadas');
        sala.cine = data.get('cine');
        salasList.add(sala);
      });
    });

/*
    var i = 0;
    for (var item in cineList) {
      item.cine.get().then((value2) {
        var cine = Cine();
        cine.id = value2.id;
        cine.nombre = value2.get('nombre');
        cine.direccion = value2.get('direccion');
        cine.salas = value2.get('salas');
        salasList[i].cine = cine;
        i++;
      });
    }

    */

    return salasList;

/*
    await FirebaseFirestore.instance
        .collection('Sala')
        .doc('V60mTpj2qixxxajxnYLP')
        .get()
        .then((value) {
      var collection = value.get('cine');

      collection.get().then((value2) {
        print(value2.get('nombre'));
      });
    });

    */
  }



    Future<List<Cine>> getCines() async {
    List<Cine> cineList = new List();
    await FirebaseFirestore.instance
        .collection('Cine')
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((data) {
        if (data != null) {
          Cine cine = new Cine();
          cine.id = data.id;
          cine.nombre = data.get('nombre').toString();
          cine.direccion = data.get('direccion').toString();
          cine.salas = data.get('salas').toString();
          cineList.add(cine);
        }
      });
    });

    return cineList;
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
          movie.descripcion = data.get('descripcion').toString();
          movie.duracion = data.get('duracion').toString();
          movie.genero = data.get('genero').toString();
          movie.idioma = data.get('idioma').toString();
          movie.sala = data.get('sala').toString();
          movie.actor = data.get('actor');
          movieList.add(movie);
        }
      });
    });

    return movieList;
  }

  Future<dynamic> getPelicula(String id) async {
    await FirebaseFirestore.instance
        .collection('Movie')
        .where('_name_', isEqualTo: id)
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((data) {
        if (data != null) {
          print(data.get('titulo').toString());
        }
      });
    });
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
