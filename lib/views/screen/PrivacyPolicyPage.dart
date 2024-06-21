import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class PrivacyPolicyPage extends StatefulWidget {
  @override
  _PrivacyPolicyPageState createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State {
  String _htmlContent = '';

  @override
  void initState() {
    super.initState();
    _fetchPrivacyPolicyData();
  }

  Future<void> _fetchPrivacyPolicyData() async {
    try {
      final privacyPolicyData = await PrivacyPolicyHelper.fetchPrivacyPolicy();
      setState(() {
        _htmlContent = privacyPolicyData;
      });
    } catch (e) {
      log('Error fetching privacy policy data: $e');
    }
  }

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
          'Privacy Policy',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: _htmlContent.isNotEmpty
          ? SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(
            h * 0.012,
          ),
          child: Html(
            data: _htmlContent,
            style: {
              "body": Style(
                color: Colors.white,
              ),
            },
          ),
        ),
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}