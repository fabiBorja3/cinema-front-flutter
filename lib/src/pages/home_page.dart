import 'dart:convert';
import 'dart:math';

import 'package:cinema/src/blocs/home_bloc.dart';
import 'package:cinema/src/blocs/provider.dart';
import 'package:cinema/src/models/Sala.dart';
import 'package:cinema/src/models/cine.dart';
import 'package:cinema/src/models/movie_model.dart';
import 'package:cinema/src/widgets/card_swiper_widget.dart';
import 'package:cinema/src/widgets/menu_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final Cine cine;
  HomePage({Key key, @required this.cine}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(cine);
}

class _HomePageState extends State<HomePage> {
  String token;
  Movie user = Movie();
  Sala _selectedSala;
  List<Sala> salaList;
  var blocHome;
  Cine cine;

  _HomePageState(this.cine);

  @override
  void initState() {
    super.initState();
    _cargarListaSalas();
    _selectedSala = Sala(
        id: '###',
        nombre: 'Seleccione',
        ocupadas: '0',
        libres: '0',
        sillas: '0',
        cine: '');
  }

  @override
  Widget build(BuildContext context) {
    final blocLogin = Provider.of(context);
    final blocHome = Provider.ofHome(context);

    List<DropdownMenuItem> items = salaList.map((item) {
      return DropdownMenuItem<Sala>(
        child: Center(
            child: Text(
          'Sala ' + item.nombre,
          textAlign: TextAlign.center,
        )),
        value: item,
      );
    }).toList();

    // if list is empty, create a dummy item
    if (items.isEmpty) {
      items = [
        DropdownMenuItem(
          child: Center(
              child: Text(
            'Sala: $_selectedSala.nombre',
            textAlign: TextAlign.center,
          )),
          value: _selectedSala,
        )
      ];
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Peliculas en cartelera'),
          backgroundColor: Colors.deepPurple,
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(cine.nombre),
              ),
                            Container(
                child: Text(cine.direccion),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Text('Seleccionar:'),
                    SizedBox(
                      height: 20.0,
                    ),
                    Expanded(
                      child: DropdownButton(
                        items: items,
                        onChanged: (newVal) =>
                            setState(() => _selectedSala = newVal),
                        value: _selectedSala,
                      ),
                    )
                  ],
                ),
              ),
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
              height: 400.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  _cargarListaSalas() async {
    var homeBloc = HomeBloc();
    salaList = await homeBloc.getSalas();
    setState(() {
      _selectedSala = salaList[0];
    });

/*
      return FutureBuilder(
      future: await homeBloc.getSalas(),
      builder: (BuildContext context, AsyncSnapshot<List<Cine>> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(movies: snapshot.data);
        } else {
          return Container(
              height: 400.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );

    */
  }
}
