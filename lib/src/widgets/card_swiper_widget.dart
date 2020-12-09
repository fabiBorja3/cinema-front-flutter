import 'package:cinema/src/Utils/alert_dialog.dart';
import 'package:cinema/src/models/movie_model.dart';
import 'package:cinema/src/pages/pelicula_page.dart';
import 'package:cinema/src/services/cinema_api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;
  final cinemaApi = CinemaApiService();

  CardSwiper({@required this.movies});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      //width: double.infinity,
      //height: 300.0,
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.5,
        itemHeight: _screenSize.height * 0.5,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                  image: NetworkImage(movies[index].portada),
                  placeholder: AssetImage('assets/img/no-image.jpg')));
        },
        itemCount: movies.length,
        onTap: (index) {
          informacion(context, movies[index]);
          //AlertDialogCustom.showInfoPeliculas(context, homeProvider.getPelicula(peliculas[index]['id']));
        },
        //pagination: new SwiperPagination(),
        //control: new SwiperControl(),
      ),
    );
  }

  void informacion(BuildContext context, Movie movie) async {
    print('Fetching user order...');
          Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            PeliculaPage(movie: movie),
      ),
    );
  }
  // "http://via.placeholder.com/350x150",
}
