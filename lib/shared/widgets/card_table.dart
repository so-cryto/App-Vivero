// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CardTable extends StatelessWidget {
  const CardTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FractionallySizedBox(
              widthFactor: 0.9, // Ajuste este valor para controlar el ancho de la tabla
              child: Table(
                children: [
                  TableRow(
                    children: [
                      buildCard(
                        context,
                        'assets/icontable/icomedicinal.png',
                        'Medicinal',
                        '/irmedicinal',
                      ),
                      buildCard(
                        context,
                        'assets/icontable/icofloral.png',
                        'Ornamental',
                        '/irornamental',
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      buildCard(
                        context,
                        'assets/icontable/icotool.png',
                        'Otros',
                        '/irotros',
                      ),
                      buildCard(
                        context,
                        'assets/icontable/icoarbol.png',
                        'Árboles',
                        '/irarboles',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildCard(BuildContext context, String imagePath, String text, String route) {
    return InkWell(
      customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
      highlightColor: const Color.fromARGB(177, 34, 95, 61),
      borderRadius: BorderRadius.circular(30),
      splashColor: const Color.fromARGB(255, 61, 247, 138),
      onTap: () => context.push(route),
      child: Column(
        children: [
          Image(
            image: AssetImage(imagePath),
            width: 150,
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.green,
              shadows: [
                Shadow(offset: Offset(0, 0.5), blurRadius: 2, color: Colors.black54),
              ],
            ),
          ),
        ],
      ),
    );
  }
}