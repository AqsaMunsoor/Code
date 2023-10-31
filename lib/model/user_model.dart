import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String firstName;
  String lastName;
  String email;
  String photoUrl;
  String gender;
  String uid = '';

  //constructor
  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.photoUrl,
    required this.gender,
    required this.uid,
  });

  //factory constructor
  factory UserModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    return UserModel(
      firstName: snapshot['firstName'],
      lastName: snapshot['lastName'],
      email: snapshot['email'],
      photoUrl: snapshot['photoUrl'],
      gender: snapshot['gender'],
      uid: snapshot.id,
    );
  }

  toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'photoUrl': photoUrl,
      'gender': gender,
      'uid': uid,
    };
  }
}
