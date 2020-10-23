
import 'package:flutter/material.dart';
import 'package:cinema/src/blocs/recuperacion_pws_bloc.dart';
export 'package:cinema/src/blocs/recuperacion_pws_bloc.dart';

class ProviderRecuperar extends InheritedWidget {
  final recuperarBloc = RecuperarBloc();

  ProviderRecuperar({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    throw UnimplementedError();
  }
  static RecuperarBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ProviderRecuperar>().recuperarBloc;
  }
}