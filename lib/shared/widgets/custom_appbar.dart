// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
//import 'package:productos_app/shared/shared.dart';

class CustomAppBar extends StatefulWidget {
   
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white38,
        borderRadius: BorderRadius.circular(24), // Adjust the radius to get the desired roundness
      ),
      child: Row(
        children: [
          const Expanded(
            child: SizedBox(
            width: 200,
            height: 50,
            child: FittedBox(
              child: Center(
                child: Text(
                  'Bienvenido',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(0, 0.5),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  
                ),
              ),
            ),
          ),

          ),
          RoundedIconButton(
            onPressed: () => context.push('/search'),
            icon: Icons.search,
          ),
        ],
      ),
    );
  }
}
class RoundedIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;

  const RoundedIconButton({super.key, 
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.green, // Adjust the color of the button
        ),
        child: Icon(
          icon,
          color: Colors.white, // Adjust the color of the icon
        ),
      ),
    );
  }
}
/* // ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// ignore: unused_import
import 'package:productos_app/shared/widgets/serach_delegate.dart';

class CustomAppBar extends StatelessWidget {
   
  const CustomAppBar({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return   SafeArea(
      
      child: Padding(
        padding:const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              const Text('Bienvenido',),//style: TextStyle(fontWeight: FontWeight.bold),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.greenAccent,
                    width: 3,
                  ),
                  color: Colors.greenAccent,
                ),
                child: IconButton(
                  onPressed: () => context.push('/search'),
                  icon: const Icon(Icons.search, color: Colors.white,),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}*/