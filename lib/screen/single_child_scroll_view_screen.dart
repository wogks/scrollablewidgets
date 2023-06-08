import 'package:flutter/material.dart';
import 'package:scrollable/const/colors.dart';
import 'package:scrollable/layout/main_layout.dart';

class SingleChildScrollViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);
  SingleChildScrollViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'single child scroll view',
      //화면을 넘어가야지만 스크롤이 가능해짐
      body: renderPerformance(),
    );
  }

  //1. 기본 렌더링법
  Widget renderSimple() {
    return SingleChildScrollView(
      child: Column(
        children: rainbowColors.map((e) => renderContainer(color: e)).toList(),
      ),
    );
  }

  //2. 화면을 넘어가지 않아도 스크롤 되게하기
  Widget renderAlwaysScroll() {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          renderContainer(color: Colors.black),
        ],
      ),
    );
  }

  //3.위젯이 잘리지 않게 하기
  Widget renderClip() {
    return SingleChildScrollView(
      //짤렸을때 어떻게 처리할것인지
      clipBehavior: Clip.none,
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          renderContainer(color: Colors.black),
        ],
      ),
    );
  }

  //4. 여러가지 physic정리
  Widget renderPhysics() {
    return SingleChildScrollView(
      //NeverScrollablePhysics - 스크롤 안됨
      //AlwaysScrollableScrollPhysics - 스크롤 됨
      //BouncingScrollPhysics - ios스타일
      //ClampingScrollPhysics - 안드로이드 스타일
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: rainbowColors.map((e) => renderContainer(color: e)).toList(),
      ),
    );
  }

  //5. 퍼포먼스
  Widget renderPerformance() {
    //싱글차일드 스크롤뷰는 100개를 한번에 렌더링 하기때문에 퍼포먼스에 좋지 않다
    return SingleChildScrollView(
      child: Column(
          children: numbers
              .map((e) => renderContainer(
                  index: e, color: rainbowColors[e % rainbowColors.length]))
              .toList()),
    );
  }

  Widget renderContainer({required Color color, int? index}) {
    if (index != null) {
      print(index);
    }
    return Container(
      height: 300,
      color: color,
    );
  }
}
