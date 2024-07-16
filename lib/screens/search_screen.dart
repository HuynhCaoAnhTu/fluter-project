// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:bolu_app/screens/profile_screen.dart';
// import 'package:bolu_app/utils/colors.dart';

// class SearchScreen extends StatefulWidget {
//   const SearchScreen({Key? key}) : super(key: key);

//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   final TextEditingController searchController = TextEditingController();
//   bool isShowUsers = false;
//   List _allUser = [];
// 	List _resutlSearch = [];

//   get_allUserSteam() async {
//     var data = await FirebaseFirestore.instance.collection('users').get();
//     setState(() {
//       _allUser  = data.docs;
//     });
//   }

// 	searchResultList(){
// 		var showResults = [];
// 		if (searchController.text == '') {
// 		showResults = [];
// 		}
// 		else{
// 			for(var clientSnapShot in _allUser)
// 			{
// 				var name = clientSnapShot['username'].toString().toLowerCase();
// 				if(name.contains(searchController.text)){
// 					showResults.add(clientSnapShot);
// 				}
// 			}
// 		}
// 		setState(() {
// 		  _resutlSearch = showResults;
// 				print(showResults);
// 		});
// 	}

// 	_onSearchChange(){
// 		print(searchController.text);
// 	searchResultList();
// 	}

// @override void dispose() {
//   searchController.removeListener(_onSearchChange);
// 	searchController.dispose();
//     super.dispose();
//   }
//   @override
//   void initState() {
//     get_allUserSteam();
// 		searchResultList();
// 		searchController.addListener(_onSearchChange);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: mobileBackgroundColor,
//         title: Form(
//           child: TextFormField(
//             controller: searchController,
//             decoration:
//                 const InputDecoration(labelText: 'Search for a user...'),
//             onFieldSubmitted: (String _) {
//               setState(() {
//                 isShowUsers = true;
//               });
//             },
//           ),
//         ),
//       ),
//       body: ListView.builder(
//                   itemCount: _resutlSearch.length,
//                   itemBuilder: (context, index) {
//                     return InkWell(
//                       onTap: () => Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (context) => ProfileScreen(
//                             uid: _resutlSearch[index]['uid'],
//                           ),
//                         ),
//                       ),
//                       child: ListTile(
//                         leading: CircleAvatar(
//                           backgroundImage: NetworkImage(
//                             _resutlSearch[index]['photoUrl'],
//                           ),
//                           radius: 16,
//                         ),
//                         title: Text(
//                           _resutlSearch[index]['username'],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//     );
//   }
// }
