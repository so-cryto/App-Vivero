// ignore_for_file: unused_local_variable, use_build_context_synchronously, avoid_print, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  String _text = '';
  bool _isListening = false;
  bool _isLoading = false;

  void _initSpeech() async {
    bool available = await _speech.initialize(
      onStatus: (val) => print('sobre el estado: $val'),
      onError: (val) => print('en Error : $val'),
    );
    if (available) {
      setState(() {
        _isListening = true;
        _isLoading = true;
      });

      _speech.listen(onResult: (val) {
        setState(() {
          _text = val.recognizedWords;
        });
        _performSearch();
      });
    } else {
      setState(() => _isListening = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No hay soporte para reconocimiento de voz.'),
        ),
      );
    }
  }

  void _stopSpeech() async {
    await _speech.stop();
    setState(() => _isListening = false);
  }

  void _performSearch() async {
    setState(() => _isLoading = true);

    final querySnapshot = await FirebaseFirestore.instance
        .collection('productos')
        .where('name', isGreaterThanOrEqualTo: _text)
        .get();

    // Perform a more advanced search mechanism
    final matchingProducts = querySnapshot.docs.where((productDoc) {
      final productName = productDoc['name'].toString().toLowerCase();
      final queryWords = _text.toLowerCase().split(' ');

      // Perform fuzzy matching and partial matching
      return queryWords.every((queryWord) {
        final queryWordLength = queryWord.length;
        final matchIndex = productName.indexOf(queryWord);

        // Match if the query word is found within the product name
        return matchIndex >= 0 &&
            (matchIndex + queryWordLength == productName.length ||
                productName[matchIndex + queryWordLength] == ' ');
      });
    }).toList();

    setState(() => _isLoading = false);
    // Process the matchingProducts list and update the UI accordingly
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar productos'),
      ),
      body: Column(
        children: [
          Text(_text),
          FloatingActionButton(
            shape: CircleBorder(
              side: BorderSide(
                color: _isListening ? Colors.red : Colors.green, // Change color based on _isListening state
                width: 5,
              ),
            ),
            onPressed: () {
              if (_isListening) {
                _stopSpeech();
              } else {
                _initSpeech();
              }
            },
            child: Icon(_isListening ? Icons.mic_off : Icons.mic),
          ),
          Expanded(
            child: Stack(
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('productos')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final querySnapshot = snapshot.data!;
                    final matchingProducts = querySnapshot.docs.where((productDoc) {
                      final productName = productDoc['name'].toString().toLowerCase();
                      final queryWords = _text.toLowerCase().split(' ');

                      return queryWords.every((queryWord) {
                        final queryWordLength = queryWord.length;
                        final matchIndex = productName.indexOf(queryWord);

                        return matchIndex >= 0 &&
                            (matchIndex + queryWordLength == productName.length ||
                                productName[matchIndex + queryWordLength] == ' ');
                      });
                    }).toList();

                    return ListView.builder(
                      itemCount: matchingProducts.length,
                      itemBuilder: (context, index) {
                        final product = matchingProducts[index];
                        return Card(
                          child: ListTile(
                            leading: Image.network(product['imageUrl']),
                            title: Text(product['name']),
                            trailing: Text(
                              'Gs ${product['price'].toInt()}',
                              style: const TextStyle(color: Colors.green),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetails(
                                    product: product,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
                if (_isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductDetails extends StatelessWidget {
  final dynamic product;

  const ProductDetails({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product['name']),
      ),
      body: const Center(
        child: Text('Product details'),
      ),
    );
  }
}

class AppbarText extends StatelessWidget {
  final String text;

  const AppbarText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

/*
//version anterioir
class _SearchScreenState extends State<SearchScreen> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  String _text = '';

  bool _isListening = false;
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchTextChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel(); // Cancel the debounce timer if it's active
    super.dispose();
  }

  void _onSearchTextChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        _text = '';
      });
      _performSearch(_searchController.text.toLowerCase());
    });
  }

void _initSpeech() async {
    try {
      bool available = await _speech.initialize(
        onStatus: (val) => print('sobre el estado: $val'),
        onError: (val) => print('en Error : $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(onResult: (val) {
          setState(() {
            _searchController.text = val.recognizedWords;
          });
        });
      } else {
        setState(() => _isListening = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No hay soporte para reconocimiento de voz.'),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isListening = false;
        _text = 'Error: $e';
      });
    }
  }
  void _stopSpeech() async {
    await _speech.stop();
    setState(() => _isListening = false);
  }
  void _performSearch(String query) {
    setState(() {
      _text = 'Buscando...';
    });
    FirebaseFirestore.instance
        .collection('productos')
        .where('name', isGreaterThanOrEqualTo: query)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        setState(() {
          _text = '';
        });
      } else {
        setState(() {
          _text = 'Intente Nuevamente';
        });
      }
    }).catchError((error) {
      setState(() {
        _text = 'Error: $error';
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppbarText(text: 'Buscar productos'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: TextFormField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      labelText: 'Buscada manual',
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _searchController.text = ''; 
                  });
                  _onSearchTextChanged();
                },
                icon: const Icon(Icons.clear_rounded),
              ),
            ],
          ),
          Text(_text),
          FloatingActionButton(
            shape: const CircleBorder(
              side: BorderSide(
                color: Colors.green,
                width: 5,
              ),
            ),
            onPressed: () {
              if (_isListening) {
                _stopSpeech();
              } else {
                _initSpeech();
              }
            },
            child: Icon(_isListening ? Icons.mic_off : Icons.mic),
          ),
          const SizedBox(height: 20,),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('productos')
                  .where('name', isGreaterThanOrEqualTo: _searchController.text.toLowerCase())
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                final products = snapshot.data!.docs;
                if (products.isEmpty) {
                  return const Center(
                    child: Text('No se encontraron productos.'),
                  );
                }
                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Card(
                      child: ListTile(
                        leading: Image.network(product['imageUrl']),
                        title: Text(product['name']),
                        //subtitle: Text(product['description']),
                        trailing: Text(
                          'Gs ${product['price'].toInt()}',
                          style: const TextStyle(color: Colors.green),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetails(
                                product: product,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
    'Llantén',
    'Pomelo',
    'Hortensia',
    'Cedron Paraguay',
    'Lirio Rojo',
import 'package:flutter/material.dart';
import 'package:productos_app/shared/widgets/widgets.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);
  @override
  _SearchScreenState createState() => _SearchScreenState();
}
class _SearchScreenState extends State<SearchScreen> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  String _text = '';
  // Crear una variable para indicar si se está escuchando o no
  bool _isListening = false;
  // Método para inicializar el reconocimiento de voz
  void _initSpeech() async {
    const noiseThreshold = 50;
    _speech.setNoiseThreshold(noiseThreshold);
    bool available = await _speech.initialize(
      onStatus: (val) => print('sobre el estado: $val'),
      onError: (val) => print('en Error : $val'),
    );
    if (available) {
      setState(() => _isListening = true);
      _speech.listen(onResult: (val) => setState(() {
            _text = val.recognizedWords;
          }));
    } else {
      setState(() => _isListening = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No hay soporte para reconocimiento de voz.'),
        ),
      );
    }
  }
  void _stopSpeech() async {
    await _speech.stop();
    setState(() => _isListening = false);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const AppbarText(text:'Buscar productos'),
      ),
      body: Column(
        children: [
          Text(_text),
          FloatingActionButton(
            shape: const CircleBorder(
                  side: BorderSide(
                    color: Colors.green,
                    width: 5,
                  ),
                ),
            onPressed: () {
              if (_isListening) {
                _stopSpeech();
              } else {
                _initSpeech();
              }
            },
            child: Icon(_isListening ? Icons.mic_off : Icons.mic),
          ),
          // Mostrar los productos que coincidan con el texto obtenido
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('productos')
                  .where('name', isGreaterThanOrEqualTo: _text)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final product = snapshot.data!.docs[index];
                    return Card(
                      child: ListTile(
                        leading: Image.network(product['imageUrl']),
                        title: Text(product['name']),
                        //subtitle: Text(product['description']),
                        trailing: Text('Gs ${product['price'].toInt()}',style: const TextStyle(color: Colors.green),),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (contex)=> ProductDetails(product:product),));
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}*/