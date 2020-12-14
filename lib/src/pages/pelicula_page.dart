import 'package:cinema/src/blocs/pelicula_bloc.dart';
import 'package:cinema/src/models/movie_model.dart';
import 'package:cinema/src/models/actor_model.dart';
import 'package:cinema/src/pages/preventa_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';

class PeliculaPage extends StatefulWidget {
  final Movie movie;
  const PeliculaPage({Key key, @required this.movie}) : super(key: key);

  @override
  _PeliculaPageState createState() => _PeliculaPageState(movie);
}

class _PeliculaPageState extends State<PeliculaPage> {
  final Movie movie;
  String _selectedHorario;
  String cantidad;
  PeliculaBloc bloc = PeliculaBloc();
  _PeliculaPageState(this.movie);

  @override
  Widget build(BuildContext context) {
    String id = movie.id;
    String titulo = movie.titulo;
    String descripcion = movie.descripcion;
    /* return Scaffold(
      appBar: AppBar(
        title: Text('Reservar silla'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
              padding: EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Text('id: $id'),
                  Text('id: $titulo'),
                  Text('id: $descripcion'),
                  
                ],
                //child: QrDemo(),
              )),
        ],
      ),
    ); */

    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        _crearAppbar(),
        SliverList(
          delegate: SliverChildListDelegate([
            SizedBox(height: 10.0),
            _posterTitulo(context),
            _descripcion(movie.id),
            _descripcion(movie.titulo),
            _descripcion(movie.descripcion),
            _nroPersonas(),
            Container(child: Row(children: [Text('Horarios: ',style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold) ,),_horarios(movie.horarios),],),
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),),
            _valor(),
            Divider( height: 3, color: Colors.deepPurple),
            _crearActoresPageView(),
            _crearBoton(),
          ]),
        )
      ],
    ));
  }

  Widget _crearAppbar() {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.deepPurple,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movie.titulo,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          image: NetworkImage(movie.portada),
          placeholder: AssetImage('assets/img/loading.gif'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _descripcion(String cadena) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        cadena,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _horarios(List<dynamic> horariosList) {
    List<DropdownMenuItem> items = horariosList.map((item) {
      return DropdownMenuItem<String>(
        child: Center(
            child: Text(item,
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
            'No existen Horarios.',
            textAlign: TextAlign.center,
          )),
        )
      ];
    }

    return StreamBuilder(
        stream: bloc.horarioStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Expanded(
            child: DropdownButton(
              items: items,
              onChanged: (newVal) {
                setState(() => _selectedHorario = newVal);
                bloc.changeHorario;
              },
              value: _selectedHorario,
            ),
          );
        });
  }

  Widget _posterTitulo(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: movie.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                //image: NetworkImage('https://1.bp.blogspot.com/-xU58YYa1Xv4/XXqOs-0lYmI/AAAAAAAAIYs/_TgZiGN3vMAg2MwRLb0-HdA__9_u_7QeQCLcBGAsYHQ/s1600/Vengadores%2B-%2BEnd%2BGame%2B-%2B%255Bfrontal%255D.jpg'),
                image: NetworkImage(movie.portada),
                height: 150.0,
              ),
            ),
          ),
          SizedBox(width: 20.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(movie.titulo,
                    style: Theme.of(context).textTheme.title,
                    overflow: TextOverflow.ellipsis),
                Text(movie.genero,
                    style: Theme.of(context).textTheme.subhead,
                    overflow: TextOverflow.ellipsis),
                Row(
                  children: <Widget>[
                    Icon(Icons.star_border),
                    Text(movie.titulo,
                        style: Theme.of(context).textTheme.subhead)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _crearActoresPageView() {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(viewportFraction: 0.3, initialPage: 1),
        itemCount: 2,
        itemBuilder: (context, i) => _actorTarjeta(),
      ),
    );
  }

  Widget _actorTarjeta() {
    return Container(
        child: Column(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: FadeInImage(
            image: NetworkImage(movie.actor['img1']),
            placeholder: AssetImage('assets/img/no-image.jpg'),
            height: 150.0,
            fit: BoxFit.cover,
          ),
        ),
        Text(
          movie.actor['nombre1'],
          overflow: TextOverflow.ellipsis,
        )
      ],
    ));
  }

  Widget _crearBoton() {
    return StreamBuilder(
        stream: bloc.formValidStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return RaisedButton(
            child: Container(
              child: Text('Comprar'),
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            ),
            onPressed: () {
              if (_selectedHorario != null && cantidad != null) {
                _venderTicket(movie, _selectedHorario, cantidad);
              }
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            elevation: 0.0,
            color: Colors.deepPurple,
            textColor: Colors.white,
          );
        });
  }

  Widget _nroPersonas() {
    return StreamBuilder(
        stream: bloc.cantidadStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.airline_seat_recline_normal,
                    color: Colors.deepPurple,
                  ),
                  labelText: 'Numero de tickets',
                ),
                onChanged: (value) {
                  cantidad = value;
                },
              ));
        });
  }

  Widget _valor() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      child: Row(children: [Text('Valor de ticket: ',style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold) ,),Text(movie.valor),],),
    );
  }

  _venderTicket(Movie movie, String horario, String cantidad) async {
    var usuario = await FlutterSession().get('user') as String;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PreventaPage(
            movie: movie, user: usuario, horario: horario, cantidad: cantidad),
      ),
    );
  }
}
