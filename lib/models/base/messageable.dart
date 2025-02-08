part of '../../flutter_kakaomaps.dart';

mixin KMessageable {
  Map<String, dynamic> toMessageable();

  @override
  String toString() {
    return "$runtimeType(${toMessageable().entries.map((e) => "${e.key}: ${e.value}").join(", ")})";
  }
}
