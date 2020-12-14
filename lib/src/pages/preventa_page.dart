import 'package:cinema/src/blocs/preventa_bloc.dart';
import 'package:cinema/src/models/movie_model.dart';
import 'package:cinema/src/widgets/menu_widget.dart';
import 'package:flutter/material.dart';

class PreventaPage extends StatefulWidget {
  Movie movie;
  String user;
  String horario;
  String cantidad;
  PreventaPage(
      {Key key,
      @required this.movie,
      @required this.user,
      @required this.horario,
      @required this.cantidad})
      : super(key: key);

  @override
  _PreventaPageState createState() =>
      _PreventaPageState(movie, user, horario, cantidad);
}

class _PreventaPageState extends State<PreventaPage> {
  Movie movie;
  String user;
  String horario;
  String cantidad;
  var valorTotal;
  PreventaBloc bloc;
  _PreventaPageState(this.movie, this.user, this.horario, this.cantidad);

  @override
  Widget build(BuildContext context) {
    bloc = PreventaBloc();
    valorTotal = int.parse(movie.valor) * int.parse(cantidad);

    return Scaffold(
        appBar: AppBar(
          title: Text('Preventa'),
          backgroundColor: Colors.deepPurple,
        ),
        body: Container(
      child: Column(
        children: [
        _movie(movie),
        _user(user),
        _horario(horario),
        _cantidad(cantidad),
        _total(valorTotal),
        _pagar(user, movie.titulo, cantidad, valorTotal.toString()),
        ],
      ),
    ),
        drawer: menuWidget());
  }

  Widget _movie(Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: 

          Column(
          children: <Widget>[
            ListTile(              
              title: Text(

                 'Título',
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Text(
                movie.toString(),
                style: TextStyle(fontSize: 18),
              ),
              trailing: Icon(
                Icons.movie,
                color: Colors.blueGrey,
              ),
            ),
            /* ListTile(
              title: Text(
                '(323) 555 6789',
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Text(
                'Work',
                style: TextStyle(fontSize: 18),
              ),
              trailing: Icon(
                Icons.chat,
                color: Colors.blueGrey,
              ),
            ), */
            Divider(color: Colors.blueGrey)
          ],
        ),











    /*   Row( children: [
            Text('Título:'),
            Text(movie.titulo),
        ],)      */
      
    );
  }

  Widget _user(String usuario) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      
      child: 

            Column(
          children: <Widget>[
            ListTile(              
              title: Text(

               'Usuario', 
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Text(
                usuario.toString(),
                style: TextStyle(fontSize: 18),
              ),
              trailing: Icon(
                Icons.supervised_user_circle,
                color: Colors.blueGrey,
              ),
            ),
            /* ListTile(
              title: Text(
                '(323) 555 6789',
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Text(
                'Work',
                style: TextStyle(fontSize: 18),
              ),
              trailing: Icon(
                Icons.chat,
                color: Colors.blueGrey,
              ),
            ), */
            Divider(color: Colors.blueGrey)
          ],
        ),













        /* Row( children:  [
            Text('Usuario:'),
            Text(usuario),
        ]
        ,
        
        ) */

    );
  }

  Widget _horario(String horario) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: 


          Column(
          children: <Widget>[
            ListTile(              
              title: Text(
                'Horario',                
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Text(
                horario.toString(),
                style: TextStyle(fontSize: 18),
              ),
              trailing: Icon(
                Icons.watch_later,
                color: Colors.blueGrey,
              ),
            ),
            /* ListTile(
              title: Text(
                '(323) 555 6789',
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Text(
                'Work',
                style: TextStyle(fontSize: 18),
              ),
              trailing: Icon(
                Icons.chat,
                color: Colors.blueGrey,
              ),
            ), */
            Divider(color: Colors.blueGrey)
          ],
        ),










        /* Row( children: [
            Text('Horario:'),
            Text(horario),
        ],)                   */
    );
  }

    Widget _cantidad(String cantidad) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: 

            Column(
          children: <Widget>[
            ListTile(              
              title: Text(
                  'Cantidad',
                
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Text(
                cantidad.toString(),
                style: TextStyle(fontSize: 18),
              ),
              trailing: Icon(
                Icons.local_movies,
                color: Colors.blueGrey,
              ),
            ),
            /* ListTile(
              title: Text(
                '(323) 555 6789',
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Text(
                'Work',
                style: TextStyle(fontSize: 18),
              ),
              trailing: Icon(
                Icons.chat,
                color: Colors.blueGrey,
              ),
            ), */
            Divider(color: Colors.blueGrey)
          ],
        ),
















        /* Row( children: [
            Text('Cantidad:'),
            Text(cantidad),
        ],) */
            
    );
  }

  Widget _total(var total) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: 

        Column(
          children: <Widget>[
            ListTile(              
              title: Text(
                'Total',
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Text(
                total.toString(),
                style: TextStyle(fontSize: 18),
              ),
              trailing: Icon(
                Icons.payment,
                color: Colors.blueGrey,
              ),
            ),
            /* ListTile(
              title: Text(
                '(323) 555 6789',
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Text(
                'Work',
                style: TextStyle(fontSize: 18),
              ),
              trailing: Icon(
                Icons.chat,
                color: Colors.blueGrey,
              ),
            ), */
            Divider(color: Colors.blueGrey)
          ],
        ),
      


/* 
      Row( children: [
            Text('Total::'),
             Text(total.toString()),
        ],)     */       
    );
  }

 Widget _pagar(String user, String pelicula, String cantidad, String valor) {
     return RaisedButton(
            child: Container(
              child: Text('Comprar Tickets'),
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            elevation: 0.0,
            color: Colors.deepPurple,
            textColor: Colors.white,
       onPressed: () {
      bloc.registrarVenta(context,user, pelicula, cantidad, valor);
    });
  }
}
