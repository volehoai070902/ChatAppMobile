import 'dart:async';

import 'package:chatapp/feature/authentication/models/auth_result.dart';
import 'package:chatapp/feature/authentication/view_models/notifiers/auth_change_notifier.dart';
import 'package:chatapp/feature/listfriend/views/list_friend.dart';
import 'package:chatapp/widgets/custom_textfield.dart';
import 'package:chatapp/widgets/password_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignIn extends StatelessWidget {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passTextController = TextEditingController();
  StreamController<bool> loginStreamController = StreamController();

  Future sleep() {
  return Future.delayed(const Duration(seconds: 1), () => "0.1");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final isLoading = context.watch<AuthChangeNotifier>().authState.isLoading;
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Center(
                child: Text(
                  "Login to Chatbox",
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: Colors.black),
                ),
              ),
              Center(
                child: Text(
                  "Welcom back! Sign in using",
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: Colors.black),
                ),
              ),
              Center(
                child: Text(
                  "your email to continue with us",
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: Colors.black),
                ),
              ),
              Expanded(
                  child: Image(
                image: AssetImage("assets/images/logo.png"),
                height: size.height / 3,
                width: size.width,
              )),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      controller: emailTextController,
                      hintText: "Email",
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Column(
                  children: [
                    PasswordFielddWidget(
                      passTextController: passTextController,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),

              Expanded(
                  child: StreamBuilder<bool>(
                      stream: loginStreamController.stream,
                      builder: (context, snapshot) {
                        final authProvider = Provider.of<AuthChangeNotifier>(context);
                        bool check = snapshot.data ?? false;
                        passTextController.addListener(() {
                          if (emailTextController.text != "" &&
                              passTextController.text != "") {
                            loginStreamController.add(true);
                          } else {
                            loginStreamController.add(false);
                          }
                        });

                        emailTextController.addListener(() {
                          if (emailTextController.text != "" &&
                              passTextController.text != "") {
                            loginStreamController.add(true);
                          } else {
                            loginStreamController.add(false);
                          }
                        });
                        return Align(
                          alignment: Alignment.topCenter,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size(size.width / 1, 40),
                                backgroundColor: Color(0xFF24786D),
                                foregroundColor: Colors.white,
                                textStyle:
                                    Theme.of(context).textTheme.labelMedium),
                            onPressed: check
                                ? () async{
                                    FocusScopeNode currentFocus =
                                        FocusScope.of(context);

                                    if (!currentFocus.hasPrimaryFocus) {
                                      currentFocus.unfocus();
                                    }


                                    await authProvider.signInWithPassword(email: emailTextController.text, password: passTextController.text);
                                    final result = context.read<AuthChangeNotifier>().authState.result;

                                    if (context.mounted && result == AuthResult.success){
                                      Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return ListFriendPage();
                                        },
                                      ),
                                      (route) => false,
                                    );
                                    }else{
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.read<AuthChangeNotifier>().exceptionMessage!)));
                                    }
                                    
                                  }
                                : null,
                            child: isLoading ? CircularProgressIndicator() : Text("Log in"),
                          ),
                        );
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
