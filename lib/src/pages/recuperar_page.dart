import 'package:cinema/src/blocs/provider.dart';
import 'package:cinema/src/blocs/provider_recuperar.dart';
import 'package:cinema/src/blocs/recuperacion_pws_bloc.dart';
import 'package:cinema/src/models/user_model.dart';
import 'package:cinema/src/providers/user_provider.dart';
import 'package:flutter/material.dart';

class RecuperarPage extends StatelessWidget {
  UserModel user = new UserModel();
  final userProvider = new UserProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _loginForm(context),
        ],
      ),
    );
  }

  _crearEmail(RecuperarBloc bloc) {
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

  _crearPassword(RecuperarBloc bloc) {
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

  _login(RecuperarBloc bloc, BuildContext context) {
    user.username = bloc.email;
    user.password = bloc.password;
    print('================');
    print('Email ${bloc.email}');
    print('Password ${bloc.password}');
    print('==============');
    userProvider.loginUser(context,user);
    
  }

  Widget _crearBoton(RecuperarBloc bloc) {
    return StreamBuilder(
        stream: bloc.formValidStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return RaisedButton(
            child: Container(
              child: Text('Recuperar Contraseña'),
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            elevation: 0.0,
            color: Colors.deepPurple,
            textColor: Colors.white,
            onPressed: snapshot.hasData ? () => _login(bloc, context) : null,
          );
        });
  }


  Widget _loginForm(BuildContext context) {
    final bloc = ProviderRecuperar.of(context);
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
                  'Recuperar contraseña',
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
          Navigator.pushReplacementNamed(context, 'registro');
  },
  child: Text("Registrese"),
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
