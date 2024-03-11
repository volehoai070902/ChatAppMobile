import 'package:flutter/material.dart';

class TestChatFrame extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text("AppBar"),

      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Container(
          child: Column(
            //message chat
            children: [
              IconButton(onPressed: (){}, icon: Image(image: AssetImage("assets/images/google.png"))),
              Expanded(
                child: ListView.builder(
                  itemCount: 40,
                  reverse: true,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Center(child: Text("Hello",style: TextStyle(color: Colors.black),)),
                    );
                  },
                ) 
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: "input message",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}