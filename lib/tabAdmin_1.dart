import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:vica2/rateform.dart';
import 'package:vica2/viewform.dart';
import 'course.dart';
import 'user.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'SlideRightRoute.dart';

double perpage = 1;
int number = 0;

class TabScreenAdmin extends StatefulWidget {
  final User user;

  TabScreenAdmin({Key key, this.user});

  @override
  _TabScreenAdminState createState() => _TabScreenAdminState();
}

class _TabScreenAdminState extends State<TabScreenAdmin> {
  GlobalKey<RefreshIndicatorState> refreshKey;

  List data;

  @override
  void initState() {
    super.initState();
    refreshKey = GlobalKey<RefreshIndicatorState>();
  }

  @override
  Widget build(BuildContext context) {
    
   SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.blue[300]));
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            resizeToAvoidBottomPadding: false,
           
            body: RefreshIndicator(
              key: refreshKey,
              color: Colors.blue[300],
              onRefresh: () async {
                await refreshList();
              },
              child: ListView.builder(
                  //Step 6: Count the data
                  itemCount: data == null ? 1 : data.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Container(
                        child: Column(
                          children: <Widget>[
                            Stack(children: <Widget>[
                              Image.asset(
                                "assets/images/cover1.png",
                                fit: BoxFit.fitWidth,
                              ),
                              Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 80,
                                  ),
                                  Container(
                                    child: Center(
                                      child: Text("Customer List",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blueAccent)),
                                  )),
                                  SizedBox(
                                    height: 16,
                                    width: 180,
                                    child: Divider(
                                      color: Colors.blue,
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
                            onTap: () => _onUserDetail(
                              data[index]['name'],
                              data[index]['email'],
                              data[index]['phone'],
                              data[index]['dob'],
                              data[index]['address'],
                              //data[index]['postdate'],
                              //widget.user.email,
                              //widget.user.name,
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
                                                  "http://myondb.com/vicaProject/profile/${data[index]['email']}.jpg")))),
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                              data[index]['name']
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(data[index]['email']),
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
            ));
  }

  Future<String> makeRequest() async {
    String urlUser = "http://myondb.com/vicaProject/php/load_user.php";
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Loading...");
    pr.show();
    http.post(urlUser, body: {
      "email": widget.user.email,
    }).then((res) {
      setState(() {
        var extractdata = json.decode(res.body);
        data = extractdata["user"];
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
    this.makeRequest();
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    this.makeRequest();
    return null;
  }

  void _onUserDetail(
    String name,
    String email,
    String phone,
    String dob,
    //String postdate,
    String address,
    //String name
  ) {
    User user = new User (
      name: name,
      email: email,
      phone: phone,
      dob: dob,
      address: address,
      //postdate: postdate,
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
                    Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewForm(
                                user: widget.user)));
                                
                  }),
              new FlatButton(
                child: new Text("Rate Course"),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              RateForm( user: widget.user)));
                },
              ),
            ],
          );
        });
  }
}
