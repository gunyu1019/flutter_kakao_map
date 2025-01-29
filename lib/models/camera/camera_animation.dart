part of '../../flutter_kakao_maps.dart';


/// 카메라 이동의 애니메이션을 정의하는 객체입니다.
class CameraAnimation with KMessageable {
  final int duration;
  final bool autoElevation;
  final bool isConsecutive;

  const CameraAnimation(this.duration, {
    this.autoElevation = false,
    this.isConsecutive = false
  });

  @override
  Map<String, dynamic> toMessageable() {
    return {
      "duration": duration,
      "autoElevation": autoElevation,
      "isConsecutive": isConsecutive,
    };
  }
}