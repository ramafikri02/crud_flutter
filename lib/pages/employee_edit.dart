import 'package:crud_flutter/pages/employee.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/employee_provider.dart';

class EmployeeEdit extends StatefulWidget {
  final String id;

  @override
  _EmployeeEditState createState() => _EmployeeEditState();
}

class _EmployeeEditState extends State<EmployeeEdit> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _salary = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final snackbarKey = GlobalKey<ScaffoldState>();

  bool _isLoading = false;

  FocusNode salaryNode = FocusNode();
  FocusNode ageNode = FocusNode();
  
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<EmployeeProvider>(context, listen:false).findEmployee(widget.id).then((response) {
        _name.text = response.employeeName;
        _salary.text = response.employeeSalary;
        _age.text = response.employeeAge;
      });
    });
    super.initState();
  }

  void submit(BuildContext context) {
    if(!_isLoading) {
      setState(() {
        _isLoading:true;
      });
    }
    Provider.of<EmployeeProvider>(context, listen: false)
      .storeEmployee(_name.text, _salary.text, _age.text)
      .then((res) {
        if (res) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Employee()));
        } else {
          var snackbar = SnackBar(content: Text('Ops, Error. Hubungi Admin'),);
          snackbarKey.currentState.showSnackBar(snackbar);
          setState(() {
            _isLoading = false;
          });
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: snackbarKey,
      appBar: AppBar(
        title: Text('Edit Employee'),
        actions: <Widget>[
          FlatButton(
            child: _isLoading
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : Icon(
                    Icons.save,
                    color: Colors.white,
                  ),
            onPressed: () => submit(context),
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            TextField(
              controller: _name,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.pinkAccent,
                  ),
                ),
                hintText: 'Nama Lengkap',
              ),
              //JIKA TOMBOL SUBMIT PADA KEYBOARD DITEKAN
              onSubmitted: (_) {
                //MAKA FOCUSNYA AKAN DIPINDAHKAN PADA FORM INPUT SELANJUTNYA
                FocusScope.of(context).requestFocus(salaryNode);
              },
            ),
            TextField(
              controller: _salary,
              focusNode: salaryNode,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.pinkAccent,
                  ),
                ),
                hintText: 'Gaji',
              ),
              onSubmitted: (_) {
                FocusScope.of(context).requestFocus(ageNode);
              },
            ),
            TextField(
              controller: _age,
              focusNode: ageNode,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.pinkAccent,
                  ),
                ),
                hintText: 'Umur',
              ),
            ),
          ],
        ),
      ),
    );
  }
}