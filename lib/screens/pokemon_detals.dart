import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PokeDetails extends StatefulWidget {
  final tag;
  final Color color;
  final pokedetails;

  const PokeDetails({
    super.key,
    required this.tag,
    required this.color,
    required this.pokedetails,
  });

  @override
  State<PokeDetails> createState() => _PokeDetailsState();
}

class _PokeDetailsState extends State<PokeDetails> {
  var texstyle = TextStyle(color: Colors.grey, fontSize: 24);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.color,
      body: Stack(
        children: [
          Positioned(
            top: 40,
            left: 10,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
            ),
          ),
          Positioned(
            top: 100,
            left: 20,
            child: Text(
              widget.pokedetails['name'],
              style: texstyle.copyWith(
                color: Colors.white,
                fontSize: 35,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Positioned(
            top: 180,
            right: -40,
            child: Image.asset(
              "assets/images/pokeball.png",
              width: 250,
              fit: BoxFit.fitHeight,
            ),
          ),
          Positioned(
            top: 140,
            right: 60,
            child: CachedNetworkImage(
              imageUrl: widget.pokedetails['img'],
              fit: BoxFit.fill,

              height: 250,
            ),
          ),
          Positioned(
            top: 400,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          Positioned(
            top: 460,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name", style: texstyle),
                SizedBox(height: 8),
                Text("Height", style: texstyle),
                SizedBox(height: 8),
                Text("Weight", style: texstyle),
                SizedBox(height: 8),
                Text("Spawn Time", style: texstyle),
                SizedBox(height: 8),
                Text("Next Evolution", style: texstyle),
                SizedBox(height: 8),
                Text("Weakness", style: texstyle),
              ],
            ),
          ),
          Positioned(
            top: 460,
            left: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.pokedetails["name"]}",
                  style: texstyle.copyWith(color: Colors.black),
                ),
                SizedBox(height: 8),
                Text(
                  "${widget.pokedetails["height"]}",
                  style: texstyle.copyWith(color: Colors.black),
                ),
                SizedBox(height: 8),
                Text(
                  "${widget.pokedetails['weight']}",
                  style: texstyle.copyWith(color: Colors.black),
                ),
                SizedBox(height: 8),
                Text(
                  "${widget.pokedetails["spawn_time"]}",
                  style: texstyle.copyWith(color: Colors.black),
                ),
                SizedBox(height: 8),
                Text(
                  (widget.pokedetails['next_evolution'] != null &&
                          widget.pokedetails['next_evolution'].isNotEmpty &&
                          widget.pokedetails['next_evolution'][0]["name"] !=
                              null &&
                          widget.pokedetails['next_evolution'][0]["name"]
                              .toString()
                              .isNotEmpty)
                      ? "${widget.pokedetails['next_evolution'][0]["name"]}"
                      : "Fully Evolved",
                  style: texstyle.copyWith(color: Colors.black),
                ),
                SizedBox(height: 8),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Text(
                    "${widget.pokedetails['weaknesses'].join(', ')}",
                    style: texstyle.copyWith(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
