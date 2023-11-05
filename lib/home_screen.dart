import 'package:flutter/material.dart';
import 'package:todo_notes/screens/notes/notes.dart';
import 'package:todo_notes/screens/todo/todo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();

    _tabController.addListener(() {
      // Call setState to trigger a rebuild when the tab index changes
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              indicatorColor: Colors.transparent,
              unselectedLabelColor: Colors.white,
              labelColor: Colors.orange,
              tabs: const [
                Tab(
                  icon: Icon(Icons.book_rounded, size: 30),
                ),
                Tab(
                  icon: Icon(Icons.check_box_outlined, size: 30),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  Center(child: Notes()),
                  Center(child: Todo()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
