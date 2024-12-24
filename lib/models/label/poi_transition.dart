part of '../../flutter_kakao_map.dart';

class PoiTransition {
  final Transition enterence;
  final Transition exit;

  const PoiTransition(
      {this.enterence = Transition.alpha, this.exit = Transition.alpha});

  bool isEnterenceTransition() => enterence != Transition.none;
  bool isExitTransition() => exit != Transition.none;

  Map<String, dynamic> toMessageable() {
    final payload = <String, dynamic>{
      "enterence": enterence.value,
      "exit": exit.value
    };
    return payload;
  }
}
