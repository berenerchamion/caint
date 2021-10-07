import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../widgets/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(
    String email,
    String userName,
    String password,
    File? image,
    bool isLogin,
    BuildContext ctx,
  ) async {
    UserCredential authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        final ref = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child(authResult.user!.uid + '.jpg');
        try {
          await ref.putFile(image!);
        }
        on FirebaseException catch (e){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('The image upload has failed: ${e.message}'),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
          return;
        }

        final url = await ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user!.uid)
            .set({
          'username': userName,
          'email': email,
          'image_url': url,
        });
      }
    } on PlatformException catch (err) {
      var message = 'Those credentials are incorrect. ';
      if (err.message != null) {
        message = message + err.message!;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Platform Exception: ${err.message}'),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      //Adding this for convenience. In debug mode teh PlatformException will not get caught.
      //So by adding this below I can see the exceptions during testing in Debug mode.
    } catch (err) {
      var message = 'Something catastrophic happened in the auth screen. ';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Platform Exception: ${err.toString()}'),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm, _isLoading),
    );
  }
}
