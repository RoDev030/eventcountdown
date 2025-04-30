import 'dart:typed_data';

abstract class DatabaseAdapter {
  Future<void> storeImage(Uint8List imageBytes);

  Future<Uint8List?> getImages();
}
