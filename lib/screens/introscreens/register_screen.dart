// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, unused_local_variable, unused_element

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:productos_app/shared/shared.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final textStyles = Theme.of(context).textTheme;

    return Scaffold(
      body: GeometricalBackground(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      if (!context.canPop()) return;
                      context.pop();
                    },
                    icon: const Icon(Icons.arrow_back_rounded, size: 40, color: Colors.white),
                  ),
                  const Spacer(flex: 1),
                  Text('Crear cuenta', style: textStyles.titleLarge?.copyWith(color: Colors.white)),
                  const Spacer(flex: 2),
                ],
              ),
              const SizedBox(height: 50),
              Container(
                height: size.height - 240,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(100)),
                ),
                child: const RegisterForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool _isPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );

        // Save additional user details to Firestore
        await FirebaseFirestore.instance.collection('usuarios').doc(userCredential.user!.uid).set({
          'nombre': _firstNameController.text.trim(),
          'apellido': _lastNameController.text.trim(),
          'correo': _emailController.text.trim(),
          // Add more fields as per your requirements
        });

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Cuenta creada'),
              content: const Text('Su cuenta se ha creado correctamente.'),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    context.go('/');
                  },
                ),
              ],
            );
          },
        );
      } catch (error) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text(error.toString()),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String password = '';
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 50),
              CustomTextFormField(
                controller: _firstNameController,
                label: 'Nombres',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, introduzca su Nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 18),
              CustomTextFormField(
                controller: _lastNameController,
                label: 'Apellido',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, introduzca su Apellido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 18),
              CustomTextFormField(
                controller: _emailController,
                label: 'Correo',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, introduzca su Correo';
                  }
                  // Add email validation logic if necessary
                  return null;
                },
              ),
              const SizedBox(height: 18),
              CustomTextFormField(
                label: 'Contraseña',
                obscureText: true,
                controller: _passwordController,
                onChanged: (value) {
                  password = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, intruduzca una contraseña';
                  }
                  if (value.length < 6) {
                    return 'La contraseña debe tener al menos 6 caracteres';
                  }
                  // Add password validation logic if necessary
                  return null;
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 60,
                child:CustomFilledButton(
                  text: 'Registrarse',
                  onPressed: _registerUser,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}