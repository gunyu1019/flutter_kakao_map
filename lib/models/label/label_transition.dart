part of '../../flutter_kakao_map.dart';

class LabelTransition {
  final Transition enterence;
  final Transition exit;

  const LabelTransition(
      {this.enterence = Transition.alpha, this.exit = Transition.alpha});

  bool isEnterenceTransition() => enterence != Transition.none;
  bool isExitTransition() => exit != Transition.none;
}
