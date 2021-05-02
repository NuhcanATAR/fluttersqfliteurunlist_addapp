import 'package:flutter/material.dart';
import 'package:sqflite_demo/data/dbHelper.dart';
import 'package:sqflite_demo/models/product.dart';

class ProductAdd extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ProductAddState();
  }
}

class ProductAddState extends State{

  var dbHelper = DbHelper();

  TextEditingController txtName = TextEditingController();
  TextEditingController txtdescription = TextEditingController();
  TextEditingController txtunitPrice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ürün Kayıt Sayfası"),
      ),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            buildNameField(),
            buildDiscriptonField(),
            buildUnitPriceField(),
            buildSaveButton(),
          ],
        ),
      ),
    );
  }

  buildNameField() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Ürün Adı",
      ),
      controller: txtName,
    );
  }

  buildDiscriptonField() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Ürün Açıkalaması",
      ),
      controller: txtdescription,
    );
  }

  buildUnitPriceField() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Ürün Fiyatı",
      ),
      controller: txtunitPrice,
    );
  }

  buildSaveButton() {
    return FlatButton(
      child: Text("Ürünü Ekle"),
      onPressed: (){
        addProduct();
      },
    );
  }

  void addProduct() async{
   var result = await dbHelper.insert(Product(
        name:txtName.text,
        description:txtdescription.text,
        unitPrice: double.tryParse(txtunitPrice.text)
    ));
   Navigator.pop(context,true);
  }


}