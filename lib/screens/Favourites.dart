import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_mojo/models/Movie_data.dart';
import 'package:movie_mojo/provider/favourite_provider.dart';
import 'package:movie_mojo/widgets/Movie_Details.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatefulWidget
{
  FavoritesScreen({super.key});
  @override
  State<FavoritesScreen> createState() {
    return _FavouritesScreenState();
  }
}
class _FavouritesScreenState extends State<FavoritesScreen>
{
  List<MovieData>favMovies=[];
  @override
  Widget build(BuildContext context) {
 final movieinfo=context.read<FavouriteProvider>();
 List movieInfo=movieinfo.movies;
   for (var info in movieInfo) {
      var movie = MovieData(
        original_language: info.or,
        title: info.title,
        overview: info.overview,
        poster_path: info.poster_path,
        release: info.release,
        vote_average: info.vote_average,
        backdrop_path: info.backdrop_path,
      );
   
      favMovies.add(movie);
   }

TextStyle typeStyle = GoogleFonts.dosis(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w400,
    );

     double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
            backgroundColor: const Color.fromARGB(255, 13, 17, 67),
      appBar: AppBar(
        title: Text('Favourite Movies',
        style: GoogleFonts.quicksand(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: height,
          child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             const SizedBox(height: 15),
            SingleChildScrollView(
              child: Container(
                height: height - 175,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: favMovies.length,
                  itemBuilder: (ctx, index) {
                    return Container(
                      color: const Color.fromARGB(255, 13, 17, 67),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                height: 200,
                                child: InkWell(
                                  onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (ctx) => MovieDetails(
                                        lan: favMovies[index].original_language,
                                        overview: favMovies[index].overview,
                                        poster_path: 'https://image.tmdb.org/t/p/w500' + favMovies[index].poster_path,
                                        release: favMovies[index].release.toString(),
                                        title: favMovies[index].title,
                                        vote_average: favMovies[index].vote_average.toString(),
                                        backdrop_path: 'https://image.tmdb.org/t/p/w500' + favMovies[index].backdrop_path,
                                      ),
                                    ),
                                  ),
                                  child: Image(
                                    filterQuality: FilterQuality.high,
                                    image: NetworkImage('https://image.tmdb.org/t/p/w500' + favMovies[index].backdrop_path),
                                    height: 200,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                left: 30,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Name : ' + favMovies[index].title,
                                      style: typeStyle.copyWith(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      'Release : ' + (favMovies[index].release.toString()),
                                      style: typeStyle.copyWith(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      'Rating : ' + (favMovies[index].vote_average.toString()),
                                      style: typeStyle.copyWith(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      )
    );
  }
}