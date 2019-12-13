import 'dart:convert';
import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'loginpage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'dart:async';

String pathAsset = 'assets/images/profile.png';
String urlUpload = 'http://myondb.com/vicaProject/php/register.php';
File _image;
final TextEditingController _uncontroller = TextEditingController();
final TextEditingController _emcontroller = TextEditingController();
final TextEditingController _pwcontroller = TextEditingController();
final TextEditingController _phcontroller = TextEditingController();

String _name, _email, _password, _phone;
bool _validate = false;

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RegisterScreen();
  }
}

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
  const RegisterScreen({Key key, File image}) : super(key: key);
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressAppBar,
      child: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            backgroundColor: Colors.blue[300],
            centerTitle: true,
            title: Text(
              'Sign up now',
              style: TextStyle(fontSize: 20, letterSpacing: 0.6),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
              child: RegisterWidget(),
            ),
          )),
    );
  }

  Future<bool> _onBackPressAppBar() async {
    _image = null;
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
    return Future.value(false);
  }
}

class RegisterWidget extends StatefulWidget {
  @override
  _RegisterWidgetState createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  @override
  GlobalKey<FormState> _globalKey = new GlobalKey();
  bool _autoValidate = false;
  @override 
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 50, right: 50, top: 5),
              child: Container(
                height: 180,
                width: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: _image == null
                          ? AssetImage(pathAsset)
                          : FileImage(_image),
                      fit: BoxFit.fill),
                ),
              ),
            ),
            Positioned(
              right: 50.0,
              bottom: 0.0,
              child: new FloatingActionButton(
                child: const Icon(Icons.camera_alt),
                backgroundColor: Colors.blue.shade800,
                onPressed: _choose,
              ),
            )
          ],
        ),
        SizedBox( 
          height: 10,
        ),
        Text('Click on the image above to take profile pic'),
        TextFormField( 
          controller: _uncontroller,
          autovalidate: _autoValidate,
          validator: _validateName,
          keyboardType: TextInputType.text,
          decoration: InputDecoration( 
            labelText: 'Name',
            icon: Icon(Icons.person),
          )
        ),

        TextFormField( 
          controller: _emcontroller,
          autovalidate: _autoValidate,
          validator: _validateEmail,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration( 
            labelText: 'Email',
            icon: Icon(Icons.email),
          )
        ),

        TextFormField( 
          controller: _pwcontroller,
          autovalidate: _autoValidate,
            validator: _validatePassword,
          decoration: InputDecoration( 
            labelText: 'Password',
            icon: Icon(Icons.lock),
          ),
          obscureText: true,
        ),

        TextFormField( 
          controller: _phcontroller,
          autovalidate: _autoValidate,
          validator: _validatePhone,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration( 
            labelText: 'Phone Number',
            icon: Icon(Icons.phone),
          )
        ),
        SizedBox( 
          height: 20,
        ),

        MaterialButton( 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)), 
          minWidth: 300,
          height: 40,
          child: Text('Sign Up', style: TextStyle(fontSize: 18,)),
          color: Colors.blueAccent,
          textColor:  Colors.white,
          elevation: 15,
          onPressed: _uploadData,
        ),
        SizedBox( 
          height: 20,
        ),
        RichText(
          text: new TextSpan(
            text: 'Already Register? ',
            style: TextStyle(color: Colors.black),
            children: <TextSpan>[
              TextSpan(
                text: 'Sign In',
                style: TextStyle(color: Colors.lightBlueAccent),
                recognizer: TapGestureRecognizer()..onTap = _goBack
              )
            ]
          )
        )
      ],
    );
  }

  void _choose() async {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            padding: EdgeInsets.all(40),
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text('Camera'),
                  onTap: () async {
                    _image =
                        await ImagePicker.pickImage(source: ImageSource.camera);
                    setState(() {});
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_album),
                  title: Text('Gallery'),
                  onTap: () async {
                    _image = await ImagePicker.pickImage(
                        source: ImageSource.gallery);
                    setState(() {});
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          );
        });
    //selection==null?_image = await ImagePicker.pickImage(source: ImageSource.camera):await ImagePicker.pickImage(source: ImageSource.gallery);
  }

  String _validateName(String value) {
    if (value.length == 0) {
      return "Please enter your name";
    } else {
      return null;
    }
  }

  String _validateEmail(String value) {
    // The form is empty
    if (value.length == 0) {
      return "Please enter your email";
    }
    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = new RegExp(p);

    if (regExp.hasMatch(value)) {
      return null;
    }
    return 'Email is not valid';
  }

  String _validatePassword(String value) {
    if (value.length == 0) {
      return "Please enter your password";
    } else if (value.length < 6) {
      return "Password must at least 6 characters";
    } else {
      return null;
    }
  }

  String _validatePhone(String value) {
    String p = r'(^[0-9]*$)';
     RegExp regExp = new RegExp(p);
     if(value.length == 0){
       return "Please enter your phone number";
     } else if (value.length <9 || value.length > 11) {
       return "Phone number must 10-11 digits";
     }else if (!regExp.hasMatch(value)){
       return "Please enter correct phone number";
     }
  }

  void _goBack() {
    _image = null;
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  void _uploadData() {
    _name = _uncontroller.text;
    _email = _emcontroller.text;
    _password = _pwcontroller.text;
    _phone = _phcontroller.text;

    if ((_isEmailValid(_email)) &&
        (_password.length > 5) &&
        (_phone.length > 9) &&
        (_image != null)) {
      ProgressDialog pr = new ProgressDialog(context,
          type: ProgressDialogType.Normal, isDismissible: false);
      pr.style(message: "Registration in progress");
      pr.show();
      String base64Image = base64Encode(_image.readAsBytesSync());
      http.post(urlUpload, body: {
        "encoded_string": base64Image,
        "name": _name,
        "email": _email,
        "password": _password,
        "phone": _phone,
      }).then((res) {
        print(res.statusCode);
        Toast.show(res.body, context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        _image = null;
        _uncontroller.text = "";
        _emcontroller.text = "";
        _pwcontroller.text = "";
        _phcontroller.text = "";

        pr.dismiss();
        if (res.body == "failed") {
          print('enter fail area');
          _showDialog();
        } else {
          _showSuccessRegister();
          /*  Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => LoginScreen())); */
        }
      }).catchError((err) {
        print(err);
      });
    } else {
      Toast.show("Check your registration information", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  bool _isEmailValid(String email) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  void _showDialog() {
    print('Enter show dialog');
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Email has already been taken!'),
            content:
                const Text('Your entered email has been registered by other'),
            actions: <Widget>[
              FlatButton(
                child: Text('Try another'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Already have account?'),
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
              )
            ],
          );
        });
  }

  void _showSuccessRegister() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Thanks for your registration'),
            content: const Text('Please Login to ViCA!'),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Ok',
                  textAlign: TextAlign.center,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => LoginPage()));
                },
              )
            ],
          );
        });
  }
}