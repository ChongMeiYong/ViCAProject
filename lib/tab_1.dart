import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vica2/rate.dart';
import 'package:vica2/rateform.dart';
import 'package:vica2/viewform.dart';
import 'user.dart';
import 'course.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';

double perpage = 1;

class TabScreen extends StatefulWidget {
  final User user;
  final Rate rate;

  TabScreen({Key key, this.user, this.rate}) : super(key: key);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  GlobalKey<RefreshIndicatorState> refreshKey;
  List data;

  @override
  void initState() {
    super.initState();
    refreshKey = GlobalKey<RefreshIndicatorState>();
    init();
    this.makeRequest();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.blue));
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            //backgroundColor: Colors.white,
            resizeToAvoidBottomPadding: false,
            /*appBar: AppBar(
          //centerTitle: true,
        // backgroundColor: Colors.white,
          title: Text(
            "OLE",
            style: TextStyle(color: Colors.white),
          ),
        ),*/
            body: SafeArea(
              child: RefreshIndicator(
                key: refreshKey,
                color: Colors.blueAccent,
                onRefresh: () async {
                  await refreshList();
                },
                child: ListView.builder(
                    //Step 6: Count the data
                    itemCount: data == null ? 1 : data.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Container(
                          child: Column(children: <Widget>[
                            Stack(children: <Widget>[
                              Image.asset(
                                "assets/images/cover1.png",
                                fit: BoxFit.fitWidth,
                              ),
                              Column(children: <Widget>[
                                SizedBox(
                                  height: 80,
                                ),
                                Container(
                                    color: Colors.blue[300],
                                    child: Center(
                                      child: Text("Taken Course",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                    )),
                              ]),
                            ]),
                          ]),
                        );
                      }
                      if (index == data.length && perpage > 1) {
                        return Container(
                          width: 250,
                          color: Colors.white,
                          child: MaterialButton(
                            child: Text(
                              "Load More",
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {},
                          ),
                        );
                      }
                      index -= 1;
                      return Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Card(
                          elevation: 2,
                          child: InkWell(
                            onTap: () => _onCourseDetail(
                              data[index]['courseid'],
                              data[index]['coursename'],
                              data[index]['courseduration'],
                              data[index]['coursedes'],
                              data[index]['courseimage'],                            
                              data[index]['userenroll'],
                              widget.user.email,
                              data[index]['selected1'],
                              data[index]['selected2'],
                              data[index]['selected3'],
                              data[index]['selected4'],
                              data[index]['selected5'],
                              data[index]['selected6'],
                              data[index]['selected7'],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          //border: Border.all(color: Colors.blueGrey),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  "http://myondb.com/vicaProject/images/${data[index]['courseimage']}.jpg")))),
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                              data[index]['coursename']
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text("Duration: " +
                                              data[index]['courseduration']),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            )));
  }

  Future<String> makeRequest() async {
    String urlCourse = "http://myondb.com/vicaProject/php/load_course.php";
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Loading...");
    pr.show();
    http.post(urlCourse, body: {
      "email": widget.user.email,
    }).then((res) {
      setState(() {
        var extractdata = json.decode(res.body);
        data = extractdata["course"];
        perpage = (data.length / 10);
        print("data");
        pr.dismiss();
      });
    }).catchError((err) {
      print(err);
      pr.dismiss();
    });
    return null;
  }

  Future init() async {
    this.makeRequest(); this.makeRequest2();
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    this.makeRequest();
    return null;
  }

  Future<String> makeRequest2() async {
    String urlResult= "http://myondb.com/vicaProject/php/get_result.php";
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Loading...");
    pr.show();
    http.post(urlResult, body: {
      "email": widget.user.email,
      "courseid": widget.rate.courseid,
    }).then((res) {
      setState(() {
        var extractdata = json.decode(res.body);
        data = extractdata["result"];
        perpage = (data.length / 10);
        print("data");
        pr.dismiss();
      });
    }).catchError((err) {
      print(err);
      pr.dismiss();
    });
    return null;
  }

  void _onCourseDetail(
    String courseid,
    String coursename,
    String courseduration,
    String coursedes,
    String courseimage,
    String userenroll,
    String email,
    String selected1,
    String selected2,
    String selected3,
    String selected4,
    String selected5,
    String selected6,
    String selected7,
  ) {
    Course course = new Course(
      courseid: courseid,
      coursename: coursename,
      courseduration: courseduration,
      coursedes: coursedes,
      courseimage: courseimage,
      userenroll: userenroll,
    );

    Rate rate = new Rate(
      email: email,
      courseid: courseid,
      coursename: coursename,
      selected1: selected1,
      selected2: selected2,
      selected3: selected3,
      selected4: selected4,
      selected5: selected5,
      selected6: selected6,
      selected7: selected7,
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("Choose to "),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                  child: new Text("View Rated Form"),
                  onPressed: () {
                    //_onRateDetail(email, courseid, coursename, selected1, selected2, selected3, selected4, selected5, selected6, selected7);
                    Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewForm(
                                course: course, user: widget.user)));                                
                  }),
              new FlatButton(
                child: new Text("Rate Course"),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              RateForm(course: course, user: widget.user)));
                },
              ),
            ],
          );
        });
  }
}
