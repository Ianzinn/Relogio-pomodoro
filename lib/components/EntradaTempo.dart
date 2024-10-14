import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../store/pomodoro.store.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EntradaTempo extends StatelessWidget {
  final String titulo;
  final int valor;
  final void Function()? inc;
  final void Function()? dec;

  const EntradaTempo({
    required this.titulo,
    required this.valor,
    this.inc,
    this.dec,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<PomodoroStore>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        
        Text(
          titulo,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 0.3),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: dec,
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(15),
                backgroundColor:
                    store.estaEstudando() ? Colors.orange : Colors.blue,
              ),
              child: const Icon(
                FontAwesomeIcons.arrowDown,
                size: 20,
                color: Colors.white,
              ),
            ),
            Text(
              '$valor min',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
            ElevatedButton(
              onPressed: inc,
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(15),
                backgroundColor:
                    store.estaEstudando() ? Colors.orange : Colors.blue,
              ),
              child: const Icon(
                FontAwesomeIcons.arrowUp,
                size: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
