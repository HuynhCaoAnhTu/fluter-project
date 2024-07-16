import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TagList extends StatelessWidget {
  final List<DocumentSnapshot> tagList;
  final Function(String) ontagSelected;
  final String selectedtagId;

  TagList({
    required this.tagList,
    required this.ontagSelected,
    required this.selectedtagId,
  });

  @override
  Widget build(BuildContext context) {
    return tagList.isEmpty
        ? Text(
            'No tags available') // Display a message if tagList is empty or null
        : ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: tagList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  ontagSelected(tagList[index]['tagId']);
                },
                child:

                    // Container(
                    //   color: selectedtagId == tagList[index]['tagId']
                    //       ? Colors.blue
                    //       : Colors.transparent,
                    //   child: Text(tagList[index]['tagName']),
                    // ),

                    Container(
                  height: 100,
                  decoration: BoxDecoration(
                      color: selectedtagId == tagList[index]['tagId']
                          ? Color(0xFF1AB65C)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                      border: selectedtagId == tagList[index]['tagId']
                          ? Border.all(color: Colors.transparent)
                          : Border.all(color: Color(0xFF1AB65C))),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12, 3, 12, 3),
                    child: Text(
                      tagList[index]['tagName'],
                      // ignore: prefer_const_constructors
                      style: TextStyle(
                        fontFamily: 'Urbanist',
												color: selectedtagId == tagList[index]['tagId']
                          ? Colors.white
                          // ignore: prefer_const_constructors
                          : Color(0xFF1AB65C),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),

                      // fontFamily: 'Urbanist',
                      // color: selectedtagId == tagList[index]['tagId']
                      //     ? Colors.white
                      //     : Colors.black,
                      // fontSize: 15,
                      // fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(width: 8); // Adjust the width of the divider
            },
          );
  }
}
