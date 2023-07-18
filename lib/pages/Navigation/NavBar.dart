import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mobile_tracking/pages/Other/changePassword.dart';
import 'package:mobile_tracking/pages/Other/theft.dart';

import '../Other/addVehicle.dart';
import '../Profile/profile.dart';
import '../home.dart';

class NavBarPage extends StatefulWidget {
  String id="";
   NavBarPage({Key? key, required this.id}) : super(key: key);
  void toPrint(){
    print("I am in nabar and id is ${id}");
  }

  @override
  State<NavBarPage> createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  late final List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[

      MyHomePage(id: widget.id),
      AddVehiclePage(id:widget.id),
      TheftPage(id: widget.id),
      ChangePasswordPage(id: widget.id),
    ];
  }
  // _NavBarPageState() {
  //   print("I am in NavBar and The id is ${widget.id}");
  //   _widgetOptions = <Widget>[
  //
  //     Text("Add"),
  //     MyHomePage(id: widget.id),
  //     Text(
  //       'Theft',
  //       style: optionStyle,
  //     ),
  //     Text(
  //       'Profile',
  //       style: optionStyle,
  //     ),
  //   ];
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Welcome Milkiyas"),actions: [ElevatedButton.icon(onPressed: (){
        Navigator.popUntil(context,  (Route<dynamic> route) => false);
        Navigator.pushNamed(context,'/');
      }, icon: Icon(Icons.person), label: Text("logout"))],),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: [
                GButton(
                  icon: LineIcons.car,
                  text: 'Vehicles',
                ),
                GButton(
                  icon: LineIcons.plus,
                  text: 'Add Vehicle',
                ),
                GButton(
                  icon: LineIcons.file,
                  text: 'Theft',
                ),
                GButton(
                  icon: LineIcons.user,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
