import 'package:health/health.dart';

class HeartRateStats {
  final double avgBpm;
  final int minBpm;
  final int maxBpm;
  final int sampleCount;
  final List<HeartRateSample> samples;

  const HeartRateStats({
    required this.avgBpm,
    required this.minBpm,
    required this.maxBpm,
    required this.sampleCount,
    required this.samples,
  });
}

class HeartRateSample {
  final DateTime time;
  final int bpm;

  const HeartRateSample({required this.time, required this.bpm});
}

class HealthService {
  static final HealthService _instance = HealthService._();
  factory HealthService() => _instance;
  HealthService._();

  bool _isAuthorized = false;

  bool get isAuthorized => _isAuthorized;

  Future<bool> requestAuthorization() async {
    try {
      // Configure Health Connect
      Health().configure();

      // Check if Health Connect is available
      final available = await Health().hasPermissions(
        [HealthDataType.HEART_RATE],
        permissions: [HealthDataAccess.READ],
      );

      if (available == true) {
        _isAuthorized = true;
        return true;
      }

      // Request permissions
      final granted = await Health().requestAuthorization(
        [HealthDataType.HEART_RATE],
        permissions: [HealthDataAccess.READ],
      );

      _isAuthorized = granted;
      return granted;
    } catch (e) {
      _isAuthorized = false;
      return false;
    }
  }

  Future<HeartRateStats?> getHeartRateForPeriod(
    DateTime start,
    DateTime end,
  ) async {
    if (!_isAuthorized) return null;

    try {
      final data = await Health().getHealthDataFromTypes(
        types: [HealthDataType.HEART_RATE],
        startTime: start,
        endTime: end,
      );

      if (data.isEmpty) return null;

      // Remove duplicates
      final unique = Health().removeDuplicates(data);

      final samples = <HeartRateSample>[];
      for (final point in unique) {
        final value = point.value;
        if (value is NumericHealthValue) {
          samples.add(HeartRateSample(
            time: point.dateFrom,
            bpm: value.numericValue.round(),
          ));
        }
      }

      if (samples.isEmpty) return null;

      samples.sort((a, b) => a.time.compareTo(b.time));

      final bpms = samples.map((s) => s.bpm).toList();
      final avg = bpms.reduce((a, b) => a + b) / bpms.length;
      final min = bpms.reduce((a, b) => a < b ? a : b);
      final max = bpms.reduce((a, b) => a > b ? a : b);

      return HeartRateStats(
        avgBpm: avg,
        minBpm: min,
        maxBpm: max,
        sampleCount: samples.length,
        samples: samples,
      );
    } catch (e) {
      return null;
    }
  }
}
