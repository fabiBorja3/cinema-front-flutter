import 'package:cinema/src/blocs/login_bloc.dart';
export 'package:cinema/src/blocs/login_bloc.dart';
import 'package:flutter/material.dart';

class Provider extends InheritedWidget {
  final loginBloc = LoginBloc();

  Provider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    throw UnimplementedError();
  }

  static LoginBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
  }
}
