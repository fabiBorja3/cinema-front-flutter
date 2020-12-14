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
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  Navigator.pushReplacementNamed(context, 'cine');
                },
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Registrar usuarios'),
                onTap: () {
                  Navigator.pushReplacementNamed(context, 'RegistroPersona');
                },
              ),
              ListTile(
                leading: Icon(Icons.movie),
                title: Text('Mostrar Compras'),
                onTap: () {
                  Navigator.pushReplacementNamed(context, 'ordenes');
                },
              ),
              
            ],
          ),
        );
  }
}