import 'package:flutter/material.dart';

import '../model/movie_model.dart';

class MovieListProvider with ChangeNotifier {
  final List<Movie> _movies = [
    Movie(
      id: "1",
      title: "Avengers",
      director: "Russo Brothers",
      imgUrl:
          "https://lumiere-a.akamaihd.net/v1/images/p_avengersendgame_19751_e14a0104.jpeg?region=0%2C0%2C540%2C810",
      status: false,
    ),
    Movie(
      id: "2",
      title: "Avengers",
      director: "Russo Brothers",
      imgUrl:
          "https://lumiere-a.akamaihd.net/v1/images/p_avengersendgame_19751_e14a0104.jpeg?region=0%2C0%2C540%2C810",
      status: false,
    ),
    Movie(
      id: "3",
      title: "Avengers",
      director: "Russo Brothers",
      imgUrl:
          "https://lumiere-a.akamaihd.net/v1/images/p_avengersendgame_19751_e14a0104.jpeg?region=0%2C0%2C540%2C810",
      status: false,
    ),
    Movie(
      id: "4",
      title: "Avengers",
      director: "Russo Brothers",
      imgUrl:
          "https://lumiere-a.akamaihd.net/v1/images/p_avengersendgame_19751_e14a0104.jpeg?region=0%2C0%2C540%2C810",
      status: false,
    ),
  ];
  List<Movie> get movies => _movies;

  void addMovie(Movie movie) {
    movies.add(movie);
    notifyListeners();
  }

  void delMovie(Movie movie) {
    movies.remove(movie);
    notifyListeners();
  }

  void movieStatus(Movie movie) {
    movie.status = !movie.status;
    notifyListeners();
  }
}
