import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final String? heading, bodyText, button1Text, button2Text;
  final Widget? headingWidget;
  final TextAlign? bodyTextAlign;
  final double? dialogHeight, okButton;
  final Color? headingColor,
      headingTextColor,
      bodyColor,
      bodyTextColor,
      button1Color,
      button1TextColor,
      button2Color,
      button2TextColor;

  const ConfirmationDialog(
      {Key? key,
      required this.heading,
      required this.bodyText,
      this.headingColor,
      this.headingTextColor,
      this.bodyColor,
      this.bodyTextColor,
      this.button1Color,
      this.button1TextColor,
      this.button2Color,
      this.button2TextColor,
      this.dialogHeight,
      this.okButton,
      this.headingWidget,
      this.bodyTextAlign,
      this.button1Text,
      this.button2Text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, false);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Center(
            child: SafeArea(
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    height: dialogHeight ?? size.height * 0.25,
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                      color: bodyTextColor ?? Theme.of(context).backgroundColor,
                    ),
                    child: Column(
                      children: [
                        headingWidget != null
                            ? headingWidget!
                            : Container(
                                height: size.height * 0.06,
                                width: double.maxFinite,
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                child: Center(
                                  child: Text(
                                    heading!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                  ),
                                ),
                              ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            bodyText!,
                            textAlign: bodyTextAlign ?? TextAlign.center,
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context, true);
                              },
                              child: Container(
                                width: 70,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: button1Color ?? Colors.transparent,
                                  border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Text(
                                    okButton == null
                                        ? button1Text ?? "No"
                                        : "Ok",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            if (okButton == null)
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context, true);
                                },
                                child: Container(
                                  width: 70,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: button2Color ??
                                        Theme.of(context).primaryColor,
                                    border: Border.all(
                                      color: Theme.of(context).hintColor,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                    child: Text(
                                      button2Text ?? "Yes",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
