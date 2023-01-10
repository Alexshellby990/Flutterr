
import 'package:blooddonationapp/AddDonner.dart';
import 'package:flutter/material.dart';
import 'package:blooddonationapp/colors.dart';
import 'package:blooddonationapp/DonnerList.dart';
import 'package:sqflite/sqflite.dart';
import 'db_manager.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dbHelper = DatabaseHelper.instance;
  List<Map<String, dynamic>> allCategoryData = [];
  late String _categoryName="donner";
  final formGlobalKey = GlobalKey<FormState>();
  @override
  void initState() {
    _query();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: MyColors.primaryColor,
              centerTitle: true,
              title: Text("Blood Appication"),
            ),
            body: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>DonnerList()));
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xfeb97531),
                        ),
                        padding: EdgeInsets.all(5),
                        child: Center(child: Text("I need Blood", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold,color: Colors.black87),)),
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 0.2,
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddDonner()));
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xffb97513),
                        ),
                        child: Center(child: Text("I want to Donate Blood", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold,color: Colors.black87),)),
                      ),
                    ),
                  ),

                ],
              ),
            )
        ));
  }

  void _insert() async {
    // row to insert
    Map<String, dynamic> row = {DatabaseHelper.columnName: _categoryName};
    print('insert stRT');

    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
    _categoryName = "";
    _query();
  }

  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach(print);
    allCategoryData = allRows;
    setState(() {});
  }

  void _delete(int id) async {
    // Assuming that the number of rows is the id for the last row.
    final rowsDeleted = await dbHelper.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
    _query();
  }
}