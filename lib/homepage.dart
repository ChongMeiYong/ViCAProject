import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'course.dart';
import 'user.dart';

void main() => runApp(new MyHomePage());

/*
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Form Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Form Demo'),
    );
  }
}
*/

class MyHomePage extends StatefulWidget {
  final Course course;
  final User user;

  MyHomePage({Key key, this.course, this.user}) : super(key: key);
  //final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String email;
  String password;
  bool _termsChecked = false;
  int radioValue = -1;
  bool _autoValidate = false;
  String selected1, selected2, selected3, selected4, selected5, selected6, selected7;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text("Rate Form"),
      ),
      body: new Container(
          margin: const EdgeInsets.all(20.0),
          child: new Form(
              key: _formKey,
              autovalidate: _autoValidate,
              child: new Column(
                children: <Widget>[
                  new SizedBox(
                    height: 10.0,
                  ),
                  Text("Evaluation Form",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                  )),                 
                  new SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: 180,
                    height: 100,
                    child: Image.network(
                      'http://myondb.com/vicaProject/images/${widget.course.courseimage}.jpg',
                      fit: BoxFit.fill),
                  ),
                  new SizedBox(
                    height: 10.0,
                  ),
                  Text(widget.course.coursename.toUpperCase(),
                    style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
                  new SizedBox(
                    height: 10.0,
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
                      new Column(
                    children: <Widget>[
                      new RadioListTile<int>(
                          title: new Text('Male'),
                          value: 0,
                          groupValue: radioValue,
                          onChanged: handleRadioValueChange),
                      new RadioListTile<int>(
                          title: new Text('Female'),
                          value: 1,
                          groupValue: radioValue,
                          onChanged: handleRadioValueChange),
                      new RadioListTile<int>(
                          title: new Text('Transgender'),
                          value: 2,
                          groupValue: radioValue,
                          onChanged: handleRadioValueChange),
                    ],
                  ),
                      SizedBox(
                        height: 5,
                      ),

                  
                  new SizedBox(
                    height: 20.0,
                  ),
                  new CheckboxListTile(
                      title: new Text('Terms and Conditionns'),
                      value: _termsChecked,
                      onChanged: (bool value) =>
                          setState(() => _termsChecked = value)),
                  new SizedBox(
                    height: 30.0,
                  ),
                  new RaisedButton(
                    onPressed: _validateInputs,
                    child: new Text('Login'),
                  )
                ],
              ))]),
    )));
  }

  void handleRadioValueChange(int value) {
    print(value);
    setState(() => radioValue = value);
  }

  void _validateInputs() {
    final form = _formKey.currentState;
    if (form.validate()) {
      // Text forms has validated.
      // Let's validate radios and checkbox
      if (!_termsChecked) {
        // The checkbox wasn't checked
        _showSnackBar("Please accept our terms");
      } else {
        // Every of the data in the form are valid at this point
        form.save();
        showDialog(
            context: context,
            builder: (BuildContext context) => new AlertDialog(
                  content: new Text("All inputs are valid"),
                ));
      }
    } else {
      setState(() => _autoValidate = true);
    }
  }

  void _showSnackBar(message) {
    final snackBar = new SnackBar(
      content: new Text(message),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
