import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Botao extends StatelessWidget {
  static const corPadrao = Color.fromRGBO(125, 122, 122, 1);
  static const corOperacao = Color.fromRGBO(5, 7, 6, 1);

  final String texto;
  final bool duplo;
  final Color cor;
  final void Function(String) callback;

  // Construtor principal
  const Botao({
    super.key,
    required this.texto,
    this.duplo = false,
    this.cor = const Color.fromARGB(255, 175, 173, 173),
    required this.callback,
  });

  // Construtor para operações
  const Botao.operacao({
    super.key,
    required this.texto,
    this.duplo = false,
    this.cor = corOperacao,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: duplo ? 2 : 1,
      child: CupertinoButton(
        color: cor,
        onPressed: () => callback(texto),
        child: Text(
          texto,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.w100,
          ),
        ),
      ),
    );
  }
}

