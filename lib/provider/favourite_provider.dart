import 'package:flutter/material.dart';
import 'package:movie_mojo/models/Movie_data.dart';

class FavouriteProvider with ChangeNotifier {
  List<MovieData> _movies = [];

  List<MovieData> get movies => _movies;

  void addMovie(MovieData movie) {
    _movies.add(movie);
    notifyListeners();
  }

  void removeMovie(MovieData movie) {
    _movies.remove(movie);
    notifyListeners();
  }
}
