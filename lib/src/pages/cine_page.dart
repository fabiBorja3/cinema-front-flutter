import 'package:cinema/src/blocs/cine_bloc.dart';
import 'package:cinema/src/models/cine.dart';
import 'package:cinema/src/widgets/menu_widget.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class CinePage extends StatefulWidget {
  CinePage({Key key}) : super(key: key);

  @override
  _CinePageState createState() => _CinePageState();
}

class _CinePageState extends State<CinePage> {
  List<Cine> cineList;

  @override
  void initState() {
    super.initState();
    _cargarListaCines();
  }

  _cargarListaCines() async {
    var cineBloc = CineBloc();
    cineList = await cineBloc.getCines();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Registrar Cinemas'),
          backgroundColor: Colors.deepPurple,
        ),
        body: ListView.builder(
            itemCount: cineList.length,
            itemBuilder: (BuildContext ctxt, int Index) {
              return ListTile(
                onTap: () {
                            Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            HomePage(cine: cineList[Index]),
      ),
    );
                },
                leading: Icon(Icons.map),
                title: Text(cineList[Index].nombre),
              );

            }),
        drawer: menuWidget());
  }
}
