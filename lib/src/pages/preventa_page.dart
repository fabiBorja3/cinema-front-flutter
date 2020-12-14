import 'package:cinema/src/blocs/preventa_bloc.dart';
import 'package:cinema/src/models/movie_model.dart';
import 'package:flutter/material.dart';

class PreventaPage extends StatefulWidget {
  Movie movie;
  String user;
  String horario;
  String cantidad;
  PreventaPage(
      {Key key,
      @required this.movie,
      @required this.user,
      @required this.horario,
      @required this.cantidad})
      : super(key: key);

  @override
  _PreventaPageState createState() =>
      _PreventaPageState(movie, user, horario, cantidad);
}

class _PreventaPageState extends State<PreventaPage> {
  Movie movie;
  String user;
  String horario;
  String cantidad;
  var valorTotal;
  PreventaBloc bloc;
  _PreventaPageState(this.movie, this.user, this.horario, this.cantidad);

  @override
  Widget build(BuildContext context) {
    bloc = PreventaBloc();
    valorTotal = int.parse(movie.valor) * int.parse(cantidad);

    return Container(
      child: Column(
        children: [_movie(movie),
        _user(user),
        _horario(horario),
        _total(cantidad),
        _pagar(user, movie.titulo, cantidad, valorTotal.toString()),
        ],
      ),
    );
  }

  Widget _movie(Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(movie.titulo),
    );
  }

  Widget _user(String usuario) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(usuario),
    );
  }

  Widget _horario(String horario) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(horario),
    );
  }

  Widget _total(String total) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(total),
    );
  }

 Widget _pagar(String user, String pelicula, String cantidad, String valor) {
    RaisedButton(onPressed: () {
      bloc.registrarVenta(user, pelicula, cantidad, valor);
    });
  }
}
