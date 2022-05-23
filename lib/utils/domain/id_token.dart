import 'dart:convert';

import 'package:mooover/utils/domain/exceptions.dart';

class IdToken {
  IdToken({
    required this.nickname,
    required this.name,
    required this.email,
    required this.picture,
    required this.updatedAt,
    required this.iss,
    required this.sub,
    required this.aud,
    required this.iat,
    required this.exp,
    this.authTime,
  });

  final String nickname;
  final String name;
  final String email;
  final String picture;
  final String updatedAt;
  final String iss;
  final String sub;
  final String aud;
  final int iat;
  final int exp;
  final int? authTime;

  factory IdToken.fromJson(Map<String, dynamic> json) {
    return IdToken(
      nickname: json["nickname"],
      name: json["name"],
      email: json["email"],
      picture: json["picture"],
      updatedAt: json["updated_at"],
      iss: json["iss"],
      sub: json["sub"],
      aud: json["aud"],
      iat: json["iat"],
      exp: json["exp"],
      authTime: json["auth_time"],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "nickname": nickname,
      "name": name,
      "email": email,
      "picture": picture,
      "updated_at": updatedAt,
      "iss": iss,
      "sub": sub,
      "aud": aud,
      "iat": iat,
      "exp": exp,
      "auth_time": authTime,
    };
  }

  factory IdToken.fromString(String? string) {
    if (string == null) {
      throw LoginException(message: "id token is invalid");
    }
    final parts = string.split(r'.');
    final Map<String, dynamic> json = jsonDecode(
      utf8.decode(
        base64Url.decode(
          base64Url.normalize(parts[1]),
        ),
      ),
    );
    return IdToken.fromJson(json);
  }
}
