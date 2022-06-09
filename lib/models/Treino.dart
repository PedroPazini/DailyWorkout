class Treino {
  late int? treino_id;
  late String titulo;

  Treino(this.treino_id, this.titulo);

  @override
  String toString() {
    return 'treino{titulo: $titulo}';
  }
}
