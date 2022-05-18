import 'package:flutter/material.dart';

/// The group page.
///
/// This is the page that displays the group's information and available groups
/// to join.
class GroupPage extends StatelessWidget {
  const GroupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Group"),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Group Page'),
      ),
    );
  }
}
