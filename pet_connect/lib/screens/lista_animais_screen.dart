import 'package:flutter/material.dart';
import 'agendamento_screen.dart';

class ListaAnimaisScreen extends StatelessWidget {
  final List<Map<String, String>> animais = [
    {
      'nome': 'Gato Tricolor',
      'foto': 'images/gato-tricolor.jpg',
    },
    {
      'nome': 'Gato Cinza',
      'foto': 'images/gato-cinza.jpg',
    },
    {
      'nome': 'Cachorro Caramelo',
      'foto': 'images/cachorro-caramelo.jpg',
    },
    {import 'package:flutter/material.dart';
import 'agendamento_screen.dart';

class ListaAnimaisScreen extends StatelessWidget {
  final List<Map<String, String>> animais = [
    {
      'nome': 'Gato Tricolor',
      'foto': 'images/gato-tricolor.jpg',
    },
    {
      'nome': 'Gato Cinza',
      'foto': 'images/gato-cinza.jpg',
    },
    {
      'nome': 'Cachorro Caramelo',
      'foto': 'images/cachorro-caramelo.jpg',
    },
    {
      'nome': 'Cachorro Preto',
      'foto': 'images/vira-lata-filhote-1.png',
    },
  ];

  final List<String> entrevistadores = [
    'João da Silva',
    'Maria Oliveira',
    'Pedro Santos',
    'Ana Souza',
  ];

  ListaAnimaisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PetConnect')),
      body: ListView.builder(
        itemCount: animais.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(animais[index]['foto']!),
            ),
            title: Text(animais[index]['nome']!),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AgendamentoScreen(
                      animal: animais[index], entrevistadores: entrevistadores),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

      'nome': 'Cachorro Preto',
      'foto': 'images/vira-lata-filhote-1.png',
    },
  ];

  final List<String> entrevistadores = [
    'João da Silva',
    'Maria Oliveira',
    'Pedro Santos',
    'Ana Souza',
  ];

  ListaAnimaisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PetConnect')),
      body: ListView.builder(
        itemCount: animais.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(animais[index]['foto']!),
            ),
            title: Text(animais[index]['nome']!),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AgendamentoScreen(
                      animal: animais[index], entrevistadores: entrevistadores),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
