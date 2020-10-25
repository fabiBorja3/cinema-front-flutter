import 'package:cinema/src/blocs/login_bloc.dart';
import 'package:cinema/src/blocs/registro_bloc.dart';
export 'package:cinema/src/blocs/registro_bloc.dart';
export 'package:cinema/src/blocs/login_bloc.dart';
import 'package:flutter/material.dart';

class Provider extends InheritedWidget {
  final loginBloc = LoginBloc();
  final registroBloc = RegistroBloc();

  Provider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    throw UnimplementedError();
  }

  static LoginBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
  }

  static RegistroBloc ofRegistro(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>().registroBloc;
  }

  static RegistroBloc ofInscripcion(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>().registroBloc;
  }

  static RegistroBloc ofRegistroPeliculas(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>().registroBloc;
  }
}
/*







class ProviderHome extends InheritedWidget {
  final homeBloc = HomeBloc();

  ProviderHome({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    throw UnimplementedError();
  }
  static HomeBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ProviderHome>().homeBloc;
  }

  
}

*/
