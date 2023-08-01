// ignore_for_file: unused_import, library_private_types_in_public_api, non_constant_identifier_names

import 'package:dialogflow_flutter/dialogflowFlutter.dart';
import 'package:dialogflow_flutter/googleAuth.dart';
import 'package:dialogflow_flutter/language.dart';
import 'package:dialogflow_flutter/message.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _ChatScreenState createState() => _ChatScreenState();
}
class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = TextEditingController();
  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).primaryColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration:
                    const InputDecoration.collapsed(hintText: "Enviar Mensaje"),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => _handleSubmitted(_textController.text)),
            ),
          ],
        ),
      ),
    );
  }
Future<void> Response(String query) async {
  _textController.clear();
  AuthGoogle authGoogle = await AuthGoogle(fileJson: 'assets/pozobot-qtjt-0f5b6bfa5497.json').build();
  DialogFlow dialogflow = DialogFlow(authGoogle: authGoogle, language: Language.spanish);
  AIResponse response = await dialogflow.detectIntent(query); 
  String messageText = response.getMessage() ?? response.getListMessage()?.first?.title ?? "";
  ChatMessage message = ChatMessage(
    text: messageText,
    name: "PozoBot",
    type: false,
  );
  setState(() {
    _messages.insert(0, message);
  });
}
void _handleSubmitted(String text) async {
  _textController.clear();
  ChatMessage message = ChatMessage(
    text: text,
    name: "Usuario",
    type: true,
  );
  setState(() {
    _messages.insert(0, message);
  });
  await Response(text);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("PozoBot Chat"),
      ),
      body: Column(children: <Widget>[
        Flexible(
            child: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          reverse: true,
          itemBuilder: (_, int index) => _messages[index],
          itemCount: _messages.length,
        )),
        const Divider(height: 1.0),
        Container(
          decoration: BoxDecoration(color: Theme.of(context).cardColor),
          child: _buildTextComposer(),
        ),
      ]),
    );
  }
}
class ChatMessage extends StatelessWidget {
const ChatMessage({Key? key, required this.text, required this.name, required this.type}) : super(key: key);
  final String text;
  final String name;
  final bool type;
  List<Widget> otherMessage(context) {
    return <Widget>[
      Container(
        margin: const EdgeInsets.only(right: 16.0),
        child: const CircleAvatar(child: Text('B')),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(name,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: Text(text),
            ),
          ],
        ),
      ),
    ];
  }
  List<Widget> myMessage(context) {
    return <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(name, style: Theme.of(context).textTheme.titleSmall),
            Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: Text(text),
            ),
          ],
        ),
      ),
      Container(
        margin: const EdgeInsets.only(left: 16.0),
        child: CircleAvatar(
            child: Text(
          name[0],
          style: const TextStyle(fontWeight: FontWeight.bold),
        )),
      ),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: type ? myMessage(context) : otherMessage(context),
      ),
    );
  }
}

/*
// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  late DialogFlowtter _dialogFlowtter; // Declare _dialogFlowtter as late

  @override
  void initState() {
    super.initState();
    DialogFlowtter.fromFile().then((instance) {
      setState(() {
        _dialogFlowtter = instance;
      });
    });
  }

  List<Map<String, dynamic>> messages = [];

  void sendMessage(String text) async {
    if (text.isEmpty) return;

    setState(() {
      Message userMessage = Message(text: DialogText(text: [text]));
      messages.add({'message': userMessage, 'isUserMessage': true});
    });

    QueryInput query = QueryInput(text: TextInput(text: text));
    DetectIntentResponse res = await _dialogFlowtter.detectIntent(queryInput: query);

    if (res.message == null) return;

    setState(() {
      messages.add({'message': res.message, 'isUserMessage': false});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _MessagesList(messages: messages),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            color: Colors.green,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    controller: _controller,
                  ),
                ),
                IconButton(
                  color: Colors.white,
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    sendMessage(_controller.text);
                    _controller.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MessagesList extends StatelessWidget {
  final List<Map<String, dynamic>> messages;

  const _MessagesList({required this.messages});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: messages.length,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      separatorBuilder: (_, i) => const SizedBox(height: 10),
      itemBuilder: (context, i) {
        return _MessageContainer(
          message: messages[messages.length - 1 - i]['message'],
          isUserMessage: messages[messages.length - 1 - i]['isUserMessage'],
        );
      },
      reverse: true,
    );
  }
}

class _MessageContainer extends StatelessWidget {
  final Message message;
  final bool isUserMessage;

  const _MessageContainer({
    Key? key,
    required this.message,
    required this.isUserMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 250),
          child: Container(
            decoration: BoxDecoration(
              color: isUserMessage ? Colors.greenAccent : Colors.blueAccent,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(10),
            child: Text(
              message.text?.text?[0] ?? '',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
*/