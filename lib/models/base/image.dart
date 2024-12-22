part of '../../flutter_kakao_map.dart';

class KImage {
  final String? path;
  final Uint8List? data;
  final ImageType type;

  const KImage._(this.type, {
    this.path,
    this.data
  });

  factory KImage.fromAsset(String asset) => KImage._(ImageType.assets, path: asset);
  
  factory KImage.fromFile(Uint8List data) => KImage._(ImageType.data, data: data);

  factory KImage.fromPath(String path) => KImage._(ImageType.file, path: path);
}
