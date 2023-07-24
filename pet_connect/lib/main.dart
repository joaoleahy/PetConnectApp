import 'package:flutter/material.dart';
import 'screens/lista_animais_screen.dart';

void main() => runApp(const PetConnect());

class PetConnect extends StatelessWidget {
  const PetConnect({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ListaAnimaisScreen(),
    );
  }
}
