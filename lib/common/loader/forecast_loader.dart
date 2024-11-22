import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../main.dart';

class WeatherShimmerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        height: height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF74ABE2), Color(0xFF5588EE)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back Button and Settings Icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    shimmerContainer(width: 50, height: 20),
                    shimmerContainer(width: 30, height: 30),
                  ],
                ),
                SizedBox(height: 20),
                // Today's Weather Section
                shimmerContainer(width: 100, height: 20),
                SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      5,
                          (index) => Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: Column(
                          children: [
                            shimmerContainer(width: 70, height: 70, shape: BoxShape.circle),
                            SizedBox(height: 8),
                            shimmerContainer(width: 60, height: 20,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Next Forecast Section
                shimmerContainer(width: 150, height: 20),
                SizedBox(height: 10),
                ListView.builder(
                  itemCount: 5,
                  physics: NeverScrollableScrollPhysics()
                  ,shrinkWrap: true,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: shimmerContainer(
                      height: 100,

                      width: width*0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          shimmerContainer(width: 80, height: 20),
                          Row(
                            children: [
                              shimmerContainer(width: 30, height: 30, shape: BoxShape.circle),
                              SizedBox(width: 16),
                              shimmerContainer(width: 40, height: 20),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget shimmerContainer({required double width, required double height, BoxShape shape = BoxShape.rectangle,Widget child =const SizedBox()}) {
    return Shimmer.fromColors(
      baseColor: Colors.white.withOpacity(0.2),
      highlightColor: Colors.white.withOpacity(0.4),
      child: Container(
        width: width,
        height: height,
        child: child,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          shape: shape,
          borderRadius: shape == BoxShape.rectangle ? BorderRadius.circular(19) : null,
        ),
      ),
    );
  }
}