import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_demo/models/product.dart';

class DbHelper{

  Database _db;

  Future<Database> get db async{
    if(_db == null){
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async{
    String dbPath = join(await getDatabasesPath(),"etrade.db");
    var etradeDb = await openDatabase(dbPath,version: 1,onCreate: createDb);
    return etradeDb;
  }

  void createDb(Database db, int version) async{
    await db.execute("Create table products(id integer primary key,name text,description text,unitPrice integer)");
  }

  /* listeleme */
  Future<List<Product>> getProducts() async{
    Database db = await this.db;
    var result  = await db.query("products");
    return List.generate(result.length, (i){
      return Product.fromObject(result[i]);
    });
  }

  /* ekleme */
  Future<int> insert(Product product) async{
    Database db = await this.db;
    var result  = await db.insert("products",product.toMap());
  }

  /* silme */
  Future<int> delete(int id) async{
    Database db = await this.db;
    var result  = await db.rawDelete("delete from products where id= $id");
    return result;
  }

  /* Güncelleme */
  Future<int> update(Product product) async{
    Database db = await this.db;
    var result  = await db.update("products", product.toMap(), where: "id = ?",whereArgs: [product.id]);
    return result;
  }



}