part of '../../flutter_kakao_map.dart';

class KImage {
  final String? path;
  final Uint8List? data;
  final ImageType type;

  final double width;
  final double height;

  const KImage._(this.type, {
    required this.width,
    required this.height,
    this.path,
    this.data,
  });

  factory KImage.fromAsset(String asset, double width, double height) => KImage._(ImageType.assets, path: asset, width: width, height: height);
  
  factory KImage.fromFile(Uint8List data, double width, double height) => KImage._(ImageType.data, data: data, width: width, height: height);

  factory KImage.fromPath(String path, double width, double height) => KImage._(ImageType.file, path: path, width: width, height: height);
  
  Map<String, dynamic> toMessageable() {
    final payload = <String, dynamic>{
      "type": type.value,
      "width": width,
      "height": height
    };

    if (type == ImageType.data) {
      payload['data'] = data;
    } else {
      payload['path'] = path;
    }
    return payload;
  }
}
