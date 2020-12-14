
import 'package:cinema/src/blocs/ordenes_bloc.dart';
import 'package:cinema/src/models/venta.dart';
import 'package:cinema/src/pages/orden_page.dart';
import 'package:cinema/src/widgets/menu_widget.dart';
import 'package:flutter/material.dart';


class OrdenesPage extends StatefulWidget {
  OrdenesPage({Key key}) : super(key: key);

  @override
  _OrdenesPageState createState() => _OrdenesPageState();
}

class _OrdenesPageState extends State<OrdenesPage> {
  List<Venta> ventaList;

  @override
  void initState() {
    super.initState();
    _cargarListaOrdenes();
  }

  _cargarListaOrdenes() async {
    var ordenesBloc = OrdenesBloc();
    ventaList = await ordenesBloc.getOrdenes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Listado de compras'),
          backgroundColor: Colors.deepPurple,
        ),
        body: ListView.separated(
          separatorBuilder: (BuildContext context, int index) => Divider( height: 3, color: Colors.deepPurple),
            itemCount: ventaList.length,
            itemBuilder: (BuildContext ctxt, int Index) {
              return ListTile(
                onTap: () {
                            Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            OrdenPage(venta: ventaList[Index]),
      ),
    );
                },
                leading: Icon(Icons.account_balance_wallet),
                title: Text(ventaList[Index].pelicula),
              );

            }),
        drawer: menuWidget());
  }
}
