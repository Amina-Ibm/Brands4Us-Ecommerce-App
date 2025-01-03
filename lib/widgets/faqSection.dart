import 'package:flutter/material.dart';

class faqSection extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
      ExpansionTile(
      title: Text('Refund Policy'),
      children: [
        ListTile(
          title: Text('How long does it take to get a refund?'),
          subtitle: Text(
            'Refunds are typically processed within 5-7 business days.',
          ),
        ),
        ListTile(
          title: Text('What items are eligible for a refund?'),
          subtitle: Text(
            'Items in unused and original condition are eligible for a refund.',
          ),
        ),
      ],
    ),
    ExpansionTile(
    title: Text('Shipping Information'),
    children: [
    ListTile(
    title: Text('How much does shipping cost?'),
    subtitle: Text(
    'Shipping costs vary depending on location and order size.',
    ),
    ),
    ListTile(
    title: Text('Do you offer international shipping?'),
    subtitle: Text(
    'Yes, international shipping is available to select countries.',
    ),
    ),
    ],
    ),
    ExpansionTile(
    title: Text('Delivery Details'),
    children: [
    ListTile(
    title: Text('How long does delivery take?'),
    subtitle: Text(
    'Delivery times range from 3-10 business days depending on location.',
    ),
    ),
    ListTile(
    title: Text('Can I track my order?'),
    subtitle: Text(
    'Yes, tracking information will be provided once your order is shipped.',
    ),
    ),
    ],
    ),
    ]
    )
    );

  }

}