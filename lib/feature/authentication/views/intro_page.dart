import 'package:chatapp/feature/authentication/views/sign_in.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/Ellipse.png"),
                alignment: Alignment.topRight)),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: size.height / 15),
              height: 56,
              child: ListTile(
                title: Center(
                    child: Text(
                  "Chatbox",
                  style: Theme.of(context).textTheme.titleSmall,
                )),
              ),
            ),
            Container(
                width: size.width,
                margin: EdgeInsets.only(
                  top: 30,
                ),
                height: size.height/2.3,
                padding: EdgeInsets.only(left: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Connect friends",
                        style: TextStyle(
                            height: 1.2,
                            fontSize: 70,
                            fontWeight: FontWeight.bold)),
                    Text(
                      "easily & quickly",
                      style: TextStyle(
                          height: 1.2,
                          fontSize: 70,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
            
            Container(
              margin: EdgeInsets.only(
                top: 10,
              ),
              padding: EdgeInsets.only(left: 24),
              child: Text(
                  "Our chat app is the perfect way to stay connected with friends and family."),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          shape: BoxShape.circle),
                      child: IconButton(
                          onPressed: () {},
                          icon: Image(
                            image: AssetImage("assets/images/google.png"),
                            height: 32,
                            width: 32,
                          ))),
                  Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          shape: BoxShape.circle),
                      child: IconButton(
                          onPressed: () {},
                          icon: Image(
                            image: AssetImage("assets/images/facebook.png"),
                            height: 32,
                            width: 32,
                          ))),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: size.width/1.2,
              child: Row(children: <Widget>[
                Expanded(child: Divider(
                  color: Colors.grey.shade200,
                )),
                SizedBox(
                  width: 5,
                ),
                Text("OR"),
                SizedBox(
                  width: 5,
                ),
                Expanded(child: Divider(
                  color: Colors.grey.shade200,
                )),
              ]),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: size.width / 1.2,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black
                ),
                onPressed: (){},
                child: Text("SIGN UP WITH MAIL", style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold
                ),),
              ),
            ),

            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Exist account? "),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder:(context) {
                          return SignIn();
                        },));
                      },
                      child: Text(
                        "Login",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
