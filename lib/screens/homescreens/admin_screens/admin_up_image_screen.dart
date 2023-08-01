// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
//firebase service
import 'package:firebase_storage/firebase_storage.dart';
// ignore: unused_import
import 'package:firebase_core/firebase_core.dart';
// ignore: unused_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:productos_app/screens/screens.dart';



class UpImageScreen extends StatefulWidget {
  const UpImageScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _UpImageScreenState createState() => _UpImageScreenState();
}

List<String> _categorias =['Arboleda','Medicinal','Ornamentales','Otros'];
// ignore: unused_element
List<String> _stock = ['Disponible', 'Sin stock'];

class _UpImageScreenState extends State<UpImageScreen> {
  // Variables para almacenar la imagen, el nombre, la descripción y el precio del producto
  File? _image;
  String? _imageUrl;
  String _name = '';
  String _description = '';
  String _propiedades = '';
  double _price = 0;
  String _categoria = 'Arboleda';
  // ignore: prefer_final_fields
  bool _isFavorite=false;
  // ignore: prefer_final_fields
  String _stock ='Disponible';
  
  // Global form key for form validation
  final _formKey = GlobalKey<FormState>();
  // Boolean flag to control loading indicator
  bool _isLoading = false;
  
  // Método para seleccionar una imagen desde la galería o la cámara
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        // ignore: avoid_print
        print('No hay imagen seleccionada.');
      }
    });
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
  }

  // Método para guardar los datos del producto en Cloud Firestore
  Future<void> _saveProductos() async {
    // Validate the form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Set the loading state
    setState(() {
      _isLoading = true;
    });

    // Upload the image to Firebase Storage and get the URL
    await _uploadImage();

    // If the image URL is null, stop the saving process
    if (_imageUrl == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    // Save the product data to Firestore
    final productos = {
      'name': _name,
      'description': _description,
      'propiedades': _propiedades,
      'price': _price,
      'imageUrl': _imageUrl,
      'categoria': _categoria,
      'stock': _stock,
      'isFavorite': _isFavorite,
    };

    await FirebaseFirestore.instance.collection('productos').add(productos);

    // Reset the form and loading state after saving the data
    _formKey.currentState!.reset();
    setState(() {
      _isLoading = false;
      _imageUrl = null;
    });
    // Show the success dialog
    showDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text('Producto guardado con éxito.'),
        actions: [
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (builder) => const ViewPlantas()),
              );
            },
          ),
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
   //cuerpo visual 
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Planta'),
        actions: [
          PopupMenuButton<ImageSource>(
            onSelected: _pickImage,
            itemBuilder: (context) => [
              const PopupMenuItem(
                // ignore: sort_child_properties_last
                child: Text('Galería'),
                value: ImageSource.gallery,
              ),
              const PopupMenuItem(
                // ignore: sort_child_properties_last
                child: Text('Cámara'),
                value: ImageSource.camera,
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey, // Assign the form key to the form
          child: Column(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                color: Colors.grey[200],
                child: _image == null
                    ? const Icon(Icons.image, size: 100)
                    : Image.file(_image!),
              ),
              // Show circular progress indicator while saving
              if (_isLoading) const CircularProgressIndicator(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese el nombre del producto.';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _name = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Descripción'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese la descripción del producto.';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _description = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: const InputDecoration(labelText: 'Propiedades'),
                  onChanged: (value) {
                    setState(() {
                      _propiedades = value;
                    });
                  },
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Precio'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese el precio del producto.';
                    }
                    // Check if the input can be parsed as a double
                    if (double.tryParse(value) == null) {
                      return 'Por favor, ingrese un valor numérico válido.';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _price = double.parse(value);
                    });
                  },
                ),
              ),
              //lista las categorias
              
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: DropdownButton<String>(
                      value: _categoria,
                      onChanged: (String? newValue) {
                      setState(() {
                        _categoria = newValue!;
                      });
                      },
                      items: _categorias.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
                      );
                      }).toList(),
                    ),
                  ),
                  
                ],
              ),
              
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // ignore: sort_child_properties_last
        child: const Icon(Icons.save),
        onPressed: _saveProductos,
      ),
    );
  }
}