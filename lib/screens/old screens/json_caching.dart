// import 'package:flutter/material.dart';
// import 'package:fetchingapp/backend/api.dart';

// class JsonPage extends StatefulWidget {
//   const JsonPage({Key? key}) : super(key: key);

//   @override
//   _JsonPageState createState() => _JsonPageState();
// }

// class _JsonPageState extends State<JsonPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Test Json Data'),
//       ),
//       body: FutureBuilder(
//         future: ApiProvider().getData(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(child: CircularProgressIndicator());
//           } else {
//             // return Text('Data fetched successfully ${snapshot.data}');
//             return ListView.builder(
//               itemCount: (snapshot.data as dynamic).length,
//               itemBuilder: (context, index) {
//                 final data = (snapshot.data as dynamic)[index];
//                 return ListTile(
//                   leading: Text(data['id'].toString()),
//                   title: Text(data['name']),
//                   subtitle: Text(data['email']),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
