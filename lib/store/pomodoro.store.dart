import 'dart:async';
import 'dart:ffi';
import 'package:flutter/rendering.dart';
import 'package:mobx/mobx.dart';

part 'pomodoro.store.g.dart';

class PomodoroStore = _PomodoroStore with _$PomodoroStore;

enum TipoIntervalo { estudo, descanso }

abstract class _PomodoroStore with Store {
  @observable
  bool iniciado = false;

  @observable
   int minutos = 2;

  @observable
   int segundos = 0;

  @observable
   int tempoEstudo = 2;

  @observable
   int tempoDescanso = 1;

  @observable
  TipoIntervalo tipoIntervalo = TipoIntervalo.estudo;

  Timer? cronometro;

  @action
  void iniciar() {
    iniciado = true;
    cronometro = Timer.periodic( const Duration(seconds: 1), (timer) {
      if (minutos == 0 && segundos == 0) {
        _trocarTipoIntervalo();
      } else if (segundos == 0) {
        segundos = 59;
        minutos--;
      } else {
        segundos--;
      }
    });
  }

  @action
  void parar() {
    iniciado = false;
    cronometro?.cancel();
  }

  @action
  void reiniciar() {
    parar();
    minutos = estaEstudando() ? tempoEstudo : tempoDescanso;
    segundos = 0;
  }

  @action
  void incrementarTempoEstudo() {
    tempoEstudo++;
    if (estaEstudando()) {
      reiniciar();
    }
  }

  @action
  void decrementarTempoEstudo() {
    if (tempoEstudo > 1) {
      tempoEstudo--;
      if (estaEstudando()) {
        reiniciar();
      }
    }
  }

  @action
  void incrementarTempoDescanso() {
    tempoDescanso++;
    if (estaDescansando()) {
      reiniciar();
    }
  }

  @action
  void decrementarTempoDescanso() {
    if (tempoDescanso > 1) {
      tempoDescanso--;
      if (estaDescansando()) {
        reiniciar();
      }
    }
  }
  

  bool podeDecrementarTempoEstudo(){
    return tempoEstudo > 1; 
  }

  bool podeDecrementarTempoDescanso(){
    return tempoDescanso >1;
  }

  bool estaEstudando() {
    return tipoIntervalo == TipoIntervalo.estudo;
  }

  bool estaDescansando() {
    return tipoIntervalo == TipoIntervalo.descanso;
  }

  void _trocarTipoIntervalo() {
    if (estaEstudando()) {
      tipoIntervalo = TipoIntervalo.descanso;
      minutos = tempoDescanso;
    } else {
      tipoIntervalo = TipoIntervalo.estudo;
      minutos = tempoEstudo;
    }
    segundos = 0;
  }

  @computed
  double get percentualTempo {
    final totalSegundos = estaEstudando() ? tempoEstudo * 60 : tempoDescanso * 60;
    final segundosRestantes = minutos * 60 + segundos;
    return segundosRestantes / totalSegundos;
  }
}
