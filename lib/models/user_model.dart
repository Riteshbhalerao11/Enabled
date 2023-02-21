import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'dart:core';

class UserModel {
  final String uid;
  final String username;
  final String email;
  final String firstName;
  final String password;
  final String bio;
  final int points;
  final String profilepic;
  final List<String> friends;

  UserModel(
      {required this.uid,
      required this.username,
      required this.email,
      required this.password,
      required this.bio,
      required this.points,
      required this.profilepic,
      required this.friends,
      required this.firstName});

  UserModel copyWith({
    String? uid,
    String? username,
    String? email,
    String? firstName,
    String? password,
    String? bio,
    int? points,
    String? profilepic,
    List<String>? friends,
  }) {
    return UserModel(
        uid: uid ?? this.uid,
        username: username ?? this.username,
        email: email ?? this.email,
        password: password ?? this.password,
        bio: bio ?? this.bio,
        points: points ?? this.points,
        profilepic: profilepic ?? this.profilepic,
        friends: friends ?? this.friends,
        firstName: firstName ?? this.firstName);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'username': username,
      'firstName': firstName,
      'email': email,
      'password': password,
      'bio': bio,
      'points': points,
      'profilepic': profilepic,
      'friends': friends,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      username: map['username'] ?? "",
      email: map['email'] ?? "",
      firstName: map['firstName'] ?? '',
      password: map['password'] ?? "",
      bio: map['bio'] ?? "",
      points: map['points']?.toInt() ?? 0,
      profilepic: map['profilepic'] ?? "",
      friends: List<String>.from(map['friends'] as List),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(uid : $uid, username: $username, email: $email, password: $password, bio: $bio, points: $points, profilepic: $profilepic, friends: $friends)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.username == username &&
        other.email == email &&
        other.password == password &&
        other.bio == bio &&
        other.points == points &&
        other.profilepic == profilepic &&
        listEquals(other.friends, friends);
  }

  @override
  int get hashCode {
    return username.hashCode ^
        email.hashCode ^
        password.hashCode ^
        bio.hashCode ^
        points.hashCode ^
        profilepic.hashCode ^
        friends.hashCode;
  }
}
