class Group {
  String nickname;
  String name;
  int todaySteps;
  int dailyStepsGoal;
  int thisWeekSteps;
  int weeklyStepsGoal;

  String get id => nickname;

  Group(this.nickname, this.name, this.todaySteps, this.dailyStepsGoal,
      this.thisWeekSteps, this.weeklyStepsGoal);

  /// Creates a group from json map.
  Group.fromJson(Map<String, dynamic> jsonData)
      : nickname = jsonData['nickname'],
        name = jsonData['name'],
        todaySteps = jsonData['today_steps'],
        dailyStepsGoal = jsonData['daily_steps_goal'],
        thisWeekSteps = jsonData['this_week_steps'],
        weeklyStepsGoal = jsonData['weekly_steps_goal'];

  /// Creates a json map from the group.
  Map<String, dynamic> toJson() => {
        'nickname': nickname,
        'name': name,
        'today_steps': todaySteps,
        'daily_steps_goal': dailyStepsGoal,
        'this_week_steps': thisWeekSteps,
        'weekly_steps_goal': weeklyStepsGoal,
      };
}
