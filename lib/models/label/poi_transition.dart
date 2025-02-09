part of '../../kakao_map_sdk.dart';

class PoiTransition with KMessageable {
  final Transition enterence;
  final Transition exit;

  const PoiTransition(
      {this.enterence = Transition.alpha, this.exit = Transition.alpha});

  bool isEnterenceTransition() => enterence != Transition.none;
  bool isExitTransition() => exit != Transition.none;

  @override
  Map<String, dynamic> toMessageable() {
    final payload = <String, dynamic>{
      "enterence": enterence.value,
      "exit": exit.value
    };
    return payload;
  }
}
