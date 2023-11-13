import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_mojo/widgets/Movie_Details.dart';

class TopRated extends StatefulWidget {
  final List topRated;
  TopRated({super.key, required this.topRated});

  @override
  State<TopRated> createState() => _TopRatedState();
}

class _TopRatedState extends State<TopRated> {
  String selectedSortOption = 'Rating : Descending';

  int currentPage = 1; 

  bool isLoading = false; 
  


  void sortMovies(String option) {
    setState(() {
      selectedSortOption = option;
      switch (option) {
        case 'Release Date : Ascending':
          widget.topRated.sort((a, b) {
            return a['release_date'].compareTo(b['release_date']);
      });
          break;
        case 'Release Date : Descending':
          widget.topRated.sort((a, b) {
            return b['release_date'].compareTo(a['release_date']);
          });
          break;
        case 'Popularity : Ascending':
          widget.topRated.sort((a, b) {
            return a['popularity'].compareTo(b['popularity']);
          });
          break;
        case 'Popularity : Descending':
          widget.topRated.sort((a, b) {
            return b['popularity'].compareTo(a['popularity']);
          });
          break;
        case 'Rating : Ascending':
          widget.topRated.sort((a, b) {
            return a['vote_average'].compareTo(b['vote_average']);
          });
          break;
        case 'Rating : Descending':
          widget.topRated.sort((a, b) {
            return b['vote_average'].compareTo(a['vote_average']);
          });
          break;
        default:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle typeStyle = GoogleFonts.dosis(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w400,
    );

    List<DropdownMenuItem<String>> sortItems = [
      DropdownMenuItem(
        value: 'Release Date : Ascending',
        child: Text('Release Date : Ascending', style: typeStyle.copyWith(fontSize: 16),
        overflow: TextOverflow.ellipsis,),
      ),
      DropdownMenuItem(
        value: 'Release Date : Descending',
        child: Text('Release Date : Descending', style: typeStyle.copyWith(fontSize: 16),overflow: TextOverflow.ellipsis),
      ),
      DropdownMenuItem(
        value: 'Popularity : Ascending',
        child: Text('Popularity : Ascending', style: typeStyle.copyWith(fontSize: 16),overflow: TextOverflow.ellipsis),
      ),
      DropdownMenuItem(
        value: 'Popularity : Descending',
        child: Text('Popularity : Descending', style: typeStyle.copyWith(fontSize: 16),overflow: TextOverflow.ellipsis),
      ),
      DropdownMenuItem(
        value: 'Rating : Ascending',
        child: Text('Rating : Ascending', style: typeStyle.copyWith(fontSize: 16),overflow: TextOverflow.ellipsis),
      ),
      DropdownMenuItem(
        value: 'Rating : Descending',
        child: Text('Rating : Descending', style: typeStyle.copyWith(fontSize: 16),overflow: TextOverflow.ellipsis),
      ),
    ];

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Container(
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Top Rated Movies',
                  style: GoogleFonts.quicksand(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                Expanded(
                  child: Container(width: 100,
                  height: 50,
                    child: Expanded(
                      child: DropdownButton<String>(
                        iconSize: 15,
                        
                        alignment: Alignment.center,
                        dropdownColor: Theme.of(context).colorScheme.primary,
                        icon: Icon(Icons.filter_alt_sharp),
                        iconEnabledColor: Colors.white,
                        items: sortItems,
                        onChanged: (selectedOption) {
                          sortMovies(selectedOption as String);
                        },
                        value: selectedSortOption,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            SingleChildScrollView(
              child: Container(
                height: height - 175,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: widget.topRated.length,
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
                                        lan: widget.topRated[index]['original_language'],
                                        overview: widget.topRated[index]['overview'],
                                        poster_path: 'https://image.tmdb.org/t/p/w500' + widget.topRated[index]['poster_path'],
                                        release: widget.topRated[index]['release_date'].toString(),
                                        title: widget.topRated[index]['title'],
                                        vote_average: widget.topRated[index]['vote_average'].toString(),
                                        backdrop_path: 'https://image.tmdb.org/t/p/w500' + widget.topRated[index]['backdrop_path'],
                                      ),
                                    ),
                                  ),
                                  child: Image(
                                    filterQuality: FilterQuality.high,
                                    image: NetworkImage('https://image.tmdb.org/t/p/w500' + widget.topRated[index]['backdrop_path']),
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
                                      'Name : ' + widget.topRated[index]['title'],
                                      style: typeStyle.copyWith(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      'Release : ' + (widget.topRated[index]['release_date'].toString()),
                                      style: typeStyle.copyWith(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      'Rating : ' + (widget.topRated[index]['vote_average'].toString()),
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
    );
  }
}
