import 'package:cinema/src/blocs/provider.dart';
import 'package:cinema/src/widgets/card_swiper_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    
    final bloc = Provider.of(context);
    
    return Scaffold(
      appBar: AppBar(

        title: Text('Home Page')
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Email: ${bloc.email}'),
            Divider(),
            Text('Password: ${bloc.password}'),
            _swiperTarjetas(),]),
    );
  }


    Widget _swiperTarjetas() {
    return CardSwiper(
        peliculas: [1,2,3,4,5],
    );

    // return CardSwiper(
    //   peliculas: [1,2,3,4,5],
    // );
  }
}