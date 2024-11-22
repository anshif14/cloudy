import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:shimmer/shimmer.dart';

import '../../main.dart';

Widget homeShimmerEffect() {
  return Container(
    width: double.infinity,
    height: double.infinity,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF74ABE2), Color(0xFF5588EE)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
    child: SafeArea(
      child: Column(
        children: [
          // Shimmer for top section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.white.withOpacity(0.4),
                  highlightColor: Colors.white.withOpacity(0.8),
                  child: Container(
                    width: 150,
                    height: 20,
                    color: Colors.white,
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Colors.white.withOpacity(0.4),
                  highlightColor: Colors.white.withOpacity(0.8),
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          // Shimmer for cloud icon and temperature
          Column(
            children: [
              Shimmer.fromColors(
                baseColor: Colors.white.withOpacity(0.4),
                highlightColor: Colors.white.withOpacity(0.8),
                child: Icon(Icons.cloud, color: Colors.white, size: height*0.25,),
              ),
              SizedBox(height: 10),
              Shimmer.fromColors(
                baseColor: Colors.white.withOpacity(0.4),
                highlightColor: Colors.white.withOpacity(0.8),
                child: Container(
                  width: 120,
                  height: 20,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Shimmer.fromColors(
                baseColor: Colors.white.withOpacity(0.4),
                highlightColor: Colors.white.withOpacity(0.8),
                child: GlassmorphicContainer(
                  width: width*0.7,
                  height: height*0.35,
                  borderRadius: 20,
                  blur: 10,
                  alignment: Alignment.center,
                  border: 2,
                  linearGradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.2),
                      Colors.white.withOpacity(0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderGradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.5),
                      Colors.white.withOpacity(0.1),
                    ],
                  ),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.white.withOpacity(0.2),
                  ),
                ),
              ),
            ],
          ),
          Spacer(),
          // Shimmer for forecast button
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Shimmer.fromColors(
              baseColor: Colors.white.withOpacity(0.4),
              highlightColor: Colors.white.withOpacity(0.8),
              child: GlassmorphicContainer(
                width: 180,
                height: 50,
                borderRadius: 25,
                blur: 10,
                alignment: Alignment.center,
                border: 2,
                linearGradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.2),
                    Colors.white.withOpacity(0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderGradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.5),
                    Colors.white.withOpacity(0.1),
                  ],
                ),
                child: Container(),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}