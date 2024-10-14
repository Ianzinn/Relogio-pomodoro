import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pomodoro/components/Cronometro.dart';
import 'package:pomodoro/components/EntradaTempo.dart';
import 'package:provider/provider.dart';
import '../store/pomodoro.store.dart';

class Pomodoro extends StatelessWidget {
  const Pomodoro({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<PomodoroStore>(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Expanded(
            child: Cronometro(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 35),
            child: Observer(
              builder: (_) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  EntradaTempo(
                    titulo: 'Estudo',
                    valor: store.tempoEstudo,
                    inc: store.iniciado && store.estaEstudando()
                        ? null 
                        : store.incrementarTempoEstudo,
                    dec: store.iniciado && store.estaEstudando() || !store.podeDecrementarTempoEstudo()
                        ? null // aqui é a parte onde se o tempo for <= 1 ele desabilita o botão 
                        : store.decrementarTempoEstudo,
                  ),
                  EntradaTempo(
                    titulo: 'Descanso',
                    valor: store.tempoDescanso,
                    inc: store.iniciado && store.estaDescansando()
                        ? null 
                        : store.incrementarTempoDescanso,
                    dec: store.iniciado && store.estaDescansando() || !store.podeDecrementarTempoDescanso()
                        ? null // aqui é a parte onde se o tempo for <= 1 ele desabilita o botão 
                        : store.decrementarTempoDescanso,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
