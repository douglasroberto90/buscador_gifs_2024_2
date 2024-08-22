import 'package:buscador_gifs_2024_2/pages/details_page.dart';
import 'package:flutter/material.dart';
import 'package:buscador_gifs_2024_2/repositories/repositorio.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Map<String, dynamic>> gifs;

  @override
  void initState() {
    gifs = Repositorio.buscarTrending();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/images/logo.png"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(label: Text("Digite sua pesquisa")),
              onSubmitted: (texto) {
                setState(() {
                  gifs = Repositorio.buscarGifs(texto);
                });
              },
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: gifs,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return Text(
                      "Aguarde",
                      style: TextStyle(fontSize: 20),
                    );
                  default:
                    if (snapshot.hasError) {
                      return Text(
                        "Deu ruim",
                        style: TextStyle(fontSize: 20),
                      );
                    } else {
                      return _criarGridDosGifs(context, snapshot);
                    }
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _criarGridDosGifs(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
      itemCount: 10,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Image.network(
              snapshot.data["data"][index]["images"]["fixed_height"]["url"]),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DetailsPage(snapshot.data["data"][index]);
            }));
          },
        );
      },
    );
  }
}
