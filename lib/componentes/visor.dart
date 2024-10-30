import 'package:flutter/material.dart';  
import 'package:auto_size_text/auto_size_text.dart';  

class Visor extends StatelessWidget {  
  final String texto;  
  const Visor(this.texto, {super.key});  

  @override  
  Widget build(BuildContext context) {  
    return Container(  
      color: const Color.fromRGBO(48, 48, 48, 1),  
      child: Column(  
        mainAxisAlignment: MainAxisAlignment.end,  
        crossAxisAlignment: CrossAxisAlignment.stretch,  
        children: <Widget>[  
          Padding(  
            padding: const EdgeInsets.all(10.0),  
            child: AutoSizeText(  
              texto,  
              minFontSize: 20,  
              maxFontSize: 80,  
              maxLines: 1,  
              textAlign: TextAlign.end,  
              style: const TextStyle(  
                fontWeight: FontWeight.normal,  
                decoration: TextDecoration.none,  
                color: Color.fromRGBO(218, 218, 218, 1),  
              ),  
            ),  
          ),  
        ],  
      ),  
    );  
  }  
}  