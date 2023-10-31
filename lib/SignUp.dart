import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scalpinspector_app/model/user_model.dart';
import 'package:scalpinspector_app/splash_screen.dart';

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
      appBar: AppBar(
        title: const Text('SIGNUP'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Your custom UI/UX design here
                  // ...
                  // For example:
                  Text(
                    'Create an Account',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24.0),
                  TextFormField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      errorText: _firstNameError,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your first name.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                      errorText: _lastNameError,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your last name.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      errorText: _emailError,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email address.';
                      }
                      // Add more email validation logic if needed
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      errorText: _passwordError,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a password.';
                      }
                      // Add more password validation logic if needed
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      errorText: _confirmPasswordError,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please confirm your password.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24.0),
                  Center(
                    child: Container(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: _signup,
                        child: Text('Sign Up'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
