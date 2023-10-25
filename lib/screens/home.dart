import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    TextStyle typeStyle = GoogleFonts.dosis(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 13, 17, 67),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: TextFormField(
          cursorHeight: 20,
          style: typeStyle.copyWith(fontWeight: FontWeight.w100,
            color: Theme.of(context).colorScheme.primary),
          decoration: InputDecoration(
            filled: true,
            constraints: BoxConstraints.tightForFinite(),
            fillColor: Theme.of(context).colorScheme.onPrimary,
            labelText: 'Search for your Favourite Movies',
            labelStyle: typeStyle.copyWith(fontWeight: FontWeight.w100,
            color: Theme.of(context).colorScheme.primary),
            floatingLabelAlignment: FloatingLabelAlignment.center,
            floatingLabelStyle: typeStyle,
            prefixIcon: Icon(Icons.search),
            iconColor: Theme.of(context).colorScheme.onBackground,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          ),
          controller: searchController,
          textAlign: TextAlign.center,
          showCursor: true,
          cursorColor:Theme.of(context).colorScheme.onBackground,
        ),
      ),
    );
  }
}
