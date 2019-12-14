import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'loginpage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

String pathAsset = 'assets/images/profile.png';
String urlUpload = 'http://myondb.com/vicaProject/php/register.php';
File _image;
final TextEditingController _namecontroller = TextEditingController();
final TextEditingController _emcontroller = TextEditingController();
final TextEditingController _passcontroller = TextEditingController();
final TextEditingController _phcontroller = TextEditingController();
final TextEditingController _dobcontroller = TextEditingController();
final TextEditingController _addcontroller = TextEditingController();

String _name, _email, _password, _phone, _dob, _address;

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
  const RegistrationScreen({Key key, File image}) : super(key: key);
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
            backgroundColor: Colors.blueAccent,
            title: Text(
              "Registration",
              //style: TextStyle(color: Colors.white),
            ),
          ),
          body: SingleChildScrollView(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onPanDown: (_) {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
                child: RegisterWidget(),
              ),
            ),
          ),
        ));
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
  final format = DateFormat("yyyy-MM-dd");

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
                height: 170,
                width: 170,
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
                backgroundColor: Colors.white,
                onPressed: _choose,
              ),
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        TextFormField(
            controller: _emcontroller,
            autovalidate: _autoValidate,
            validator: _validateEmail,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent)),
            )),
        SizedBox(
          height: 10,
        ),
        TextFormField(
            controller: _namecontroller,
            autovalidate: _autoValidate,
            validator: _validateName,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent)),
            )),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: _passcontroller,
          autovalidate: _autoValidate,
          validator: _validatePassword,
          decoration: InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueAccent)),
          ),
          obscureText: true,
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
            controller: _phcontroller,
            autovalidate: _autoValidate,
            validator: _validatePhone,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: 'Phone',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent)),
            )),
        SizedBox(
          height: 10,
        ),
        DateTimeField(
          controller: _dobcontroller,
          format: format,
          decoration: InputDecoration(
            labelText: 'Date of birth',
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueAccent)),
          ),
          onShowPicker: (context, currentValue) {
            return showDatePicker(
                context: context,
                firstDate: DateTime(1990),
                initialDate: currentValue ?? DateTime.now(),
                lastDate: DateTime(2020));
          },
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
            controller: _addcontroller,
            autovalidate: _autoValidate,
            validator: _validateAddress,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Address',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent)),
            )),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: MaterialButton(
            child: Text(
              'REGISTER',
              style: TextStyle(
                  color: Colors.white, fontSize: 18, letterSpacing: 0.8),
            ),
            minWidth: 200,
            height: 50,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            onPressed: _onRegister,
            color: Colors.blue[700],
          ),
        ),
        SizedBox(
          height: 13,
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Divider(),
            ),
            GestureDetector(
              onTap: _goBack,
              child: Text(
                'Already Register',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Divider(),
            )
          ],
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

  String _validateName(String value) {
    if (value.length == 0) {
      return "Please enter your name";
    } else {
      return null;
    }
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
    if (value.length == 0) {
      return "Please enter your phone number";
    } else if (value.length < 9 || value.length > 11) {
      return "Phone number must 10-11 digits";
    } else if (!regExp.hasMatch(value)) {
      return "Please enter correct phone number";
    }
  }

  String _validateAddress(String value) {
    if (value.length == 0) {
      return "Please enter your address";
    } else {
      return null;
    }
  }

  /*void _onRegister(){
     print('onRegister Button from RegisterUser()');
    print(_image.toString());
    uploadData();
  }*/

  void _goBack() {
    _image = null;
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  void _onRegister() {
    _name = _namecontroller.text;
    _email = _emcontroller.text;
    _password = _passcontroller.text;
    _phone = _phcontroller.text;
    _dob = _dobcontroller.text;
    _address = _addcontroller.text;

    if ((_isEmailValid(_email)) &&
        (_password.length > 5) &&
        (_phone.length > 5) &&
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
        "dob": _dob,
        "address": _address,
      }).then((res) {
        print(res.statusCode);
        Toast.show(res.body, context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        _image = null;
        _namecontroller.text = "";
        _emcontroller.text = "";
        _passcontroller.text = "";
        _phcontroller.text = "";
        _dobcontroller.text = "";
        _addcontroller.text = "";

        pr.dismiss();
        if (res.body == "Email Registered! Please try again") {
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
      setState(() {
        _autoValidate = true;
      });
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
            content: const Text('You can login now!'),
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
