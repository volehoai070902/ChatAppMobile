import 'dart:async';

import 'package:chatapp/feature/chat/views/chat_views.dart';
import 'package:chatapp/feature/listfriend/views/list_friend.dart';
import 'package:chatapp/widgets/custom_textfield.dart';
import 'package:chatapp/widgets/password_textfield.dart';
import 'package:flutter/material.dart';

class SignIn extends StatelessWidget{
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passTextController = TextEditingController();
  StreamController<bool> loginStreamController = StreamController() ;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
      ),
      body: Container(
        child:Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              
              Center(
                child: Text("Login to Chatbox", style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Colors.black
                ),),
              ),
              Center(
                child: Text("Welcom back! Sign in using",style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Colors.black
                ),),
              ),
              Center(
                child: Text("your email to continue with us",style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Colors.black
                ),),
              ),
              Expanded(child: Image(image: AssetImage("assets/images/logo.png"), height: size.height / 3,width: size.width,)),
              SizedBox(
                height: 20,
              ),
              
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    CustomTextField(
                      emailTextController: emailTextController,
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
                    bool check = snapshot.data ?? false;
                    passTextController.addListener(() {
                      if (emailTextController.text != "" && passTextController.text != "") {
                        loginStreamController.add(true);
                      } else {
                        loginStreamController.add(false);
                      }
                    });
        
                    emailTextController.addListener(() {
                      if (emailTextController.text != "" && passTextController.text != "") {
                        loginStreamController.add(true);
                      } else {
                        loginStreamController.add(false);
                      }
                    });
                    return Align(
                      alignment: Alignment.topCenter,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(size.width / 1,40),
                          backgroundColor: Color(0xFF24786D),
                          foregroundColor: Colors.white,
                          textStyle: Theme.of(context).textTheme.labelMedium
                        ),
                        onPressed: check ? (){
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {
                            return ListFriendPage();
                          },), (route) => false);
                        }:null,
                        child: Text("Log in"),
                      ),
                    );
                  }
                ))
            ],
          ),
        ),
      ),
    );
  }
}