import 'package:flutter/material.dart';
import 'package:ups_clone/models/types.model.dart';
import 'package:ups_clone/widgets/mapWidget.dart';

class DeliveryCard extends StatelessWidget {
  DeliveryCard({
    Key? key,
    required this.order,
    required this.size,
    required this.color,
  }) : super(key: key);
  OrderList order;
  Color color;
  double size;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.5),
              offset: Offset(-2, 0),
              blurRadius: 12,
            ),
            BoxShadow(
              color: color.withOpacity(0.5),
              offset: Offset(2, 0),
              blurRadius: 12,
            ),
          ]),
      child: Column(children: [
        const Icon(
          Icons.inventory,
          size: 32,
          color: Colors.white,
        ),
        Text(
          "${order.value!.carrier!.toUpperCase()}-${order.value!.trackingId}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          "Expected Delivery: ${order.value!.createdAt!.toString().substring(0, 11)}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        Divider(
          color: Colors.white,
          thickness: 1,
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          "Address",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        Text(
          "${order.value!.address}, ${order.value!.city}",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        Text(
          "Shipping Cost: ${order.value!.shippingCost} USD",
          style: TextStyle(
            color: Colors.white,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ListView.builder(
            shrinkWrap: true,
            itemCount: order.value?.trackingItems?.items?.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        order.value!.trackingItems!.items![index].name!,
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "x ${order.value!.trackingItems!.items![index].quantity!.toString()}",
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              );
            }),
        MapWidget(
          lat: order.value!.lat!,
          long: order.value!.lng!,
          address: order.value!.address!,
          size: size,
        ),
      ]),
    );
  }
}
