// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:productos_app/shared/shared.dart';

class ImageSlideShows extends StatefulWidget {
  const ImageSlideShows({Key? key}) : super(key: key);

  @override
  _ImageSlideShowsState createState() => _ImageSlideShowsState();
}

class _ImageSlideShowsState extends State<ImageSlideShows> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double maxWidth = constraints.maxWidth;
        final double maxHeight = constraints.maxHeight;
        final double aspectRatio = maxWidth / maxHeight;
        double slideWidth = 340;
        double slideHeight = 240;
        if (aspectRatio < 1.0) {
          // Portrait orientation
          slideWidth = maxWidth;
          slideHeight = maxWidth * 240 / 340;
        } else {
          // Landscape orientation or square
          slideHeight = maxHeight;
          slideWidth = maxHeight * 340 / 240;
        }
        return SizedBox(
          width: slideWidth,
          height: slideHeight,
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('productos')
                .where('isFavorite', isEqualTo: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final products = snapshot.data!.docs;
                return GestureDetector(
                  child: Swiper(
                    controller: SwiperController(), // Add Swiper controller
                    onIndexChanged: (index) {
                      setState(() {
                        currentIndex = index; // Update the currentIndex
                      });
                    },
                    viewportFraction: 0.8,
                    scale: 0.5,
                    autoplay: true,
                    itemBuilder: (BuildContext context, int index) {
                      final product = products[index];
                      final imageUrl = product['imageUrl'];
                      return Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Text('Error al cargar Imagenes');
                        },
                      );
                    },
                    itemCount: products.length,
                    pagination: const SwiperPagination(
                      margin: EdgeInsets.only(top: 0),
                    ),
                    control: const SwiperControl(),
                  ),
                  onTap: () {
                    final product = products[currentIndex]; // Use currentIndex to get the selected product
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetails(product: product),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        );
      },
    );
  }
}

/*import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:productos_app/shared/shared.dart';

class ImageSlideShows extends StatelessWidget {
  const ImageSlideShows({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double maxWidth = constraints.maxWidth;
        final double maxHeight = constraints.maxHeight;
        final double aspectRatio = maxWidth / maxHeight;
        double slideWidth = 340;
        double slideHeight = 240;
        if (aspectRatio < 1.0) {
          // Portrait orientation
          slideWidth = maxWidth;
          slideHeight = maxWidth * 240 / 340;
        } else {
          // Landscape orientation or square
          slideHeight = maxHeight;
          slideWidth = maxHeight * 340 / 240;
        }
        return SizedBox(
          width: slideWidth,
          height: slideHeight,
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('productos')
                .where('isFavorite', isEqualTo: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final products = snapshot.data!.docs;
                return GestureDetector(
                  child: Swiper(
                    viewportFraction: 0.8,
                    scale: 0.5,
                    autoplay: true,
                    itemBuilder: (BuildContext context, int index) {
                      final product = products[index];
                      final imageUrl = product['imageUrl'];
                      return Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Text('Error al cargar Imagenes');
                        },
                      );
                    },
                    itemCount: products.length,
                    pagination: const SwiperPagination(
                      margin: EdgeInsets.only(top: 0),
                    ),
                    control: const SwiperControl(),
                  ),
                  onTap: () {
                    final product = products[index];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetails(product: product),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        );
      },
    );
  }
}*/