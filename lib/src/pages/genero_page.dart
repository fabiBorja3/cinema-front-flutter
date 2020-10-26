import 'package:cinema/src/Utils/alert_dialog.dart';
import 'package:cinema/src/blocs/genero_bloc.dart';
import 'package:cinema/src/blocs/provider.dart';
import 'package:cinema/src/models/gender_model.dart';
import 'package:cinema/src/services/cinema_api_services.dart';
import 'package:flutter/material.dart';

class GeneroPage extends StatelessWidget {
  GeneroModel generoModel = GeneroModel();
  //final userProvider = new UserProvider();
  final servicioApi = CinemaApiService();

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

  Widget _crearGenero(RegistroGeneroBloc bloc) {
    return StreamBuilder(
      stream: bloc.generoStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.alternate_email,
                  color: Colors.deepPurple,
                ),
                hintText: 'Accion',
                labelText: 'Genero',
                errorText: snapshot.error,
                counterText: snapshot.data),
            onChanged: bloc.changeGenero,
          ),
        );
      },
    );
  }



  _registrarGenero(RegistroGeneroBloc bloc, BuildContext context) {
    generoModel.name = bloc.nombre;
    servicioApi.registrarGenero(generoModel).then((value) {
      if(value == 'invalido'){
      AlertDialogCustom.showAlert(context, 'Autorizacion Invalida');
      }else{
Navigator.pushReplacementNamed(context, 'home');
      }
      
      return value;
    });

 
  }

  Widget _crearBoton(BuildContext context, RegistroGeneroBloc bloc) {
          return RaisedButton(
            child: Container(
              child: Text('Ingreso'),
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            elevation: 0.0,
            color: Colors.deepPurple,
            textColor: Colors.white,
            onPressed: bloc.nombre.length > 0 ? () => _registrarGenero(bloc, context) : null,
          );
  }

  Widget _loginForm(BuildContext context) {
    final bloc = Provider.ofRegistroGenero(context);
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
                  'Ingreso',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(
                  height: 60.0,
                ),
                _crearGenero(bloc),
                SizedBox(
                  height: 60.0,
                ),
                _crearBoton(context, bloc),
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
