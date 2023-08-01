// ignore: depend_on_referenced_packages
import 'package:animate_do/animate_do.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';

class SearchImageDelgate extends SearchDelegate{
  @override
  String get searchFieldLabel=>'Buscar Planta';
  @override
  List<Widget>? buildActions(BuildContext context) {
    // implement buildActions -para construir las acciones
    //throw UnimplementedError();
    //return[const Text('Contruir Acciones'),];
    return[
      if(query.isNotEmpty)  //el if para condicionar si no hay text no muestra la X
        FadeIn(
          //se importa libreria animate_do para la animacion del FadeIn con la X
          //el siguiente linea hace lo mismo que la If, entrada boleana
          //animate: query.isNotEmpty
          child: IconButton(
            onPressed: ()=>query='',//limpia lo escrito..
            icon: const Icon(Icons.clear)
          ),
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // implement buildLeading - para construir un icono
    //throw UnimplementedError();
    //return const Text('Contruir Lecturas');
    return IconButton(
      onPressed: ()=>close(context, null), 
      icon: const Icon(Icons.arrow_back_ios_new)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // implement buildResults- los resultodos que apareceran al darle enter, obligatoriopuede retornar vielist
    //throw UnimplementedError();
    return const Text('Contruir Resultados');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // implement buildSuggestions- cuando este escribiendo que quiero que haga el buscador 
    //throw UnimplementedError();
    return const Text('Contruir Sugerencias');  
  }



}