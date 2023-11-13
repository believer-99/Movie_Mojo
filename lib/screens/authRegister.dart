import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_mojo/widgets/spinner.dart';
import 'package:movie_mojo/models/user_details.dart';
import 'package:movie_mojo/screens/authLogin.dart';
import 'package:http/http.dart' as http;
import 'package:movie_mojo/screens/home.dart';

class AuthRegisterScreen extends StatefulWidget {
  AuthRegisterScreen({super.key});
  @override
  State<AuthRegisterScreen> createState() {
    return _AuthRegisterScreenState();
  }
}

class _AuthRegisterScreenState extends State<AuthRegisterScreen> {
  final _form = GlobalKey<FormState>();
  var _emailController = TextEditingController();
  var _userNameController = TextEditingController();
  var _passwordController = TextEditingController();
  var _phoneController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    var _isAuthenticating = false;

    void _authenticate() async {
      final isValid = _form.currentState!.validate();
      if (!isValid) {
        return;
      } else {
        _form.currentState!.save();
      }
    }

    void submit() async {
      var _enteredEmail = _emailController.text;
      var _enteredUserName = _userNameController.text;
      var _enteredPassword = _passwordController.text;
      var _enteredPhone = int.parse(_phoneController.text);

      String? _error = '';
      setState(() {
        _isAuthenticating = true;
      });
      Map<String, dynamic> userDetails = {
        'username': _enteredUserName,
        'email': _enteredEmail,
        'phone': _enteredPhone,
        'password': _enteredPassword,
      };
      var userDataJson = json.encode(userDetails);
      final url = Uri.https(
          'movie-mojo-32152-default-rtdb.firebaseio.com', 'movie-mojo.json');
      final response = await http.post(
        url,
        body: userDataJson,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode >= 400) {
        setState(
          () {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(_error = 'Failed to Connect ! Please Try Again'),
              ),
            );
          },
        );
      }
      final List<UserDetails> userData = [];
      final Set<String> usernames = {};
      final Map<String, dynamic> listData = json.decode(response.body);
      for (final data in listData.entries) {
        final username = data.value['username'];
        if (usernames.contains(username)) {
          setState(() {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(_error =
                    'username already exists ! \n Try a different username or Login'),
              ),
            );
          });
        }
        userData.add(
          UserDetails(
            email: data.value['email'],
            password: data.value['password'],
            phone: data.value['phone'],
            username: data.value['username'],
          ),
        );
        print(userData);
      }
    }

    TextStyle typeStyle = GoogleFonts.dosis(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/movie_background.jpg'),
                opacity: 0.75,
                fit: BoxFit.fill,
              ),
            ),
            height: height,
            width: width,
          ),
          SingleChildScrollView(
            child: Center(
              child: Form(
                key: _form,
                child: Container(
                  padding: EdgeInsets.all(16),
                  color:
                      Theme.of(context).colorScheme.primary.withOpacity(0.75),
                  height: height,
                  width: width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello !',
                        style: GoogleFonts.quicksand(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Text(
                        'Register Yourself to Immerse into a World of Magical Movies',
                        style: GoogleFonts.dosis(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      TextFormField(
                        controller: _userNameController,
                        style: typeStyle,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.primary,
                          isDense: true,
                          labelText: 'Username',
                          labelStyle: typeStyle,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        enableSuggestions: false,
                        validator: (value) {
                          if (value == null || value.trim().length < 4) {
                            return 'Please enter atleast 4 characters for username !';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      TextFormField(
                        controller: _emailController,
                        style: typeStyle,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.primary,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.75),
                          ),
                          labelText: 'Email Address',
                          labelStyle: typeStyle,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              !value.contains('@')) {
                            return 'Please enter a Valid email address !';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      TextFormField(
                        controller: _phoneController,
                        style: typeStyle.copyWith(fontWeight: FontWeight.w100),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.primary,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.75),
                            ),
                            labelText: 'Phone Number',
                            labelStyle: typeStyle),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              value.length < 10) {
                            return 'Please enter a Valid Phone Number !';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.primary,
                          labelText: 'Password',
                          labelStyle: typeStyle,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.75),
                          ),
                        ),
                        obscureText: true,
                        autocorrect: false,
                        cursorColor: Colors.white,
                        style: typeStyle,
                        validator: (value) {
                          if (value == null || value.trim().length < 6) {
                            return 'Password must be at least 6 characters long.';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              _authenticate();
                              submit();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (ctx) => HomeScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 13, 17, 67)),
                            child: Text(
                              'Submit',
                              style: GoogleFonts.quicksand(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Already Registered ?',
                              style: typeStyle,
                            ),
                            SizedBox(
                              width: 1,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (ctx) => AuthLoginScreen()),
                                );
                              },
                              child: Text(
                                'Login',
                                style: typeStyle.copyWith(
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
