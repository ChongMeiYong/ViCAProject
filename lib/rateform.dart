import 'dart:async';
import 'package:toast/toast.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:vica2/tab_1.dart';
import 'user.dart';
import 'course.dart';
import 'mainscreen.dart';

String urlUpload = 'http://myondb.com/vicaProject/php/evaluate.php';
//final TextEditingController _s1controller = TextEditingController();

String selected1, selected2, selected3, selected4, selected5, selected6, selected7;

class RateForm extends StatefulWidget {
  final Course course;
  final User user;

  const RateForm({Key key, this.course, this.user}) : super(key: key);

  @override
  _RateFormState createState() => _RateFormState();
}

class _RateFormState extends State<RateForm> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.blue[300]));
    return WillPopScope(
      onWillPop: _onBackPressAppBar,
      child: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            title: Text('Rate Course'),
            backgroundColor: Colors.blue[300],
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
              child: DetailInterface(
                course: widget.course,
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
  final Course course;
  final User user;

  DetailInterface({this.course, this.user});

  @override
  _DetailInterfaceState createState() => _DetailInterfaceState();
}

class _DetailInterfaceState extends State<DetailInterface> {
  @override
  void initState() {
    super.initState();
  }
  
  GlobalKey<FormState> _globalKey = new GlobalKey();
  bool _autoValidate = false;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(),
        Text("Evaluation Form",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
        SizedBox(
          height: 10,
        ),
        Container(
          width: 180,
          height: 100,
          child: Image.network(
              'http://myondb.com/vicaProject/images/${widget.course.courseimage}.jpg',
              fit: BoxFit.fill),
        ),
        SizedBox(
          height: 10,
        ),
        Text(widget.course.coursename.toUpperCase(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
        SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.topLeft,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                  Widget>[
            SizedBox(
              height: 5,
            ),
            Text("Course ID : " + widget.course.courseid,
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text("Course Name : " + widget.course.coursename,
                style: TextStyle(fontWeight: FontWeight.bold)),
      
            //Course Evaluation Question
            SizedBox(
              height: 10,
            ),
            Text("Course",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  color: Colors.blue,
                )),
            Text("Question 1: ", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("Did the course content meet your expectations?"),
            RadioButtonGroup(
                orientation: GroupedButtonsOrientation.HORIZONTAL,
                labels: <String>[
                  "Bad",
                  "Average",
                  "Good",
                  "Excellent",
                ],
                onSelected: (String selected1) => print(selected1)),
            SizedBox(
              height: 5,
            ),

            Text("Question 2: ", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
                "How did you experience the speed or rate at which the training was presented?"),
            RadioButtonGroup(
                orientation: GroupedButtonsOrientation.HORIZONTAL,
                labels: <String>[
                  "Bad",
                  "Average",
                  "Good",
                  "Excellent",
                ],
                onSelected: (String selected2) => print(selected2)),
            SizedBox(
              height: 5,
            ),

            Text("Question 3: ", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
                "Can you practically apply the course material to your daily work situations?"),
            RadioButtonGroup(
                orientation: GroupedButtonsOrientation.HORIZONTAL,
                labels: <String>[
                  "Bad",
                  "Average",
                  "Good",
                  "Excellent",
                ],
                onSelected: (String selected3) => print(selected3)),
            SizedBox(
              height: 5,
            ),

            //Facilitator Evaluation Question
            SizedBox(
              height: 10,
            ),
            Text("Facilitator",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  color: Colors.blue,
                )),
            Text("Question 1: ", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
                "How knowledgeable was the facilitator on the subject matter?"),
            RadioButtonGroup(
                orientation: GroupedButtonsOrientation.HORIZONTAL,
                labels: <String>[
                  "Bad",
                  "Average",
                  "Good",
                  "Excellent",
                ],
                onSelected: (String selected4) => print(selected4)),
            SizedBox(
              height: 5,
            ),

            Text("Question 2: ", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
                "Did the facilitator explain the concepts clearly and in an understandable way?"),
            RadioButtonGroup(
                orientation: GroupedButtonsOrientation.HORIZONTAL,
                labels: <String>[
                  "Bad",
                  "Average",
                  "Good",
                  "Excellent",
                ],
                onSelected: (String selected5) => print(selected5)),
            SizedBox(
              height: 5,
            ),

            Text("Question 3: ", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("How did the facilitator handle questions that were asked?"),
            RadioButtonGroup(
                orientation: GroupedButtonsOrientation.HORIZONTAL,
                labels: <String>[
                  "Bad",
                  "Average",
                  "Good",
                  "Excellent",
                ],
                onSelected: (String selected6) => print(selected6)),
            SizedBox(
              height: 5,
            ),

            //Venue Evaluation Question
            SizedBox(
              height: 10,
            ),
            Text("Venue",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  color: Colors.blue,
                )),
            Text("Question 1: ", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
                "Was the venue sufficient for the type of training presented?"),
            RadioButtonGroup(
                orientation: GroupedButtonsOrientation.HORIZONTAL,               
                labels: <String>[
                  "Bad",
                  "Average",
                  "Good",
                  "Excellent",
                ],               
                onSelected: (String selected7) => print(selected7)
            ),
            SizedBox(
              height: 5,
            ),
          ])),
      
        SizedBox(
              height: 15,
        ),

        Container(
                width: 350,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  height: 40,
                  child: Text(
                    'Rate',
                    style: TextStyle(fontSize: 16),
                  ),
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  elevation: 5,
                  //onPressed: validateAnswers,             
                ),
                //MapSample(),
        ),        
      ]);
    }
  }
/*
  void validateAnswers() {
    if (selected1 == -1 && selected2 == -1 &&
        selected3 == -1 && selected4 == -1 &&
        selected5 == -1 && selected6 == -1 &&
        selected7 == -1) {
      Fluttertoast.showToast(msg: 'Please select atleast one answer',
          toastLength: Toast.LENGTH_SHORT);
    } else {
      Fluttertoast.showToast(
          msg: 'Your total score is: $correctScore out of 5',
          toastLength: Toast.LENGTH_LONG);
    }
  }
*/
/*
  void _onRate() {
      http.post(urlUpload, body: {
        "selected1": selected1,
        "selected2": selected2,
        "selected3": selected3,
        "selected4": selected4,
        "selected5": selected5,
        "selected6": selected6,
        "selected7": selected7,
        "email": widget.user.email,
      }).then((res) {
        print(res.statusCode);
        Toast.show(res.body, context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        //pr.dismiss();
        if (res.body == "Please rate for all question!") {
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
                      MaterialPageRoute(builder: (context) => TabScreen()));
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
            title: Text('Thanks for Registration'),
            content: const Text('Please verify account from your email'),
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
                          builder: (BuildContext context) => TabScreen()));
                },
              )
            ],
          );
        });
  }
}
*/
