import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'user.dart';
import 'course.dart';
import 'rate.dart';
import 'mainscreen.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';

double perpage = 1;
String urlgetresult = "http://myondb.com/vicaProject/php/get_result.php";

String selected1, selected2, selected3, selected4, selected5, selected6, selected7;

class ViewForm extends StatefulWidget {
  final Course course;
  final User user;
  final Rate rate;
  
  ViewForm({this.course, this.user, this.rate});

  @override
  _ViewFormState createState() => _ViewFormState();
  
}

class _ViewFormState extends State<ViewForm> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.blue[300]));
    return WillPopScope(
      onWillPop: _onBackPressAppBar,
      child: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            title: Text('View Rated Form'),
            backgroundColor: Colors.blue[300],
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
              child: DetailInterface(
                course: widget.course,
                user: widget.user,
                //rate: widget.rate,
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
  final Rate rate;

  DetailInterface({this.course, this.user, this.rate});

  @override
  _DetailInterfaceState createState() => _DetailInterfaceState();
}

class _DetailInterfaceState extends State<DetailInterface> {
  GlobalKey<RefreshIndicatorState> refreshKey;
  List data;

  @override
  void initState() {
    super.initState();
    refreshKey = GlobalKey<RefreshIndicatorState>();
    init();
    makeRequest();
  }
  
  GlobalKey<FormState> _globalKey = new GlobalKey();
  bool _autoValidate = false;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(),        
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
            Text("Rate :  " + selected6, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple)),
           
            SizedBox(
              height: 5,
            ),

            Text("Question 2: ", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("How did you experience the speed or rate at which the training was presented?"),
            Text("Rate :  " + selected2, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple)),
         
            SizedBox(
              height: 5,
            ),

            Text("Question 3: ", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("Can you practically apply the course material to your daily work situations?"),
            Text("Rate :  " + selected3, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple)),
           
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
            Text("How knowledgeable was the facilitator on the subject matter?"),
            Text("Rate :  " + selected4, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple)),
       
            SizedBox(
              height: 5,
            ),

            Text("Question 2: ", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("Did the facilitator explain the concepts clearly and in an understandable way?"),
            Text("Rate :  " + selected5, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple)),
            
            SizedBox(
              height: 5,
            ),

            Text("Question 3: ", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("How did the facilitator handle questions that were asked?"),
            Text("Rate :  " + selected6, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple)),
            
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
            Text("Was the venue sufficient for the type of training presented?"),
            Text("Rate :  " + selected7, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple)),
            
            SizedBox(
              height: 5,
            ),
          ])),
      
        SizedBox(
              height: 15,
        ),
      ]);
    }

    Future<String> makeRequest() async {
    String urlResult = "http://myondb.com/vicaProject/php/get_result.php";
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Loading...");
    pr.show();
    http.post(urlResult, body: {
      "email": widget.user.email,
      "courseid": widget.course.courseid,
    }).then((res) {
      setState(() {
        var extractdata = json.decode(res.body);
        data = extractdata["course"];
        print(data[0]);
        _onFormDetail(
          data[0], data[1], data[2], data[3], data[4], data[5], data[6]);
        pr.dismiss();
      });
    }).catchError((err) {
      print(err);
      pr.dismiss();
    });
    return null;
  }

  Future init() async {
    this.makeRequest();
  }

  void _onFormDetail(String d0, d1, d2, d3, d4, d5, d6) {
    selected1 = d0 ;
    selected2 = d1 ;
    selected3 = d2 ;
    selected4 = d3 ;
    selected5 = d4 ;
    selected6 = d5 ;
    selected7 = d6 ;
  }
 }

