class Cycle {
  String cycleId;
  bool status;

  Cycle({required this.cycleId, required this.status});

  factory Cycle.fromJson(Map<String, dynamic> json) {
    return Cycle(
      cycleId: json['cycleId'] ?? '',
      status: json['status'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cycleId': cycleId,
      'status': status,
    };
  }
}
