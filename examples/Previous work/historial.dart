import 'package:flutter/material.dart';

// Widget historialTab = Form(
//   child: Column(
//     children: [
//       Column(
//         children: [
//           SizedBox(
//             width: 50,
//           ),
//           Text("data")
//         ],
//       ),
//       Row(
//         children: [
//           Expanded(
//             child: TextFormField(
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }

//                 return null;
//               },
//             ),
//           ),
//           Expanded(
//             child: TextFormField(
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }

//                 return null;
//               },
//             ),
//           ),
//         ],
//       ),
//       Row(
//         children: [
//           Expanded(
//             child: TextFormField(
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }

//                 return null;
//               },
//             ),
//           ),
//           Expanded(
//             child: TextFormField(
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }

//                 return null;
//               },
//             ),
//           ),
//         ],
//       ),
//     ],
//   ),
// );

Widget historialTab(BuildContext context) {
  double colSpaceHeight = MediaQuery.of(context).size.height / 1.5;
  double colSpaceWidth = MediaQuery.of(context).size.width / 1.5;

  return Padding(
    padding: const EdgeInsets.all(50),
    child: Form(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }

                    return null;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
