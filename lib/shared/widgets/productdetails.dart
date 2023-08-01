// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:productos_app/shared/shared.dart';

class ProductDetails extends StatefulWidget {
  final DocumentSnapshot product;

  const ProductDetails({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    checkFavoriteStatus();
  }

  void checkFavoriteStatus() async {
    // Check if the product is marked as a favorite for the current user
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userId = user.uid;
      final favoritesRef = FirebaseFirestore.instance
          .collection('usuarios')
          .doc(userId)
          .collection('favorites');
      final favoriteDoc = await favoritesRef.doc(widget.product.id).get();
      setState(() {
        isFavorite = favoriteDoc.exists;
      });
    }
  }

  void toggleFavorite() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userId = user.uid;
      final favoritesRef = FirebaseFirestore.instance
          .collection('usuarios')
          .doc(userId)
          .collection('favorites');
      final favoriteDoc = favoritesRef.doc(widget.product.id);

      setState(() {
        isFavorite = !isFavorite;
      });

      if (isFavorite) {
        final productData = widget.product.data() as Map<String, dynamic>;
        await favoriteDoc.set(productData);
      } else {
        await favoriteDoc.delete();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.get('name')),
        elevation: 0,
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white54,
                  ),
                  child: Image.network(widget.product.get('imageUrl')),
                ),
                FloatingActionButton(
                  onPressed: toggleFavorite,
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  mini: true,
                  heroTag: null,
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.center,
              child: Text(
                widget.product.get('name'),
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.product.get('stock'),
              style: const TextStyle(fontSize: 14, color: Colors.greenAccent),
            ),
            const SizedBox(height: 15),
            const Text(
              'Descripcion',
              style: TextStyle(fontSize: 18,),
            ),
            const SizedBox(height: 8),
            Text(
              widget.product.get('description'),
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            const Text(
              'Propiedades',
              style: TextStyle(fontSize: 18,),
            ),
            const SizedBox(height: 8),
            Text(
              widget.product.get('propiedades'),
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 25),
            Text(
              'Gs ${widget.product.get('price').toInt()}',
              style: const TextStyle(fontSize: 20, color: Colors.green),
            ),
          ],
        ),
      ),
      floatingActionButton: const Btnchatbot(),
    );
  }
}

/*//version ok v1
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:productos_app/shared/shared.dart';

class ProductDetails extends StatefulWidget {
  final DocumentSnapshot product;
  const ProductDetails({Key? key, required this.product}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _ProductDetailsState createState() => _ProductDetailsState();
}
class _ProductDetailsState extends State<ProductDetails> {
  //Funcion de Fovorito
  bool isFavorite = false;
  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
    // Save the favorite status to Firebase
    final productRef =
        FirebaseFirestore.instance.collection('productos').doc(widget.product.id);
    if (isFavorite) {
      productRef.set({'isFavorite': true}, SetOptions(merge: true));
    } else {
      // se cambia update por set y FieldValue.delete() por false
      productRef.set({'isFavorite': false}, SetOptions(merge: true));
    }
  }
  @override
  void initState() {
    super.initState();
    isFavorite = widget.product.get('isFavorite') ?? false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.get('name')),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white54,
                  ),
                  child: Image.network(widget.product.get('imageUrl')),
                ),
                FloatingActionButton(
                  onPressed: toggleFavorite,
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  mini: true,
                  heroTag: null,
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.center,
              child: Text(
                widget.product.get('name'),
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.product.get('stock'),
              style: const TextStyle(fontSize: 14, color: Colors.greenAccent),
            ),
            const SizedBox(height: 15),
            const Text(
              'Descripcion',
              style: TextStyle(fontSize: 18,),
            ),
            const SizedBox(height: 8),
            Text(
              widget.product.get('description'),
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              widget.product.get('propiedades'),
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 25),
            Text(
              'Gs ${widget.product.get('price').toInt()}',
              style: const TextStyle(fontSize: 20, color: Colors.green),
            ),
          ],
        ),
      ),
      //boton chat
      floatingActionButton: const Btnchatbot(),
    );
  }
}
*/