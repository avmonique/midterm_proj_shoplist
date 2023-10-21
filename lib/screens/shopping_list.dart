import 'package:flutter/material.dart';

class ShoppingListScreen extends StatefulWidget {
  const ShoppingListScreen({Key? key}) : super(key: key);

  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  List<ShoppingItem> shoppingItems = [];
  List<ShoppingItem> selectedItems = [];

  TextEditingController itemController = TextEditingController();

  void addItem() {
    String itemName = itemController.text.trim();
    if (itemName.isNotEmpty) {
      setState(() {
        shoppingItems.add(ShoppingItem(name: itemName, isDone: false));
        itemController.clear();
      });
    }
  }

  void clearSelectedItems() {
    setState(() {
      shoppingItems.removeWhere((item) => selectedItems.contains(item));
      selectedItems.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.check_circle_outlined),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text("Shopping List"),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.cleaning_services),
            onPressed: clearSelectedItems,
          ),
        ],
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(16.0),
            elevation: 4,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TextField(
                    controller: itemController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Item"),
                      ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: addItem, 
                    child: Text("Add"),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: shoppingItems.length,
              itemBuilder: (_, index) {
                return ShoppingListItem(
                  item: shoppingItems[index],
                  onChecked: (isChecked) {
                    setState(() {
                      shoppingItems[index].isDone = isChecked ?? false;
                      if (isChecked ?? false) {
                        selectedItems.add(shoppingItems[index]);
                      } else {
                        selectedItems.remove(shoppingItems[index]);
                      }
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ShoppingItem {
  final String name;
  bool isDone;

  ShoppingItem({required this.name, required this.isDone});
}

class ShoppingListItem extends StatelessWidget {
  final ShoppingItem item;
  final Function(bool?) onChecked;

  ShoppingListItem({required this.item, required this.onChecked});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ListTile(
          title: Text(
            item.name,
            style: TextStyle(
              decoration: item.isDone ? TextDecoration.lineThrough : null,
            ),
          ),
          trailing: Checkbox(
            value: item.isDone,
            onChanged: onChecked,
            activeColor: Colors.grey,
          ),
        ),
      ),
    );
  }
}
