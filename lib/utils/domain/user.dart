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
  int todaySteps;
  int dailyStepsGoal;
  int thisWeekSteps;
  int weeklyStepsGoal;
  AppTheme appTheme;

  get id => sub;

  User(
      this.sub,
      this.name,
      this.givenName,
      this.familyName,
      this.nickname,
      this.email,
      this.picture,
      this.todaySteps,
      this.dailyStepsGoal,
      this.thisWeekSteps,
      this.weeklyStepsGoal,
      this.appTheme);

  /// Creates a user from json map.
  User.fromJson(Map<String, dynamic> jsonData)
      : sub = jsonData['sub'],
        name = jsonData['name'],
        givenName = jsonData['given_name'],
        familyName = jsonData['family_name'],
        nickname = jsonData['nickname'],
        email = jsonData['email'],
        picture = jsonData['picture'],
        todaySteps = jsonData['today_steps'],
        dailyStepsGoal = jsonData['daily_steps_goal'],
        thisWeekSteps = jsonData['this_week_steps'],
        weeklyStepsGoal = jsonData['weekly_steps_goal'],
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
        'today_steps': todaySteps,
        'daily_steps_goal': dailyStepsGoal,
        'this_week_steps': thisWeekSteps,
        'weekly_steps_goal': weeklyStepsGoal,
        'app_theme': appThemeToString(appTheme),
      };
}
