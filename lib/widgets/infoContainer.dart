import 'package:flutter/material.dart';

class infoContainer extends StatelessWidget{
  infoContainer({super.key, required this.infoText, required this.infoCaption });
  final String infoText;
  final String infoCaption;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 120,
      width: 140,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
          child: Column(
            children: [
              Text(infoText,
                style: Theme.of(context).textTheme.displayMedium,),
              SizedBox(height: 5,),
              Text(infoCaption,
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.center,)
            ],
          )
      ),
    );
  }

}