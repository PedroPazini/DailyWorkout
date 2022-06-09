class TreinoFinalizado {
  late int? treino_id;
  late String titulo;
  late String dataFinalizado;

  TreinoFinalizado(this.treino_id, this.titulo, this.dataFinalizado);

  @override
  String toString() {
    return 'treino{titulo: $titulo, dataFinalizado: $dataFinalizado}';
  }
}
