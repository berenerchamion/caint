import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File pickedImage) imagePickFn;

  const UserImagePicker(this.imagePickFn, {Key? key}) : super(key: key);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;
  final _imagePicker = ImagePicker();

  void _pickImage() async {
    final pickedImageFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );
    if (pickedImageFile != null) {
      setState(() {
        _pickedImage = File(pickedImageFile.path);
      });
      widget.imagePickFn(_pickedImage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.black26,
          backgroundImage:
              _pickedImage == null ? null : FileImage(_pickedImage!),
          radius: 40,
        ),
        IconButton(
          icon: const Icon(Icons.upload_file_rounded),
          tooltip: 'Upload a photo...',
          color: Theme.of(context).colorScheme.secondary,
          onPressed: _pickImage,
        ),
      ],
    );
  }
}
