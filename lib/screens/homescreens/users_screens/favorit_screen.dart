// ignore_for_file: library_private_types_in_public_api


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:productos_app/shared/shared.dart';
class FavoritScreen extends StatefulWidget {
  const FavoritScreen({Key? key}) : super(key: key);
  @override
  _FavoritScreenState createState() => _FavoritScreenState();
}
class _FavoritScreenState extends State<FavoritScreen> {
  User? firebaseUser;
  GoogleSignInAccount? googleUser;

  @override
  void initState() {
    super.initState();
    checkUserValidation();
    checkGoogleSignIn();
  }
  
  Future<void> checkGoogleSignIn() async {
    final googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);
    final currentUser = await googleSignIn.signInSilently();
    setState(() {
      googleUser = currentUser;
    });
  }

  Future<void> checkUserValidation() async {
    FirebaseAuth.instance.authStateChanges().listen((User? newUser) {
      setState(() {
        firebaseUser = newUser;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if ( googleUser != null) {
      return Scaffold(
        appBar: AppBar(
          title: const AppbarText(text: 'Top Favorito'),
        ),
        body: Column(
          children: [
            const ImageSlideShows(),
            const SizedBox(height: 10),
            const Text(
              'Mis Favoritos',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.green,
                shadows: [
                  Shadow(offset: Offset(0, 0.5), blurRadius: 2, color: Colors.black54),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('usuarios')
                    .doc(firebaseUser?.uid ?? googleUser?.id)
                    .collection('favorites')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    final favoriteProducts = snapshot.data!.docs;
                    if (favoriteProducts.isEmpty) {
                      return const Center(
                        child: Text('No tienes productos favoritos.'),
                      );
                    }
                    return ListView.builder(
                      itemCount: favoriteProducts.length,
                      itemBuilder: (context, index) {
                        final product = favoriteProducts[index];
                        final imageUrl = product.get('imageUrl') ?? '';
                        final name = product.get('name') ?? '';
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetails(product: product),
                              ),
                            );
                          },
                          child: Card(
                            child: ListTile(
                              leading: imageUrl.isNotEmpty
                                  ? Image.network(
                                      imageUrl,
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(),
                              title: Text(name),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error.toString()}'),
                    );
                  }
                  return const Center(
                    child: Text('No tienes productos favoritos.'),
                  );
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: const NavigationAppbar(),
      );
    } else {
      return Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: const Text('Inicie sesión para ver más.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cerrar'),
                      ),
                      TextButton(
                        onPressed: () {
                          GoRouter.of(context).go('/loginscreen');
                        },
                        child: const Text('Crear Cuenta'),
                      ),
                    ],
                  );
                },
              );
            },
            child: const Text('Mostrar mensaje'),
          ),
        ),
        bottomNavigationBar: const NavigationAppbar(),
      );
    }
  }
}