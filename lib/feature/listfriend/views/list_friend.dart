import 'dart:async';

import 'package:chatapp/feature/authentication/models/user_model.dart';
import 'package:chatapp/feature/authentication/view_models/notifiers/auth_change_notifier.dart';
import 'package:chatapp/feature/authentication/views/intro_page.dart';
import 'package:chatapp/feature/authentication/views/sign_in.dart';
import 'package:chatapp/feature/chat/view_model/notifier/chat_notifier.dart';
import 'package:chatapp/feature/chat/views/chat_views.dart';
import 'package:chatapp/feature/listfriend/constants/categorys.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListFriendPage extends StatelessWidget {
  StreamController listFriendController = StreamController();

  List<Widget> _widgetOptions = <Widget>[
    ListFriend(),
    Center(
      child: Text(
        "Hello",
        style: TextStyle(color: Colors.amber),
      ),
    ),
    Center(
      child: Text(
        "Troi oi la troi",
        style: TextStyle(color: Colors.amber),
      ),
    ),
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> categoryList = [];
    print("Change page");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return ChatPage();
                  },
                ));
              },
              icon: Icon(Icons.search)),
          IconButton(
              onPressed: () async {
                final authProvider =
                    Provider.of<AuthChangeNotifier>(context, listen: false);
                await authProvider.logOut();
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return MainPage();
                  },
                ));
              },
              icon: Icon(Icons.output)),
        ],
        backgroundColor: Colors.transparent,
        title: ListTile(
          title: Text(
            "Hello,",
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: Colors.grey.shade300),
          ),
          subtitle: Text(
            Provider.of<AuthChangeNotifier>(context).displayName!,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => Padding(
          padding: EdgeInsets.all(8),
          child: Container(
            child: Column(
              children: [
                Container(
                  height: 40,
                  width: constraints.maxWidth / 1.2,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: GetCategoryList(
                      categoryList: categoryList,
                      selectedIndex: selectedIndex,
                      listFriendController: listFriendController),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: StreamBuilder(
                    initialData: selectedIndex,
                    stream: listFriendController.stream,
                    builder: (context, snapshot) {
                      return _widgetOptions[snapshot.data];
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GetCategoryList extends StatefulWidget {
  GetCategoryList(
      {super.key,
      this.textColor,
      required this.selectedIndex,
      this.onTap,
      required this.listFriendController,
      required this.categoryList});

  StreamController listFriendController;
  Color? textColor;
  int selectedIndex;
  List<Widget> categoryList;
  Function()? onTap;
  @override
  State<GetCategoryList> createState() => _GetCategoryListState();
}

class _GetCategoryListState extends State<GetCategoryList> {
  List<Widget> getListCategory() {
    widget.categoryList = [];
    for (int i = 0; i < categoryMainPage.length; i++) {
      Color backgroundColorButton;
      if (i == widget.selectedIndex) {
        backgroundColorButton = Color(0xFF584CD7);
      } else {
        backgroundColorButton = Colors.grey.shade100;
      }

      widget.categoryList.add(CustomeCategory(
        onTap: () {
          setState(() {
            widget.selectedIndex = i;
            widget.categoryList = [];
            widget.listFriendController.add(i);
          });
        },
        listFriendController: widget.listFriendController,
        backgroundColorButton: backgroundColorButton,
        title: categoryMainPage[i],
        index: i,
        textColor: widget.selectedIndex == i ? Colors.white : Colors.black,
      ));
    }
    return widget.categoryList;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: getListCategory(),
    );
  }
}

class ListFriend extends StatefulWidget {
  const ListFriend({
    super.key,
  });

  @override
  State<ListFriend> createState() => _ListFriendState();
}

class _ListFriendState extends State<ListFriend> {
  late ChatNotifier chatNotifier;

  @override
  void initState() {
    super.initState();
    chatNotifier = Provider.of(context, listen: false);
    Future.delayed(const Duration(milliseconds: 10), () {
      chatNotifier.getUsers();
    });
  }

  @override
  Widget build(BuildContext context){
    print("Rebuild");
    return Consumer<ChatNotifier>(builder: (context, value, child) {
      return Container(
        child: Expanded(
          child: StreamBuilder<List<UserModel>>(
            stream: value.getUsers(),
            builder: (context, snapshot) {
              final users = snapshot.data;
              return Container(
                child: ListView.builder(
                  itemCount: users?.length ?? 0,
                  itemBuilder: (context, index) {
                    UserModel? user = users?[index];
                    return Container(
                      child: ListTile(
                        onLongPress: () {},
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return ChatPage();
                            },
                          ));
                        },
                        leading:
                            Image(image: AssetImage("assets/images/gamer.png")),
                        title: Text(
                          user?.username ?? "",
             
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        subtitle: Text(
                          "Anh Khan",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade300),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          ),
        ),
      );
    });
  }
}

class CustomeCategory extends StatelessWidget {
  CustomeCategory(
      {super.key,
      required this.backgroundColorButton,
      required this.title,
      this.textColor,
      required this.index,
      this.onTap,
      required this.listFriendController});
  StreamController listFriendController;
  Color backgroundColorButton;
  Color? textColor;
  String title;
  int index;
  Function()? onTap;

  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: backgroundColorButton,
        ),
        child: GestureDetector(
          onTap: onTap,
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: textColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
