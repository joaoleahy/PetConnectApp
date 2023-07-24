import 'package:flutter/material.dart';
import 'confirmacao_screen.dart';
import '../utils/utils.dart';
import 'lista_animais_screen.dart';

class AgendamentoScreen extends StatefulWidget {
  final Map<String, String> animal;
  final List<String> entrevistadores;

  const AgendamentoScreen(
      {super.key, required this.animal, required this.entrevistadores});

  @override
  _AgendamentoScreenState createState() => _AgendamentoScreenState();
}

class _AgendamentoScreenState extends State<AgendamentoScreen> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? selectedEntrevistador;

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
      final DateTime currentTime = DateTime.now();
      final DateTime pickedDateTime = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        picked.hour,
        picked.minute,
      );
      if (pickedDateTime.isAfter(currentTime)) {
        setState(() {
          selectedTime = picked;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Selecione um horário válido.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agendamento de Adoção')),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.animal['foto']!),
              radius: 50,
            ),
            const SizedBox(height: 20),
            const Text(
              'Escolhendo um animal para adoção:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              widget.animal['nome']!,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 40),
            const Text(
              'Escolha um entrevistador:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: selectedEntrevistador,
              hint: const Text('Selecione um entrevistador'),
              onChanged: (String? newValue) {
                setState(() {
                  selectedEntrevistador = newValue;
                });
              },
              items: widget.entrevistadores
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 40),
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
                    ? 'Hora selecionada: ${Utils.formatTime(selectedTime!)}'
                    : 'Selecionar Hora',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (selectedDate != null &&
                    selectedTime != null &&
                    selectedEntrevistador != null) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConfirmacaoScreen(
                        animal: widget.animal,
                        data: selectedDate!,
                        hora: selectedTime!,
                        entrevistador: selectedEntrevistador!,
                      ),
                    ),
                    (route) => route.isFirst,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'Selecione data, hora e entrevistador para agendar a entrevista.'),
                    ),
                  );
                }
              },
              child: const Text('Agendar Entrevista'),
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
        )
          ],
        )
      ),
    );
  }
}
