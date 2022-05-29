import 'package:mooover/config/themes/themes.dart';

/// The user model.
class User {
  String sub;
  String name;
  String givenName;
  String familyName;
  String nickname;
  String email;
  String picture;
  int steps;
  int dailyStepsGoal;
  AppTheme appTheme;

  get id => sub;

  User(this.sub, this.name, this.givenName, this.familyName, this.nickname,
      this.email, this.picture, this.steps, this.dailyStepsGoal, this.appTheme);

  /// Creates a user from json map.
  User.fromJson(Map<String, dynamic> jsonData)
      : sub = jsonData['sub'],
        name = jsonData['name'],
        givenName = jsonData['given_name'],
        familyName = jsonData['family_name'],
        nickname = jsonData['nickname'],
        email = jsonData['email'],
        picture = jsonData['picture'],
        steps = jsonData['steps'],
        dailyStepsGoal = jsonData['daily_steps_goal'],
        appTheme = appThemeFromString(jsonData['app_theme']);

  /// Creates a json map from the user.
  Map<String, dynamic> toJson() => {
        'sub': sub,
        'name': name,
        'given_name': givenName,
        'family_name': familyName,
        'nickname': nickname,
        'email': email,
        'picture': picture,
        'steps': steps,
        'daily_steps_goal': dailyStepsGoal,
        'app_theme': appThemeToString(appTheme),
      };
}
