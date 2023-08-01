// ignore_for_file: deprecated_member_use, unnecessary_null_comparison, avoid_print, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class _ChatHomeState extends State<ChatHome> {
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15), // Set the border radius for rounded edges
                child: TextField(
                  controller: _textController,
                  onSubmitted: _handleSubmitted,
                  decoration: const InputDecoration.collapsed(
                    hintText: "Mensaje ..",
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 4.0),
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () => _handleSubmitted(_textController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void handleResponse(String query) async {
    String responseText;
    if (query.contains('Hola')) {
      responseText = 'Buenas soy PozoBot, ¿En qué le puedo ayudar?';
    } else if (query.contains('Mbateko')) {
      responseText = 'Mbateko, che ha´e PozoBot, mba´éichapa ikatu roipytyvõ?';
    } else if (query.contains('mbaeteko')) {
      responseText = 'Mbateko, che ha´e PozoBot, mba´éichapa ikatu roipytyvõ?';
    } else if (query.contains('hola')) {
      responseText = 'Buenas soy PozoBot, ¿En qué le puedo ayudar?';
      } else if (query.contains('buen dia')) {
      responseText = 'Buenas soy PozoBot, ¿En qué le puedo ayudar?';
      } else if (query.contains('Buen dia')) {
      responseText = 'Buenas soy PozoBot, ¿En qué le puedo ayudar?';
      } else if (query.contains('buen día')) {
      responseText = 'Buenas soy PozoBot, ¿En qué le puedo ayudar?';
      } else if (query.contains('Buen día')) {
      responseText = 'Buenas soy PozoBot, ¿En qué le puedo ayudar?';
      } else if (query.contains('buenas')) {
      responseText = 'Buenas soy PozoBot, ¿En qué le puedo ayudar?';
      } else if (query.contains('Buenas')) {
      responseText = 'Buenas soy PozoBot, ¿En qué le puedo ayudar?';
      } else if (query.contains('buenas tardes')) {
      responseText = 'Buenas soy PozoBot, ¿En qué le puedo ayudar?';
      } else if (query.contains('Buenas tardes')) {
      responseText = 'Buenas soy PozoBot, ¿En qué le puedo ayudar?';
      } else if (query.contains('buenas noches')) {
      responseText = 'Buenas soy PozoBot, ¿En qué le puedo ayudar?';
      } else if (query.contains('Buenas noches')) {
      responseText = 'Buenas soy PozoBot, ¿En qué le puedo ayudar?';
    } else if (query.contains('precio')) {
      responseText = 'Tenemos distintos precios dependiendo de la planta que desee';
      } else if (query.contains('Precio')) {
      responseText = 'Tenemos distintos precios dependiendo de la planta que desee';
      } else if (query.contains('precio?')) {
      responseText = 'Tenemos distintos precios dependiendo de la planta que desee';
      } else if (query.contains('Precio?')) {
      responseText = 'Tenemos distintos precios dependiendo de la planta que desee';
      } else if (query.contains('delivery')) {
      responseText = 'Actualmente no contamos con delivery';
      } else if (query.contains('delivery?')) {
      responseText = 'Actualmente no contamos con delivery';
      } else if (query.contains('Delivery')) {
      responseText = 'Actualmente no contamos con delivery';
      } else if (query.contains('Delivery?')) {
      responseText = 'Actualmente no contamos con delivery';
      } else if (query.contains('hacen delivery')) {
      responseText = 'Actualmente no contamos con delivery';
      } else if (query.contains('Hacen delivery')) {
      responseText = 'Actualmente no contamos con delivery';
      } else if (query.contains('hacen delivery?')) {
      responseText = 'Actualmente no contamos con delivery';
      } else if (query.contains('Hacen delivery?')) {
      responseText = 'Actualmente no contamos con delivery';
      } else if (query.contains('tienen delivery')) {
      responseText = 'Actualmente no contamos con delivery';
      } else if (query.contains('Tienen delivery')) {
      responseText = 'Actualmente no contamos con delivery';
      } else if (query.contains('tienen delivery?')) {
      responseText = 'Actualmente no contamos con delivery';
      } else if (query.contains('Tienen delivery?')) {
      responseText = 'Actualmente no contamos con delivery';
      } else if (query.contains('horario')) {
      responseText = 'Lunes a Sábado de 07 a 21hs';
      } else if (query.contains('Horario')) {
      responseText = 'Lunes a Sábado de 07 a 21hs';
      } else if (query.contains('horario de atencion')) {
      responseText = 'Lunes a Sábado de 07 a 21hs';
      } else if (query.contains('Horario de atencion')) {
      responseText = 'Lunes a Sábado de 07 a 21hs';
      } else if (query.contains('horario de atención')) {
      responseText = 'Lunes a Sábado de 07 a 21hs';
      } else if (query.contains('Horario de atención')) {
      responseText = 'Lunes a Sábado de 07 a 21hs';
      } else if (query.contains('horario de atencion al cliente')) {
      responseText = 'Lunes a Sábado de 07 a 21hs';
      } else if (query.contains('Horario de atencion al cliente')) {
      responseText = 'Lunes a Sábado de 07 a 21hs';
      } else if (query.contains('horarios de atencion al cliente')) {
      responseText = 'Lunes a Sábado de 07 a 21hs';
      } else if (query.contains('horarios de atención al cliente')) {
      responseText = 'Lunes a Sábado de 07 a 21hs';
      } else if (query.contains('Horarios de atencion al cliente')) {
      responseText = 'Lunes a Sábado de 07 a 21hs';
      } else if (query.contains('Horarios de atención al cliente')) {
      responseText = 'Lunes a Sábado de 07 a 21hs';
      } else if (query.contains('horarios')) {
      responseText = 'Lunes a Sábado de 07 a 21hs';
      } else if (query.contains('Horarios')) {
      responseText = 'Lunes a Sábado de 07 a 21hs';
    } else if (query.contains('Quiero comprar una planta')) {
      responseText = '¿Me indica qué tipo de planta quiere?';
    } else if (query.contains('ereko planta')) {
      responseText = 'Ikatúpa ere chéve mba´eichagua ka´avo reipotápa?';
      } else if (query.contains('plantas')) {
      responseText = 'Tenemos diversos tipos de plantas, puede utilizar el buscador para encontrar la que desea';
      } else if (query.contains('Plantas')) {
      responseText = 'Tenemos diversos tipos de plantas, puede utilizar el buscador para encontrar la que desea';
      } else if (query.contains('tipos de plantas')) {
      responseText = 'Tenemos diversos tipos de plantas, puede utilizar el buscador para encontrar la que desea';
      } else if (query.contains('Tipos de plantas')) {
      responseText = 'Tenemos diversos tipos de plantas, puede utilizar el buscador para encontrar la que desea';
      } else if (query.contains('Ubicación')) {
      responseText = 'Puedes encontrar la ubicación en el icono del GPS';
      } else if (query.contains('ubicación')) {
      responseText = 'Puedes encontrar la ubicación en el icono del GPS';
      } else if (query.contains('Ubicacion')) {
      responseText = 'Puedes encontrar la ubicación en el icono del GPS';
      } else if (query.contains('ubicacion')) {
      responseText = 'Puedes encontrar la ubicación en el icono del GPS';
      } else if (query.contains('numero')) {
      responseText = '0972141919';
      } else if (query.contains('Numero')) {
      responseText = '0972141919';
      } else if (query.contains('número')) {
      responseText = '0972141919';
      } else if (query.contains('Número')) {
      responseText = '0972141919';
      } else if (query.contains('numero de contacto')) {
      responseText = '0972141919';
      } else if (query.contains('Numero de contacto')) {
      responseText = '0972141919';
      } else if (query.contains('número de contacto')) {
      responseText = '0972141919';
      } else if (query.contains('Número de contacto')) {
      responseText = '0972141919';
      } else if (query.contains('gracias')) {
      responseText = 'A usted que tenga un Buen Día!😊';
      } else if (query.contains('Gracias')) {
      responseText = 'A usted que tenga un Buen Día!😊';
      } else if (query.contains('chau')) {
      responseText = 'A usted que tenga un Buen Día!😊';
      } else if (query.contains('Chau')) {
      responseText = 'A usted que tenga un Buen Día!😊';
      } else if (query.contains('Hasta la proxima')) {
      responseText = 'Igualmente que tenga un Buen Día!😊';
      } else if (query.contains('hasta la proxima')) {
      responseText = 'Igualmente que tenga un Buen Día!😊';
      } else if (query.contains('Hasta la próxima')) {
      responseText = 'Igualmente que tenga un Buen Día!😊';
      } else if (query.contains('hasta la próxima')) {
      responseText = 'Igualmente que tenga un Buen Día!😊';
     } else if (query.contains('WhatsApp')) {
      responseText = 'Sí, tenemos WhatsApp. Puedes contactarnos [aquí](https://wa.me/qr/CLGW7QJQT5MJK1).';
      // Obtener la URL del link
      String url = responseText.substring(responseText.indexOf('(') + 1, responseText.indexOf(')'));
      // Verificar si se puede lanzar la URL
      if (await canLaunch(url)) {
        // Lanzar la URL
        await launch(url);
      } else {
        // Mostrar un mensaje de error
        print('No se pudo lanzar $url');
      }
    }else if (query.contains('tienes whatsapp')) {
      responseText = 'Sí, tenemos WhatsApp. Puedes contactarnos [aquí](https://wa.me/qr/CLGW7QJQT5MJK1).';
      // Obtener la URL del link
      String url = responseText.substring(responseText.indexOf('(') + 1, responseText.indexOf(')'));
      // Verificar si se puede lanzar la URL
      if (await canLaunch(url)) {
        // Lanzar la URL
        await launch(url);
      } else {
        // Mostrar un mensaje de error
        print('No se pudo lanzar $url');
      }
      }else if (query.contains('Tienes whatsapp')) {
      responseText = 'Sí, tenemos WhatsApp. Puedes contactarnos [aquí](https://wa.me/qr/CLGW7QJQT5MJK1).';
      // Obtener la URL del link
      String url = responseText.substring(responseText.indexOf('(') + 1, responseText.indexOf(')'));
      // Verificar si se puede lanzar la URL
      if (await canLaunch(url)) {
        // Lanzar la URL
        await launch(url);
      } else {
        // Mostrar un mensaje de error
        print('No se pudo lanzar $url');
      }
      } 
       else if (query.contains('tenes whatsapp')) {
      responseText = 'Sí, tenemos WhatsApp. Puedes contactarnos [aquí](https://wa.me/qr/CLGW7QJQT5MJK1).';//Añádeme como contacto en WhatsApp. https://wa.me/qr/CLGW7QJQT5MJK1 
      // Obtener la URL del link
      String url = responseText.substring(responseText.indexOf('(') + 1, responseText.indexOf(')'));
      // Verificar si se puede lanzar la URL
      if (await canLaunch(url)) {
        // Lanzar la URL
        await launch(url);
      } else {
        // Mostrar un mensaje de error
        print('No se pudo lanzar $url');
      }
      } 
       else if (query.contains('Tenes whatsapp')) {
      responseText = 'Sí, tenemos WhatsApp. Puedes contactarnos [aquí](https://wa.me/qr/CLGW7QJQT5MJK1).';//Añádeme como contacto en WhatsApp. https://wa.me/qr/CLGW7QJQT5MJK1 
      // Obtener la URL del link
      String url = responseText.substring(responseText.indexOf('(') + 1, responseText.indexOf(')'));
      // Verificar si se puede lanzar la URL
      if (await canLaunch(url)) {
        // Lanzar la URL
        await launch(url);
      } else {
        // Mostrar un mensaje de error
        print('No se pudo lanzar $url');
      }
      } 
       else if (query.contains('Tenes whatsApp')) {
      responseText = 'Sí, tenemos WhatsApp. Puedes contactarnos [aquí](https://wa.me/qr/CLGW7QJQT5MJK1).';//Añádeme como contacto en WhatsApp. https://wa.me/qr/CLGW7QJQT5MJK1 
      // Obtener la URL del link
      String url = responseText.substring(responseText.indexOf('(') + 1, responseText.indexOf(')'));
      // Verificar si se puede lanzar la URL
      if (await canLaunch(url)) {
        // Lanzar la URL
        await launch(url);
      } else {
        // Mostrar un mensaje de error
        print('No se pudo lanzar $url');
      }
    } 
       else if (query.contains('whatsApp')) {
      responseText = 'Sí, tenemos WhatsApp. Puedes contactarnos [aquí](https://wa.me/qr/CLGW7QJQT5MJK1).';//Añádeme como contacto en WhatsApp. https://wa.me/qr/CLGW7QJQT5MJK1 
      // Obtener la URL del link
      String url = responseText.substring(responseText.indexOf('(') + 1, responseText.indexOf(')'));
      // Verificar si se puede lanzar la URL
      if (await canLaunch(url)) {
        // Lanzar la URL
        await launch(url);
      } else {
        // Mostrar un mensaje de error
        print('No se pudo lanzar $url');
      }
      } 
       else if (query.contains('WhatsApp')) {
      responseText = 'Sí, tenemos WhatsApp. Puedes contactarnos [aquí](https://wa.me/qr/CLGW7QJQT5MJK1).';//Añádeme como contacto en WhatsApp. https://wa.me/qr/CLGW7QJQT5MJK1 
      // Obtener la URL del link
      String url = responseText.substring(responseText.indexOf('(') + 1, responseText.indexOf(')'));
      // Verificar si se puede lanzar la URL
      if (await canLaunch(url)) {
        // Lanzar la URL
        await launch(url);
      } else {
        // Mostrar un mensaje de error
        print('No se pudo lanzar $url');
      }
    }
    else {
      responseText = 'Lo siento! 😕 Aún sigo aprendiendo. Si tienes alguna otra pregunta, no dudes en preguntar.';
    }

    ChatMessage message = ChatMessage(
      text: responseText,
      name: "PozoBot",
      type: false,
    );

    setState(() {
      _messages.insert(0, message);
    });
  }


  void _handleSubmitted(String text) {
    if (text == null || text.isEmpty) {
      return; // Skip processing if text is null or empty
    }
    _textController.clear();
    ChatMessage message = ChatMessage(
      text: text,
      name: "Usuario",
      type: true,
    );
    setState(() {
      _messages.insert(0, message);
    });
    handleResponse(text); // Call the updated handleResponse method
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Pozo Azul Consultas"),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            ),
          ),
          const Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  const ChatMessage({
    Key ? key,
    required this.text,
    required this.name,
    required this.type,
  }) : super(key: key);

  final String text;
  final String name;
  final bool type;

  List<Widget> otherMessage(BuildContext context) {
    return <Widget>[
      Container(
        margin: const EdgeInsets.only(right: 16.0),
        child: CircleAvatar(
          child: Image.asset('assets/icon/bot.png'),
        ),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.0),
              ),
              margin: const EdgeInsets.only(top: 5.0),
              padding: const EdgeInsets.all(10.0),
              child: Text(
                text,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> myMessage(BuildContext context) {
    return <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.green[300],
                borderRadius: BorderRadius.circular(10.0),
              ),
              margin: const EdgeInsets.only(top: 5.0),
              padding: const EdgeInsets.all(10.0),
              child: Text(
                text,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
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
          ),
        ),
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

class ChatHome extends StatefulWidget {
  @override
  _ChatHomeState createState() => _ChatHomeState();
}