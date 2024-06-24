import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallpaper/views/utils/ColorUtils.dart';
import 'package:wallpaper/views/utils/ImageUtils.dart';

class LikePage extends StatelessWidget {
  const LikePage({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Likes",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: ColorUtils.PrimaryColor,
            fontSize: h * 0.026,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(h * 0.02,),
        child: MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: h * 0.02,
          crossAxisSpacing: h * 0.02,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage(
                        ImageUtils.ImagePath +
                            'HomeWallpaper${index + 1}.jpg',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: (index % 2 == 0) ? h * 0.3 : h * 0.25,
                ),
                Positioned(
                  top: h * 0.02,
                  right: h * 0.02,
                  child: Container(
                    height: h * 0.038,
                    width: h * 0.038,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
