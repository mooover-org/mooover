import 'package:flutter/material.dart';

class User {
  String givenName;
  String familyName;
  String name;
  String nickname;
  Image profilePicture;

  User(this.givenName, this.familyName, this.name, this.nickname,
      this.profilePicture);
}
