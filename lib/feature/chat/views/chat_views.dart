import 'dart:async';

import 'package:chatapp/feature/chat/model/chat_message_model.dart';
import 'package:chatapp/feature/chat/view_model/notifier/chat_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// final listMessage = [
//   {
//     "id":123,
//     "message": 331
//   },
//   {
//     "id":123,
//     "message": 332
//   },
//   {
//     "id":123,
//     "message": 333
//   },
//   {
//     "id":123,
//     "message": 334
//   }
// ];

List<Map<String,Object>> listMessage = [
  {"id": 331, "home": 123, "away": 234, "message": "chao ban"},
  {"id": 332, "home": 234, "away": 123, "message": "chao ban"},
  {"id": 333, "home": 123, "away": 234, "message": "ban khoe khong"},
  {
    "id": 334,
    "home": 234,
    "away": 123,
    "message": "toi khoe! cam on sssssssssssssssssssssssssssssssssssssssssss"
  },
  {"id": 333, "home": 123, "away": 234, "message": "ban khoe khong"},
  {"id": 333, "home": 123, "away": 234, "message": "ban khoe khong"},
  {"id": 333, "home": 123, "away": 234, "message": "ban khoe khong"},
  {"id": 333, "home": 123, "away": 234, "message": "ban khoe khong"},
];

class ChatPage extends StatelessWidget {
  StreamController<List<Map<String,Object>>> chatBoxController = StreamController<List<Map<String,Object>>>();
  ScrollController scrollController = ScrollController();
  String? senderId;
  String? receiverId;
  List<Map<String, dynamic>> messageList = [];
  String? displayName;
  late SupabaseStreamFilterBuilder listMessageStream;
  ChatPage({
    required this.senderId,
    required this.receiverId,
    required this.displayName
  });
  
  Widget build(BuildContext context) {

    chatBoxController.add(listMessage);
    listMessageStream = context.read<ChatNotifier>().listenMessage(senderId!);
    // listMessageStream.forEach((element) {
    //   element.forEach((element) {print(element['id']);});
    // });
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(35))),
          child: Column(
            children: [
              Container(
                height: 80,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: const BoxDecoration(color: Colors.white),
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Color(0xFF584CD7),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(35))),
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            height: 80,
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 50,
                                child: Image(image: AssetImage("assets/images/gamer.png"),)),
                              title: Text(displayName!, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration:
                            const BoxDecoration(color: Color(0xFF584CD7)),
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(35))),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: listMessageStream,
                  builder: (context, snapshot) {
                    var data = snapshot.data;

                    data = data?.where((element) {
                      if (element["senderid"].toString().trim() == senderId?.trim() && receiverId?.trim() == element["receiverid"].toString().trim()){
                        return true;
                      }
                      if (element["receiverid"].toString().trim() == senderId?.trim() && receiverId?.trim() == element["senderid"].toString().trim()){
                        return true;
                      }
                        return false;
                    }).toList();

                    data?.sort((a, b) => DateTime.parse(b["created_at"]).compareTo(DateTime.parse(a["created_at"])));

                    return Container(
                      padding: EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Color(0xFF584CD7),
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(35)),
                      ),
                      child: ListView.builder(
                        reverse: true,
                        itemCount: data?.length ?? 0,
                        controller: scrollController,
                        itemBuilder: (context, index) {
                          
                          return Align(
                            alignment: (data?[index]["senderid"].toString().trim() == senderId)
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth: constraints.maxWidth * 0.66,
                              ),
                              padding: const EdgeInsets.all(10.0),
                              margin: const EdgeInsets.symmetric(vertical: 5.0),
                              decoration: BoxDecoration(
                                color: (data?[index]["senderid"].toString().trim() == senderId)
                                    ? Colors.white
                                    : Color.fromARGB(255, 123, 112, 240),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Text(
                                "${data?[index]["message"]}",
                                style: (data?[index]["senderid"].toString().trim() == senderId)
                                    ? Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: Color(0xFF584cd7))
                                    : Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: Colors.white),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                ),
              ),
              buildMessageInputBox(
                scrollController: scrollController,
                chatBoxController: chatBoxController,
                senderId: senderId,
                receiverId: receiverId,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class buildMessageInputBox extends StatelessWidget {
  ScrollController scrollController;
  TextEditingController chatController = TextEditingController();
  StreamController<List<Map<String,Object>>> chatBoxController;
  String? senderId;
  String? receiverId;
  buildMessageInputBox({
    super.key,
    required this.scrollController,
    required this.chatBoxController,
    this.receiverId,
    this.senderId
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(color: Color(0xFF584CD7)),
      child: Row(
        children: [
          Expanded(
              flex: 8,
              child: Container(
                margin: EdgeInsets.only(
                  left: 10
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white),
                child: TextField( 
                  controller: chatController, 
                  style: TextStyle(color: Colors.black, fontSize: 15),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    hintText: "Message",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none),
                  ),
                ),
              )),
          Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    backgroundColor: Colors.white,
                    elevation: 0
                  ),
                  onPressed: ()async{
                    listMessage.add(
                      {"id": 333, "home": 123, "away": 234, "message": chatController.text},
                    );
                    scrollController.animateTo(scrollController.position.minScrollExtent, duration: Duration(milliseconds: 200), curve: Curves.easeIn);
                    chatBoxController.add(listMessage);
                    
                    context.read<ChatNotifier>().sendMessage(
                      {
                        "senderid": senderId?.trim(),
                        "receiverid": receiverId?.trim(),
                        "message":chatController.text,
                        "created_at":DateTime.now().toIso8601String(),
                        "updated_at":DateTime.now().toIso8601String()
                      }
                    );

                    chatController.clear();
                  },
                  child: Icon(Icons.send),
                ),
              ))
        ],
      ),
    );
  }
}
