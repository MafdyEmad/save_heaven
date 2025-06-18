import 'package:flutter/material.dart';

class OrphanageCircleItem extends StatelessWidget {
  final String title;
  final String image;

  const OrphanageCircleItem({
    super.key,
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double circleSize = screenWidth * 0.2;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
      child: Container(
        width: circleSize,
        height: circleSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(color: Colors.black26, width: 1),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                image,
                width: circleSize * 0.45,
                height: circleSize * 0.45,
              ),
              SizedBox(height: circleSize * 0.02),
              SizedBox(
                width: circleSize * 0.9,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  softWrap: true,
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                    fontSize: screenWidth * 0.018, 
                    fontWeight: FontWeight.w700, 
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
