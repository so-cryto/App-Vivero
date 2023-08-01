// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:productos_app/shared/shared.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomAppBar(), 
        elevation: 0,
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const ImageSlideShows(),
            const Text(
              'Top Favorito',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Colors.green,
                shadows: [
                  Shadow(offset: Offset(0, 0.5), blurRadius: 2, color: Colors.black54),
                ],
              ),
            ),
            Expanded( // Wrap the Column with Expanded
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const CardTable(),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const NavigationAppbar(),
    );
  }
}