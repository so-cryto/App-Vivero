import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
class Btnchatbot extends StatelessWidget {
  const Btnchatbot({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip( 
      message: 'Te Ayudo?', 
      enableFeedback: false,
        padding: const EdgeInsets.all(8), 
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration( 
          color: Colors.white, 
          border: Border.all(color: Colors.green), 
          borderRadius: BorderRadius.circular(10), 
        ),
        textStyle: const TextStyle( 
          fontSize: 18, 
          color: Colors.green, 
          fontWeight: FontWeight.bold,
        ),
      child: FloatingActionButton(
        onPressed: () => context.push('/chat2'),
        backgroundColor: Colors.green, 
        shape: RoundedRectangleBorder( 
          borderRadius: BorderRadius.circular(10),
        ),
        child: Image.asset('assets/icon/bot.png',fit: BoxFit.scaleDown,),
      ),
    );
  }
}