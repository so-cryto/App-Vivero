// ignore_for_file: deprecated_member_use, prefer_final_fields, avoid_print, use_build_context_synchronously, non_constant_identifier_names
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:productos_app/shared/shared.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({Key? key}) : super(key: key);
  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}
String cantidad_favoritos = '';
class _PerfilScreenState extends State<PerfilScreen> {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);
  GoogleSignInAccount? _user;
  File? _profileImage;
  String? _userName;
  String? _userEmail;
  String? _userProfileImage;
  //bool _isFavorited = false;
  int favoriteCount = 0;
  @override
  void initState() {
    super.initState();
    _initGoogleSignIn();
    _fetchUserData();
  //  comprobar();
  }
  /*
  void comprobar() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        print('Ningún usuario ha iniciado sesión');
        setState(() {
          _isFavorited = false;
          favoriteCount = 0; // Reset the favorite count
        });
      } else {
        print('Usuario que ha iniciado sesión');
        final result = await FirebaseFirestore.instance
            .collection('usuarios')
            .where('favorite')
            .get();
        setState(() {
          cantidad_favoritos = result.docs.length.toString();
          _isFavorited = result.docs.isNotEmpty;
          favoriteCount = result.docs.length; // Set the favorite count
        });
      }
    });
  }*/
  Future<void> _initGoogleSignIn() async {
    try {
      await _googleSignIn.signInSilently();
      setState(() {
        _user = _googleSignIn.currentUser;
      });
    } catch (error) {
      print('Google Sign-In Error: $error');
    }
  }
  Future<void> _fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userId = user.uid;
      final userData = await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(userId)
          .get();
      setState(() {
        _userName = userData['nombre'];
        _userEmail = userData['correo'];
        _userProfileImage = userData['profileImage'];
      });
    }
  }
  Future<void> _pickProfileImage() async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _profileImage = File(pickedImage.path);
      });
      await _uploadProfileImage();
    }
  }
  Future<void> _uploadProfileImage() async {
    if (_profileImage == null) return;
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) return;
      final storageRef =
          FirebaseStorage.instance.ref().child('profile_images/$userId.jpg');
      final uploadTask = storageRef.putFile(_profileImage!);
      final snapshot = await uploadTask.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();
      await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(userId)
          .update({
        'profileImage': downloadUrl,
      });
      print('Imagen de perfil cargada correctamente!');
      setState(() {
        _userProfileImage = downloadUrl;
      });
    } catch (error) {
      print('Error al cargar la imagen de perfil: $error');
    }
  }
  @override
  Widget build(BuildContext context) {
  // Obtener el usuario actual
  var user = _googleSignIn.currentUser;
  // Verificar si el usuario es nulo
  if (user == null) {
    // Si el usuario no ha iniciado sesión, muestre un mensaje o redirija a la pantalla de inicio de sesión
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Mostrar el AlertDialog
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: const Text('Inicie sesión para ver más.'),
                  actions: [
                    // Agregar un botón para cerrar el diálogo
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
      bottomNavigationBar: const NavigationAppbar(), // Agregar el bottomNavigationBar aquí
    );
  }
  // Si el usuario ha iniciado sesión, mostrar el resto de la interfaz
    return Scaffold(
      appBar: AppBar(title: const AppbarText(text:'Perfil Usuario'),
     ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Align the column at the center
          children: [
            const SizedBox(height: 5),
            Stack(
              children: [
                StyleAvatarUser(profileImage: _profileImage, user: _user, userProfileImage: _userProfileImage),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    onTap: _pickProfileImage,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.greenAccent,
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            /*const SizedBox(height: 15,),
            if (_isFavorited)
              const Text('Mis Favoritos Total:'), 
            if (!_isFavorited)
              const Text('El usuario no tiene favoritos'),
            Text(
              favoriteCount.toString(), // Mostrar el número de favoritos
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
            ),*/
            const SizedBox(height: 30,),
            TextandMore(userName: _userName, user: _user, userEmail: _userEmail),
            TextBtonDeletUser(googleSignIn: _googleSignIn),
            const Spacer(),
            TextButton(
              onPressed: () async {
                await _googleSignIn.signOut();
                await DefaultCacheManager().emptyCache(); // Borrar el cache
                GoRouter.of(context).go('/loginscreen');
              },
              child: const Text('Cerrar Sesión'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const NavigationAppbar(),
    );
  }
}






















class StyleAvatarUser extends StatelessWidget {
  const StyleAvatarUser({
    super.key,
    required File? profileImage,
    required GoogleSignInAccount? user,
    required String? userProfileImage,
  }) : _profileImage = profileImage, _user = user, _userProfileImage = userProfileImage;

  final File? _profileImage;
  final GoogleSignInAccount? _user;
  final String? _userProfileImage;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: _profileImage != null
          ? FileImage(_profileImage!)
          : (_user?.photoUrl != null
              ? NetworkImage(_user!.photoUrl!)
              : (_userProfileImage != null
                  ? NetworkImage(_userProfileImage!) as ImageProvider<Object>
                  : null)),
      radius: 75,
      child: _profileImage == null &&
              (_user?.photoUrl == null && _userProfileImage == null)
          ? const Icon(Icons.person, size: 75, color: Colors.white70)
          : null,
    );
  }
}

class TextBtonDeletUser extends StatelessWidget {
  const TextBtonDeletUser({
    super.key,
    required GoogleSignIn googleSignIn,
  }) : _googleSignIn = googleSignIn;

  final GoogleSignIn _googleSignIn;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        // Display a confirmation dialog
        bool confirm = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Confirmación'),
              content: const Text('¿Está seguro de que desea eliminar su cuenta?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Sí'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('No'),
                ),
              ],
            );
          },
        );
        if (confirm == true) {
          try {
            // Delete the user's account
            await FirebaseAuth.instance.currentUser?.delete();
            // Sign out the user
            await _googleSignIn.signOut();
            // Navigate to the login screen
            GoRouter.of(context).go('/loginscreen');
          } catch (error) {
            print('Error al eliminar la cuenta: $error');
            // Display an error message or handle the error accordingly
          }
        }
      },
      child: const Text('Eliminar Cuenta'),
    );
  }
}