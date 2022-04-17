class Stats {
  int steps;
  int heartPoints;

  Stats(this.steps, this.heartPoints);

  Stats.fromJson(Map<String, dynamic> json)
      : steps = json['steps'],
        heartPoints = json['heartPoints'];

  Map<String, dynamic> toJson() => {'steps': steps, 'heartPoints': heartPoints};
}
