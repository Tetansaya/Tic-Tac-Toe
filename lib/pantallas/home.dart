import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'controles.dart';
import '../config/config.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ControlesState> _controlesKey = GlobalKey<ControlesState>();

  int victoriasX = 0;
  int victoriasO = 0;
  int empates = 0;

  void actualizarEstadisticas(estados ganador) {
    setState(() {
      if (ganador == estados.cruz) {
        victoriasX++;
      } else if (ganador == estados.circulo) {
        victoriasO++;
      } else {
        empates++;
      }
    });
  }

  void reiniciarJuego() {
    setState(() {
      tablero = List.filled(9, estados.vacio);
      _controlesKey.currentState?.reiniciarTablero();
      victoriasX = 0;
      victoriasO = 0;
      empates = 0;
    });
  }

  void limpiarTablero() {
    setState(() {
      tablero = List.filled(9, estados.vacio);
    });
  }

  void salirJuego() {
    SystemNavigator.pop();
    exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tik Tak Toe'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String result) {
              if (result == 'reiniciar') {
                reiniciarJuego();
              } else if (result == 'limpiar') {
                limpiarTablero();
              } else if (result == 'salir') {
                salirJuego();
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'reiniciar',
                child: Text('Reiniciar'),
              ),
              const PopupMenuItem<String>(
                value: 'limpiar',
                child: Text('Limpiar tablero'),
              ),
              const PopupMenuItem<String>(
                value: 'salir',
                child: Text('Salir'),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              "images/board.png",
              fit: BoxFit.cover,
            ),
            Controles(
              key: _controlesKey,
              actualizarEstadisticas: actualizarEstadisticas,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text('X: $victoriasX'),
            Text('O: $victoriasO'),
            Text('Empates: $empates'),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: reiniciarJuego,
            ),
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: limpiarTablero,
            ),
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: salirJuego,
            ),
          ],
        ),
      ),
    );
  }
}
