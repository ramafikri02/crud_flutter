import 'package:flutter/material.dart';
import '../models/employee_model.dart';
import 'package:provider/provider.dart';
import 'package:crud_flutter/providers/employee_provider.dart';
import './employee_add.dart';

class Employee extends StatelessWidget {
  final data = [
    EmployeeModel(
      id: "1",
      employeeName: "Dilucard",
      employeeSalary: "320800",
      employeeAge: "61",
      profileImage: "",
    ),
    EmployeeModel(
      id: "2",
      employeeName: "Zilong",
      employeeSalary: "40000",
      employeeAge: "25",
      profileImage: "",
    ),
    EmployeeModel(
      id: "3",
      employeeName: "Zilong",
      employeeSalary: "40000",
      employeeAge: "25",
      profileImage: "",
    ),
    EmployeeModel(
      id: "4",
      employeeName: "Zilong",
      employeeSalary: "40000",
      employeeAge: "25",
      profileImage: "",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DPS Employee CRUD'),
      ),
      body: RefreshIndicator(
        onRefresh: () =>
        Provider.of<EmployeeProvider>(context, listen: false).getEmployee(),
        color: Colors.red,
        child: Container(
          margin: EdgeInsets.all(10),
          child: FutureBuilder(
            future: Provider.of<EmployeeProvider>(context, listen: false)
                .getEmployee(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Consumer<EmployeeProvider>(
                builder: (context, data, _) {
                  return ListView.builder(
                    itemCount: data.dataEmployee.length,
                    itemBuilder: (context, i) {
                      return Card(
                        elevation: 8,
                        child: ListTile(
                          title: Text(
                            data.dataEmployee[i].employeeName,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          subtitle:
                              Text('Umur: ${data.dataEmployee[i].employeeAge}'),
                          trailing:
                              Text("\$${data.dataEmployee[i].employeeSalary}"),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        child: Text('+'),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => EmployeeAdd()));
        },
      ),
    );
  }
}