import 'package:emp_management/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class EmployeeStatisticsScreen extends StatelessWidget {
  const EmployeeStatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greenColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(120),
          child: Column(
            spacing: 5,
            children: [
              Container(
                height: 75,
                width: 75,
                decoration: BoxDecoration(
                  color: Color(0xff5C8956),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person_outline_rounded,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              Text(
                "Employee ID : 123456",
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 0.5,
                  fontSize: 18,
                ),
              ),
              Text(
                "Faius Mojumder Nahin",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 5),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Personal Statistics",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500,color: Colors.grey.shade800,
                letterSpacing: .5,),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 20,
                      fontWeight: FontWeight.w400),
                  value: "Last 14 days",
                  items: [
                    "Last 7 days",
                    "Last 14 days",
                    "Last 30 days",
                    "This months",
                    "Last months",
                  ]
                      .map(
                        (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {},
                ),
                IconButton(
                  ///todo : logic :-)
                  onPressed: () {},
                  icon: Icon(Icons.calendar_today),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildCircularIndicator("Late", 0.1, Colors.red),
                buildCircularIndicator("Absent", 0.05, Colors.orange),
                buildCircularIndicator("Leaves", 0.05, Colors.green),
              ],
            ),
            SizedBox(height: 16),
            Text(
              "Leave Requests",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade800,
                letterSpacing: .5,
              ),
            ),
            SizedBox(height: 8),
            DropdownButtonFormField(
              icon: Icon(
                Icons.keyboard_arrow_down_outlined,
                size: 30,
              ),
              decoration: InputDecoration(border: OutlineInputBorder()),
              hint: Text(
                "Tap to view leave requests",
                style: TextStyle(
                    color: Colors.grey, fontSize: 20, letterSpacing: .5),
              ),
              items: [],
              onChanged: (value) {},
            ),
            SizedBox(height: 16),
            buildInfoTile("Total Presents", "12 days"),
            buildInfoTile("Late", "2 days"),
            buildInfoTile("Early Leaves", "2 days"),
            buildInfoTile("Absent", "1 day"),
            buildInfoTile("Leaves", "1 day"),
          ],
        ),
      ),
    );
  }

  Widget buildCircularIndicator(String label, double percent, Color color) {
    return Column(
      children: [
        CircularPercentIndicator(
          radius: 45.0,
          lineWidth: 8.0,
          backgroundColor: Colors.grey.shade300,
          percent: percent,
          center: Text(
            "${(percent * 100).toInt()}%",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          progressColor: color,
        ),
        SizedBox(height: 20),
        Text(
          label,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget buildInfoTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade800,
              letterSpacing: .5,
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: 100,
            decoration:
                BoxDecoration(border: Border.all(color: Colors.grey.shade600)),
            child: Text(
              value,
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
                letterSpacing: .2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
