import 'package:cinema/src/blocs/provider.dart';
import 'package:cinema/src/models/movie_model.dart';
import 'package:cinema/src/providers/home_provider.dart';
import 'package:cinema/src/services/cinema_api_services.dart';
import 'package:cinema/src/widgets/card_swiper_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';

class HomePage extends StatelessWidget {
  String token;
  final servicioApi = CinemaApiService();
  MovieModel user = new MovieModel();
  final homeProvider = new HomeProvider();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Peliculas en cartelera'),
          backgroundColor: Colors.deepPurple,
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Email: ${bloc.email}'),
              Divider(),
              Text('Password: ${bloc.password}'),
              _swiperTarjetas()
            ]),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.deepPurple),
                child: Text(
                  'MY APP',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              ListTile(
                leading: Icon(Icons.verified_user),
                title: Text("Crear administradores"),
                onTap: () {
                  Navigator.pushReplacementNamed(context, 'registro');
                },
              ),
              ListTile(
                leading: Icon(Icons.verified_user),
                title: Text("Registrar usuarios"),
                onTap: () {
                  Navigator.pushReplacementNamed(context, 'registroPersona');
                },
              ),
              ListTile(
                leading: Icon(Icons.verified_user),
                title: Text("Registrar Teatro"),
                onTap: () {
                  Navigator.pushReplacementNamed(context, 'RegistroTeatro');
                },
              ),
               ListTile(
                leading: Icon(Icons.verified_user),
                title: Text("Ocupacion"),
                onTap: () {
                  Navigator.pushReplacementNamed(context, 'OcuparCine');
                },
              ),
               ListTile(
                leading: Icon(Icons.verified_user),
                title: Text("Registrar Persona"),
                onTap: () {
                  Navigator.pushReplacementNamed(context, 'RegistroPersona');
                },
              ),
               ListTile(
                leading: Icon(Icons.verified_user),
                title: Text("Registrar Teatro"),
                onTap: () {
                  Navigator.pushReplacementNamed(context, 'RegistroTeatro');
                },
              ),
              
            ],
          ),
        ));
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
      //future: homeProvider.getEnCines(),
      future: servicioApi.cinemaApiRepository.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(peliculas: snapshot.data);
        } else {
          return Container(
              height: 400.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );


    // return CardSwiper(
    //   peliculas: [1,2,3,4,5],
    // );
  }
/*
  Future<String> getToken() async {
    token = await FlutterSession().get("token");
    return token;
  }
  */
}
