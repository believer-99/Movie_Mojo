import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart%20';
import 'package:movie_mojo/models/user_details.dart';
import 'package:movie_mojo/screens/home.dart';

class AuthLoginScreen extends StatefulWidget
{
  AuthLoginScreen({super.key});
  @override
  State<AuthLoginScreen> createState() {
    return _AuthLoginScreenState();
  }
}
class _AuthLoginScreenState extends State<AuthLoginScreen>
{
    final _form = GlobalKey<FormState>();
  var _userNameController=TextEditingController(); 
    var _passwordController=TextEditingController();

    @override
  void dispose() {
    // TODO: implement dispose
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
     double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    void _authenticate() async {
      final isValid = _form.currentState!.validate();
      if (!isValid) {
        return;
      } else {
        _form.currentState!.save();
      }
    }

    void submit() async {
         
    var _enteredUserName = _userNameController.text;
    var _enteredPassword = _passwordController.text;
    int flag=0;
    

            final url = Uri.https(
                'movie-mojo-32152-default-rtdb.firebaseio.com',
                'movie-mojo.json');
                 Map<String, dynamic> userDetails = {
              'username': _enteredUserName,
              'password': _enteredPassword,
            };
            var userDataJson = json.encode(userDetails);
            final response = await http.get(url);

            if (response.statusCode >= 400) {
              setState(
                () {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('Failed to Connect ! Please Try Again'),
                    ),
                  );
                },
              );
            }
            final Map<String, dynamic> listData = json.decode(response.body);
            for (final data in listData.entries) {
              final username = data.value['username'];
              final password=data.value['password'];
              if(username==_enteredUserName && password==_enteredPassword)
              {
                 ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('Successfully Logged In !'),
                    ),
                  );
                  flag=1;
              }
            }
            if(flag==0)
            {
              ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('Register Yourself Before Logging In !'),
                    ),
                  );
            }

    }

    TextStyle typeStyle = GoogleFonts.dosis(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500);

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
            child: Form(
              key: _form,
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(16),
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.75),
                  height: height,
                  width: width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome Back !',
                        style: GoogleFonts.quicksand(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Text(
                        'Login to Immerse Yourself into a World of Magical Movies ',
                        style: GoogleFonts.dosis(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      TextFormField(
                      
                        style: typeStyle,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.primary,
                          isDense: true,
                          labelText: 'Username',
                          labelStyle: typeStyle,
                          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white),
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
                      SizedBox(height: 25,),
                       Center(
                         child: ElevatedButton(
                                    onPressed:(){
                                      _authenticate();
                                      submit();
                                     Navigator.push(context, MaterialPageRoute(builder: (ctx)=>HomeScreen()),);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(255, 13, 17, 67)
                                    ),
                                    child: Text('Submit',
                                    style: GoogleFonts.quicksand(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
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
