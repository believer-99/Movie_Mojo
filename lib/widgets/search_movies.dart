import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_mojo/widgets/Movie_Details.dart';
import 'package:tmdb_api/tmdb_api.dart';

class SearchMovies extends StatefulWidget {
  final String searchQuery;
  SearchMovies({super.key, required this.searchQuery});

  @override
  State<SearchMovies> createState() => _SearchMoviesState();
}

class _SearchMoviesState extends State<SearchMovies> {
  @override
  void initState() {
    // TODO: implement initState
    loadMovies();
    super.initState();
  }

  final String _apiKey = 'ed6c4f5c69660f34ca26373d78f86a45';
  final String _readAccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlZDZjNGY1YzY5NjYwZjM0Y2EyNjM3M2Q3OGY4NmE0NSIsInN1YiI6IjY1MzhiYTMxYWUzNjY4MDBlYTljYzA0YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.KUkwechpmG0mSkSywp0MK_UV1uP7Nki7r-k_9qAGth4';
  List movies = [];

  void loadMovies() async {
    TMDB tmdbCustomLogs = TMDB(
      ApiKeys(_apiKey, _readAccessToken),
      logConfig: ConfigLogger(showLogs: true, showErrorLogs: true),
    );

    Map TopRatedMovies = await tmdbCustomLogs.v3.movies.getTopRated();
    Map MovieDetails = await tmdbCustomLogs.v3.discover.getMovies();
    List allMovies = MovieDetails['results'];

    setState(() {
      movies = TopRatedMovies['results'];
    });
    print(allMovies);
    print(widget.searchQuery);
  }

  @override
  Widget build(BuildContext context) {
    loadMovies();
    for (final item in movies) {
      if (item?['title'] == widget.searchQuery) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => MovieDetails(
              lan: item?['original_language'],
              overview: item?['overview'],
              poster_path: item?['poster_path'],
              release: item?['release_date'],
              title: item?['title'],
              vote_average: item?['vote_average'],
              backdrop_path: item?['backdrop_path'],
            ),
          ),
        );
      }
    }
    return SnackBar(
      content: Text('Movie Not Found !'),
    );
  }
}
