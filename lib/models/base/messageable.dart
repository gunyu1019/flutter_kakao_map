part of '../../flutter_kakao_maps.dart';

mixin KMessageable {
  Map<String, dynamic> toMessageable();

  @override
  String toString() {
    return "$runtimeType(${toMessageable().entries.map((e) => "${e.key}: ${e.value}").join(", ")})";
  }
}
