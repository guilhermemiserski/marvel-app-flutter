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
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          itemCount: _listaHerois.length,
          itemBuilder: (BuildContext ctx, index) {
            return Column(
              children: [
                Image(
                  image: NetworkImage(
                      _listaHerois[index].thumbnail!.path! + ".jpg"),
                  width: 100,
                  height: 100,
                ),
                Text('${_listaHerois[index].name}')
              ],
            );
          }),
    );
  }

  Future<void> _buscaHerois() async {
    _listaHerois = await ConsumindoAPI.getCharacters('Spider');
    setState(() {
      _listaHerois;
    });
  }
}
