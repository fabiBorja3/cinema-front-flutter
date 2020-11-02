
import 'package:cinema/src/blocs/provider.dart';
import 'package:cinema/src/blocs/registro_personas_bloc.dart';
import 'package:cinema/src/models/person_model.dart';
import 'package:cinema/src/services/cinema_api_services.dart';
import 'package:cinema/src/widgets/menu_widget.dart';
import 'package:flutter/material.dart';

class PersonaPage extends StatelessWidget {
  //final userProvider = new UserProvider();
  final servicioApi = CinemaApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Registro de Usuarios'),
          backgroundColor: Colors.deepPurple,
        ),
        body: Stack(
          children: <Widget>[
            _crearFondo(context),
            _loginForm(context),
          ],
        ),
        drawer: menuWidget());
  }

  Widget _crearNombre(RegistrarPersonasBloc bloc) {
    return StreamBuilder(
      stream: bloc.nombreStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.account_circle,
                  color: Colors.deepPurple,
                ),
                hintText: 'John',
                labelText: 'Nombre',
                errorText: snapshot.error,
                counterText: snapshot.data),
            onChanged: bloc.changeNombre,
          ),
        );
      },
    );
  }

  Widget _crearApellido(RegistrarPersonasBloc bloc) {
    return StreamBuilder(
      stream: bloc.apellidoStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.alternate_email,
                  color: Colors.deepPurple,
                ),
                hintText: 'Doe',
                labelText: 'Apellido',
                errorText: snapshot.error,
                counterText: snapshot.data),
            onChanged: bloc.changeApellido,
          ),
        );
      },
    );
  }

  Widget _crearTelefono(RegistrarPersonasBloc bloc) {
    return StreamBuilder(
      stream: bloc.telefonoStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.phone,
                  color: Colors.deepPurple,
                ),
                hintText: '34567235',
                labelText: 'Telefono',
                errorText: snapshot.error,
                counterText: snapshot.data),
            onChanged: bloc.changeTelefono,
          ),
        );
      },
    );
  }

  Widget _crearDireccion(RegistrarPersonasBloc bloc) {
    return StreamBuilder(
      stream: bloc.direccionStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.alternate_email,
                  color: Colors.deepPurple,
                ),
                hintText: 'calle falsa 123',
                labelText: 'Direccion',
                errorText: snapshot.error,
                counterText: snapshot.data),
            onChanged: bloc.changeDireccion,
          ),
        );
      },
    );
  }

  Widget _crearEmail(RegistrarPersonasBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.alternate_email,
                  color: Colors.deepPurple,
                ),
                hintText: 'ejemplo@correo.com',
                labelText: 'Correo electronico',
                errorText: snapshot.error,
                counterText: snapshot.data),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );
  }

  void _registrarPersonas(RegistrarPersonasBloc bloc, BuildContext context) {
    var personModel = PersonModel();
    personModel.name = bloc.nombre;
    personModel.lastname = bloc.apellido;
    personModel.phone = bloc.telefono;
    personModel.address = bloc.direccion;
    personModel.mail = bloc.email;
    bloc.registrarUsuario(context, personModel);

    //userProvider.loginUser(context, user);
  }

  Widget _crearBoton(RegistrarPersonasBloc bloc) {
    return StreamBuilder(
        stream: bloc.formValidStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return RaisedButton(
            child: Container(
              child: Text('Aceptar'),
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            elevation: 0.0,
            color: Colors.deepPurple,
            textColor: Colors.white,
            onPressed: snapshot.hasData
                ? () => _registrarPersonas(bloc, context)
                : null,
          );
        });
  }

  Widget _loginForm(BuildContext context) {
    final bloc = Provider.ofRegistroPersonas(context);
    final size = MediaQuery.of(context).size;
    //Navigator.pushReplacementNamed(context, 'home');

    return SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(
              child: Container(
            height: 180.1,
          )),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3.0)
                ]),
            child: Column(
              children: <Widget>[
                Text(
                  'Usuarios',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(
                  height: 60.0,
                ),
                _crearNombre(bloc),
                SizedBox(
                  height: 60.0,
                ),
                _crearApellido(bloc),
                SizedBox(
                  height: 60.0,
                ),
                _crearTelefono(bloc),
                SizedBox(
                  height: 60.0,
                ),
                _crearDireccion(bloc),
                SizedBox(
                  height: 60.0,
                ),
                _crearEmail(bloc),
                SizedBox(
                  height: 60.0,
                ),
                _crearBoton(bloc),
              ],
            ),
          ),
          const Divider(
            color: Colors.black,
            height: 20,
            thickness: 5,
            indent: 20,
            endIndent: 0,
          ),
          SizedBox(
            height: 100.0,
          )
        ],
      ),
    );
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color.fromRGBO(63, 63, 156, 1.0),
        Color.fromRGBO(90, 70, 178, 1.0),
      ])),
    );
  }
}
