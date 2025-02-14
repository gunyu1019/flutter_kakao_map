part of '../../kakao_map_sdk.dart';

mixin KMessageable {
  Map<String, dynamic> toMessageable();

  @override
  String toString() {
    return "$runtimeType(${toMessageable().entries.map((e) => "${e.key}: ${e.value}").join(", ")})";
  }
}
