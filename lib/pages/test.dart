import 'package:flutter/material.dart';
import '../models/employee_model.dart';
import 'package:provider/provider.dart';
import 'package:crud_flutter/providers/employee_provider.dart';

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
      employeeName: "Alok",
      employeeSalary: "40000",
      employeeAge: "25",
      profileImage: "",
    ),
    EmployeeModel(
      id: "4",
      employeeName: "Simon",
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
      body: ListView.builder(
        itemCount: data.length, //MENGHITUNG JUMLAH DATA YANG AKAN DITAMPILKAN
        //LOOPING DATA
        itemBuilder: (context, i) {
          //KEMUDIAN TAMPILKAN DATA PEGAWAI BERDASARKAN INDEX YANG DISIMPAN DI DALAM VARIABLE I
          return Card(
            elevation: 8,
            child: ListTile(
              title: Text(
                data[i].employeeName,
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle:
                  Text('Umur: ${data[i].employeeAge}'),
              trailing:
                 Text("\$${data[i].employeeSalary}"),
            ),
          );
        },
      ),
    );
  }
}