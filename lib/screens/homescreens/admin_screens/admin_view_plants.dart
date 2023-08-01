//V_OK
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ViewPlantas extends StatefulWidget {
  const ViewPlantas({Key? key}) : super(key: key);

  @override
  _ViewPlantasState createState() => _ViewPlantasState();
}

class _ViewPlantasState extends State<ViewPlantas> {
  String? selectedCategory; // New variable to store the selected category

  // Método para borrar un documento de Firestore
  Future<void> _deleteProductos(String id) async {
    await FirebaseFirestore.instance.collection('productos').doc(id).delete();
    // ignore: use_build_context_synchronously
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text('Producto eliminado con éxito.'),
        actions: [
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list),
            onSelected: (value) {
              setState(() {
                selectedCategory = value; // Update the selected category
              });
            },
            itemBuilder: (context) {
              return ['Arboleda', 'Medicinal', 'Ornamentales', 'Otros']
                  .map((option) {
                return PopupMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('productos').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return CupertinoAlertDialog(
              title: const Text('No hay productos'),
              content: const Text(
                  'Por favor, agrega algunos productos a la colección.'),
              actions: [
                CupertinoDialogAction(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          } else {
            final filteredProducts = selectedCategory != null
                ? snapshot.data!.docs
                    .where((productos) =>
                        productos['categoria'] == selectedCategory)
                    .toList()
                : snapshot.data!.docs;

            return ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final productos = filteredProducts[index];
                final productosId = productos.id;
                final product = snapshot.data!.docs[index];
                return Card(
                  child: ListTile(
                    leading: Flexible(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Image.network(productos['imageUrl']),
                      ),
                    ),
                    title: AutoSizeText(productos['name']),
                    subtitle: AutoSizeText(productos['stock']),
                    trailing: Flexible( // Agregar este widget
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text('Gs ${productos['price'].toInt()}'),
                          ),
                          Flexible(
                            child: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _deleteProductos(productosId),
                            ),
                          ),
                          Flexible(
                            child: IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (contex)=> EditProductScreen(product:product),));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}