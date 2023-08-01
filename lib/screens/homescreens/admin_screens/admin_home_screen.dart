// ignore: depend_on_referenced_packages
// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:productos_app/screens/screens.dart';

import 'package:google_sign_in/google_sign_in.dart';

class AdminHomeScreen extends StatefulWidget {
 
 const AdminHomeScreen({Key? key}) : super(key: key);

 @override
 State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> with SingleTickerProviderStateMixin {
  // Crear el AnimationController
  late AnimationController _animationController;
  // Crear la Animation
  late Animation<double> _animation;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void initState() {
    super.initState();
    // Inicializar el AnimationController con una duración de 1 segundo
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    // Inicializar la Animation con una curva de rebote
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.bounceOut,
    );
    // Ejecutar la animación solo una vez
    _animationController.forward();
    // Añadir un listener para saber cuándo la animación ha terminado
    _animation.addStatusListener((status) {
      // Si la animación ha terminado, resetear el AnimationController
      if (status == AnimationStatus.completed) {
        _animationController.reset();
      }
    });
  }

  @override
  void dispose() {
    // Liberar los recursos del AnimationController
    _animationController.dispose();
    super.dispose();
  }

 @override
 Widget build(BuildContext context) {
 return Scaffold(
 appBar: AppBar(
 centerTitle: true,
 title: const Text(
 'Administrador',
 ),
 ),
 
 body: Center(
 child: Column(
 children: [
 const OptionsButton(),
 const Spacer(),
 TextButton(
 onPressed: (){
  _googleSignIn.signOut();
  GoRouter.of(context).go('/loginscreen');
 }, 
 child: const Text('Cerrar Sesion')),
 ],
 )
 
 ),
 // Agregar el widget AnimatedBuilder
 floatingActionButton: AnimatedBuilder(
   animation: _animation,
   builder: (context, child) {
     return Transform.translate(
       // Usar el valor de la animación para modificar la posición del botón
       offset: Offset(0, -_animation.value * 100),
       child: child,
     );
   },
   child: FloatingActionButton(
      onPressed: () {
        // Llamar a la función que quieras al pulsar el botón
        // Por ejemplo, navegar a la pantalla de agregar plantas
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (builder) => const UpImageScreen()));
      },
      elevation: 3,
      // Usar el mismo color que el AppBar
      backgroundColor: Theme.of(context).primaryColor,
      shape: const CircleBorder(
        side: BorderSide(
          color: Colors.greenAccent,
          width: 4,
        ),
      ),
      child: const Icon(Icons.add, color: Colors.white, size: 24),
    ),
 ),
 
 );
 }
}

//Aqui van los botones 
class OptionsButton extends StatelessWidget {
  const OptionsButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //seguna fila de botton
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                const SizedBox(height: 80),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.greenAccent,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    minimumSize: const Size(150, 60), //////// HERE
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute( builder: (builder) => const ViewPlantas()));
                  },
                  child: const Text('Ver Productos'),
                )
              ],
            ),
            
          ],
        ),
      ],
    );
  }
}