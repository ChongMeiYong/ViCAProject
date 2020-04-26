import 'dart:async';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:vica2/tabAdmin_1.dart';
import 'info_card.dart';
import 'user.dart';
import 'package:toast/toast.dart';
import 'mainscreen.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

String urlupdate = "http://myondb.com/vicaProject/php/update_profile.php";

class UserDetail extends StatefulWidget {
  final User user;

  const UserDetail({Key key, this.user}) : super(key: key);

  @override
  _UserDetailState createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.blue));
    return WillPopScope(
      onWillPop: _onBackPressAppBar,
      child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            title: Text('User Details',
                          style: TextStyle(fontWeight: FontWeight.bold)),
            backgroundColor: Colors.blue,
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              //padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
              child: DetailInterface(
                user: widget.user,
              ),
            ),
          )),
    );
  }

  Future<bool> _onBackPressAppBar() async {
    Navigator.pop(
        context,
        MaterialPageRoute(
          builder: (context) => MainScreen(
            user: widget.user,
          ),
        ));
    return Future.value(false);
  }
}

class DetailInterface extends StatefulWidget {
  final User user;
  DetailInterface({this.user});

  @override
  _DetailInterfaceState createState() => _DetailInterfaceState();
}

class _DetailInterfaceState extends State<DetailInterface> {
  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Stack(
          alignment: Alignment.topCenter,
          overflow: Overflow.visible,
          children: <Widget>[
            Row(children: <Widget>[
              Container(
                height: media.height * 0.15,
                width: media.width,
                decoration: BoxDecoration(color: Colors.blue),
              )
            ]),
            Padding(
              padding: EdgeInsets.only(top: 30, left: 35, right: 35, bottom: 5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  "http://myondb.com/vicaProject/profile/${widget.user.email}.jpg?dummy=${(number)}'",
                  fit: BoxFit.cover,
                  height: 150,
                  width: 150,
                ),
              ),
            ),
          ],
        ),
        Column(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              /*Padding(
                padding: EdgeInsets.only(top: 9),
                child: Icon(
                  Icons.star,
                  color: Colors.teal[300],
                  //size: 20,
                ),
              ),
              SizedBox(width: 5),
              Container(
                padding: EdgeInsets.only(top: 9),
                child: Text(
                  widget.user.name,
                  style: TextStyle(
                      fontFamily: 'Poppins', fontSize: 17, letterSpacing: 0.6),
                ),
              ),*/
            ],
          )
        ]),
        Container(
            width: 800,
            padding: EdgeInsets.only(left: 30, right: 30, top: 20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Column(children: <Widget>[
                        Icon(
                          Icons.person,
                          color: Colors.blue[300],
                          size: 25,
                        ),
                      ]),
                      Text("  "),
                      Text(widget.user.name.toUpperCase(),
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                      SizedBox(width: 3),                     
                    ],
                  ),
                  Divider(
                    height: 12,
                    color: Colors.blue[300],
                    thickness: 3,
                    endIndent: media.width / 2.0,
                  ),
                  Text('* Click for edit data',
                          style: TextStyle(fontWeight: FontWeight.bold)
                  ),
                  SizedBox(width: 3),
                  SizedBox(height: 10),                  
                  InfoCard(
                    text: widget.user.email,
                    icon: Icons.email,
                  ),
                  InfoCard(
                    text: widget.user.phone,
                    icon: Icons.phone,
                    onPressed: _changePhone,
                  ),
                  InfoCard(
                    text: widget.user.dob,
                    icon: Icons.calendar_today,
                    onPressed: _changeDob,
                  ),
                  InfoCard(
                    text: widget.user.address,
                    icon: Icons.home,
                    onPressed: _changeAddress,
                  ),
                ])),
        SizedBox(height: 28),
      ],
    ));
  }

  void _changeName() {
    TextEditingController nameController = TextEditingController();
    // flutter defined function

    if (widget.user.name == "not register") {
      Toast.show("Not allowed", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Change name for " + widget.user.name),
          content: new TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                icon: Icon(Icons.person),
              )),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                if (nameController.text.length < 5) {
                  Toast.show(
                      "Name should be more than 5 characters long", context,
                      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  return;
                }
                http.post(urlupdate, body: {
                  "email": widget.user.email,
                  "name": nameController.text,
                }).then((res) {
                  var string = res.body;
                  List dres = string.split(",");
                  if (dres[0] == "success") {
                    print('in success');
                    setState(() {
                      widget.user.name = dres[1];
                      if (dres[0] == "success") {
                        print("in setstate");
                        widget.user.name = dres[1];
                      }
                    });
                  } else {}
                }).catchError((err) {
                  print(err);
                });
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _changePhone() {
    TextEditingController phoneController = TextEditingController();
    // flutter defined function
    print(widget.user.name);
    if (widget.user.name == "not register") {
      Toast.show("Not allowed", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Change phone for " + widget.user.name),
          content: new TextField(
              keyboardType: TextInputType.phone,
              controller: phoneController,
              decoration: InputDecoration(
                labelText: 'phone',
                icon: Icon(Icons.phone_in_talk),
              )),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                if (phoneController.text.length < 5) {
                  Toast.show("Please enter correct phone number", context,
                      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  return;
                }
                http.post(urlupdate, body: {
                  "email": widget.user.email,
                  "phone": phoneController.text,
                }).then((res) {
                  var string = res.body;
                  List dres = string.split(",");
                  if (dres[0] == "success") {
                    setState(() {
                      widget.user.phone = dres[3];
                      Toast.show("Success ", context,
                          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                      Navigator.of(context).pop();
                      return;
                    });
                  }
                }).catchError((err) {
                  print(err);
                });
              },
            ),
            new FlatButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _changeDob() {
    TextEditingController dobController = TextEditingController();
    final format = DateFormat("yyyy-MM-dd");
    // flutter defined function
    print(widget.user.name);
    if (widget.user.name == "not register") {
      Toast.show("Not allowed", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Change Dob for " + widget.user.name),
          content: DateTimeField(
              controller: dobController,
              format: format,
              decoration: InputDecoration(
                  labelText: 'Date of birth',
                  icon: Icon(Icons.calendar_today)),
              onShowPicker: (context, currentValue) {
                return showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)));
              }),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                if (dobController.text.length < 5) {
                  Toast.show("Please enter correct date", context,
                      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  return;
                }
                http.post(urlupdate, body: {
                  "email": widget.user.email,
                  "dob": dobController.text,
                }).then((res) {
                  var string = res.body;
                  List dres = string.split(",");
                  if (dres[0] == "success") {
                    setState(() {
                      widget.user.dob = dres[4];
                      Toast.show("Success ", context,
                          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                      Navigator.of(context).pop();
                      return;
                    });
                  }
                }).catchError((err) {
                  print(err);
                });
              },
            ),
            new FlatButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _changeAddress() {
    TextEditingController addressController = TextEditingController();
    // flutter defined function
    print(widget.user.name);
    if (widget.user.name == "not register") {
      Toast.show("Not allowed", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Change address for " + widget.user.name),
          content: new TextField(
              keyboardType: TextInputType.text,
              controller: addressController,
              decoration: InputDecoration(
                  labelText: 'Address',
                  icon: Icon(Icons.home))),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                if (addressController.text.length == 0) {
                  Toast.show("Please enter correct address", context,
                      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  return;
                }
                http.post(urlupdate, body: {
                  "email": widget.user.email,
                  "address": addressController.text,
                }).then((res) {
                  var string = res.body;
                  List dres = string.split(",");
                  if (dres[0] == "success") {
                    setState(() {
                      widget.user.address = dres[5];
                      Toast.show("Success ", context,
                          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                      Navigator.of(context).pop();
                      return;
                    });
                  }
                }).catchError((err) {
                  print(err);
                });
              },
            ),
            new FlatButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
