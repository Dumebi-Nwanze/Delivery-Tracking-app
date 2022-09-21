import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ups_clone/models/types.model.dart';
import 'package:ups_clone/screens/ordersDetailsScreen.dart';

class OrderCard extends StatelessWidget {
  OrderCard({
    Key? key,
    required this.order,
  }) : super(key: key);
  OrderList order;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => OrderDetails(
              order: order,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Icon(
                  Icons.local_shipping,
                  color: Colors.blue.shade400,
                ),
                Text(
                  DateFormat('EEEE, d MMM yyyy')
                      .format(order.value!.createdAt!),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  "${order.value!.carrier!}-${order.value!.trackingId}",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                Text(
                  order.value!.trackingItems!.customer!.name!,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "x ${order.value!.trackingItems!.items!.length}",
                      style: TextStyle(
                        color: Colors.blue.shade400,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(Icons.view_in_ar_outlined),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
