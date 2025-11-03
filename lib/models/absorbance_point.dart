class AbsorbancePoint {
  final double timeSeconds;
  final double absorbance;

  AbsorbancePoint({
    required this.timeSeconds,
    required this.absorbance,
  });

  Map<String, dynamic> toMap() => {
    't': timeSeconds,
    'a': absorbance,
  };

  factory AbsorbancePoint.fromMap(Map<String, dynamic> map) => AbsorbancePoint(
    timeSeconds: (map['t'] as num).toDouble(),
    absorbance: (map['a'] as num).toDouble(),
  );
}
