// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:productos_app/shared/shared.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: GeometricalBackground(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                SizedBox(
                  height: 250,
                  width: 400,
                  child: Image.asset('assets/logostyle.png'),
                ),
                Container(
                  height: size.height - 240,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(70)),
                  ),
                  child: const _LoginForm(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class _LoginForm extends StatefulWidget {
  const _LoginForm({Key? key}) : super(key: key);
  @override
  _LoginFormState createState() => _LoginFormState();
}
class _LoginFormState extends State<_LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  String errorMessage = '';
  void _signInWithEmailAndPassword(
    String email,
    String password,
    GoRouter goRouter,
  ) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      String userMail = userCredential.user!.email!;
      bool isAdmin = await _checkIfUserIsAdmin(userMail);
      if (isAdmin) {
        goRouter.go('/adminhome');
      } else {
        goRouter.go('/');
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: Correo electrónico o contraseña incorrectos.';
      });
      print('Login error: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Correo o contraseña incorrectos.'),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () async {
                    try {
                      await _auth.sendPasswordResetEmail(email: email);
                      Navigator.of(context).pop(); // Close the AlertDialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Éxito'),
                            content: const Text(
                              'Se ha enviado un correo de restablecimiento de contraseña. Por favor, revise su bandeja de entrada.',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); 
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    } catch (e) {
                      print('Password reset error: $e');
                      Navigator.of(context).pop(); 
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content: const Text(
                              'Error al enviar un correo de restablecimiento de contraseña. Inténtalo de nuevo más tarde.',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); 
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: const Text('Restablecer contraseña'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the AlertDialog
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
  Future<bool> _checkIfUserIsAdmin(String email) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('UserAdmin')
        .where('correo', isEqualTo: email)
        .where('admin', isEqualTo: true)
        .limit(2)
        .get();
    return querySnapshot.docs.isNotEmpty;
  }
  void _signInWithGoogle(GoRouter goRouter) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      String userMail = userCredential.user!.email!;
      bool isAdmin = await _checkIfUserIsAdmin(userMail);
      if (isAdmin) {
        goRouter.go('/adminhome');
      } else {
        goRouter.go('/');
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: Error al iniciar sesión en Google.';
      });
      print('Login error: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    String email = '';
    String password = '';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            children: [
              const SizedBox(height: 15),
              Text('Bienvenido', style: textStyles.titleMedium),
              const SizedBox(height: 5),
              Text('Vivero', style: textStyles.titleSmall),
              Text('Pozo Azul', style: textStyles.titleLarge),
              const SizedBox(height: 10),
              Text('Inciar Sesion', style: textStyles.titleSmall),
              const SizedBox(height: 10),
              CustomTextFormField(
                label: 'Correo',
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                onChanged: (value) {
                  email = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'El campo correo es obligatorio';
                  } else if (!value.contains('@')) {
                    return 'El formato del correo es incorrecto';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                label: 'Contraseña',
                obscureText: true,
                controller: _passwordController,
                onChanged: (value) {
                  password = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'El campo contraseña es obligatorio';
                  } else if (value.length < 6) {
                    return 'La contraseña debe tener al menos 6 caracteres';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: CustomFilledButton(
                  text: 'Ingresar',
                  onPressed: () async {
                    setState(() {
                      errorMessage = '';
                    });
                    _signInWithEmailAndPassword(
                      email,
                      password,
                      GoRouter.of(context),
                    );
                  },
                ),
              ),
              const Text('O'),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    errorMessage = '';
                  });
                  _signInWithGoogle(GoRouter.of(context));
                },
                icon: Image.asset('assets/google.png', scale: 20),
                label: const Text(' Iniciar sesión con Google'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('¿No tienes cuenta?'),
                  TextButton(
                    onPressed: () => context.push('/registerscreen'),
                    child: const Text('Crea una aquí'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => context.push('/'),
                    child: const Text('Ingresar sin Registrarse'),
                  ),
                ],
              ),
              const Text(
                'Version 2.0.2',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
              ),
              Text(
                errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}