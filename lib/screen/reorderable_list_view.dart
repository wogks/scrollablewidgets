import 'package:flutter/material.dart';
import 'package:scrollable/const/colors.dart';
import 'package:scrollable/layout/main_layout.dart';

class RedorderableListViewScreen extends StatefulWidget {
  const RedorderableListViewScreen({super.key});

  @override
  State<RedorderableListViewScreen> createState() =>
      _RedorderableListViewScreenState();
}

class _RedorderableListViewScreenState
    extends State<RedorderableListViewScreen> {
  final List<int> numbers = List.generate(100, (index) => index);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
        title: 'reorderableListView',
        body: ReorderableListView.builder(
          itemBuilder: (context, index) {
            return renderContainer(
                color: rainbowColors[index % rainbowColors.length],
                //이렇게 하면 순서를 바꿔도 컨테이너 색이 변하지 않는다
                index: numbers[index]);
          },
          itemCount: numbers.length,
          onReorder: (oldIndex, newIndex) {
            setState(() {
              //oldIndex와 newIndex모두 이동이 되기전에 산정한다
              //[red, orange, yellow]
              //[0,1,2]
              //
              //red를 yellow다음으로 옮기고 싶다
              //red:0 oldIndex -> 3 newIndex
              //[orange, yellow, red]
              //
              //[red, orange, yellow]
              //yellow를 맨 앞으로 옮기고 싶다.
              //yellow : 2 oldIndex -> 0 newIndex
              //[yellow, red, orange]

              if (oldIndex < newIndex) {
                //newIndex에서 1을 뺀다는 뜻
                newIndex -= 1;
              }

              final item = numbers.removeAt(oldIndex);
              numbers.insert(newIndex, item);
            });
          },
        ));
  }

  Widget renderDefault() {
    return ReorderableListView(
      children: numbers
          .map((e) => renderContainer(
              color: rainbowColors[e % rainbowColors.length], index: e))
          .toList(),
      onReorder: (oldIndex, newIndex) {
        setState(() {
          //oldIndex와 newIndex모두 이동이 되기전에 산정한다
          //[red, orange, yellow]
          //[0,1,2]
          //
          //red를 yellow다음으로 옮기고 싶다
          //red:0 oldIndex -> 3 newIndex
          //[orange, yellow, red]
          //
          //[red, orange, yellow]
          //yellow를 맨 앞으로 옮기고 싶다.
          //yellow : 2 oldIndex -> 0 newIndex
          //[yellow, red, orange]

          if (oldIndex < newIndex) {
            //newIndex에서 1을 뺀다는 뜻
            newIndex -= 1;
          }

          final item = numbers.removeAt(oldIndex);
          numbers.insert(newIndex, item);
        });
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
      //프로그램이 봤을때는 무지개색 전부다 똑같은 컨테이너다
      //모두 다르다는것을 알려주기위해 키를 넣어준다
      key: Key(index.toString()),
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
