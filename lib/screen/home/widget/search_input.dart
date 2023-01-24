import 'dart:math';

import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
            height: 35,
            width: 100,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              border: Border.all(width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: OutlinedButton.icon(
              onPressed: () {
                showModalBottomSheet(context: context, builder: (context){
              return SizedBox(
                height: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      child: TextButton(onPressed: (){

                      }, child: Text('Newest',style: TextStyle(fontWeight: FontWeight.bold),)),
                    ),
                    Container(
                      child: TextButton(onPressed: (){

                      }, child: Text('Price(High to Low)',style: TextStyle(fontWeight: FontWeight.bold),)),
                    ),
                    Container(
                      child: TextButton(onPressed: (){

                      }, child: Text('Price(Low to High)',style: TextStyle(fontWeight: FontWeight.bold),)),
                    ),
                    
                  ],
                ),
              );
              
                }
                );
                child: const Text(
    'Choose Option',
    style: TextStyle(fontSize: 24),
  );
              },
              icon: const Icon(
                Icons.sort_rounded,
                size: 27.0,
              ),
              label: const Text('Sort'),
            ),
          ),
          Container(
            height: 35,
            width: 100,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              border: Border.all(width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.filter_alt_outlined,
                size: 27.0,
              ),
              label: const Text('Fiter'),
            ),
          ),
        ]);
  }
}