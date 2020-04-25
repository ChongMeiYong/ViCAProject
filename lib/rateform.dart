import 'package:vica2/tab_1.dart';
import 'user.dart';
import 'dart:async';
import 'course.dart';
import 'mainscreen.dart';
import 'package:toast/toast.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:progress_dialog/progress_dialog.dart';

String selected1 ,
    selected2 ,
    selected3 ,
    selected4 ,
    selected5 ,
    selected6 ,
    selected7 ;
String _selected1 ,
    _selected2 ,
    _selected3 ,
    _selected4 ,
    _selected5 ,
    _selected6 ,
    _selected7 ;

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
    return Column(children: <Widget>[
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
              //validator: _validateName,
                orientation: GroupedButtonsOrientation.HORIZONTAL,
                labels: <String>[
                  "Bad",
                  "Average",
                  "Good",
                  "Excellent",
                ],
                onSelected: (selected1) => setS1(selected1)              
            ),
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
                onSelected: (selected2) => setS2(selected2) 
            ),
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
                onSelected: (selected3) => setS3(selected3) 
            ),
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
                onSelected: (selected4) => setS4(selected4) 
            ),
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
                onSelected: (selected5) => setS5(selected5) 
            ),
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
                onSelected: (selected6) => setS6(selected6) 
            ),
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
                onSelected: (selected7) => setS7(selected7) 
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          height: 40,
          child: Text(
            'Rate',
            style: TextStyle(fontSize: 16),
          ),
          color: Colors.blueAccent,
          textColor: Colors.white,
          elevation: 5,
          onPressed: _validateInputs,
        ),
        //MapSample(),
      ),
    ]);
  }

  void setS1(String s1) {
    _selected1 = s1 ;
  }

  void setS2(String s2) {
     _selected2 = s2 ;
  }

  void setS3(String s3) {
    _selected3 = s3 ;
  }

  void setS4(String s4) {
    _selected4 = s4 ;
  }

  void setS5(String s5) {
    _selected5 = s5 ;
  }

  void setS6(String s6) {
    _selected6 = s6 ;
  }

  void setS7(String s7) {
    _selected7 = s7;
  }

  Future<String> rateCourse() async {
    String urlUpload = "http://myondb.com/vicaProject/php/evaluate.php";
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Rating..");
    pr.show();
    http.post(urlUpload, body: {
      "selected1": _selected1,
      "selected2": _selected2,
      "selected3": _selected3,
      "selected4": _selected4,
      "selected5": _selected5,
      "selected6": _selected6,
      "selected7": _selected7,
      "email": widget.user.email,
      "courseid": widget.course.courseid,
      "coursename": widget.course.coursename,
    }).then((res) {
      if (res.body == "success") {
        Toast.show("success", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM); 
        
        pr.dismiss();  
        setS1(null);setS2(null);setS3(null);setS4(null);
        setS5(null);setS6(null);setS7(null); 
        _showSuccessRate(); 
      } else {
        Toast.show("Sorry, Please try again!", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        pr.dismiss(); 
        _showDialog();
      }
    }).catchError((err) {
      print(err);
      pr.dismiss();
    });
    return null;
  }

  void _validateInputs() {
    if (_selected1 == null ||
        _selected2 == null ||
        _selected3 == null ||
        _selected4 == null ||
        _selected5 == null ||
        _selected6 == null ||
        _selected7 == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Remind"),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Text("Please rate for all question!"),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text(
                  "OK",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                color: Colors.lightBlueAccent,
              ),
            ],
          );
        },
      );
      //_showSnackBar("Please rate for for all questions.");
    } else {
      // Every of the data in the form are valid at this point
      rateCourse();      
    }
  }

  void _showDialog() {
       showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Sorry!"),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Text("Course Rated! Please Rate for other Course."),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text(
                  "OK",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                color: Colors.lightBlueAccent,
              ),
            ],
          );
        },
      );
  }

  void _showSuccessRate() {
       showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Thank You"),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Text("Rated Success!"),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text(
                  "OK",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  //Navigator.of(context).pop();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => MainScreen(user: widget.user)));
                },
                color: Colors.lightBlueAccent,
              ),
            ],
          );
        },
      );
  }
}