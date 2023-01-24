import 'package:flutter/material.dart';
import 'package:house_an_apartement/model/house.dart';
import 'package:house_an_apartement/screen/detail/detail.dart';
// import 'package:house_rent/model/house.dart';
// import 'package:house_rent/screen/detail/detail.dart';
// import 'package:house_rent/widget/circle_icon_button.dart';

class RecommendedHouse extends StatelessWidget {
  final recommendedList = House.generateRecommended();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      height: 340,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return DetailPage(house: recommendedList[index]);
                  }));
                },
                child: Container(
                  width: 230,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  recommendedList[index].imageUrl,
                                ),
                                fit: BoxFit.cover)),
                      ),
                      Positioned(
                        right: 15,
                        top: 15,
                        child: IconButton(onPressed: (){

                        }, icon: const Icon(Icons.bookmark),
                        color: Theme.of(context).colorScheme.secondary)
                        //  CircleIconButton(
                        //     iconUrl: 'assets/icons/mark.svg',
                        //     color: Theme.of(context).colorScheme.secondary),
                      ),
                      Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            color: Colors.white54,
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(recommendedList[index].name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1!
                                            .copyWith(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      recommendedList[index].address,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                IconButton(onPressed: (){

                        }, icon: const Icon(Icons.favorite),
                        color: Theme.of(context).colorScheme.secondary)
                                // CircleIconButton(
                                //     iconUrl: 'assets/icons/mark.svg',
                                //     color: Theme.of(context).colorScheme.secondary)
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              ),
          separatorBuilder: (_, index) => const SizedBox(width: 20),
          itemCount: recommendedList.length),
    );
  }
}