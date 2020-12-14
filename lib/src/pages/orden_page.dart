import 'package:cinema/src/models/venta.dart';
import 'package:cinema/src/widgets/menu_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrdenPage extends StatefulWidget {
  final Venta venta;
  OrdenPage({Key key, @required this.venta}) : super(key: key);

  @override
  _OrdenPageState createState() => _OrdenPageState(venta);
}

class _OrdenPageState extends State<OrdenPage> {
  Venta venta;


    _OrdenPageState(this.venta);

  @override
  Widget build(BuildContext context) {

        return Scaffold(
        appBar: AppBar(
          title: Text('Compras'),
          backgroundColor: Colors.deepPurple,
        ),body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(venta.pelicula),
              ),
                    ]),
        drawer: menuWidget());
  }

}
