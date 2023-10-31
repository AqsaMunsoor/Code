import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:scalpinspector_app/animation.dart';
import 'package:scalpinspector_app/screens/auth/SignUp.dart';
import 'package:scalpinspector_app/screens/splash_screen.dart';

import '../home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    autoLogin();
  }

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _firebaseError = '';
  User? user;
  autoLogin() async {
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      //ensure widget is mounted before navigating
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.to(SplashScreen());
      });
    }
  }

  firebaseLogin() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _firebaseError = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        _firebaseError = 'Wrong password provided for that user.';
      }
    }
    if (user != null) {
      Get.to(SplashScreen());
    } else {
      Get.snackbar('Error', _firebaseError);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      width: double.maxFinite,
      height: double.maxFinite,
      child: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              child: FadeAnimation(
                delay: 1,
                child: Container(
                  width: double.maxFinite,
                  height: 350,
                  // color: Colors.blue,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        HexColor('fccc8c'),
                        HexColor('fab67e'),
                        HexColor('f89f6f'),
                        HexColor('f78961'),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),

                  child: FadeAnimation(
                    delay: 1.3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                          child: Image.asset('assets/scalp_logo.png'),
                          width: 100,
                          height: 100,
                        ),
                        const Gutter(),
                        Text(
                          'Scalp Inspector',
                          style: GoogleFonts.playfair(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
          Positioned(
            right: 15,
            top: 250,
            child: FadeAnimation(
              delay: 1.6,
              child: Text(
                'Login',
                style: GoogleFonts.playfair(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                ),
              ),
            ),
          ),
          Positioned(
            top: 320,
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(30))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  FadeAnimation(
                    delay: 1.8,
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(30),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email_rounded),
                          prefixIconColor: Colors.black45,
                          contentPadding: EdgeInsets.all(15),
                          border: InputBorder.none,
                          hintText: "Email",
                          hintStyle: TextStyle(
                            color: Colors.black45,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email.';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  FadeAnimation(
                    delay: 2,
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(30),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock_rounded),
                          prefixIconColor: Colors.black45,
                          contentPadding: EdgeInsets.all(15),
                          border: InputBorder.none,
                          hintText: "Password",
                          hintStyle: TextStyle(
                            color: Colors.black45,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password.';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Positioned(
                    top: 570,
                    left: 30,
                    right: 30,
                    child: FadeAnimation(
                      delay: 2.2,
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(colors: [
                              HexColor('fccc8c'),
                              HexColor('fab67e'),
                              HexColor('f89f6f'),
                              HexColor('f78961'),
                            ])),
                        child: Center(
                          child: TextButton(
                            onPressed: () async {
                              await firebaseLogin();
                            },
                            child: Text(
                              "Login",
                              style: GoogleFonts.playfair(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account',
                        style: GoogleFonts.playfair(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignupScreen()),
                          );
                        },
                        child: Text(
                          'Sign Up',
                          style: GoogleFonts.playfair(
                            color: HexColor('f78961'),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
