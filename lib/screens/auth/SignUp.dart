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
          Get.snackbar(
            'Success',
            'Your account has been created.',
            snackPosition: SnackPosition.BOTTOM,
          );
          await Future.delayed(const Duration(seconds: 2));
          if (user != null) {
            user!.updateDisplayName("$firstName $lastName");
            userModel.uid = user!.uid;
            initFirestore(userModel);
            Get.to(SplashScreen());
          }
        } else {
          Get.snackbar(
            'Error',
            _firebaseError!,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } else {
        setState(() {
          _confirmPasswordError = 'Passwords do not match.';
        });
        Get.snackbar(
          'Error',
          'Passwords do not match.',
          snackPosition: SnackPosition.BOTTOM,
        );
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
    return Scaffold(
        resizeToAvoidBottomInset: true,
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
                      height: 330,
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
                              height: 30,
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
                top: 200,
                child: FadeAnimation(
                  delay: 1.6,
                  child: Text(
                    'Sign Up',
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
                top: 260,
                child: Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(30))),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FadeAnimation(
                          delay: 1.8,
                          child: Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(30),
                            child: TextFormField(
                              controller: _firstNameController,
                              decoration: InputDecoration(
                                errorText: _firstNameError,
                                prefixIcon: Icon(Icons.email_rounded),
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
                                prefixIcon: Icon(Icons.email_rounded),
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
                          delay: 1.8,
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
                          delay: 2,
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
                          delay: 2,
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
                                  onPressed: () {
                                    _signup();
                                  },
                                  child: Text(
                                    "Signup",
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
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));

    // );
  }
}
