// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/colors.dart';

class TodoCard extends StatelessWidget {
  final int index;
  final Map item;
  final Function(Map) navigateToEdit;
  final Function(String) deleteById;
  const TodoCard(
      {super.key,
      required this.index,
      required this.item,
      required this.navigateToEdit,
      required this.deleteById});

  @override
  Widget build(BuildContext context) {
    final id = item['_id'] as String;
    return Card(
      child: ListTile(
        leading: Icon(
          Icons.task_alt,
          size: 30,
        ),
        //  CircleAvatar(
        //   backgroundColor: colorlist,
        //   radius: 30,
        //   child: Text('${index + 1}'),
        // ),
        title: Text(
          item['title'],
          style: TextStyle(
            color: textColorW,
            fontSize: 20,
          ),
        ),
        subtitle: Text(
          item['description'],
        ),
        trailing: PopupMenuButton(
          onSelected: (value) {
            if (value == 'edit') {
              // Open Edit Page
              navigateToEdit(item);
            } else if (value == 'delete') {
              // Delete and remove the item
              deleteById(id);
            }
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(Icons.edit_document),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Edit'),
                  ],
                ),
                value: 'edit',
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(Icons.delete),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Delete'),
                  ],
                ),
                value: 'delete',
              ),
            ];
          },
        ),
      ),
    );
  }
}
