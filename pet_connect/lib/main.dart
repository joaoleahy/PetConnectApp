import 'package:flutter/material.dart';

void main() => runApp(const AdocaoApp());

class AdocaoApp extends StatelessWidget {
  const AdocaoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ListaAnimaisScreen(),
    );
  }
}

class ListaAnimaisScreen extends StatelessWidget {
  final List<Map<String, String>> animais = [
    {
      'nome': 'Gato Tricolor',
      'foto': 'images/gato-tricolor',
    },
    {
      'nome': 'Gato Cinza',
      'foto': 'images/gato-cinza',
    },
    {
      'nome': 'Cachorro Caramelo',
      'foto': 'images/cachorro-caramelo',
    },
    {
      'nome': 'Cachorro Preto',
      'foto': 'images/vira-lata-filhote-1',
    },
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
                  builder: (context) =>
                      AgendamentoScreen(animal: animais[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class AgendamentoScreen extends StatefulWidget {
  final Map<String, String> animal;

  const AgendamentoScreen({super.key, required this.animal});

  @override
  _AgendamentoScreenState createState() => _AgendamentoScreenState();
}

class _AgendamentoScreenState extends State<AgendamentoScreen> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agendamento de Entrevista')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.animal['foto']!),
              radius: 50,
            ),
            const SizedBox(height: 20),
            Text(
              widget.animal['nome']!,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text(selectedDate != null
                  ? 'Data selecionada: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                  : 'Selecionar Data'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectTime(context),
              child: Text(
                selectedTime != null
                    ? 'Hora selecionada: ${selectedTime!.hour}:${selectedTime!.minute}'
                    : 'Selecionar Hora',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (selectedDate != null && selectedTime != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConfirmacaoScreen(
                        animal: widget.animal,
                        data: selectedDate!,
                        hora: selectedTime!,
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text(
                            'Selecione data e hora para agendar a entrevista.')),
                  );
                }
              },
              child: const Text('Agendar Entrevista'),
            ),
          ],
        ),
      ),
    );
  }
}

class ConfirmacaoScreen extends StatelessWidget {
  final Map<String, String> animal;
  final DateTime data;
  final TimeOfDay hora;

  const ConfirmacaoScreen(
      {super.key,
      required this.animal,
      required this.data,
      required this.hora});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Entrevista Agendada')),
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
              'Entrevista marcada para: ${data.day}/${data.month}/${data.year} às ${hora.hour}:${hora.minute}',
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Voltar para a tela inicial
              },
              child: const Text('Voltar para a Lista'),
            ),
          ],
        ),
      ),
    );
  }
}
