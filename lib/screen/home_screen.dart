import 'package:flutter/material.dart';
import 'item_list_screen.dart';
import 'cart_screen.dart';
import 'package:quan_ly_muc/provider/item_monitor_provider.dart';
import 'item_monitoring_screen.dart';
import 'package:quan_ly_muc/model/item_model.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  final List<Item> _items = List.generate(
    100,
    (index) => Item(
      name: 'Mục ${index + 1}',
      value: 'Giá trị ${index + 1}',
      price: 10.0,
    ),
  );

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
    ); 
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void toggleMonitoring(Item item) {
    setState(() {
      item.isMonitoring = !item.isMonitoring;
    });
  }

  @override
  Widget build(BuildContext context) {
    final monitoredCount = _items.where((item) => item.isMonitoring).length;

    return ItemMonitorProvider(
      items: _items,
      monitoringItem: _items.where((item) => item.isMonitoring).toList(),
      toggleMonitoring: toggleMonitoring,
      child: Scaffold(
        appBar: AppBar(title: const Text('Ứng dụng của tôi')),
        body: TabBarView(
          controller: _tabController,
          children: [
            ItemListScreen(),
            ItemMonitoringScreen(),
            CartScreen(), 
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
              _tabController.animateTo(index);
            });
          },
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Danh sách mục',
            ),
            BottomNavigationBarItem(
              icon:
                  monitoredCount > 0
                      ? Badge.count(
                        count: monitoredCount,
                        child: const Icon(Icons.bar_chart),
                      )
                      : const Icon(Icons.bar_chart),
              label: 'Theo dõi',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.shopping_cart),
              label: 'Giỏ hàng',
            ),
          ],
        ),
      ),
    );
  }
}
