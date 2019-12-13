import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vica2/admin.dart';
import 'forgotpassword.dart';
import 'mainscreenAdmin.dart';
import 'register.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'mainscreen.dart';
import 'user.dart';

String urlLogin = "http://myondb.com/vicaProject/php/login.php";
String urlLoginAdmin = "http://myondb.com/vicaProject/php/loginAdmin.php";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> key = new GlobalKey();
  bool _validate = false;
  bool _isChecked = false;
  final TextEditingController _emcontroller = TextEditingController();
  String _email = "";
  final TextEditingController _pscontroller = TextEditingController();
  String _pass = "";

  @override
  void initState() {
    loadpref();
    print('Init: $_email');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressAppBar,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: new Container(
          padding: EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/logo.png',
                scale: 4.5,
              ),
              TextFormField(
                  autovalidate: _validate,
                  controller: _emcontroller,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelText: 'Email', icon: Icon(Icons.email))),
              TextFormField(
                autovalidate: _validate,
                controller: _pscontroller,
                decoration: InputDecoration(
                    labelText: 'Password', icon: Icon(Icons.lock)),
                obscureText: true,
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool value) {
                      _onChange(value);
                    },
                  ),
                  Text('Remember Me', style: TextStyle(fontSize: 15))
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(children: <Widget>[
                SizedBox(
                  width: 25,
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  minWidth: 120,
                  height: 50,
                  child: Text('User', style: TextStyle(fontSize: 17)),
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  elevation: 15,
                  onPressed: _onLogin,
                ),
                SizedBox(
                  width: 10,
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  minWidth: 120,
                  height: 50,
                  child: Text('Admin', style: TextStyle(fontSize: 17)),
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  elevation: 15,
                  onPressed: _onLoginAdmin,
                ),
              ]),
              SizedBox(
                height: 20,
              ),
              RichText(
                  text: new TextSpan(
                      text: 'Forgot your password? ',
                      style: TextStyle(color: Colors.black),
                      children: <TextSpan>[
                    TextSpan(
                        text: 'Click Here!',
                        style: TextStyle(color: Colors.lightBlueAccent),
                        recognizer: TapGestureRecognizer()..onTap = _onForgot)
                  ])),
              SizedBox(
                height: 20,
              ),
              RichText(
                  text: new TextSpan(
                      text: 'Dont have an account? ',
                      style: TextStyle(color: Colors.black),
                      children: <TextSpan>[
                    TextSpan(
                        text: 'Create New Account',
                        style: TextStyle(color: Colors.lightBlueAccent),
                        recognizer: TapGestureRecognizer()..onTap = _onRegister)
                  ])),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    } else {
      return null;
    }
  }

  String validatePassword(String value) {
    if (value.length == 0) {
      return "Password is Required";
    } else if (value.length < 6) {
      return "Password must at least 6 characters";
    } else {
      return null;
    }
  }

  void _onLogin() {
    _email = _emcontroller.text;
    _pass = _pscontroller.text;
    if (_isEmailValid(_email) && (_pass.length > 4)) {
      ProgressDialog pr = new ProgressDialog(context,
          type: ProgressDialogType.Normal, isDismissible: false);
      pr.style(message: "Login");
      pr.show();
      http.post(urlLogin, body: {
        "email": _email,
        "password": _pass,
      }).then((res) {
        print(res.statusCode);
        var string = res.body;
        List dres = string.split(",");
        print(dres);
        Toast.show(dres[0], context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        if (dres[0] == "success") {
          pr.dismiss();
          //print("Radius:");
          print(dres);
          User user = new User(name: dres[1], email: dres[2], phone: dres[3]);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => MainScreen(user: user)));
        } else {
          pr.dismiss();
        }
      }).catchError((err) {
        pr.dismiss();
        print(err);
      });
    } else {}
  }

  void _onLoginAdmin() {
    _email = _emcontroller.text;
    _pass = _pscontroller.text;
    if (_isEmailValid(_email) && (_pass.length > 4)) {
      ProgressDialog pr = new ProgressDialog(context,
          type: ProgressDialogType.Normal, isDismissible: false);
      pr.style(message: "Login in");
      pr.show();
      http.post(urlLoginAdmin, body: {
        "email": _email,
        "password": _pass,
      }).then((res) {
        print(res.statusCode);
        var string = res.body;
        List dres = string.split(",");
        print(dres);
        Toast.show(dres[0], context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        if (dres[0] == "success") {
          pr.dismiss();
          print("Radius:");
          print(dres);
         Admin admin = new Admin(name:dres[1],email: dres[2],phone:dres[3]);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MainScreenAdmin(admin: admin)));
        } else {
          pr.dismiss();
        }
      }).catchError((err) {
        pr.dismiss();
        print(err);
      });
    } else {}
  }

  void _onChange(bool value) {
    setState(() {
      _isChecked = value;
      savepref(value);
    });
  }

  void _onRegister() {
    print('onRegister');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RegistrationScreen()));
  }

  void _onForgot() {
    print('Forgot');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ForgotPassword()));
  }

  void loadpref() async {
    print('Inside loadpref()');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _email = (prefs.getString('email'));
    _pass = (prefs.getString('pass'));
    print(_email);
    print(_pass);
    if (_email.length > 1) {
      _emcontroller.text = _email;
      _pscontroller.text = _pass;
      setState(() {
        _isChecked = true;
      });
    } else {
      print('No pref');
      setState(() {
        _isChecked = false;
      });
    }
  }

  void savepref(bool value) async {
    print('Inside savepref');
    _email = _emcontroller.text;
    _pass = _pscontroller.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value) {
      //true save pref
      if (_isEmailValid(_email) || _pass.length < 5) {
        await prefs.setString('email', _email);
        await prefs.setString('pass', _pass);
        print('Save pref $_email');
        print('Save pref $_pass');
        Toast.show("Preferences saved succesfully", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      } else {
        print('No email');
        setState(() {
          _isChecked = false;
        });
        Toast.show("Invalid Preferences", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    } else {
      await prefs.setString('email', '');
      await prefs.setString('pass', '');
      setState(() {
        _emcontroller.text = '';
        _pscontroller.text = '';
        _isChecked = false;
      });
      print('Remove pref');
      Toast.show("Preferences removed", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  Future<bool> _onBackPressAppBar() async {
    SystemNavigator.pop();
    print('Backpress');
    return Future.value(false);
  }

  bool _isEmailValid(String email) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }
}
