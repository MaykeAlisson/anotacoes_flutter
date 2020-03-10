import 'package:minhasanotacoes/model/Anotacao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AnotacaoHelper {

  // Constantes
  static final String nomeTabela = "anotacao";

  static final AnotacaoHelper _anotacaoHelper = AnotacaoHelper.internal();
  Database _db;

  factory AnotacaoHelper(){
    return _anotacaoHelper;
  }

  AnotacaoHelper.internal(){}

  get db async {
    if(_db != null){
      return _db;
    }else{
      _db = await inicializaDB();
      return _db;
    }
  }

  _oncreate(Database db, int version) async {

    String sql = "CREATE TABLE $nomeTabela("
        "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "titulo VARCHAR, descricao TEXT,"
        "data DATETIME)";
    await db.execute(sql);

  }


  inicializaDB() async{
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDeDados = join(caminhoBancoDados, "banco_minhas_anotacoes.db");
    
    var db = await openDatabase(localBancoDeDados, version: 1, onCreate: _oncreate );
    return db;
  }

  Future<int> salvarAnotacao(Anotacao anotacao) async {

    var bancoDeDados = await db;

    int result = await bancoDeDados.insert(nomeTabela, anotacao.toMap());
    return result;
  }

  Future<List> recuperarAnotacoes() async {

    var bancoDados = await db;
    String sql = "SELECT * FROM $nomeTabela ORDER BY data DESC";
    List anotacoes = await bancoDados.rawQuery(sql);
    return anotacoes;
  }

}
