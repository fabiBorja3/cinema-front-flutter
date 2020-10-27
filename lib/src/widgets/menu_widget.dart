import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class menuWidget  extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return 
    Drawer( child: ListView(
            children: [DrawerHeader(
                decoration: BoxDecoration(color: Colors.deepPurple),
                child: Text(
                  'CINEMA',
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
                leading: Icon(Icons.home),
                title: Text("Home"),
                onTap: () {
                  Navigator.pushReplacementNamed(context, 'home');
                },
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text("Registrar usuarios"),
                onTap: () {
                  Navigator.pushReplacementNamed(context, 'RegistroPersona');
                },
              ),
              ListTile(
                leading: Icon(Icons.movie),
                title: Text("Registrar Teatro"),
                onTap: () {
                  Navigator.pushReplacementNamed(context, 'RegistroTeatro');
                },
              ),
               ListTile(
                leading: Icon(Icons.airline_seat_recline_extra),
                title: Text("Ocupacion"),
                onTap: () {
                  Navigator.pushReplacementNamed(context, 'OcuparCine');
                },
              ),
                ListTile(
                leading: Icon(Icons.games),
                title: Text("Registrar Genero"),
                onTap: () {
                  Navigator.pushReplacementNamed(context, 'RegistroGenero');
                },
              ),
              ListTile(
                leading: Icon(Icons.games),
                title: Text("Registrar Cinema"),
                onTap: () {
                  Navigator.pushReplacementNamed(context, 'RegistrarCinema');
                },
              ),
              
            ],
          ),
        );
  }
}