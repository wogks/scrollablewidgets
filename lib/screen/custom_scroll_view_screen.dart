import 'package:flutter/material.dart';
import 'package:scrollable/const/colors.dart';

class _SliverFixedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double maxHeight;
  final double minHeight;

  _SliverFixedHeaderDelegate({
    required this.child,
    required this.maxHeight,
    required this.minHeight,
  });
  //델리게이트는 어떤함수가 안에 들어오는지 정의를 한다
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    //최대사이즈(있아도되고 없어도 됌)
    return SizedBox.expand(
      child: child,
    );
  }

  @override
  //최대높이
  double get maxExtent => maxHeight;

  @override
  // 최소높이
  double get minExtent => minHeight;

  @override
  //covariant - 상속된 클래스도 사용가능
  //oldDelegate - build가 실행이 됐을때 이전 delegate
  //this - 새롭게 빌드된 delegate
  //shoudRebuild - 새로 빌드를 해야할지 말지 결정
  //true - 빌드를 다시함 false - 빌드 안함
  bool shouldRebuild(covariant _SliverFixedHeaderDelegate oldDelegate) {
    return oldDelegate.maxHeight != maxHeight ||
        oldDelegate.maxHeight != maxHeight ||
        oldDelegate.child != child;
  }
}

class CustomScrollViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);
  CustomScrollViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          renderSliverAppbar(),
          renderHeader(),
          renderBuilderSliverList(),
          renderHeader(),
          renderSliverGridBuilder(),
          renderBuilderSliverList(),
        ],
      ),
    );
  }

  SliverPersistentHeader renderHeader() {
    return //직접 클래스를 만들어야한다
        SliverPersistentHeader(
      //헤더가 쌓인다
      pinned: true,
      delegate: _SliverFixedHeaderDelegate(
        child: Container(
          color: Colors.black,
          child: const Center(
            child: Text(
              '신기하지~',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        maxHeight: 150,
        minHeight: 70,
      ),
    );
  }

  //Appbar
  Widget renderSliverAppbar() {
    return SliverAppBar(
      //밑으로 스크롤하면 없어지고 위로하면 생김
      floating: false,
      //스크롤해도 앱바가 남아있다
      pinned: false,
      //자석 효과(플로팅이 트루일대만 사용 가능)
      snap: false,
      //맨위에서 밑으로 더 땡기면 앱바의 사이즈가 늘어나서 뒷 배경색이 안보인다.(안드에서는 physics에서 바운싱 이펙트를 사용했을 경우에만 사용가능)
      stretch: false,
      //앱바 높이 설정
      expandedHeight: 200,
      //앱바 최소 높이설정(앱바의 높이가 있을때 더 빨리 밀려들어감)
      collapsedHeight: 150,
      //앱바의 높이가 있을때 앱바 밑에 나타남
      flexibleSpace: FlexibleSpaceBar(
        //앱바에 배경 넣기
        background: Image.asset(''),
        title: const Text('flexible spacebar'),
      ),
      title: const Text('custom scroll view'),
    );
  }

  //리스트뷰 기본 생성자와 유사함
  Widget renderChildSliverList() {
    return SliverList(
      //일반으로 할지, 빌드를 쓸지 delegat
      delegate: SliverChildListDelegate(numbers
          .map((e) => renderContainer(
              color: rainbowColors[e % rainbowColors.length], index: e))
          .toList()),
    );
  }

  //리스트뷰 빌더와 유사함
  Widget renderBuilderSliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return renderContainer(
            color: rainbowColors[index % rainbowColors.length],
            index: index,
          );
        },
        childCount: 10,
      ),
    );
  }

  Widget renderSliverGrid() {
    return SliverGrid(
      delegate: SliverChildListDelegate(numbers
          .map((e) => renderContainer(
              color: rainbowColors[e % rainbowColors.length], index: e))
          .toList()),
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    );
  }

  //gridview.builder와 비슷함
  Widget renderSliverGridBuilder() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        childCount: 100,
        (context, index) {
          return renderContainer(
              color: rainbowColors[index % rainbowColors.length], index: index);
        },
      ),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 100),
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
