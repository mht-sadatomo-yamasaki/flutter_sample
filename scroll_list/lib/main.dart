import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

const numberOfItems = 5001;
const itemHeight = 50.0;

void main() {
  runApp(ScrollablePositionedListExample());
}

// The root widget for the example app.
class ScrollablePositionedListExample extends StatelessWidget {
  const ScrollablePositionedListExample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ScrollablePositionedList Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ScrollablePositionedListPage(),
    );
  }
}

class ScrollablePositionedListPage extends StatefulWidget {
  const ScrollablePositionedListPage({Key key}) : super(key: key);
  @override
  _ScrollablePositionedListPageState createState() =>
    _ScrollablePositionedListPageState();
}

class _ScrollablePositionedListPageState extends State<ScrollablePositionedListPage> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  @override
  Widget build(BuildContext context) => Material(
    child: Column(
      children: <Widget>[
        Expanded(
          child: list(),
        ),
          jumpControlButtons
      ],
    ),
  );

  // リストウィジェット
  Widget list() => ScrollablePositionedList.builder(
    itemCount: numberOfItems,
    itemBuilder: (context, index) => item(index),
    itemScrollController: itemScrollController,
    itemPositionsListener: itemPositionsListener,
  );

  // ボタン群
  Widget get jumpControlButtons => Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      const Text('jump to'),
      jumpButton(10),
      jumpButton(100),
    ],
  );

  // jumpToメソッドが発火するボタン
  Widget jumpButton(int value) => GestureDetector(
    onTap: () => jumpTo(value),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text('$value')
    ),
  );

  void jumpTo(int index) =>
    itemScrollController.jumpTo(index: index);

  // リストアイテム
  Widget item(int i) {
    return SizedBox(
      height: itemHeight,
      child: Container(
        color: Colors.grey,
        child: Center(
          child: Text('Item $i'),
        ),
      ),
    );
  }
}