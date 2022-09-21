import 'package:flutter/material.dart';
import 'package:ups_clone/models/types.model.dart';
import 'package:ups_clone/widgets/orderCard.dart';

class OrdersScreen extends StatefulWidget {
  OrdersScreen({
    Key? key,
    required this.ordersList,
  }) : super(key: key);
  List<OrderList> ordersList;
  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool ascending = false;
  @override
  void initState() {
    super.initState();
    sortList();
  }

  sortList() {
    widget.ordersList.sort((a, b) {
      if (ascending) {
        return a.value!.createdAt!.compareTo(b.value!.createdAt!);
      } else {
        return b.value!.createdAt!.compareTo(a.value!.createdAt!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade400,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/orders.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  ascending = !ascending;
                  sortList();
                });
              },
              child: Container(
                margin: EdgeInsets.all(10),
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    ascending
                        ? "Showing: Oldest First"
                        : "Showing: Most Recent First",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: widget.ordersList.length,
                itemBuilder: (context, index) {
                  return OrderCard(
                    order: widget.ordersList[index],
                  );
                })
          ],
        ),
      ),
    );
  }
}
