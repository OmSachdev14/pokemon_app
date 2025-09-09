import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon/screens/pokemon_detals.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List pokepedia = [];

  @override
  void initState() {
    if (mounted) {
      fetchdata();
    }
    super.initState();
  }

  Widget build(BuildContext context) {
    var pokepediaAPI =
        "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: -50,
            right: -50,
            child: Image.asset(
              "assets/images/pokeball.png",
              width: 250,
              fit: BoxFit.fitHeight,
            ),
          ),
          Positioned(
            top: 100,
            left: 15,
            child: Text(
              "Poke'pedia",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            top: 160,
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: Container(
              child:
                  // ignore: unnecessary_null_comparison
                  pokepedia.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.18,
                        ),
                        itemCount: pokepedia.length,

                        itemBuilder: (context, index) {
                          var type = pokepedia[index]['type'][0];
                          return Card(
                            child: InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: type == 'Grass'
                                      ? Colors.greenAccent
                                      : type == 'Fire'
                                      ? Colors.redAccent
                                      : type == 'Water'
                                      ? Colors.blueAccent
                                      : type == 'Electric'
                                      ? Colors.yellowAccent
                                      : type == 'Rock'
                                      ? Colors.grey
                                      : type == 'Ground'
                                      ? Colors.brown
                                      : type == 'Psychic'
                                      ? Colors.indigo
                                      : type == 'Fighting'
                                      ? Colors.orange
                                      : type == 'Bug'
                                      ? Colors.lightGreen
                                      : type == 'Ghost'
                                      ? Colors.deepPurple
                                      : type == 'Normal'
                                      ? Colors.black26
                                      : type == 'Poison'
                                      ? Colors.deepPurpleAccent
                                      : Colors.pink,
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      bottom: -20,
                                      right: -20,
                                      child: Image.asset(
                                        "assets/images/pokeball.png",
                                        width: 120,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                    Positioned(
                                      left: 10,
                                      top: 10,
                                      child: Text(
                                        pokepedia[index]['name'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 45,
                                      left: 10,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                          color: Colors.white70,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0,
                                          ),
                                          child: Text(
                                            type.toString(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 5,
                                      right: 5,

                                      child: CachedNetworkImage(
                                        imageUrl: pokepedia[index]['img'],
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                print(pokepedia.length);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => PokeDetails(
                                      tag: index,
                                      color: type == 'Grass'
                                          ? Colors.greenAccent
                                          : type == 'Fire'
                                          ? Colors.redAccent
                                          : type == 'Water'
                                          ? Colors.blueAccent
                                          : type == 'Electric'
                                          ? Colors.yellowAccent
                                          : type == 'Rock'
                                          ? Colors.grey
                                          : type == 'Ground'
                                          ? Colors.brown
                                          : type == 'Psychic'
                                          ? Colors.indigo
                                          : type == 'Fighting'
                                          ? Colors.orange
                                          : type == 'Bug'
                                          ? Colors.lightGreen
                                          : type == 'Ghost'
                                          ? Colors.deepPurple
                                          : type == 'Normal'
                                          ? Colors.black26
                                          : type == 'Poison'
                                          ? Colors.deepPurpleAccent
                                          : Colors.pink,
                                      pokedetails: pokepedia[index],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    )
                  : Center(child: CircularProgressIndicator()),
            ),
          ),
        ],
      ),
    );
  }

  void fetchdata() {
    var url = Uri.https(
      "raw.githubusercontent.com",
      "Biuni/PokemonGO-Pokedex/master/pokedex.json",
    );
    print(url);
    http.get(url).then((value) {
      if (value.statusCode == 200) {
        var decodedata = jsonDecode(value.body);
        pokepedia = decodedata["pokemon"];
        setState(() {});
      }
    });
  }
}
