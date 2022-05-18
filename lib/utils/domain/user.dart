import 'package:mooover/config/themes/themes.dart';

/// The user model.
class User {
  String userId;
  String givenName;
  String familyName;
  String name;
  String nickname;
  String email;
  String picture;
  int steps;
  int dailyStepsGoal;
  AppTheme appTheme;

  User(this.userId, this.givenName, this.familyName, this.name, this.nickname,
      this.email, this.picture, this.steps, this.dailyStepsGoal, this.appTheme);

  /// Creates a user from json map.
  User.fromJson(Map<String, dynamic> jsonData)
      : userId = jsonData['id'],
        givenName = jsonData['given_name'],
        familyName = jsonData['family_name'],
        name = jsonData['name'],
        nickname = jsonData['nickname'],
        email = jsonData['email'],
        picture = jsonData['picture'],
        steps = jsonData['steps'],
        dailyStepsGoal = jsonData['daily_steps_goal'],
        appTheme = appThemeFromString(jsonData['app_theme']);

  /// Creates a user from an id token.
  User.fromUserInfo(Map<String, dynamic> userInfo)
      : userId = userInfo['sub'].split('|')[1],
        givenName = userInfo['given_name'],
        familyName = userInfo['family_name'],
        name = userInfo['name'],
        nickname = userInfo['nickname'],
        email = userInfo['email'],
        picture = userInfo['picture'],
        steps = 0,
        dailyStepsGoal = 0,
        appTheme = AppTheme.light;

  /// Creates a json map from the user.
  Map<String, dynamic> toJson() => {
        'id': userId,
        'given_name': givenName,
        'family_name': familyName,
        'name': name,
        'nickname': nickname,
        'email': email,
        'picture': picture,
        'steps': steps,
        'daily_steps_goal': dailyStepsGoal,
        'app_theme': appThemeToString(appTheme),
      };
}
