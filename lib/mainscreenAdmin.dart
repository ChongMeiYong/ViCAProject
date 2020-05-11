import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vica2/tabAdmin_1.dart';
import 'package:vica2/tabAdmin_2.dart';
import 'package:vica2/user.dart';
import 'admin.dart';


class MainScreenAdmin extends StatefulWidget {
  final Admin admin;
  final User user;

  const MainScreenAdmin({Key key, this.admin, this.user}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreenAdmin> {
  List<Widget> tabs;

  int currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    tabs = [
      TabScreenAdmin(admin: widget.admin),
      TabScreenAdmin2(admin: widget.admin),
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
            icon: Icon(Icons.list),
            title: Text("Customer List"),
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
