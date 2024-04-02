import 'package:flutter/material.dart';

abstract class Component extends StatelessWidget {
  const Component({super.key});
}

class Leaf extends Component {
  final String name;
  const Leaf(this.name);
  @override
  Widget build(BuildContext context) {
    return Text(name);
  }
}

class Composite extends Component {
  final String name;
  final List<Component> children;
  Composite(this.name, this.children);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Text(name), for (var child in children) child],
    );
  }
}

class CommentTree extends StatelessWidget {
  const CommentTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Comment tree demo")),
      body: Composite('Composite 1', [
        Leaf('Leaf 1.1'),
        Leaf('Leaf 1.2'),
        Composite('Composite 2', [
          Leaf('Leaf 2.1'),
          Leaf('Leaf 2.2'),
        ])
      ]),
    );
  }
}
