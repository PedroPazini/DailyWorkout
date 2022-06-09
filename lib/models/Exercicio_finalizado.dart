class ExercicioFinalizado {
  final int exercicio_id;
  late String nome;
  late int qtdSeries;
  late int qtdPeso;
  late int repeticoes;
  late int qtdSeriesFeitas;



  ExercicioFinalizado(this.exercicio_id, this.nome, this.qtdSeries, this.qtdPeso, this.repeticoes, this.qtdSeriesFeitas);

  @override
  String toString() {
    return 'Exercicio{nome: $nome, Séries: $qtdSeries, Peso: $qtdPeso, Repetições: $repeticoes, SeriesFeitas: $qtdSeriesFeitas}';
  }
}
