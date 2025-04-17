import 'package:flutter/material.dart';
import 'package:quan_ly_muc/provider/item_monitor_provider.dart';
import 'package:quan_ly_muc/model/item_model.dart';


class ItemListScreen extends StatefulWidget {
  const ItemListScreen({super.key});

  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  void _addToCart(Item item) {
    setState(() {
      item.isInCart = !item.isInCart; // Thêm hoặc bỏ mục khỏi giỏ hàng
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ItemMonitorProvider.of(context);

    if (provider == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Danh sách mục')),
        body: Center(child: Text('Lỗi: Không thể tải dữ liệu.')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Danh sách mục')),
      body: ListView.builder(
        itemCount: provider.items.length,
        itemBuilder: (context, index) {
          final item = provider.items[index];
          return Dismissible(
            key: ValueKey(item.name),
            onDismissed: (direction) {
              setState(() {
                provider.items.removeAt(index); 
              });
            },
            child: ListTile(
              title: Text(item.name),
              subtitle: Text('Giá: \$${item.price}'),
              trailing: IconButton(
                icon: Icon(
                  item.isInCart
                      ? Icons.remove_shopping_cart
                      : Icons.add_shopping_cart,
                ),
                onPressed: () => _addToCart(item), // Thêm vào giỏ hàng
              ),
              onTap: () => provider.toggleMonitoring(item),
            ),
          );
        },
      ),
    );
  }
}
