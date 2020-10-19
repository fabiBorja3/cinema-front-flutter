import 'package:cinema/src/blocs/home_bloc.dart';
import 'package:cinema/src/blocs/login_bloc.dart';
export 'package:cinema/src/blocs/login_bloc.dart';
import 'package:flutter/material.dart';

class Provider extends InheritedWidget {
  final loginBloc = LoginBloc();
  final homeBloc = HomeBloc();

  Provider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {

    throw UnimplementedError();
  }

  static LoginBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
  }

}
