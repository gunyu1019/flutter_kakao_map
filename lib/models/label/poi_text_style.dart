part of '../../flutter_kakaomaps.dart';

class PoiTextStyle with KMessageable {
  final double aspectRatio;
  final int characterSpace;
  final Color color;
  final String font;
  final double lineSpace;
  final int size;
  final int stroke;
  final Color strokeColor;

  const PoiTextStyle({
    this.aspectRatio = 0.0,
    this.characterSpace = 0,
    this.color = Colors.black,
    this.font = "",
    this.lineSpace = 1.0,
    this.size = 24,
    this.stroke = 0,
    this.strokeColor = Colors.black
  });

  @override
  Map<String, dynamic> toMessageable() {
    final payload = <String, dynamic>{
      "aspectRatio": aspectRatio,
      "characterSpace": characterSpace,
      // ignore: deprecated_member_use
      "color": color.value,
      "font": font,
      "lineSpace": lineSpace,
      "size": size,
      "stroke": stroke,
      // ignore: deprecated_member_use
      "strokeColor": strokeColor.value
    };
    return payload;
  }
}
