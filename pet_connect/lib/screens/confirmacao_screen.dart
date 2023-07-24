import 'package:flutter/material.dart';
import '../utils/utils.dart';
import 'lista_animais_screen.dart'; // Importe a tela ListaAnimaisScreen

class ConfirmacaoScreen extends StatelessWidget {
  final Map<String, String> animal;
  final DateTime data;
  final TimeOfDay hora;
  final String entrevistador;

  const ConfirmacaoScreen({
    Key? key,
    required this.animal,
    required this.data,
    required this.hora,
    required this.entrevistador,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrevista Agendada'),
        automaticallyImplyLeading: false, // Remover o botão de voltar padrão
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(animal['foto']!),
              radius: 50,
            ),
            const SizedBox(height: 20),
            Text(
              animal['nome']!,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Entrevista marcada para: ${data.day}/${data.month}/${data.year} às ${Utils.formatTime(hora)}',
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              'Entrevistador: $entrevistador',
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListaAnimaisScreen(),
                  ),
                  (route) =>
                      false, // Remove todas as rotas exceto a tela inicial
                );
              },
              child: const Text('Voltar para a Lista'),
            ),
          ],
        ),
      ),
    );
  }
}
