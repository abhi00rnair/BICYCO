class Fine {
  String cycleId;
  String rollNo;
  DateTime date;
  int fine;

  Fine({
    required this.cycleId,
    required this.rollNo,
    required this.date,
    required this.fine,
  });

  factory Fine.fromJson(Map<String, dynamic> json) {
    return Fine(
      cycleId: json['cycleId'],
      rollNo: json['rollNo'],
      date: DateTime.parse(json['date']),
      fine: json['fine'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cycleId': cycleId,
      'rollNo': rollNo,
      'date': date.toIso8601String(),
      'fine': fine,
    };
  }
}
