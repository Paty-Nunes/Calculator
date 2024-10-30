import 'package:flutter/foundation.dart';  
import 'package:flutter/material.dart';  
import '../componentes/visor.dart'; // Certifique-se de que este caminho está correto  
import '../componentes/teclado.dart'; // Certifique-se de que este caminho está correto  
import '../modelos/memoria.dart'; // Certifique-se de que este caminho está correto  

class Calculadora extends StatefulWidget {  
  const Calculadora({super.key});  

  @override  
  State<Calculadora> createState() => _CalculadoraState();  
}  

class _CalculadoraState extends State<Calculadora> {  
  final Memoria memoria = Memoria();  

  // Função que lida com o comando pressionado e atualiza o visor  
  void _pressionado(String comando) {  
    if (kDebugMode) {  
      print(comando); // Exibe o comando pressionado no console em modo debug  
    }  

    // Atualiza a memória com o dígito pressionado e refresca a interface  
    setState(() {  
      memoria.tratarDigito(comando);  
    });  
  }  

  @override  
  Widget build(BuildContext context) {  
    return MaterialApp(  
      home: Scaffold(  
        body: Container(  
          padding: const EdgeInsets.all(10.0),  
          child: Column(  
            children: <Widget>[  
              Expanded(  
                flex: 2, // O visor ocupa aproximadamente 60% da tela  
                child: Visor(memoria.valor), // Exibindo o valor atual da memória no visor  
              ),  
              const SizedBox(height: 2),  
              Expanded(  
                flex: 10, 
                child: Teclado(_pressionado), // Chamando _pressionado ao pressionar um botão  
              ),  
            ],  
          ),  
        ),  
      ),  
    );  
  }  
}
