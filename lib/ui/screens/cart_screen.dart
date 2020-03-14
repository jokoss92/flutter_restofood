import 'package:flutter/material.dart';
import 'package:restofood_api/core/models/cart_model.dart';
import 'package:restofood_api/core/services/cart_services.dart';
import 'package:restofood_api/ui/screens/detail_screen.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Restofood", style: TextStyle(color: Colors.white)),
        leading: Icon(
          Icons.fastfood,
          color: Colors.white,
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.add_circle,
                color: Colors.white,
              ))
        ],
      ),
      body: CartBody(),
    );
  }
}

class CartBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //Bagian ini untuk itemnya
          Text(
            "Keranjang Makanan & Minuman",
            style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          //Widget daftar makanan
          ListCart()
        ],
      ),
    );
  }
}

class ListCart extends StatefulWidget {
  @override
  _ListCartState createState() => _ListCartState();
}

class _ListCartState extends State<ListCart> {
  List<CartModel> carts;

  void loadData() async {
    var _carts = carts = await CartServices.getAll();
    setState(() {
      carts = carts;
    });
  }

  @override
  void initState() {
    super.initState();
    this.loadData();
  }

  @override
  Widget build(BuildContext context) {
    if (carts == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: carts.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Card(
                elevation: 1,
              ),
            );
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //Title
                Text(
                  carts[index].username,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            );
          }),
    );
  }
}
