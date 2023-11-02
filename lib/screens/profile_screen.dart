import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scalpinspector_app/animation.dart';
import 'package:scalpinspector_app/screens/auth/login_screen.dart';
import 'package:scalpinspector_app/model/user_model.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditMode = false;
  String _name = '';
  String _selectedGender = '';
  TextEditingController _nameController = TextEditingController();
  XFile? _profileImage;
  UserModel? _user;
  User? user = FirebaseAuth.instance.currentUser;

  getUser() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) {
      setState(() {
        _user = UserModel.fromDocumentSnapshot(value);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _toggleEditMode() {
    _nameController.text =
        (_user!.firstName ?? '') + ' ' + (_user!.lastName ?? '');
    _selectedGender = _user?.gender ?? '';
    setState(() {
      _isEditMode = !_isEditMode;
    });
  }

  Future<void> _saveChanges() async {
    Get.dialog(const Center(child: CircularProgressIndicator()));
    if (_profileImage != null) {
      await uploadImage();
    } else {
      Get.back();
      Get.snackbar('Error', 'Please select a profile picture',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    List name = _nameController.text.split(' ');
    await FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
      'firstName': name[0],
      'lastName': name[1],
      'gender': _selectedGender,
    }).then((value) {
      setState(() {
        _name = _nameController.text;
        _isEditMode = false;
      });
      user?.updateDisplayName(name[0] + ' ' + name[1]);
      Get.back();
    });
    getUser();
  }

  void _selectGender(String gender) {
    setState(() {
      _selectedGender = gender;
    });
  }

  uploadImage() async {
    File image = File(_profileImage!.path);
    String fileName = user!.uid;
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('profiles/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    taskSnapshot.ref.getDownloadURL().then((value) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update({'photoUrl': value});
      user!.updatePhotoURL(value);
    });
  }

  Future<void> _editProfilePicture() async {
    final imagePicker = ImagePicker();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Image'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: const Text('Take a photo'),
                  onTap: () async {
                    final XFile? image =
                        await imagePicker.pickImage(source: ImageSource.camera);
                    if (image != null) {
                      setState(() {
                        _profileImage = image;
                      });
                    }
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(height: 16.0),
                GestureDetector(
                  child: const Text('Choose from gallery'),
                  onTap: () async {
                    final XFile? image = await imagePicker.pickImage(
                        source: ImageSource.gallery);
                    if (image != null) {
                      setState(() {
                        _profileImage = image;
                      });
                    }
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout your account?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                if (!mounted) return;
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/1.png',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _profileImage != null
                      ? Container(
                          width: 150.0,
                          height: 150.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: FileImage(File(_profileImage!.path)),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : CircleAvatar(
                          radius: 70.0,
                          backgroundImage: NetworkImage(
                            _user?.photoUrl ??
                                'https://www.revixpert.ch/app/uploads/portrait-placeholder.jpg',
                          ),
                        ),
                  if (_isEditMode)
                    IconButton(
                      onPressed: _editProfilePicture,
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 25.0,
                      ),
                    ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 60,
              ),
              width: width,
              height: height / 1.5,
              child: FadeAnimation(
                  delay: 1.4,
                  child: Column(
                    children: [
                      if (_isEditMode)
                        Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(30),
                          child: TextFormField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.person_rounded),
                              prefixIconColor: Colors.black45,
                              contentPadding: EdgeInsets.all(15),
                              border: InputBorder.none,
                              hintText: "Name",
                              hintStyle: TextStyle(
                                color: Colors.black45,
                              ),
                            ),
                          ),
                        )
                      else
                        Text(
                          (_user?.firstName ?? '') +
                              ' ' +
                              (_user?.lastName ?? ''),
                          style: GoogleFonts.robotoCondensed(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      const SizedBox(
                        height: 50,
                      ),
                      Text(
                        'Gender:',
                        style: GoogleFonts.robotoCondensed(fontSize: 20),
                      ),
                      const SizedBox(height: 10.0),
                      if (_isEditMode)
                        Row(
                          children: [
                            _buildGenderOption('Male'),
                            const SizedBox(width: 8.0),
                            _buildGenderOption('Female'),
                          ],
                        )
                      else
                        Text(
                          _user?.gender ?? '',
                          style: const TextStyle(fontSize: 18.0),
                        ),
                      const SizedBox(
                        height: 50,
                      ),
                      InkWell(
                        onTap: _isEditMode ? _saveChanges : _toggleEditMode,
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
                              _isEditMode ? 'Save' : 'Edit Profile',
                              style: GoogleFonts.robotoCondensed(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (!_isEditMode) ...[
                        const SizedBox(height: 16.0),
                      ],
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     automaticallyImplyLeading: false, // Remove the back button
    //     title: Text('Profile'),
    //     centerTitle: true,
    //   ),
    //   body: SingleChildScrollView(
    //     padding: EdgeInsets.all(16.0),
    //     child: Center(
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           Container(
    //             alignment: Alignment.center,
    //             child: Stack(
    //               alignment: Alignment.bottomRight,
    //               children: [
    //                 _profileImage != null
    //                     ? Container(
    //                         width: 150.0,
    //                         height: 150.0,
    //                         decoration: BoxDecoration(
    //                           shape: BoxShape.circle,
    //                           image: DecorationImage(
    //                             image: FileImage(File(_profileImage!.path)),
    //                             fit: BoxFit.cover,
    //                           ),
    //                         ),
    //                       )
    //                     : CircleAvatar(
    //                         radius: 70.0,
    //                         backgroundImage: NetworkImage(
    //                           _user?.photoUrl ??
    //                               'https://www.revixpert.ch/app/uploads/portrait-placeholder.jpg',
    //                         ),
    //                       ),
    //                 if (_isEditMode)
    //                   Padding(
    //                     padding: const EdgeInsets.all(8.0),
    //                     child: IconButton(
    //                       onPressed: _editProfilePicture,
    //                       icon: Icon(
    //                         Icons.edit,
    //                         color: Colors.white,
    //                         size: 25.0,
    //                       ),
    //                     ),
    //                   ),
    //               ],
    //             ),
    //           ),
    //           SizedBox(height: 16.0),
    //           if (_isEditMode)
    //             TextFormField(
    //               controller: _nameController,
    //               decoration: InputDecoration(labelText: 'Name'),
    //             )
    //           else
    //             Text(
    //               (_user?.firstName ?? '') + ' ' + (_user?.lastName ?? ''),
    //               style: TextStyle(
    //                 fontSize: 24.0,
    //                 fontWeight: FontWeight.bold,
    //               ),
    //             ),
    //           SizedBox(height: 24.0),
    //           Container(
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.start,
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Text(
    //                   'Gender:',
    //                   style: TextStyle(fontSize: 12.0),
    //                 ),
    //                 SizedBox(height: 10.0),
    //                 if (_isEditMode)
    //                   Row(
    //                     children: [
    //                       _buildGenderOption('Male'),
    //                       SizedBox(width: 8.0),
    //                       _buildGenderOption('Female'),
    //                     ],
    //                   )
    //                 else
    //                   Text(
    //                     _user?.gender ?? '',
    //                     style: TextStyle(fontSize: 18.0),
    //                   ),
    //               ],
    //             ),
    //           ),
    //           SizedBox(height: 50.0),
    //           ElevatedButton(
    //             onPressed: _isEditMode ? _saveChanges : _toggleEditMode,
    //             child: Text(_isEditMode ? 'Save' : 'Edit Profile'),
    //           ),
    //           if (!_isEditMode) ...[
    //             SizedBox(height: 16.0),
    //           ],
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }

  Widget _buildGenderOption(String gender) {
    return GestureDetector(
      onTap: () {
        _selectGender(gender);
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _selectedGender == gender ? Colors.blue : Colors.grey,
        ),
        padding: const EdgeInsets.all(4.0),
        child: CircleAvatar(
          radius: 16.0,
          backgroundColor: Colors.white,
          child: Icon(
            gender == 'Male' ? Icons.male : Icons.female,
            color: _selectedGender == gender ? Colors.blue : Colors.grey,
          ),
        ),
      ),
    );
  }
}
