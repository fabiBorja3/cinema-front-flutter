
import 'package:cinema/src/Utils/alert_dialog.dart';
import 'package:cinema/src/blocs/provider.dart';
import 'package:cinema/src/models/api_response.dart';
import 'package:cinema/src/widgets/menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:cinema/src/models/cinema_model.dart';
import 'package:cinema/src/blocs/cinema_bloc.dart';

class CinemaPage extends StatelessWidget {
    //final userProvider = new UserProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Registrar Cinemas'),
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

  Widget _crearDireccion(CinemaBloc bloc) {
    //
    return StreamBuilder(
      stream: bloc.addressStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            //keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(

                //hintText: 'ejemplo@correo.com',
                labelText: 'Digite la dirección',
                errorText: snapshot.error,
                counterText: snapshot.data),
            onChanged: bloc.changeAddress,
          ),
        );
      },
    );
  }

  Widget _crearNombreCinema(CinemaBloc bloc) {
    //cap total
    return StreamBuilder(
      stream: bloc.nameStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            //keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(

                //hintText: 'ejemplo@correo.com',
                labelText: 'Digite el nombre',
                errorText: snapshot.error,
                counterText: snapshot.data),
            onChanged: bloc.changeName,
          ),
        );
      },
    );
  }

  Widget _crearTelefono(CinemaBloc bloc) {
    //cap total
    return StreamBuilder(
      stream: bloc.phoneStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            //keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(

                //hintText: 'ejemplo@correo.com',
                labelText: 'Digite el teléfono',
                errorText: snapshot.error,
                counterText: snapshot.data),
            onChanged: bloc.changePhone,
          ),
        );
      },
    );
  }

   void _registrarCinema(CinemaBloc bloc, BuildContext context) {
    var cinemaModel = CinemaModel();
    cinemaModel.address = bloc.address;
    cinemaModel.name = bloc.name;
    cinemaModel.phone = bloc.phone;
    var apiResponse = bloc.registrarCinema(cinemaModel) as ApiResponse;

    
    if (apiResponse.statusResponse == 200) {
      AlertDialogCustom.showAlert(context, 'Se ingreso un cinema.');
    } else {
      AlertDialogCustom.showAlert(context, 'Existe un problema con la creacion del cinema.');
    }
  }

  //userProvider.loginUser(context, user);
  //}

  Widget _crearBoton(CinemaBloc bloc) {
    return StreamBuilder(
        stream: bloc.formValidStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return RaisedButton(
            child: Container(
              child: Text('Registrar'),
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            elevation: 0.0,
            color: Colors.deepPurple,
            textColor: Colors.white,
            onPressed:
                snapshot.hasData ? () => _registrarCinema(bloc, context) : null,
          );
        });
  }

  Widget _loginForm(BuildContext context) {
    final bloc = Provider.ofRegistroCinemas(context);
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
                  'Registrar Cinema',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(
                  height: 60.0,
                ),
                _crearDireccion(bloc),
                SizedBox(
                  height: 60.0,
                ),
                _crearNombreCinema(bloc),
                SizedBox(
                  height: 60.0,
                ),
                _crearTelefono(bloc),
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
