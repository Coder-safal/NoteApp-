import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:noteapp_sec/classes/status_check.dart';

class ShowPopUp extends StatefulWidget {
  IconData? wrong;
  String? title1;
  String? subTitle;
  ShowPopUp({
    super.key,
    this.wrong,
    this.subTitle = "Are you want to add note!",
    this.title1 = "Sure!",
  });

  @override
  State<ShowPopUp> createState() => _InputFieldState();
}

class _InputFieldState extends State<ShowPopUp> {
  @override
  Widget build(BuildContext context) {
    print("${widget.wrong} wrong symbols");
    return AlertDialog(
      actions: [
        IconButton(
          onPressed: () {
            StatusCheck.isSubbmitted = false;
            StatusCheck.isUpdated = false;

            Navigator.pop(context);
          },
          icon: Icon(
            widget.wrong,
            size: 30,
            color: Colors.red,
          ),
        ),
        IconButton(
            onPressed: () {
              // widget.isSubmitted = false;
              StatusCheck.isSubbmitted = true;
              StatusCheck.isUpdated = true;
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.check,
              size: 35,
              color: Colors.green,
            ))
      ],
      title: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text("${widget.title1.toString()}"),
      ),
      content: Padding(
        padding: const EdgeInsets.only(left: 19.0),
        child: Text("${widget.subTitle.toString()}"),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
    );
  }
}
