import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lenore/application/provider/user_registration_provider/user_registration_provider.dart';

void showImagePickerBottomSheet(
    UserRegistrationProvider provider, BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text("Take a Photo"),
              onTap: () {
                Navigator.pop(context);
                provider.pickImage(ImageSource.camera, context);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text("Choose from Gallery"),
              onTap: () {
                Navigator.pop(context);
                provider.pickImage(ImageSource.gallery, context);
              },
            ),
          ],
        ),
      );
    },
  );
}
