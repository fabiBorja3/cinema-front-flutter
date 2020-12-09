import 'dart:convert';

import 'package:cinema/src/blocs/home_bloc.dart';
import 'package:cinema/src/blocs/provider.dart';
import 'package:cinema/src/models/api_response.dart';
import 'package:cinema/src/models/movie_model.dart';
import 'package:cinema/src/widgets/card_swiper_widget.dart';
import 'package:cinema/src/widgets/menu_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  String token;
  Movie user = Movie();

  @override
  Widget build(BuildContext context) {
    final blocLogin = Provider.of(context);
    final blocHome = Provider.ofHome(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Peliculas en cartelera'),
          backgroundColor: Colors.deepPurple,
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Email: ${blocLogin.email}'),
              Divider(),
              Text('Password: ${blocLogin.password}'),
              _swiperTarjetas(context, blocHome)
            ]),
        drawer: menuWidget());
  }

  Widget _swiperTarjetas(BuildContext context, HomeBloc blocHome) {
      
      return FutureBuilder(
        future: blocHome.peliculasEnCine(context),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return CardSwiper(movies: snapshot.data);
          } else {
            return Container(
                height: 400.0,
                child: Center(child: CircularProgressIndicator()));
          }
        },
      );
  }
}
