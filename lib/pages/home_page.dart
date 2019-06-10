import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  Future getHomeContent() async {
    try {
      Response response = await Dio().get("https://51dev.club/api/duoduo/goods_list");
      return response;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: FutureBuilder(
          future: getHomeContent(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data=json.decode(snapshot.data.toString());
              List goods_list = data['goods_list'];
              return Center(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, //每行三列
                      childAspectRatio: 1.0 //显示区域宽高相等
                  ),
                  itemCount: goods_list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("hello1"),
                              Text("hello2"),
                            ],
                          )
                        ],
                      )
                    );
                  },
                ),
              );
            } else {
              return Center(
                child: Text("没有数据"),
              );
            }
          },
        ),
      )
    );
  }
}