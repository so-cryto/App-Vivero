//CatOrnaScreen

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:productos_app/shared/widgets/widgets.dart';

class CatOrnaScreen extends StatefulWidget {
  const CatOrnaScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CatOrnaScreenState createState() => _CatOrnaScreenState();
}

class _CatOrnaScreenState extends State<CatOrnaScreen> {
  // ignore: prefer_final_fields
  String _text = 'Ornamentales';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ornamentales'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('productos')
                  .where('categoria', isGreaterThanOrEqualTo: _text)
                  .where('categoria', isLessThanOrEqualTo: '$_text\uf8ff')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.data!.docs.isEmpty) {
                  return CupertinoAlertDialog(
                    title: const Text('Lo Sentimos'),
                    content: const Text('Actualmente no contamos con este productos disponible'),
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
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns
                      childAspectRatio: 0.8, // Adjust this value to change the aspect ratio of each box
                    ),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final product = snapshot.data!.docs[index];
                      return Card(
                        child: GestureDetector(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Image.network(
                                  product['imageUrl'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              ListTile(
                                title: Text(product['name']),
                                subtitle: Text(product['stock'], style: const TextStyle(color:Colors.black45),),
                                trailing: Text(
                                  'Gs ${product['price'].toInt()}',
                                  style: const TextStyle(color: Colors.green),
                                ),
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (contex)=> ProductDetails(product:product),));
                                },
                              ),
                            ],
                          ),
                          onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (contex)=> ProductDetails(product:product),));
                              },
                        ),
                        
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

