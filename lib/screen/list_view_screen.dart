import 'package:flutter/material.dart';
import 'package:scrollable/const/colors.dart';
import 'package:scrollable/layout/main_layout.dart';

class ListViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);
  ListViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'ListViewScreen',
      body: renderBuilder(),
    );
  }
  
  //1. 한번에 다불러옴
  Widget renderDefault() {
    return ListView(
      children: numbers
          .map((e) => renderContainer(
              color: rainbowColors[e % rainbowColors.length], index: e))
          .toList(),
    );
  }
  
  //3. 중간중간에 위젯을 넣을 수 있음
  Widget renderSeperated() {
    return ListView.separated(
      //5개의 아이템마다 배너보여주기(광고할때 매우 유용)
      separatorBuilder: (context, index) {
        //이렇게 하면 맨처음의 이상한 위치의 컨네이너는 사라짐
        index += 1;
        if (index % 5 == 0) {
          return renderContainer(
              color: Colors.black, index: index, height: 100);
        }
        return Container();
      },
      itemCount: 100,
      itemBuilder: (context, index) {
        return renderContainer(
          color: rainbowColors[index % rainbowColors.length],
          index: index,
        );
      },
    );
  }
  //2. 보이는것만 그림
  //위젯이 화면 밖으로 나가면 메모리에서 지워버린다
  Widget renderBuilder() {
    return ListView.builder(
      itemCount: 100,
      itemBuilder: (context, index) {
        return renderContainer(
          color: rainbowColors[index % rainbowColors.length],
          index: index,
        );
      },
    );
  }

  Widget renderContainer({
    required Color color,
    required int index,
    double? height,
  }) {
    print(index);
    return Container(
      height: height ?? 300,
      color: color,
      child: Text(
        index.toString(),
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
      ),
    );
  }
}
