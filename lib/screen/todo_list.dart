// ignore_for_file: prefer_const_constructors, prefer_const_declarations, avoid_print, sort_child_properties_last, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/add_page.dart';
import 'package:flutter_application_1/services/todo_service.dart';
import 'package:flutter_application_1/theme/colors.dart';
import 'package:flutter_application_1/utils/snackbar_helper.dart';
import 'package:flutter_application_1/widget/todo_card.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  bool isLoading = true;
  List items = [];
  @override
  void initState() {
    super.initState();
    fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorlist,
        title: Text(
          "Todo List",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Visibility(
        visible: isLoading,
        child: Center(
          child: CircularProgressIndicator(),
        ),
        replacement: RefreshIndicator(
          onRefresh: fetchTodo,
          child: Visibility(
            visible: items.isNotEmpty,
            replacement: Center(
              child: Text(
                'No Todo Item',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            child: ListView.builder(
              itemCount: items.length,
              padding: EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final item = items[index] as Map;
                final id = item['_id'] as String;
                return TodoCard(
                  index: index,
                  deleteById: deleteById,
                  navigateToEdit: navigateToEditPage,
                  item: item,
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAddPage,
        label: Row(
          children: [
            Icon(Icons.task_alt),
            SizedBox(
              width: 5,
            ),
            Text('Add Todo'),
          ],
        ),
        // icon: Icon(Icons.playlist_add_sharp),
        backgroundColor: colorlist,
      ),
    );
  }

  Future<void> navigateToEditPage(Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => AddTodoPage(todo: item),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future<void> navigateToAddPage() async {
    final route = MaterialPageRoute(
      builder: (context) => AddTodoPage(),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future<void> deleteById(String id) async {
    // Delete the item

    final isSuccess = await TodoService.deleteById(id);
    if (isSuccess) {
      // Remove item from list
      final filtered = items.where((element) => element['_id'] != id).toList();
      setState(() {
        items = filtered;
      });
    } else {
      //show error
      showErrorMessage(context, message: 'Deletion Failed');
    }
  }

  Future<void> fetchTodo() async {
    final response = await TodoService.fetchTodo();
    if (response != null) {
      setState(() {
        items = response;
      });
    } else {
      // Show error
      showErrorMessage(context, message: 'Something went wrong');
    }
    setState(() {
      isLoading = false;
    });
  }
}
