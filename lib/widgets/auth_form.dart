import 'dart:io';
import 'package:caint/widgets/user_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFunction, this.isLoading, {Key? key})
      : super(
          key: key,
        );
  bool isLoading;

  final void Function(
    String email,
    String username,
    String password,
    File? image,
    bool isLogin,
    BuildContext ctx,
  ) submitFunction;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';
  File? _userImage;
  bool _isLogin = true;


  void _pickedImage(File image) {
    _userImage = image;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();

    FocusScope.of(context).unfocus();

    if (_userImage == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('You have to pick an avatar image.'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }

    if (isValid) {
      _formKey.currentState!.save();
      widget.submitFunction(
        _userEmail.trim(),
        _userName.trim(),
        _userPassword.trim(),
        _userImage,
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (!_isLogin) UserImagePicker(_pickedImage),
                  TextFormField(
                    key: ValueKey('userEmail'),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !value.contains('@')) {
                        return 'Please enter a valid email address.';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                    ),
                    onSaved: (value) {
                      _userEmail = value!;
                    },
                  ),
                  if (!_isLogin) //Special conditional
                    TextFormField(
                      key: ValueKey('userName'),
                      validator: (value) {
                        if (value == null || value.length < 8) {
                          return 'Come on enter a reasonable username.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'User Name',
                      ),
                      onSaved: (value) {
                        _userName = value!;
                      },
                    ),
                  TextFormField(
                    key: ValueKey('userPassword'),
                    validator: (value) {
                      String pattern =
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                      RegExp regex = new RegExp(pattern);
                      if (value == null || value.length < 8) {
                        return 'That password is not good at all.';
                      }
                      if (!regex.hasMatch(pattern)) {
                        return 'That password is not complex enough.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    onSaved: (value) {
                      _userPassword = value!;
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    ElevatedButton(
                      child: Text(_isLogin ? 'Login' : 'Sign Up'),
                      onPressed: _trySubmit,
                    ),
                  if (!widget.isLoading)
                    TextButton(
                      child: Text(_isLogin
                          ? 'Create New Account'
                          : 'I already have an account'),
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        textStyle: TextStyle(
                            //color: Colors.orange,
                            ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
