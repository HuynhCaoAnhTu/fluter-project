import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String _selectedOption = ''; // Biến lưu trữ giá trị của lựa chọn đã chọn

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkbox, Ảnh và Text'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CheckboxListTile(
            title: Text('Lựa chọn 1'),
            value: _selectedOption == 'Option 1',
            onChanged: (value) {
              setState(() {
                if (value!) {
                  _selectedOption = 'Option 1';
                } else {
                  _selectedOption = '';
                }
              });
            },
            secondary: Image.network(
              'https://fastly.picsum.photos/id/887/600/600.jpg?hmac=4OCHG2I5w2lV94dIUES-EBXx6c07fYQUn775ZtrVKmk', // Thay đổi URL hình ảnh theo đường dẫn của bạn
              width: 50,
              height: 50,
            ),
          ),
          CheckboxListTile(
            title: Text('Lựa chọn 2'),
            value: _selectedOption == 'Option 2',
            onChanged: (value) {
              setState(() {
                if (value!) {
                  _selectedOption = 'Option 2';
                } else {
                  _selectedOption = '';
                }
              });
            },
            secondary: Image.network(
              'https://fastly.picsum.photos/id/887/600/600.jpg?hmac=4OCHG2I5w2lV94dIUES-EBXx6c07fYQUn775ZtrVKmk', // Thay đổi URL hình ảnh theo đường dẫn của bạn
              width: 50,
              height: 50,
            ),
          ),
          CheckboxListTile(
            title: Text('Lựa chọn 3'),
            value: _selectedOption == 'Option 3',
            onChanged: (value) {
              setState(() {
                if (value!) {
                  _selectedOption = 'Option 3';
                } else {
                  _selectedOption = '';
                }
              });
            },
            secondary: Image.network(
              'https://fastly.picsum.photos/id/887/600/600.jpg?hmac=4OCHG2I5w2lV94dIUES-EBXx6c07fYQUn775ZtrVKmk', // Thay đổi URL hình ảnh theo đường dẫn của bạn
              width: 50,
              height: 50,
            ),
          ),
          SizedBox(height: 16),
          Text('Lựa chọn của bạn: $_selectedOption'),
        ],
      ),
    );
  }
}
