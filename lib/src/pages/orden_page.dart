import 'package:cinema/src/models/venta.dart';
import 'package:cinema/src/widgets/menu_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
        ), body: Column(
        children: [
          Container(
              padding: EdgeInsets.all(30.0),
              child: Column(
                children: [
                  QrImage(data: venta.usuario+'|'+venta.pelicula+'|'+venta.cantidad+'|'+venta.valor),
                  Row(children: [Text('Usuario: ',style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold) ,),Text(venta.usuario),],),
                  Row(children: [Text('Pelicula: ',style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold) ,),Text(venta.pelicula),],),
                  Row(children: [Text('Tickets: ',style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold) ,),Text(venta.cantidad),],),
                  Row(children: [Text('Valor: ',style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold) ,),Text(venta.valor),],), 
                ],
                //child: QrDemo(),
              )),
        ],
            ),
        drawer: menuWidget());
  }

}
