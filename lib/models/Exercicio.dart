class Exercicio {
  final int exercicio_id;
  late String nome;
  late int qtdSeries;
  late int qtdPeso;
  late int repeticoes;


  Exercicio(this.exercicio_id, this.nome, this.qtdSeries, this.qtdPeso, this.repeticoes);

  @override
  String toString() {
    return 'Exercicio{nome: $nome, Séries: $qtdSeries, Peso: $qtdPeso, Repetições: $repeticoes}';
  }
}
