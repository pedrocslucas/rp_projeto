
class InformacoesObra {
  final String identificacao;
  final String construtora;
  final String cnpj;

  InformacoesObra({
    required this.identificacao,
    required this.construtora,
    required this.cnpj,
  });

  factory InformacoesObra.fromJson(Map<String, dynamic> json) {
    return InformacoesObra(
      identificacao: json['identificacao'] ?? '',
      construtora: json['construtora'] ?? '',
      cnpj: json['cnpj'] ?? '',
    );
  }
}
