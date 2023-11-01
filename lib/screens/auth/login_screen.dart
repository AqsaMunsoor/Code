// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:scalpinspector_app/animation.dart';
import 'package:scalpinspector_app/screens/auth/SignUp.dart';
import 'package:scalpinspector_app/screens/splash_screen.dart';
import 'package:another_flushbar/flushbar.dart';

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
      Flushbar(
        duration: const Duration(seconds: 3),
        flushbarStyle: FlushbarStyle.FLOATING,
        backgroundGradient: LinearGradient(colors: [
          HexColor('fccc8c'),
          HexColor('fab67e'),
          HexColor('f89f6f'),
          HexColor('f78961'),
        ]),
        messageText: Text(
          e.code.toString(),
          style: GoogleFonts.robotoCondensed(
            fontSize: 18.0,
            color: Colors.white,
          ),
        ),
      ).show(context);
      // if (e.code == 'user-not-found') {
      //   _firebaseError = 'No user found for that email.';
      // } else if (e.code == 'wrong-password') {
      //   _firebaseError = 'Wrong password provided for that user.';
      // }
    }
    if (user != null) {
      Get.to(SplashScreen());
    } else {
      // Fluttertoast.showToast(
      //   msg: _firebaseError,
      //   toastLength: Toast.LENGTH_LONG,
      //   gravity: ToastGravity.BOTTOM,
      //   backgroundColor: Colors.red,
      //   textColor: Colors.white,
      // );
      // Get.snackbar('Error', _firebaseError);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/1.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  FadeAnimation(
                    delay: 1,
                    child: SizedBox(
                      child: Image.asset('assets/scalp_logo.png'),
                      width: 100,
                      height: 100,
                    ),
                  ),
                  const Gutter(),
                  FadeAnimation(
                    delay: 1.2,
                    child: Text(
                      'Scalp Inspector',
                      style: GoogleFonts.robotoCondensed(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3,
                      ),
                    ),
                  ),
                ],
              ),
              FadeAnimation(
                delay: 1.4,
                child: Text(
                  'Login',
                  style: GoogleFonts.robotoCondensed(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 30),
                    width: width,
                    height: height / 1.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        FadeAnimation(
                          delay: 1.6,
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
                          delay: 1.8,
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
                        FadeAnimation(
                          delay: 2,
                          child: InkWell(
                            onTap: () async {
                              await firebaseLogin();
                            },
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
                                child: Text(
                                  "Log in",
                                  style: GoogleFonts.robotoCondensed(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        FadeAnimation(
                          delay: 2.2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account',
                                style: GoogleFonts.robotoCondensed(
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
                                  style: GoogleFonts.robotoCondensed(
                                    color: HexColor('f78961'),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
