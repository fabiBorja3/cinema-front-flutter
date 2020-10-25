
import 'package:cinema/src/blocs/provider.dart';
import 'package:cinema/src/blocs/registro_bloc.dart';
import 'package:cinema/src/models/user_model.dart';
import 'package:cinema/src/services/cinema_api_services.dart';
import 'package:flutter/material.dart';

class RegistroPage extends StatelessWidget {
  UserModel user = new UserModel();
  final cinemaService = new CinemaApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
          title: Text('Registro de usuarios'),
          backgroundColor: Colors.deepPurple,
        ),
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _loginForm(context),
        ],
      ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.deepPurple),
                child: Text(
                  'MY APP',
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
                leading: Icon(Icons.verified_user),
                title: Text("Registrar usuarios"),
                onTap: () {
                  Navigator.pushReplacementNamed(context, 'registroPersona');
                },
              ),
              ListTile(
                leading: Icon(Icons.verified_user),
                title: Text("Registrar Teatro"),
                onTap: () {
                  Navigator.pushReplacementNamed(context, 'RegistroTeatro');
                },
              ),
               ListTile(
                leading: Icon(Icons.verified_user),
                title: Text("Ocupacion"),
                onTap: () {
                  Navigator.pushReplacementNamed(context, 'OcuparCine');
                },
              )
            ],
          ),
        ));

  }

 Widget _crearEmail(RegistroBloc bloc) {
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

 Widget _crearPassword(RegistroBloc bloc) {
    return StreamBuilder(
        stream: bloc.passwordStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.lock_outline,
                    color: Colors.deepPurple,
                  ),
                  labelText: 'Password',
                  counterText: snapshot.data,
                  errorText: snapshot.error),
              onChanged: bloc.changePassword,
            ),
          );
        });
  }

 void _registrar(RegistroBloc bloc, BuildContext context) {
    user.username = bloc.email;
    user.password = bloc.password;
    print('================');
    print('Email ${bloc.email}');
    print('Password ${bloc.password}');
    print('==============');
    cinemaService.registrarUser(user);
    
  }

  Widget _crearBoton(RegistroBloc bloc) {
    return StreamBuilder(
        stream: bloc.formValidStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return RaisedButton(
            child: Container(
              child: Text('Registro'),
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            elevation: 0.0,
            color: Colors.deepPurple,
            textColor: Colors.white,
            onPressed: snapshot.hasData ? () => _registrar(bloc, context) : null,
          );
        });
  }


  Widget _loginForm(BuildContext context) {
    final bloc = Provider.ofRegistro(context);
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
                  'Ingrese los datos del usuario',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(
                  height: 60.0,
                ),
                _crearEmail(bloc),
                SizedBox(
                  height: 60.0,
                ),
                _crearPassword(bloc),
                SizedBox(
                  height: 60.0,
                ),
                _crearBoton(bloc),
              ],
            ),
          ),
          GestureDetector(
  onTap: () {
       Navigator.pushReplacementNamed(context, 'login');
  },
  child: Text("Login"),
),
          const Divider(
            color: Colors.black,
            height: 20,
            thickness: 5,
            indent: 20,
            endIndent: 0,
          ),
                  GestureDetector(
  onTap: () {
       Navigator.pushReplacementNamed(context, 'recuperacion');
  },
  child: Text("¿Olvido la contraseña?"),
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
