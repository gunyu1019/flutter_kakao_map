part of '../../flutter_kakao_map.dart';

enum ImageType {
  assets(value: 0),
  file(value: 1),
  data(value: 2);
  
  final int value;  

  const ImageType({required this.value});
}