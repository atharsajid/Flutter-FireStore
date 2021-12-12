import 'package:flutter/material.dart';
import 'package:google_sign_in/color.dart';

class MenuBtn extends StatefulWidget {
  const MenuBtn({Key? key}) : super(key: key);

  @override
  _MenuBtnState createState() => _MenuBtnState();
}

class _MenuBtnState extends State<MenuBtn> {
  List<bool> isselected = [true, false, false];
  final padding = const EdgeInsets.only(top: 15, left: 15);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: padding,
          child: ListTile(
            leading: Icon(
              Icons.task,
              color: primary,
            ),
            title: Text(
              "All Task",
              style: btntxt,
            ),
            onTap: () {
              setState(() {
                Navigator.pop(context);
              });
            },
          ),
        ),
        Padding(
          padding: padding,
          child: ListTile(
            leading: Icon(
              Icons.delete,
              color: primary,
            ),
            title: Text(
              "Recycle Bin",
              style: btntxt,
            ),
            onTap: () {},
          ),
        ),
        Padding(
          padding: padding,
          child: ListTile(
            leading: Icon(
              Icons.settings,
              color: primary,
            ),
            title: Text(
              "Setting",
              style: btntxt,
            ),
            onTap: () {},
          ),
        ),
      ],
    );
  }

  final btntxt = TextStyle(
    color: primary,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
}
