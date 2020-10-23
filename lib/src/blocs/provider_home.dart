import 'package:flutter/cupertino.dart';

import 'home_bloc.dart';

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
