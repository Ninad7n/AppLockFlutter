// ignore_for_file: file_names

import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:url_launcher/url_launcher.dart';

class ExtraMethods {
  String getWhatsAppUrl(String number, [String msg = '']) {
    return 'https://wa.me/91$number?text=$msg';
  }

  String getCallUrl(String number) {
    return "tel:+91$number";
  }

  String getMailUrl(String email, [String subject = '']) {
    try {
      Uri _emailLaunchUri = Uri(
          scheme: 'mailto', path: email, queryParameters: {'subject': subject});
      return _emailLaunchUri.toString().replaceAll('+', ' ');
    } catch (e) {
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
        url = 'https://' + url;
      }
    }
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        // headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {}
  }

  String getInitials(String data) {
    String toReturn = '';
    toReturn = data.contains(' ')
        ? data.split(' ')[0][0] + data.split(' ')[1][0]
        : data[0];
    return toReturn.toUpperCase();
  }
}
