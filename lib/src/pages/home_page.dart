import 'package:flutter/material.dart';
import 'package:marvel_api/src/models/character.dart';
import '../controller/consumindoAPI.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

List<Character> listaHerois = [];
String heroiPesquisado = 'Hulk';

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    buscaHerois(heroiPesquisado);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: MySearchDelegate());
            },
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
      body: buildGridHerois(),
    );
  }

  Future<void> buscaHerois(heroiPesquisado) async {
    listaHerois = await ConsumindoAPI.getCharacters(heroiPesquisado);
    setState(() {
      listaHerois;
    });
  }

  Widget buildGridHerois() {
    buscaHerois(heroiPesquisado);
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
        ),
        itemCount: listaHerois.length,
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
                          listaHerois[index].thumbnail!.path! + ".jpg"),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      '${listaHerois[index].name}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                margin: const EdgeInsets.only(
                    left: 10, right: 10, top: 10, bottom: 10),
              )
            ],
          );
        });
  }
}

class MySearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              heroiPesquisado = query;
              close(context, null);
              showResults(context);
            }
          },
          icon: const Icon(Icons.search))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildGridHerois();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> sugestoes = [
      'Spider-Man',
      'Hulk',
      'Thor',
      'Iron Man',
      'Ant-man',
      'Wasp',
      'Hawkeye',
      'Wolverine',
      'Star-lord'
    ];
    return ListView.builder(
      controller: ScrollController(),
      itemCount: sugestoes.length,
      itemBuilder: (context, index) {
        final sugestao = sugestoes[index];
        return ListTile(
          title: Text(sugestao),
          onTap: () {
            query = sugestao;
            heroiPesquisado = sugestao;
            close(context, null);
            showResults(context);
          },
        );
      },
    );
  }

  Widget buildGridHerois() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
        ),
        itemCount: listaHerois.length,
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
                          listaHerois[index].thumbnail!.path! + ".jpg"),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      '${listaHerois[index].name}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                margin: const EdgeInsets.only(
                    left: 10, right: 10, top: 10, bottom: 10),
              )
            ],
          );
        });
  }
}
