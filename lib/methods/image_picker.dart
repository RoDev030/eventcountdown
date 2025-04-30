import 'package:image_picker/image_picker.dart';

Future pickImage() async {
  final ImagePicker picker = ImagePicker();
  final XFile? backgroundImage = await picker.pickImage(
    source: ImageSource.gallery,
    imageQuality: 50,
  );
  if (backgroundImage != null) {
    return backgroundImage;
  } else {
    return null;
  }
}
