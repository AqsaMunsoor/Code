// ignore_for_file: use_build_context_synchronously

import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:scalpinspector_app/animation.dart';
import 'package:scalpinspector_app/model/user_model.dart';
import 'package:scalpinspector_app/screens/splash_screen.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  User? user;
  String? _firstNameError;
  String? _lastNameError;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;
  String? _firebaseError;

  Future<void> _signup() async {
    setState(() {
      _firstNameError = null;
      _lastNameError = null;
      _emailError = null;
      _passwordError = null;
      _confirmPasswordError = null;
    });
    firebaseSignup() async {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
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
        if (e.code == 'weak-password') {
          _firebaseError = 'The password provided is too weak.';
        } else if (e.code == 'email-already-in-use') {
          _firebaseError = 'The account already exists for that email.';
        }
      } catch (e) {
        _firebaseError = 'An error occurred while creating your account : $e';
      }
    }

    if (_formKey.currentState!.validate()) {
      final firstName = _firstNameController.text;
      final lastName = _lastNameController.text;
      final email = _emailController.text;
      final password = _passwordController.text;
      final confirmPassword = _confirmPasswordController.text;
      UserModel userModel = UserModel(
        firstName: firstName,
        lastName: lastName,
        email: email,
        gender: '',
        photoUrl: '',
        uid: '',
      );
      if (password == confirmPassword) {
        // Success - Perform signup logic here
        await firebaseSignup();
        if (_firebaseError == null) {
          Flushbar(
            duration: const Duration(seconds: 3),
            flushbarStyle: FlushbarStyle.FLOATING,
            backgroundColor: Colors.greenAccent,
            titleText: Text(
              'Success',
              style: GoogleFonts.robotoCondensed(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.white),
            ),
            messageText: Text(
              'Your account has been created.',
              style: GoogleFonts.robotoCondensed(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
          ).show(context);
          // Get.snackbar(
          //   'Success',
          //   'Your account has been created.',
          //   snackPosition: SnackPosition.BOTTOM,
          // );
          await Future.delayed(const Duration(seconds: 2));
          if (user != null) {
            user!.updateDisplayName("$firstName $lastName");
            userModel.uid = user!.uid;
            initFirestore(userModel);
            Get.to(SplashScreen());
          }
        } else {
          Flushbar(
            duration: const Duration(seconds: 3),
            flushbarStyle: FlushbarStyle.FLOATING,
            backgroundColor: Colors.redAccent,
            titleText: Text(
              'Error',
              style: GoogleFonts.robotoCondensed(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.white),
            ),
            messageText: Text(
              _firebaseError!,
              style: GoogleFonts.robotoCondensed(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
          ).show(context);
          // Get.snackbar(
          //   'Error',
          //   _firebaseError!,
          //   snackPosition: SnackPosition.BOTTOM,
          // );
        }
      } else {
        setState(() {
          _confirmPasswordError = 'Passwords do not match.';
        });
        Flushbar(
          duration: const Duration(seconds: 3),
          flushbarStyle: FlushbarStyle.FLOATING,
          backgroundColor: Colors.redAccent,
          titleText: Text(
            'Error',
            style: GoogleFonts.robotoCondensed(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Colors.white),
          ),
          messageText: Text(
            'Passwords do not match',
            style: GoogleFonts.robotoCondensed(
              fontSize: 15.0,
              color: Colors.white,
            ),
          ),
        ).show(context);
        // Get.snackbar(
        //   'Error',
        //   'Passwords do not match.',
        //   snackPosition: SnackPosition.BOTTOM,
        // );
      }
    }
  }

  initFirestore(UserModel userModel) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .set(userModel.toMap());
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
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
            'assets/2.png',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        body: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                FadeAnimation(
                  delay: 1,
                  child: SizedBox(
                    child: Image.asset('assets/scalp_logo.png'),
                    width: 75,
                    height: 75,
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
                'Sign Up',
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
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
                  width: width,
                  height: height / 1,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FadeAnimation(
                          delay: 1.6,
                          child: Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(30),
                            child: TextFormField(
                              controller: _firstNameController,
                              decoration: InputDecoration(
                                errorText: _firstNameError,
                                prefixIcon: Icon(Icons.person_rounded),
                                prefixIconColor: Colors.black45,
                                contentPadding: EdgeInsets.all(15),
                                border: InputBorder.none,
                                hintText: "First Name",
                                hintStyle: TextStyle(
                                  color: Colors.black45,
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your first name.';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        FadeAnimation(
                          delay: 1.8,
                          child: Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(30),
                            child: TextFormField(
                              controller: _lastNameController,
                              decoration: InputDecoration(
                                errorText: _lastNameError,
                                prefixIcon: Icon(Icons.person_rounded),
                                prefixIconColor: Colors.black45,
                                contentPadding: EdgeInsets.all(15),
                                border: InputBorder.none,
                                hintText: "Last Name",
                                hintStyle: TextStyle(
                                  color: Colors.black45,
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your last name.';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        FadeAnimation(
                          delay: 2,
                          child: Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(30),
                            child: TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                errorText: _emailError,
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
                          height: 30,
                        ),
                        FadeAnimation(
                          delay: 2.2,
                          child: Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(30),
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                errorText: _passwordError,
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
                          height: 30,
                        ),
                        FadeAnimation(
                          delay: 2.4,
                          child: Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(30),
                            child: TextFormField(
                              controller: _confirmPasswordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                errorText: _confirmPasswordError,
                                prefixIcon: Icon(Icons.lock_rounded),
                                prefixIconColor: Colors.black45,
                                contentPadding: EdgeInsets.all(15),
                                border: InputBorder.none,
                                hintText: "Confirm Password",
                                hintStyle: TextStyle(
                                  color: Colors.black45,
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please confirm your password.';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        FadeAnimation(
                          delay: 2.6,
                          child: InkWell(
                            onTap: () => _signup(),
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
                                  "Sign up",
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
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
