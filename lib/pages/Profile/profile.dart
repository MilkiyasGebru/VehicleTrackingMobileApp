import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_card/widgets/profile_list_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/src/screen_util.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'constants.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: ScreenUtil.defaultSize);

    var profileInfo = Expanded(
      child: Column(
        children: <Widget>[
          Container(
            height: 100,
            width: 100,
            margin: EdgeInsets.only(top: 30),
            child: Stack(
              children: <Widget>[
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/avatar.png'),
                ),

              ],
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Nicolas Adams',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),

          SizedBox(height: 20),


        ],
      ),
    );



    var header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: 30),

        profileInfo,
        // themeSwitcher,
        SizedBox(width: 30),
      ],
    );

    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 50),
          header,
          Expanded(
            child: ListView(
              children: <Widget>[
                Container(
                  height: kSpacingUnit.w * 5.5,
                  margin: EdgeInsets.symmetric(
                    horizontal: kSpacingUnit.w * 4,
                  ).copyWith(
                    bottom: kSpacingUnit.w * 2,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: kSpacingUnit.w * 2,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kSpacingUnit.w * 3),
                    color: Theme.of(context).backgroundColor,
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        LineAwesomeIcons.mail_bulk,
                        size: kSpacingUnit.w * 2.5,
                      ),
                      SizedBox(width: kSpacingUnit.w * 1.5),
                      Text(
                        "Email",
                        style: kTitleTextStyle.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),

                      IconButton(
                        onPressed: (){
                          print("button presseed");
                        },
                        icon: Icon(
                          LineAwesomeIcons.angle_right,
                          size: kSpacingUnit.w * 2.5,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: kSpacingUnit.w * 5.5,
                  margin: EdgeInsets.symmetric(
                    horizontal: kSpacingUnit.w * 4,
                  ).copyWith(
                    bottom: kSpacingUnit.w * 2,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: kSpacingUnit.w * 2,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kSpacingUnit.w * 3),
                    color: Theme.of(context).backgroundColor,
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        LineAwesomeIcons.phone,
                        size: kSpacingUnit.w * 2.5,
                      ),
                      SizedBox(width: kSpacingUnit.w * 1.5),
                      Text(
                        "Phone number",
                        style: kTitleTextStyle.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),

                      IconButton(
                        onPressed: (){
                          print("button presseed");
                        },
                        icon: Icon(
                          LineAwesomeIcons.angle_right,
                          size: kSpacingUnit.w * 2.5,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: kSpacingUnit.w * 5.5,
                  margin: EdgeInsets.symmetric(
                    horizontal: kSpacingUnit.w * 4,
                  ).copyWith(
                    bottom: kSpacingUnit.w * 2,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: kSpacingUnit.w * 2,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kSpacingUnit.w * 3),
                    color: Theme.of(context).backgroundColor,
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        LineAwesomeIcons.key,
                        size: kSpacingUnit.w * 2.5,
                      ),
                      SizedBox(width: kSpacingUnit.w * 1.5),
                      Text(
                        "Change Password",
                        style: kTitleTextStyle.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),

                      IconButton(
                        onPressed: (){
                          print("button presseed");
                        },
                        icon: Icon(
                          LineAwesomeIcons.angle_right,
                          size: kSpacingUnit.w * 2.5,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: kSpacingUnit.w * 5.5,
                  margin: EdgeInsets.symmetric(
                    horizontal: kSpacingUnit.w * 4,
                  ).copyWith(
                    bottom: kSpacingUnit.w * 2,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: kSpacingUnit.w * 2,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kSpacingUnit.w * 3),
                    color: Theme.of(context).backgroundColor,
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        LineAwesomeIcons.alternate_sign_out,
                        size: kSpacingUnit.w * 2.5,
                      ),
                      SizedBox(width: kSpacingUnit.w * 1.5),
                      Text(
                        "Log out",
                        style: kTitleTextStyle.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),

                      IconButton(
                        onPressed: (){
                          print("button presseed");
                        },
                        icon: Icon(
                          LineAwesomeIcons.angle_right,
                          size: kSpacingUnit.w * 2.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );



  }
}