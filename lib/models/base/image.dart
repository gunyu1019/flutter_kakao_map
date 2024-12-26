part of '../../flutter_kakao_map.dart';

/// 지도에서 사용할 수 있는 이미지를 생성하는 객체입니다.
class KImage {
  final String? _path;
  final Uint8List? _data;
  final ImageType type;

  /// 이미지 객체의 가로 길이를 설정합니다.
  final double width;

  /// 이미지 객체의 세로 길이를 설정합니다.
  final double height;

  const KImage._(
    this.type, {
    required this.width,
    required this.height,
    String? path,
    Uint8List? data,
  })  : _path = path,
        _data = data;

  /// Assets으로 이미지 객체를 생성합니다.  
  factory KImage.fromAsset(String asset, double width, double height) =>
      KImage._(ImageType.assets, path: asset, width: width, height: height);

  /// 이미지 바이너리 값으로 이미지 객체를 생성합니다.
  factory KImage.fromData(Uint8List data, double width, double height) =>
      KImage._(ImageType.data, data: data, width: width, height: height);

  /// 이미지 파일로 이미지 객체를 생성합니다.
  factory KImage.fromFile(File file, double width, double height) =>
      KImage._(ImageType.file, path: file.path, width: width, height: height);

  Map<String, dynamic> toMessageable() {
    final payload = <String, dynamic>{
      "type": type.name,
      "width": width,
      "height": height
    };

    switch(type) {
      case ImageType.data:
        payload['data'] = _data;
        break;
      case ImageType.assets:
      case ImageType.file:
        payload['path'] = _path;
        break;
    }
    return payload;
  }
}
