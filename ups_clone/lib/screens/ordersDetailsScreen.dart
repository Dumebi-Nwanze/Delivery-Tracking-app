import 'package:flutter/material.dart';
import 'package:ups_clone/models/types.model.dart';
import 'package:ups_clone/widgets/deliveryCard.dart';

class OrderDetails extends StatelessWidget {
  OrderDetails({Key? key, required this.order}) : super(key: key);

  OrderList order;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue.shade400,
        elevation: 0,
        centerTitle: true,
        title: Text(order.value!.trackingItems!.customer!.name!),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DeliveryCard(
            order: order,
            color: Colors.blue.shade400,
            size: 270,
          ),
        ),
      ),
    );
  }
}
