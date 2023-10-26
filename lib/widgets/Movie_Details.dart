import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_mojo/models/Movie_data.dart';
import 'package:movie_mojo/provider/favourite_provider.dart';
import 'package:movie_mojo/widgets/TopRated.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MovieDetails extends StatefulWidget {
  final String lan,
      poster_path,
      title,
      release,
      overview,
      vote_average,
      backdrop_path;
  MovieDetails(
      {super.key,
      required this.lan,
      required this.overview,
      required this.poster_path,
      required this.release,
      required this.title,
      required this.vote_average,
      required this.backdrop_path});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  Widget build(BuildContext context) {
     bool isFavorite = false;
     final movieData = context.watch<FavouriteProvider>();
    TextStyle typeStyle = GoogleFonts.dosis(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400);
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 13, 17, 67),
        body: Container(
            child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 400,
                    width: width,
                    child: Image.network(
                      widget.poster_path,
                      fit: BoxFit.fill,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          widget.title,
                          style: typeStyle,
                        ),
                      ),
                      SizedBox(width: 15,),
                       Container(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        

                        if (isFavorite) {
                         movieData.removeMovie(MovieData(backdrop_path: widget.backdrop_path, release:widget. release, title: widget.title, vote_average:widget. vote_average, original_language: widget.lan, overview:widget. overview, poster_path:widget. poster_path));
                        
                        } else {
                          movieData.addMovie(MovieData(backdrop_path: widget.backdrop_path, release:widget. release, title: widget.title, vote_average:widget. vote_average, original_language: widget.lan, overview:widget. overview, poster_path:widget. poster_path));
                        }
                        });
                      },
                      icon: Icon(
                        isFavorite ? Icons.star : Icons.star_border,
                        color: isFavorite ? Colors.yellow : Colors.white,
                      ),
                      label: Text(
                        isFavorite ? 'Remove from Favorites' : 'Add to Favorites',
                        style: TextStyle(
                          color: isFavorite ? Colors.yellow : Colors.white,
                        ),
                      ),
                    ),
                    ),
                    ]
                  ),
                ]
              )
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'IMDB Rating :' + widget.vote_average,
                      style: typeStyle,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'Release Date :' + widget.release,
                      style: typeStyle,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      widget.overview,
                      style: typeStyle,
                    ),
                  ),
                ],
              ),
            ),
    );
        
  }
}
