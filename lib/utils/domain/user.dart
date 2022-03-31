/// The user model.
class User {
  String userId;
  String givenName;
  String familyName;
  String name;
  String nickname;
  String email;
  String picture;

  User(this.userId, this.givenName, this.familyName, this.name, this.nickname,
      this.email, this.picture);

  /// Creates a user from json map.
  User.fromJson(Map<String, dynamic> jsonData)
      : userId = jsonData['id'],
        givenName = jsonData['given_name'],
        familyName = jsonData['family_name'],
        name = jsonData['name'],
        nickname = jsonData['nickname'],
        email = jsonData['email'],
        picture = jsonData['picture'];

  /// Creates a json map from the user.
  Map<String, dynamic> toJson() => {
        'id': userId,
        'given_name': givenName,
        'family_name': familyName,
        'name': name,
        'nickname': nickname,
        'email': email,
        'picture': picture,
      };
}
