import 'package:flutter/material.dart';
import 'package:marvel_api/src/models/character.dart';
import '../controller/consumindoAPI.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Character> _listaHerois = [];

  @override
  void initState() {
    _buscaHerois();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
          )
        ],
        centerTitle: true,
        title: Image.asset(
          'images/logo.png',
          width: 150,
          height: 150,
        ),
      ),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
          ),
          itemCount: _listaHerois.length,
          itemBuilder: (BuildContext ctx, index) {
            return Column(
              children: [
                Card(
                  child: Container(
                    height: 475,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            _listaHerois[index].thumbnail!.path! + ".jpg"),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        '${_listaHerois[index].name}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  margin: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                )
              ],
            );
          }),
    );
  }

  Future<void> _buscaHerois() async {
    _listaHerois = await ConsumindoAPI.getCharacters('Hulk');
    setState(() {
      _listaHerois;
    });
  }
}
