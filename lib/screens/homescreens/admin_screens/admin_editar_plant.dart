// ignore_for_file: library_private_types_in_public_api, unused_import, use_build_context_synchronously, deprecated_member_use, unused_element, prefer_final_fields

import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:productos_app/shared/shared.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';

class EditProductScreen extends StatefulWidget {
  final DocumentSnapshot product;

  const EditProductScreen({Key? key, required this.product}) : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController propiedadesController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  
  final StreamController<String> _imageStreamController = StreamController<String>();

  late String imageUrl;
  File? _image;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.product.get('name');
    stockController.text = widget.product.get('stock');
    descriptionController.text = widget.product.get('description');
    propiedadesController.text = widget.product.get('propiedades');
    priceController.text = widget.product.get('price').toInt().toString();
    imageUrl = widget.product.get('imageUrl');
    _imageUrl = imageUrl;
        // Inicializar el stream con la imagen actual
    _imageStreamController.add(imageUrl);
  }
  // Método para seleccionar una imagen desde la galería o la cámara
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: source);
      if (pickedFile != null) {
       setState(() {
          _image = File(pickedFile.path);
       });
      }
  }
  // Método para subir la imagen a Firebase Storage y obtener la URL de descarga
  Future<void> _uploadImage() async {
    if (_image == null) return;
    final fileName = _image!.path.split('/').last;
    final storageRef = FirebaseStorage.instance.ref().child(fileName);
    await storageRef.putFile(_image!);
    final downloadUrl = await storageRef.getDownloadURL();
    setState(() {
      _imageUrl = downloadUrl;
    });
        // Agregar la nueva imagen al stream
    _imageStreamController.add(_imageUrl!);
  }
  Future<void> updateProduct() async {
    await _uploadImage();
    if (_imageUrl == null) return;

    // Limpiar la caché de imágenes
    imageCache.clear();
    imageCache.clearLiveImages();
    final updatedData = {
      'name': nameController.text,
      'stock': stockController.text,
      'description': descriptionController.text,
      'propiedades': propiedadesController.text,
      'price': double.parse(priceController.text),
      'imageUrl': _imageUrl,
    };
    await FirebaseFirestore.instance
        .collection('productos')
        .doc(widget.product.id)
        .update(updatedData);
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Producto actualizado'),
        content: const Text('El producto se ha actualizado correctamente.'),
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
  void dispose() {
    super.dispose();
    // Cerrar el StreamController cuando no se necesite
    _imageStreamController.close();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Editar Planta'),
        actions: [
          PopupMenuButton<ImageSource>(
            onSelected: _pickImage,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: ImageSource.gallery,
                child: Text('Galería'),
              ),
              const PopupMenuItem(
                value: ImageSource.camera,
                child: Text('Cámara'),
              ),
            ],
          ),
        ],
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
                  child: StreamBuilder<String>(
                    stream: _imageStreamController.stream, // Pasar el stream del StreamController
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        // Mostrar la imagen desde el snapshot
                        return Image.network(snapshot.data!);
                      } else if (snapshot.hasError) {
                        // Mostrar un mensaje de error si hay algún problema
                        return Text('Error al cargar la imagen: ${snapshot.error}');
                      } else {
                        // Mostrar un indicador de carga mientras se espera la imagen
                        return const CircularProgressIndicator();
                      }
                    } // Agregar un paréntesis aquí
                  ), // Agregar una llave aquí
                ),
              ],
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.center,
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: stockController,
              decoration: const InputDecoration(
                labelText: 'Stock',
              ),
            ),
            const SizedBox(height: 15),
            const SizedBox(height: 8),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Descripcion',
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: propiedadesController,
              decoration: const InputDecoration(
                labelText: 'Propiedades',
              ),
            ),
            const SizedBox(height: 25),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(
                labelText: 'Precio',
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: updateProduct,
              child: const Text('Actualizar producto'),
            ),
          ],
        ),
      ),
    );
  }
}