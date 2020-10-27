import 'package:cinema/src/Utils/alert_dialog.dart';
import 'package:cinema/src/blocs/provider.dart';
import 'package:cinema/src/pages/registro_page.dart';
import 'package:cinema/src/services/cinema_api_services.dart';
import 'package:flutter/material.dart';
import 'package:cinema/src/models/cinema_model.dart';
import 'package:cinema/src/blocs/cinema_bloc.dart';

class CinemaPage extends StatelessWidget {
  CinemaModel cinemaModel = CinemaModel();
  //final userProvider = new UserProvider();
  final servicioApi = CinemaApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(
          title: Text('Registrar Cinema'),
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
                title: Text("Registrar Cinema"),
                onTap: () {
                  Navigator.pushReplacementNamed(context, 'RegistrarCinema');
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

  Widget _crearDireccion(CinemaBloc bloc) { //
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

  Widget _crearNombreCinema(CinemaBloc bloc) { //cap total
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
  
  


  Widget _crearTelefono(CinemaBloc bloc) { //cap total
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


 _registrarCinema(CinemaBloc bloc, BuildContext context) {
    cinemaModel.address = bloc.address;
    cinemaModel.name = bloc.name;
    cinemaModel.phone = bloc.phone;
    
   servicioApi.registrarCinema(cinemaModel).then((value) {
      if(value == 'correcto'){
      AlertDialogCustom.showAlert(context, 'Se ingreso un cinema.');
     }
      
      return value;
  });

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
            onPressed: snapshot.hasData ? () => _registrarCinema(bloc, context) : null,
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