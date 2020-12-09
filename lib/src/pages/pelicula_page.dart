import 'package:cinema/src/models/movie_model.dart';
import 'package:flutter/material.dart';

class PeliculaPage extends StatelessWidget {
  final Movie movie;
  const PeliculaPage({Key key, @required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String id = movie.id;
    String titulo = movie.titulo;
    String descripcion = movie.descripcion;
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservar silla'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
              padding: EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Text('id: $id'),
                  Text('id: $titulo'),
                  Text('id: $descripcion'),
                  
                ],
                //child: QrDemo(),
              )),
        ],
      ),
    );
  }
}