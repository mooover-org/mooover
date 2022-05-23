class Group {
  String nickname;
  String name;
  int steps;
  int dailyStepsGoal;
  int weeklyStepsGoal;

  get id => nickname;

  Group(this.nickname, this.name,
      this.steps, this.dailyStepsGoal, this.weeklyStepsGoal);

  /// Creates a group from json map.
  Group.fromJson(Map<String, dynamic> jsonData)
      : nickname = jsonData['nickname'],
        name = jsonData['name'],
        steps = jsonData['steps'],
        dailyStepsGoal = jsonData['daily_steps_goal'],
        weeklyStepsGoal = jsonData['weekly_steps_goal'];

  /// Creates a json map from the group.
  Map<String, dynamic> toJson() => {
    'nickname': nickname,
    'name': name,
    'steps': steps,
    'daily_steps_goal': dailyStepsGoal,
    'weekly_steps_goal': weeklyStepsGoal,
  };
}