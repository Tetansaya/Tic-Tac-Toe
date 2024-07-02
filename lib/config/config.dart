library config.globals;

enum estados { vacio, cruz, circulo }

List<estados> tablero = List.filled(9, estados.vacio);
Map<estados, bool> resultado = {estados.cruz: false, estados.circulo: false};
