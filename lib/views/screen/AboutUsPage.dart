import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:wallpaper/controller/AboutUsController.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'About Us',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: GetX<AboutUsController>(
        init: AboutUsController(),
        builder: (controller) {
          if (controller.htmlContent.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (controller.htmlContent.value.startsWith('Error:')) {
            return Center(
              child: Text(
                controller.htmlContent.value,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(h * 0.016),
                child: HtmlWidget(
                  controller.htmlContent.value,
                  textStyle: TextStyle(color: Colors.white),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
