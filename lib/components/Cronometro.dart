import 'package:flutter/material.dart'; 
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:pomodoro/components/cronometroBotao.dart';
import 'package:pomodoro/store/pomodoro.store.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class Cronometro extends StatelessWidget {
  const Cronometro({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<PomodoroStore>(context);

    return Observer(
      builder: (_) {
        final timeString =
            '${store.minutos.toString().padLeft(2, '0')}:${store.segundos.toString().padLeft(2, '0')}';

        return TweenAnimationBuilder<double>(
          tween: Tween<double>(
            begin: 0.9,
            end: store.estaDescansando() ? 1.0 : 1.03,  
          ),
          duration: const Duration(milliseconds: 600), 
          curve: Curves.easeInOut, 
          builder: (context, scale, child) {
            return Transform.scale(
              scale: scale, 
              child: AnimatedContainer(
                duration: const Duration(seconds: 1),
                color: store.estaEstudando() ? Colors.orange : Colors.blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      store.estaEstudando() ? 'Hora de Estudar' : 'Hora de descansar',
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 42,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 65),
                    
                    // CustomPaint para o círculo animado
                    CustomPaint(
                      size: const Size(183, 183), // Tamanho do círculo
                      painter: TimerPainter(
                        animationValue: store.percentualTempo, // Adapte este valor com a lógica do MobX
                        backgroundColor: Colors.white24,
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          timeString,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 115,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 35),
                    Observer(builder: (_) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (!store.iniciado)
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: CronometroBotao(
                                texto: 'Iniciar',
                                icone: Icons.play_arrow,
                                click: store.iniciar,
                                corTexto: Colors.black, // Cor do texto do botão "Iniciar"
                              ),
                            ),
                          if (store.iniciado)
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: CronometroBotao(
                                texto: 'Parar',
                                icone: Icons.stop,
                                click: store.parar,
                                corTexto: Colors.red, // Cor do texto do botão "Parar"
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: CronometroBotao(
                              texto: 'Reiniciar',
                              icone: Icons.refresh,
                              click: store.reiniciar,
                              corTexto: Colors.black, // Cor do texto do botão "Reiniciar"
                            ),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

// Painter para desenhar o círculo de progresso
class TimerPainter extends CustomPainter {
  final double animationValue;
  final Color backgroundColor, color;

  TimerPainter({
    required this.animationValue,
    required this.backgroundColor,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    Paint progressPaint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    double progress = (1.0 - animationValue) * 2 * pi;

    // Desenhar o círculo de fundo
    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);

    // Desenhar o progresso
    canvas.drawArc(
      Offset.zero & size,
      -pi / 2,
      progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(TimerPainter oldDelegate) {
    return animationValue != oldDelegate.animationValue ||
        color != oldDelegate.color ||
        backgroundColor != oldDelegate.backgroundColor;
  }
}
