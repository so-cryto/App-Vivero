//no se esta usando
// ignore: depend_on_referenced_packages
/*import 'package:flutter/material.dart';

class PlantCards extends StatelessWidget {
  const PlantCards({super.key, 
  required this.image, 
  required this.title, 
  required this.statedis, 
  required this.price, 
  required this.press, });
  final String image,title,statedis;
  final int price;
  final Function press;
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(
        left: 20,
        top: 20 /2,
        bottom: 20 * 2.5,
      ),
      width: size.width *0.4,
      child: Column(
        children: <Widget>[
          Image.asset(image),
          GestureDetector(
            onTap:press(),
            child: Container(
              padding: const EdgeInsets.all(20/2),
              decoration:  BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 10),
                    blurRadius: 50,
                    color: Colors.greenAccent.withOpacity(0.23),
                  )
                ]
              ),
              child: Row(
                children:<Widget> [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '$title\n'.toUpperCase(),
                          // ignore: deprecated_member_use
                          style: Theme.of(context).textTheme.button,
                        ),
                        TextSpan(
                          text: statedis.toUpperCase(),
                          style:TextStyle(
                            color:  Colors.green.withOpacity(0.5),
                          )
                        )
                      ]
                    )
                  ),
                  Text(
                    '$price',
                    style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: Colors.green),
                  )
                ]
              ),
            ),
          )
        ]
      ),
    );
  }
}*/