
import 'package:flutter/material.dart';

class CronometroBotao extends StatelessWidget {
  final String texto;
  final IconData icone;
  final void Function()? click;
  final Color corTexto; // Nova propriedade para a cor do texto

  const CronometroBotao({
    required this.texto,
    required this.icone,
    this.click,
    this.corTexto = Colors.black, // Valor padrão para a cor do texto
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 20,
        ),
      ),
      onPressed: click,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 0.5),
            child: Icon(
              color: corTexto, // A cor do ícone
              icone,
              size: 35,
            ),
          ),
          Text(
            texto,
            style: TextStyle(
              color: corTexto, // A cor do texto
              fontSize: 27,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
