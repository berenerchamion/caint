import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({Key? key}) : super(key: key);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage = File('assets/images/default-avatar.png');
  final _imagePicker = ImagePicker();

  void _pickImage() async {
   final pickedImageFile = await _imagePicker.pickImage(source: ImageSource.gallery);
   setState(() {
     if (pickedImageFile != null) {
       _pickedImage = File(pickedImageFile.path);
     }
   });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: FileImage(File('assets/images/default-avatar.png')),
          radius: 40,
        ),
          IconButton(
            icon: const Icon(Icons.upload_file_rounded),
            tooltip: 'Upload a photo...',
            color: Theme.of(context).colorScheme.secondary,
            onPressed: () {},
          ),
      ],
    );
  }
}

