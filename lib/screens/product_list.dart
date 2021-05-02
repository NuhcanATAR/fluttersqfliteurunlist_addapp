import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_demo/data/dbHelper.dart';
import 'package:sqflite_demo/models/product.dart';

import 'Product_Add.dart';

class ProductList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ProductListState();
  }
}

class _ProductListState extends State<ProductList>{

  var dbHelper = DbHelper();/* database çağırdık */
  List<Product> products; /* product dosyasını çağırdık */
  int productCount = 0;

  @override
  void initState() => getProducts();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ürün Listesi"),
      ),
      body: buildProductList(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
         goToProductAdd();
        },
        child: Icon(
          Icons.add,
        ),
        tooltip: "Yeni Ürün Ekle",
      ),
    );
  }

  ListView buildProductList() {

    return ListView.builder(
        itemCount: productCount,
        itemBuilder: (BuildContext context, int position){
         return Card(
          color: Colors.cyan,
          elevation: 2.0,
           child: ListTile(
            leading: CircleAvatar(backgroundColor: Colors.black12,child: Text("A"),),
            title: Text(this.products[position].name),
            subtitle: Text(this.products[position].description),
            onTap: (){

            },
           ),
         );
        });
  }

  void goToProductAdd() async{
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) => ProductAdd(),),);
    if(result != null){
      if(result){
        getProducts();
      }
    }
  }

  void getProducts(){
    var productsFuture = dbHelper.getProducts();
    productsFuture.then((data){
      this.products = data;
      productCount = data.length;
    });
  }
}