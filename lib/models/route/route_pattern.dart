// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../../flutter_kakao_map.dart';

class RoutePattern {
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
}
