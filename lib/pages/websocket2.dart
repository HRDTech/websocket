import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

class WebSoketEje2 extends StatefulWidget {
  WebSocketChannel channel = IOWebSocketChannel.connect("ws://192.168.0.103:8000/chat");

  @override
  WebSoketEje2State createState() {
    return WebSoketEje2State();
  }
}

class WebSoketEje2State extends State<WebSoketEje2> {
  TextEditingController _controller = TextEditingController();
  List<String> listMsg = <String>[];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title:  Text("Web Socket"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                  Radius.circular(
                    5.0,
                  ),
                ),
              ),
              hintText: "Texto a enviar ...",
              filled: true,
              fillColor: Colors.white60,
              contentPadding: EdgeInsets.all(15.0),
                ),
              ),
            ),
            StreamBuilder(
              stream: widget.channel.stream,
              builder: (context, snapshot) {
                if (snapshot.data != null ){
                  var tmpData = jsonDecode(snapshot.data.toString());
                  listMsg.add(tmpData['data']);
                }
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(listMsg.toString().isNotEmpty ? listMsg.toString().replaceAll(",", "\n") : ""),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.send),
        onPressed: sendData,
      ),
    );
  }

  void sendData() {
    if (_controller.text.isNotEmpty) {
      String msg = jsonEncode({
        'action':'echo',
        'data':_controller.text
      });
      widget.channel.sink.add(msg);
    }
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }
}