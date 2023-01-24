import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:house_an_apartement/model/house.dart';

class DetailAppBar extends StatelessWidget {
  final House house;
  const DetailAppBar({Key? key, required this.house}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Stack(
        children: [
          Image.asset(
            house.imageUrl,
            fit: BoxFit.cover,
            height: double.infinity,
          ),
          SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    child: IconButton(onPressed: (){
                          Navigator.pop(context);
                    }, icon: const Icon(Icons.arrow_back))
                    // SvgPicture.asset('assets/icons/arrow.svg'),
                  ),
                ),
                Container(
                  child:IconButton(onPressed: (){

                  }, icon: const Icon(Icons.bookmark),
                  // SvgPicture.asset('assets/icons/mark.svg'),
                )
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}