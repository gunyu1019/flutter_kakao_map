part of '../../kakao_map_sdk.dart';

class PoiTransition with KMessageable {
  final Transition entrance;
  final Transition exit;

  const PoiTransition(
      {this.entrance = Transition.alpha, this.exit = Transition.alpha});

  bool isEntranceTransition() => entrance != Transition.none;
  bool isExitTransition() => exit != Transition.none;

  @override
  Map<String, dynamic> toMessageable() {
    final payload = <String, dynamic>{
      "entrance": entrance.value,
      "exit": exit.value
    };
    return payload;
  }
}
