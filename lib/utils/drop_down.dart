import 'dart:io';

import 'package:appsians/providers/date_provider.dart';
import 'package:appsians/providers/store_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart' as pie;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'dart:math' as math;
import 'package:http/http.dart' as http;
import 'dart:convert';

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

class CustomDropdown extends StatefulWidget {
  final List<String> options;
  final String? value;
  final ValueChanged<String?> onChanged;
  final IconData suffixIcon;

  const CustomDropdown({
    Key? key,
    required this.options,
    required this.value,
    required this.onChanged,
    this.suffixIcon = Icons.keyboard_arrow_down,
  }) : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  bool _isDropdownOpened = false;
  int _selectedIndex = 1;
  List<String> headings = ['24H', '7D', '30D', '1Y', 'ALL'];
  final List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40),
  ];

  final legendLabels = <String, String>{
    "Flutter": "Flutter legend",
    "React": "React legend",
    "Xamarin": "Xamarin legend",
    "Ionic": "Ionic legend",
  };

  final colorList = <Color>[
    const Color(0xfffdcb6e),
    const Color(0xff0984e3),
    const Color(0xfffd79a8),
    const Color(0xffe17055),
    const Color(0xff6c5ce7),
  ];

  final gradientList = <List<Color>>[
    [
      const Color.fromRGBO(223, 250, 92, 1),
      const Color.fromRGBO(129, 250, 112, 1),
    ],
    [
      const Color.fromRGBO(129, 182, 205, 1),
      const Color.fromRGBO(91, 253, 199, 1),
    ],
    [
      const Color.fromRGBO(175, 63, 62, 1.0),
      const Color.fromRGBO(254, 154, 92, 1),
    ]
  ];
  pie.ChartType? _chartType = pie.ChartType.disc;
  bool _showCenterText = true;
  bool _showCenterWidget = true;
  double? _ringStrokeWidth = 32;
  double? _chartLegendSpacing = 32;

  bool _showLegendsInRow = false;
  bool _showLegends = true;
  bool _showLegendLabel = false;

  bool _showChartValueBackground = true;
  bool _showChartValues = true;
  bool _showChartValuesInPercentage = false;
  bool _showChartValuesOutside = false;

  bool _showGradientColors = false;

  pie.LegendPosition legendPosition = pie.LegendPosition.right;
  int _selectedPage = 0;

  void changePage(int currentPageIndex) {
    setState(() {
      _selectedPage = currentPageIndex;
    });
  }
  void _onHeadingTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    final dateProvider = Provider.of<DateProvider>(context, listen: false);
    dateProvider.fetchTicketsForHeading(headings[index]);
  }
  @override
  void initState() {
    
    super.initState();
    fetchStores();
     final dateProvider = Provider.of<DateProvider>(context, listen: false);
    dateProvider.fetchTicketsForHeading(headings[_selectedIndex]);
  }

  List<Map<String, dynamic>>? stores;
  bool isLoading = true;
  String errorMessage = '';
 Future<void> fetchStores() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");

    final headers = {
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(
        Uri.parse('https://www.jarvey.ai/api/stores'),
        headers: headers,
        
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['message'] == 'Stores found for the logged-in user') {
          print("stores list here");
          print(jsonResponse);
          setState(() {
            stores = List<Map<String, dynamic>>.from(jsonResponse['stores']);
            isLoading = false;
          });
        } else {
          setState(() {
            errorMessage = jsonResponse['message'] ?? 'Unknown error';
            isLoading = false;
          });
        }
      } else {
        setState(() {
          errorMessage = 'Failed to load stores';
          isLoading = false;
        });
      }
    } on SocketException {
      setState(() {
        errorMessage = 'No Internet connection';
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }var dataName = "0x29...55";
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final List<SalesData> chartData = [
      SalesData(DateTime(2010, 1), 20),
      SalesData(DateTime(2011, 1), 100),
      SalesData(DateTime(2012, 3), 20),
      SalesData(DateTime(2012, 8), 50),
    ];
    final containerWidth = mediaQuery.size.width;
    final containerHeight = mediaQuery.size.height;
    double height = MediaQuery.of(context).size.height * 1;
    double width = MediaQuery.of(context).size.width * 1;

    Map<String, double> dataMap = {
      "Flutter": 5,
      "React": 3,
      "Xamarin": 2,
      "Ionic": 2,
    };

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: Image.asset(
          "assets/images/Frame 310.png",
          scale: 2,
        ),
        actions: [
          Container(
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isDropdownOpened = !_isDropdownOpened;
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2.7,
                          height: MediaQuery.of(context).size.height / 26,
                          padding: EdgeInsets.symmetric(
                            horizontal: containerWidth / 30,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0XFF262626),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/profile-circle.png",
                                scale: 2.5,
                              ),
                              SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  dataName,
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                ),
                              ),
                              Icon(
                                Icons.arrow_drop_down_outlined,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0XFF262626),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 7,
                                vertical:
                                    MediaQuery.of(context).size.height / 100),
                            child: Image.asset(
                              "assets/images/notification-bing.png",
                              scale: 2.5,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: containerHeight / 20,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: containerWidth / 20, right: containerWidth / 20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: containerHeight / 25,
                          ),
                          Padding(
                              padding:  EdgeInsets.only(left: width/20,right: width/20),
                            child: Container(
                              // width: MediaQuery.of(context).size.width / 1.3,
                              decoration: BoxDecoration(
                                color: Color(0xFF01060F).withOpacity(0.1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: List.generate(headings.length, (index) {
                                    return GestureDetector(
                                      onTap: () => _onHeadingTap(index),
                                      child: Container(
                                        width: MediaQuery.of(context).size.width/9,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: _selectedIndex == index
                                              ? Color(0xFF9945FF)
                                              : Colors.transparent,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Center(
                                          child: Text(
                                            headings[index],
                                            style: TextStyle(
                                              color: _selectedIndex == index
                                                  ? Colors.white
                                                  : Color(0xFF01060F).withOpacity(0.5),
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ), ),
                          ),
                          SizedBox(
                            height: containerHeight / 50,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.3,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Ticket Value",
                                style: GoogleFonts.plusJakartaSans(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF01060F)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: containerHeight / 80,
                          ),
                          Center(
                              child: Padding(
                            padding: EdgeInsets.only(
                                right: MediaQuery.of(context).size.width / 15),
                            child: Container(
                                child: SfCartesianChart(
                                    primaryXAxis: DateTimeAxis(),
                                    series: <CartesianSeries>[
                                  // Renders line chart
                                  LineSeries<SalesData, DateTime>(
                                      dataSource: chartData,
                                      xValueMapper: (SalesData sales, _) =>
                                          sales.year,
                                      yValueMapper: (SalesData sales, _) =>
                                          sales.sales)
                                ])),
                          )),
                          SizedBox(
                            height: containerHeight / 60,
                          ),
                          Container(
                            width: width / 1.3,
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Ticket by Category ",
                                  style: GoogleFonts.plusJakartaSans(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF01060F)),
                                )),
                          ),
                          SizedBox(
                            height: containerHeight / 20,
                          ),
                          Consumer<StoreProvider>(
                            builder: (context, storeProvider, child) {
                              if (storeProvider.isLoading) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (storeProvider
                                  .errorMessage.isNotEmpty) {
                                return Center(
                                    child: Text(
                                        'Error: ${storeProvider.errorMessage}'));
                              } else if (storeProvider.dataMap.isNotEmpty) {
                                return Container(
                                  width: double.infinity,
                                  child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Container(
                                       
                                                                          
                                          child: pie.PieChart(
                                            
                                            dataMap: storeProvider.dataMap,
                                            animationDuration:
                                                Duration(milliseconds: 800),
                                            chartLegendSpacing: 32,
                                            chartRadius:
                                                MediaQuery.of(context).size.width /
                                                    2.7,
                                            colorList: storeProvider.colorList,
                                            initialAngleInDegree: 0,
                                            chartType: pie.ChartType.ring,
                                            ringStrokeWidth: 32,
                                            centerText: "Tickets "+storeProvider.totalCount.toString(),
                                            legendOptions: pie.LegendOptions(
                                              showLegendsInRow: false,
                                              legendPosition:
                                                  pie.LegendPosition.right,
                                              showLegends: false,
                                              legendShape: BoxShape.circle,
                                              legendTextStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            chartValuesOptions:
                                                pie.ChartValuesOptions(
                                              showChartValueBackground: false,
                                              showChartValues: false,
                                              showChartValuesInPercentage: true,
                                              showChartValuesOutside: false,
                                              decimalPlaces: 1,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                    
                                    ],
                                  ),
                                );
                              } else {
                                return Center(child: Text('No data'));
                              }
                            },
                          ),
                          SizedBox(
                            height: containerHeight / 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: containerHeight / 30,
                ),
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: width / 1.11,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            20,
                          ),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: width * 0.0125,
                            vertical: height * 0.025,
                          ),

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              20,
                            ),
                          ),
                          child: Consumer<StoreProvider>(
                            builder: (context, storeProvider, child) {
                              if (storeProvider.isLoading) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (storeProvider
                                  .errorMessage.isNotEmpty) {
                                return Center(
                                    child: Text(
                                        'Error: ${storeProvider.errorMessage}'));
                              } else if (storeProvider.dataMap.isNotEmpty) {
                                return Column(
                                  children: storeProvider.dataMap.entries
                                      .map((entry) {
                                    int index = storeProvider.dataMap.keys
                                        .toList()
                                        .indexOf(entry.key);
                                    return TickerWithNameColorPercentage(
                                      verticalLineColor:
                                          storeProvider.colorList[index],
                                      title: entry.key,
                                      percentage: entry.value.toString(),
                                    );
                                  }).toList(),
                                );
                              } else {
                                return Center(child: Text('No data'));
                              }
                            },
                          ),

                          // Column(
                          //           children: storeProvider.dataMap.entries.map((entry) {
                          //             int index = storeProvider.dataMap.keys.toList().indexOf(entry.key);
                          //             return   TickerWithNameColorPercentage(
                          //       verticalLineColor: Color(
                          //         0xff9945FF,
                          //       ),
                          //       title: 'Order Issue',
                          //       percentage: '45%',
                          //     );
                          //           }).toList(),
                          //         ),
                        ),
                      ),
                      SizedBox(
                        height: height / 30,
                      ),
                      Container(
                        width: width / 1.11,
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.05,
                          vertical: height * 0.025,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(
                            20,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'LATEST TICKETS',
                              style: TextStyle(
                                color: Color(0xff01060F),
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            //table
                            SizedBox(
                              height: height * 0.35,
                              child: Consumer<DateProvider>(
                                builder: (context, dateProvider, child) {
                                  if (dateProvider.isLoading) {
                                    return Center(child: CircularProgressIndicator());
                                  }
                              
                                  if (dateProvider.errorMessage.isNotEmpty) {
                                    return Center(child: Text(dateProvider.errorMessage));
                                  }
                              
                                  if (dateProvider.tickets.isEmpty) {
                                    return Center(child: Text('No data available'));
                                  }
                              
                                  return ListView(
                                    children: [
                                      Table(
                                        columnWidths: {
                                          0: FlexColumnWidth(1),
                                          1: FlexColumnWidth(3),
                                          2: FlexColumnWidth(6),
                                        },
                                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                        children: [
                                          myTableRow(
                                            context,
                                            '#',
                                            'Name',
                                            'Email ',
                                            
                                            'Date Time', 
                                            backgroundColor: Color(0xffF3F3F3),
                                            nameColor: Color(0xff62656a),
                                            serialNumberColor: Color(0xff62656a),
                                            emailText2Color: Color(0xff62656a),
                                          ),
                                          ...List<TableRow>.generate(dateProvider.tickets.length, (index) {
                                            final ticket = dateProvider.tickets[index];
                                            DateTime createdAt = DateTime.parse(ticket['created_at']);
                                            String formattedDate = DateFormat('dd MMM, yyyy').format(createdAt);
                                            String formattedTime = DateFormat('hh:mm a').format(createdAt);
                                            return myTableRow(
                                              context,
                                              (index + 1).toString(),
                                              ticket['name'] ?? 'No Name',
                                          
                                              ticket['email']+" "?? 'No Email',
                                              '$formattedDate - $formattedTime',
                                              backgroundColor: Colors.white,
                                              nameColor: Colors.black,
                                              serialNumberColor: Colors.black,
                                              emailText2Color: Colors.black,
                                            );
                                          }),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              ), ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.015,
                                    vertical: height * 0.009),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Color(0xff111111).withOpacity(
                                      0.08,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      size: 16,
                                      Icons.arrow_back,
                                      color: Color(0xff111111),
                                    ),
                                    for (var index = 0; index <= 3; index++)
                                      InkWell(
                                        onTap: () {
                                          changePage(index);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.013,
                                          ),
                                          margin: EdgeInsets.symmetric(
                                            horizontal: width * 0.01,
                                          ),
                                          decoration: _selectedPage == index
                                              ? BoxDecoration(
                                                  border: Border.all(
                                                    color: Color(0xff9945FF),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                )
                                              : BoxDecoration(),
                                          child: Text(
                                            '${index + 1}',
                                            style: TextStyle(
                                              color: _selectedPage == index
                                                  ? Color(0xff9945FF)
                                                  : Color(0xff111111),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            // TextButton(
                            //   onPressed: () {
                            //     showPasswordChangeDialogueBox(context);
                            //   },
                            //   child: Text(
                            //     'OPEN POPUP',
                            //     style: TextStyle(fontSize: 30),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              top: containerHeight / 150,
              left: containerWidth / 2,
              child: Column(
                children: [
                  if (_isDropdownOpened)
                    Container(
                      width: MediaQuery.of(context).size.width / 2.7,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: isLoading
                    ? Center(child: CircularProgressIndicator())
                    : errorMessage.isNotEmpty
                        ? Center(child: Text('Error: $errorMessage'))
                        : stores!.isNotEmpty
                            ? Column(
                                children: [
                                  Column(
                                    children: stores!.map((store) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (store['store_name'] != null) {
                                              print("Selected store: ${store['store_name']}");
                                              dataName = store['store_name'];
                                            } else {
                                              print("Store name is null");
                                            }
                                            _isDropdownOpened = false;
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 16, horizontal: 12),
                                          child: Text(
                                            store['store_name'],
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _isDropdownOpened = false;
                                      });
                                    },
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                ],
                              )
                            : Center(child: Text('No data')),
                    )
                ],
              ))
        ],
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final DateTime year;
  final double sales;
}

class TickerWithNameColorPercentage extends StatelessWidget {
  TickerWithNameColorPercentage({
    super.key,
    required this.verticalLineColor,
    required this.title,
    required this.percentage,
  });

  Color verticalLineColor;
  String title;
  String percentage;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 1;
    double width = MediaQuery.of(context).size.width * 1;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.025, vertical: height * 0.0075),
      margin: EdgeInsets.symmetric(
          horizontal: width * 0.04, vertical: height * 0.0085),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xff01060F).withOpacity(0.1),
        ),
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      child: Row(
        children: [
          Container(
            height: height * 0.035,
            width: width * 0.011,
            decoration: BoxDecoration(
              color: verticalLineColor,
              borderRadius: BorderRadius.circular(
                50,
              ),
            ),
          ),
          SizedBox(
            width: width * 0.0175,
          ),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Color(
                0xff01060F,
              ),
            ),
          ),
          Spacer(),
          Text(
            percentage,
            style: TextStyle(
              fontSize: 14,
              color: Color(
                0xff01060F,
              ),
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}

TableRow myTableRow(
  BuildContext context,
  String serialNumber,
  String name,
  String emailText1,
  String emailText2, {
  Color backgroundColor = Colors.transparent,
  Color serialNumberColor = const Color(0xff01060F),
  Color nameColor = const Color(0xff01060F),
  Color emailText2Color = const Color(0xff7F8798),
}) {
  double height = MediaQuery.of(context).size.height * 1;
  double tableRowHeight = 0.05;

  return TableRow(
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(
        3,
      ),
      shape: BoxShape.rectangle,
    ),
    children: [
      Container(
        height: height * tableRowHeight,
        child: Center(
          child: Text(
            serialNumber,
            style: TextStyle(
              color: serialNumberColor,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ),
      Text(
        name,
        style: TextStyle(
          color: nameColor,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
      RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: emailText1,
              style: TextStyle(
                color: Color(0xff01060F),
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            TextSpan(
              text: emailText2,
              style: TextStyle(
                color: emailText2Color,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

void showPasswordChangeDialogueBox(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        double height = MediaQuery.of(context).size.height * 1;
        double width = MediaQuery.of(context).size.width * 1;
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            padding: EdgeInsets.symmetric(
                vertical: height * 0.06, horizontal: width * 0.1),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: height * 0.08,
                  width: height * 0.08,
                  decoration: BoxDecoration(
                    color: Color(0xffD6B5FF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.done,
                      color: Color(0xff9945FF),
                      size: 30,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Text(
                  'Password changed successfully!',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Color(0xff343A40),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: height * 0.0175,
                ),
                Text(
                  'We recommend that you write it down so you don\'t forget, okay?',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Color(0xff6C6C6C),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      });
}

TableRow myTableRo(
  BuildContext context,
  String serialNumber,
  String name,
  String date,
  String time, {
  Color backgroundColor = Colors.white,
  Color nameColor = Colors.black,
  Color serialNumberColor = Colors.black,
  Color emailText2Color = Colors.black,
}) {
  return TableRow(
    decoration: BoxDecoration(color: backgroundColor),
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          serialNumber,
          style: TextStyle(color: serialNumberColor),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          name,
          style: TextStyle(color: nameColor),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
           time,
          style: TextStyle(color: emailText2Color),
        ),
      ),
    ],
  );
}
