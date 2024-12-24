part of '../../flutter_kakao_map.dart';

class PoiTextStyle {
  final double aspectRatio;
  final double characterSpace;
  final int color;
  final String font;
  final double lineSpace;
  final double size;
  final int stroke;
  final int strokeColor;

  const PoiTextStyle({
    this.aspectRatio = 0,
    this.characterSpace = 0,
    this.color = -16777216,
    this.font = "",
    this.lineSpace = 1.0,
    this.size = 24,
    this.stroke = 0,
    this.strokeColor = 0
  });

  Map<String, dynamic> toMessageable() {
    final payload = <String, dynamic>{
      "aspectRatio": aspectRatio,
      "characterSpace": characterSpace,
      "color": color,
      "font": font,
      "lineSpace": lineSpace,
      "size": size,
      "stroke": stroke,
      "strokeColor": strokeColor
    };
    return payload;
  }
}
