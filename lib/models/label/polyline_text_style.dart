part of '../../flutter_kakao_map.dart';

class PolylineText {
  bool applyDpScale;
  int zoomLevel;

  final int size;
  final int strokeSize;
  final Color color;
  final Color strokeColor;

  PolylineText(this.size, this.strokeSize, this.color, this.strokeColor, {
    this.applyDpScale = true,
    this.zoomLevel = 0
  });

  Map<String, dynamic> toMessageable() {
    final payload = <String, dynamic>{
      "applyDpScale": applyDpScale,
      // ignore: deprecated_member_use
      "color": color.value,
      "size": size,
      "strokeSize": strokeSize,
      // ignore: deprecated_member_use
      "strokeColor": strokeColor.value,
    };
    return payload;
  }
}