import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_mojo/screens/Favourites.dart';
import 'package:movie_mojo/widgets/Movie_Details.dart';
import 'package:movie_mojo/widgets/TopRated.dart';
import 'package:tmdb_api/tmdb_api.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List topRated = [];
  List allMovies = [];
  final String _apiKey = 'ed6c4f5c69660f34ca26373d78f86a45';
  final String _readAccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlZDZjNGY1YzY5NjYwZjM0Y2EyNjM3M2Q3OGY4NmE0NSIsInN1YiI6IjY1MzhiYTMxYWUzNjY4MDBlYTljYzA0YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.KUkwechpmG0mSkSywp0MK_UV1uP7Nki7r-k_9qAGth4';

  @override
  void initState() {
    loadMovies();
    TopRated(topRated: topRated);
    super.initState();
  }

  void loadMovies() async {
    TMDB tmdbCustomLogs = TMDB(
      ApiKeys(_apiKey, _readAccessToken),
      logConfig: ConfigLogger(showLogs: true, showErrorLogs: true),
    );

    Map TopRatedMovies = await tmdbCustomLogs.v3.movies.getTopRated();
    Map MovieDetails = await tmdbCustomLogs.v3.discover.getMovies();

    setState(() {
      topRated = TopRatedMovies['results'];
      allMovies = MovieDetails['results'];
    });
    print(topRated);
    print(allMovies);
  }
  @override
  Widget build(BuildContext context) {
    int flag = 0;
    double width = MediaQuery.of(context).size.width;
    //String enteredSearch = searchController.text;
   

    TextStyle typeStyle = GoogleFonts.dosis(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 13, 17, 67),
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: TextFormField(
          cursorHeight: 20,
          style: typeStyle.copyWith(
              fontWeight: FontWeight.w100,
              color: Theme.of(context).colorScheme.primary),
          decoration: InputDecoration(
            filled: true,
            constraints: BoxConstraints.tightForFinite(),
            fillColor: Theme.of(context).colorScheme.onPrimary,
            labelText: ' Movies',
            labelStyle: typeStyle.copyWith(
                fontWeight: FontWeight.w100,
                color: Theme.of(context).colorScheme.primary),
            floatingLabelAlignment: FloatingLabelAlignment.center,
            floatingLabelStyle: typeStyle,
            prefixIcon: Icon(Icons.search),
            iconColor: Theme.of(context).colorScheme.onBackground,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          ),
          controller: searchController,
          textAlign: TextAlign.left,
          showCursor: true,
          cursorColor: Theme.of(context).colorScheme.onBackground,
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              print('check1');
              for (final item in allMovies) {
                print(searchController.text)
;                if (item?['title'] == searchController.text) {
                  print('check2');
                  flag = 1;
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
              if (flag == 0)
                SnackBar(
                  content: Text('Movie Not Found !'),
                );
            },
            child: Text('Search'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: TopRated(topRated: topRated),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: ListView(
          children: [
            DrawerHeader(
              child: Image.asset('assets/images/Movie_Mojo_logo.png'),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 13, 17, 67),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 12),
              title: Text(
                'Favourites',
                style: typeStyle,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FavoritesScreen(),
                  ),
                );
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 12),
              title: Text(
                'Logout',
                style: typeStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}