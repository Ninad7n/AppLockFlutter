import 'package:app_lock_flutter/executables/controllers/password_controller.dart';
import 'package:flutter/material.dart';
import 'package:app_lock_flutter/services/constant.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

class SetPasscode extends StatefulWidget {
  const SetPasscode({Key? key}) : super(key: key);

  @override
  State<SetPasscode> createState() => _SetPasscodeState();
}

class _SetPasscodeState extends State<SetPasscode> {
  @override
  void initState() {
    super.initState();
    Get.find<PasswordController>().clearData();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: SizedBox(
          height: 60,
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
              child: MaterialButton(
                color: Colors.transparent,
                elevation: 0,
                onPressed: () {
                  Get.find<PasswordController>().savePasscode();
                },
                child: GetBuilder<PasswordController>(
                  builder: (state) {
                    return Text(
                      state.isConfirm ? "Set Passcode" : "Save Passcode",
                      style: MyFont().subtitle(),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.keyboard_arrow_left,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Set Passcode",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 10,
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/appLogo.png',
                      height: 100,
                      width: 100,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: GetBuilder<PasswordController>(builder: (state) {
                  return Text(
                    state.isConfirm ? "Confirm Passcode" : "Set Passcode",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: Colors.white,
                        ),
                  );
                }),
              ),

              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < 6; i++)
                    GetBuilder<PasswordController>(builder: (state) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 2,
                        ),
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            state.passcode.length >= i + 1 ? "•" : "",
                            style: MyFont().normaltext(
                              fontsize: 28,
                              color: state.passcode.length >= i + 1
                                  ? Theme.of(context).primaryColor
                                  : Colors.black54,
                            ),
                          ),
                        ),
                      );
                    }),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              // keyboard buttons
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 25,
                ),
                child: GetBuilder<PasswordController>(builder: (state) {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 12,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 0.0,
                      childAspectRatio: 2,
                      mainAxisSpacing: 10.0,
                    ),
                    itemBuilder: (context, index) {
                      if (index == 9) {
                        return const SizedBox();
                      }
                      return GestureDetector(
                        onTap: () {
                          state.setPasscode(index);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).primaryColorDark,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              index != 11
                                  ? "${index == 10 ? 0 : index + 1}"
                                  : "<",
                              style: MyFont().subtitle(
                                color:
                                    index != 11 ? Colors.white : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
