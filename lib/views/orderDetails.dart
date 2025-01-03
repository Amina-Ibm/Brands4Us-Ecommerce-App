import 'package:choice/choice.dart';
import 'package:elo_clone/widgets/pastOrdersView.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OrderDetails extends StatefulWidget{
  OrderDetails({super.key});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  List<String> orderTypes = ['Delivered', 'Processing', 'En-route'];
  String? selectedOrderType;
   void setSelectedType( String? value){
    setState(() {
      selectedOrderType = value;
    });

  }


  @override
  Widget build(BuildContext context) {
    final Widget orderBody =  selectedOrderType == 'Delivered' ?
        Expanded(child: pastOrdersView())

        :Center(
          child: Lottie.asset(
            'assets/no_items_cart.json',
            height: 200.0,
            repeat: true,
            reverse: true,
            animate: true,
          )
      );
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: Padding(
          padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Choice<String>.inline(
              clearable: true,
              value: ChoiceSingle.value(selectedOrderType),
              onChanged: ChoiceSingle.onChanged(setSelectedType),
              itemCount: orderTypes.length,
              itemBuilder: (state, i) {
                return ChoiceChip(
                  selected: state.selected(orderTypes[i]),
                  onSelected: state.onSelected(orderTypes[i]),
                  label: Text(orderTypes[i]),
                );
              },
              listBuilder: ChoiceList.createScrollable(
                spacing: 10,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 25,
                ),
              ),
            ),
            orderBody

          ],
        ),
      ),
    );
  }
}