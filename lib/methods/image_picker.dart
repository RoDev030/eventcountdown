import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

Future pickImage() async {
  final ImagePicker picker = ImagePicker();
  final XFile? backgroundImage = await picker.pickImage(
    source: ImageSource.gallery,
    imageQuality: 50,
  );
  if (backgroundImage != null) {
    // Krijg toegang tot een veilige permanente directory
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = path.basename(backgroundImage.path);

    // Kopieer het bestand naar deze directory
    final savedImage = await File(
      backgroundImage.path,
    ).copy('${appDir.path}/$fileName');

    //Permanent pad om op te slaan of te tonen
    return savedImage.path;
  } else {
    return null;
  }
}
