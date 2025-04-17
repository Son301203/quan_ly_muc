import 'package:flutter/material.dart';
import 'package:quan_ly_muc/provider/item_monitor_provider.dart';
import 'package:quan_ly_muc/model/item_model.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void _removeFromCart(Item item) {
    setState(() {
      item.isInCart = false; // Xóa mục khỏi giỏ hàng
    });
  }

  @override
Widget build(BuildContext context) {
  final provider = ItemMonitorProvider.of(context);
  final cartItems = provider?.items.where((item) => item.isInCart).toList() ?? [];

  double totalPrice = cartItems.fold(0.0, (total, item) => total + item.price);

  return Scaffold(
    appBar: AppBar(title: const Text('Giỏ hàng')),
    body: cartItems.isEmpty
        ? Center(child: Text('Giỏ hàng trống.'))
        : ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final item = cartItems[index];
              return ListTile(
                title: Text(item.name),
                subtitle: Text('Giá: \$${item.price}'),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red,),
                  onPressed: () {
                    _removeFromCart(item);  
                  },
                ),
              );
            },
          ),
    bottomNavigationBar: BottomAppBar(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Tổng: \$${totalPrice.toStringAsFixed(2)}'),
      ),
    ),
  );
}
}