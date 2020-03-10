import '../helper/AnotacaoHelper.dart';

class Anotacao {

  int id;
  String titulo;
  String descricao;
  String data;

  Anotacao(this.titulo, this.descricao, this.data);

  Anotacao.fromMap(Map map){
    this.id = map[AnotacaoHelper.anotacaoColumId];
    this.titulo = map[AnotacaoHelper.anotacaoColumTitulo];
    this.descricao = map[AnotacaoHelper.anotacaoColumDescricao];
    this.data = map[AnotacaoHelper.anotacaoColumData];
  }

  Map toMap(){

    Map<String, dynamic> map = {
      "titulo": this.titulo,
      "descricao": this.descricao,
      "data": this.data,
    };

    if(this.id != null){
      map["id"] = this.id;
    }

    return map;

  }


}