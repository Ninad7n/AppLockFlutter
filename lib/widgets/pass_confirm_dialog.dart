import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/state_manager.dart';
import 'package:app_lock_flutter/executables/controllers/apps_controller.dart';

import '../services/constant.dart';

Future showComfirmPasswordDialog(context) async {
  return await showGeneralDialog(
    barrierColor: Colors.black.withOpacity(0.8),
    context: context,
    barrierDismissible: false,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (context, animation1, animation2) {
      return const PasswordCorfirmDialog();
    },
  );
}

class PasswordCorfirmDialog extends StatelessWidget {
  const PasswordCorfirmDialog({Key? key}) : super(key: key);

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
          child: Container(
            width: size.width * 0.8,
            height: size.height * 0.2,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Confirm Password",
                        style: MyFont().normaltext(
                          color: Colors.white,
                          fontweight: FontWeight.w600,
                          fontsize: 16,
                        ),
                      ),
                      GetBuilder<AppsController>(builder: (state) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Theme.of(context).primaryColorLight,
                            ),
                          ),
                          child: TextField(
                            obscureText: true,
                            autofocus: true,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(color: Colors.white),
                            onChanged: (value) {
                              Fluttertoast.cancel();
                              if (value.length == 6 &&
                                  value == state.getPasscode()) {
                                if (Navigator.canPop(context)) {
                                  Navigator.pop(context, true);
                                }
                              } else if (value.length == 6) {
                                Fluttertoast.showToast(msg: "Invalid password");
                              }
                            },
                            keyboardType: TextInputType.phone,
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(6),
                            ],
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 15,
                              ),
                              // labelText: 'Enter Passcode...',
                              hintText: 'Enter Passcode...',
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(color: Colors.white),
                              isCollapsed: true,
                              filled: true,
                              fillColor: Colors.transparent,
                              border: InputBorder.none,
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Theme.of(context).primaryColorLight,
                        ),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        icon: const Icon(
                          Icons.clear,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
