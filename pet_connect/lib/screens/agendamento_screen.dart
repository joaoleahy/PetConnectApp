import 'package:flutter/material.dart';
import 'confirmacao_screen.dart';
import '../utils/utils.dart';

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
                    ? 'Hora selecionada: ${Utils.formatTime(selectedTime!)}'
                    : 'Selecionar Hora',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (selectedDate != null && selectedTime != null) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConfirmacaoScreen(
                        animal: widget.animal,
                        data: selectedDate!,
                        hora: selectedTime!,
                      ),
                    ),
                    (route) => route.isFirst,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'Selecione data e hora para agendar a entrevista.'),
                    ),
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
