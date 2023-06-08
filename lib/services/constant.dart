import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:html/parser.dart';

extension CapExtension on String {
  String get inCaps =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';
  String get capitalizeFirstOfEach => replaceAll(RegExp(' +'), ' ')
      .split(" ")
      .map((str) => str.inCaps)
      .join(" ");
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

Route getMaterialRoute({required Widget child, bool fullscreenDialog = false}) {
  return MaterialPageRoute(
    fullscreenDialog: fullscreenDialog,
    builder: (BuildContext context) {
      return child;
    },
  );
}

///Route End

///URL Launcher Start

String getWhatsAppUrl(String number, [String msg = '']) {
  return 'https://wa.me/91$number?text=$msg';
}

String getCallUrl(String number) {
  return "tel:+91$number";
}

String getMailUrl(String email, [String subject = '']) {
  try {
    Uri emailLaunchUri = Uri(
        scheme: 'mailto', path: email, queryParameters: {'subject': subject});
    return emailLaunchUri.toString().replaceAll('+', ' ');
  } catch (e) {
    log("$e", name: "getMailUrl");
    return '';
  }
}

Future<void> launchInBrowser(String url) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    );
  } else {
    Fluttertoast.showToast(msg: 'Invalid url {$url}');
    log('Could not launch $url');
  }
}

Future<void> launchWebsite(String url) async {
  if (!(url.startsWith('http'))) {
    if (!(url.startsWith('https://'))) {
      url = 'https://$url';
    }
  }
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      // headers: <String, String>{'my_header_key': 'my_header_value'},
    );
  } else {
    log('Could not launch $url');
  }
}

///URL Launcher End

///String Operation Start

String getInitials(String data) {
  String toReturn = '';
  toReturn = data.contains(' ')
      ? data.split(' ')[0][0] + data.split(' ')[1][0]
      : data[0];
  return toReturn.toUpperCase();
}

String getStringFromList(var data) {
  String toReturn = '';
  if (data.length > 1) {
    for (var element in data) {
      toReturn += element.name + ', ';
    }

    // log(toReturn);
    toReturn = toReturn.substring(0, toReturn.length - 2);
    // log(toReturn);
  } else {
    toReturn = data.first.name;
  }

  return toReturn;
}

bool isStringValid(String? data) {
  return data != null && data.isNotEmpty;
}

///String Operation End

///Date Operation Start

class DateFormatters {
  DateFormat yMD = DateFormat('yyyy-MM-dd');
  DateFormat mD = DateFormat('MM-dd');
  DateFormat hMA = DateFormat('hh:mm a');
  DateFormat dMy = DateFormat('dd MMM yyyy');
  DateFormat dMyDash = DateFormat('dd-MM-yyyy');
  DateFormat dMonthYear = DateFormat('dd MMMMM yyyy');
  DateFormat dateTime = DateFormat('dd MMM yyyy, hh:mm a');
  DateFormat dayDate = DateFormat('EEE,  dd MMM yyyy');
  DateFormat day = DateFormat('EEE');
  DateFormat month = DateFormat('MMMM');
  DateFormat date = DateFormat('dd');
}

bool compareDates({required DateTime one, required DateTime two}) {
  return DateFormatters().dMy.format(one) == DateFormatters().dMy.format(two);
}

///Date Operation End

class PriceConverter {
  convert(price) {
    return '₹ ${double.parse('$price').toStringAsFixed(2)}';
  }

  convertRound(price) {
    return '₹ ${double.parse('$price').toInt()}';
  }
}

class MySeparator extends StatelessWidget {
  const MySeparator(
      {Key? key, this.height = 1, this.color = Colors.black, this.dashWidthget})
      : super(key: key);
  final double height;
  final Color color;
  // ignore: prefer_typing_uninitialized_variables
  final dashWidthget;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = dashWidthget ?? 10.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}

class AppConstants {
  // static String baseUrl = '';

  static const String setPassCode = "setPasscode";
  static const String saveQa = "saveQa";

  static const String appName = 'AppLock';
  static const int appVersion = 9;

  // Shared Key
  static const String theme = 'theme';
  static const String token = 'user_app_token';
  static const String userId = 'user_app_id';
  static const String lockedApps = 'lockedApps';

  String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;
    return parsedString;
  }
}

class MyFont {
  title({
    double fontsize = 18,
    FontWeight fontweight = FontWeight.w700,
    double? latterSpace,
    Color? color,
  }) {
    return GoogleFonts.epilogue(
      textStyle: TextStyle(
        color: color ?? Colors.black.withOpacity(0.90),
        //height: 1,
        fontSize: fontsize,
        letterSpacing: latterSpace,
        //fontFamily: "Montserrat",
        fontWeight: fontweight,
      ),
    );
  }

  TextStyle subtitle(
      {double fontsize = 16,
      FontWeight fontweight = FontWeight.w700,
      double? latterSpace,
      Color? color}) {
    return GoogleFonts.epilogue(
      textStyle: TextStyle(
        color: color ?? Colors.white.withOpacity(0.90),
        //height: 1,
        fontSize: fontsize,
        letterSpacing: latterSpace,
        //fontFamily: "Montserrat",
        fontWeight: fontweight,
      ),
    );
  }

  TextStyle normaltext(
      {double fontsize = 14,
      FontWeight fontweight = FontWeight.w400,
      double? latterSpace,
      Color? color}) {
    return GoogleFonts.epilogue(
      textStyle: TextStyle(
        color: color ?? Colors.white.withOpacity(0.90),
        //height: 1,
        fontSize: fontsize,
        letterSpacing: latterSpace,
        //fontFamily: "Montserrat",
        fontWeight: fontweight,
      ),
    );
  }
}
