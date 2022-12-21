import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:app_lock_flutter/services/constant.dart';

class CustomDialogs extends StatefulWidget {
  final String? title, descriptions, buttonLabel;
  final Function onTap;

  const CustomDialogs(
      {Key? key,
      this.title,
      this.descriptions,
      this.buttonLabel,
      required this.onTap})
      : super(key: key);

  @override
  _CustomDialogsState createState() => _CustomDialogsState();
}

class _CustomDialogsState extends State<CustomDialogs> {
  @override
  void initState() {
    super.initState();
    log("dialogue run");
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(
            left: Constants.padding,
            top: Constants.padding,
            right: Constants.padding,
            bottom: Constants.padding,
          ),
          // margin: const EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(Constants.padding),
            // ignore: prefer_const_literals_to_create_immutables
            // boxShadow: [
            //   const BoxShadow(
            //       color: Colors.black, offset: Offset(0, 5), blurRadius: 5),
            // ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.title!,
                style: MyFont().title(color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.descriptions!,
                style: MyFont().normaltext(color: Colors.black),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(110, 38),
                      elevation: 0,
                      primary: Colors.grey[300],
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  // const SizedBox(
                  //   width: 10,
                  // ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(110, 38),
                      elevation: 0,
                      primary: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      widget.onTap();
                    },
                    child: Text(
                      widget.buttonLabel!,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Constants {
  Constants._();
  static const double padding = 20;
  static const double avatarRadius = 45;
}
