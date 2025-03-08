import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../component/app_bar_udf.dart';
import '../component/drawer_udf.dart';
import '../component/static_date_time.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  String? selectedReason;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMethod(),
      drawer: SideMenu(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  StaticDateTime(),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 30,
                ),
                SizedBox(width: 8),
                Text(
                  'Status:',
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800),
                ),
                Text(
                  ' Now you are at NBR',
                  style: TextStyle(
                    fontSize: 23,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              height:350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(23.7337, 90.3938),
                  zoom: 14,
                ),
                markers: {
                  Marker(
                    markerId: MarkerId('currentLocation'),
                    position: LatLng(23.7337, 90.3938),
                  ),
                },
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  Icons.location_pin,
                  color: Colors.grey,
                  size: 30,

                ),
                SizedBox(width: 8),
            Expanded(child:  Text.rich(TextSpan(
                children: [
                  TextSpan(text: 'Your Location:',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23,)),
                  TextSpan(text: 'Find your location in app:',style: TextStyle(fontSize: 23,))
                ]
            ))),
                ElevatedButton(onPressed: () {
                  showDialog(context: context, builder:(context) {
                    return AlertDialog(content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "You are late!!!",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                            SizedBox(height: 10),
                            Icon(
                              Icons.warning,
                              color: Colors.red,
                              size: 40,
                            ),
                            SizedBox(height: 10),
                            Text("Select a reason"),
                            RadioListTile(
                              title: Text("Traffic Jam"),
                              value: "Traffic Jam",
                              groupValue: selectedReason,
                              activeColor: Colors.green,
                              onChanged: (value) {
                                setState(() {
                                  selectedReason = value.toString();
                                });
                              },
                            ),
                            RadioListTile(
                              title: Text("Health Issue"),
                              value: "Health Issue",
                              groupValue: selectedReason,
                              activeColor: Colors.green,
                              onChanged: (value) {
                                setState(() {
                                  selectedReason = value.toString();
                                });
                              },
                            ),
                            RadioListTile(
                              title: Text("Others"),
                              value: "Others",
                              groupValue: selectedReason,
                              activeColor: Colors.green,
                              onChanged: (value) {
                                setState(() {
                                  selectedReason = value.toString();

                                });
                              },
                            ),

                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                              onPressed: () {},
                              child: Text("Submit"),
                            ),
                          ],
                        ),
                      ],
                    ),);
                  },);
                }, child: Text('Save')),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: Colors.green,
                      size: 50,
                    ),
                    SizedBox(height: 5),
                    Text(
                      '09:55',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text('Check In',
                        style: TextStyle(color: Colors.grey, fontSize: 20)),
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: Colors.grey,
                      size: 50,
                    ),
                    SizedBox(height: 5),
                    Text('--:--',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Text('Check Out',
                        style: TextStyle(color: Colors.grey, fontSize: 20)),
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 50,
                    ),
                    SizedBox(height: 5),
                    Text(
                      '--:--',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text("Working Hr's",
                        style: TextStyle(color: Colors.grey, fontSize: 20)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
