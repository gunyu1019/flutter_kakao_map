part of '../../flutter_kakaomaps.dart';

class RoutePattern with KMessageable {
  final KImage patternImage;
  final KImage? symbolImage;
  final double distance;
  
  bool pinStart;
  bool pinEnd;

  RoutePattern(this.patternImage, this.distance, {
    this.symbolImage,
    this.pinStart = false,
    this.pinEnd = false,
  });

  @override
  Map<String, dynamic> toMessageable() {
    return {
      "patternImage": patternImage.toMessageable(),
      "symbolImage": symbolImage?.toMessageable(),
      "distance": distance,
      "pinStart": pinStart,
      "pinEnd": pinEnd
    };
  }
}
