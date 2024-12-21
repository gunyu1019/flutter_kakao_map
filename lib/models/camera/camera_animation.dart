part of '../../flutter_kakao_map.dart';


class CameraAnimation {
  final int duration;
  final bool autoElevation;
  final bool isConsecutive;

  const CameraAnimation(this.duration, [
    this.autoElevation = false,
    this.isConsecutive = false
  ]);

  Map<String, dynamic> toMessageable() {
    return {
      "duration": duration,
      "autoElevation": autoElevation,
      "isConsecutive": isConsecutive,
    };
  }

  @override
  String toString() => "$runtimeType: ${toMessageable().map}";
}