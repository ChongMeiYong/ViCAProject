import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'user.dart';
import 'tab_1.dart';
import 'tab_2.dart';
import 'tab_3.dart';

class MainScreen extends StatefulWidget {
  final User user;

  const MainScreen({Key key, this.user}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> tabs;

  int currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    tabs = [
      TabScreen(user: widget.user),
      TabScreen2(user: widget.user),
      TabScreen3(user: widget.user),
    ];
  }

  String $pagetitle = "ViCA";

  onTapped(int index) {
    setState(() {
      currentTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.blueAccent));
    return Scaffold(
      body: tabs[currentTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTapped,
        currentIndex: currentTabIndex,
        //backgroundColor: Colors.blueGrey,
        type: BottomNavigationBarType.fixed,

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text("Rating"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message ),
            title: Text("Virtual Assistance"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, ),
            title: Text("Profile"),
          )
        ],
      ),
    );
  }
}
