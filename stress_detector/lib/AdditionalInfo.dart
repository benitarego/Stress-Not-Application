import 'package:flutter/material.dart';
import 'package:stress_detector/Essentials/ThemeColor.dart';
import 'package:stress_detector/Essentials/Loading.dart';
import 'package:stress_detector/DashboardPage.dart';
import 'package:stress_detector/LoginPage.dart';

class AddInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/dashboard': (context) => DashboardPage(),
      },
    );
  }
}


class AdditionalInfo extends StatefulWidget {
  @override
  _AdditionalInfoState createState() => _AdditionalInfoState();
}

class _AdditionalInfoState extends State<AdditionalInfo> {

  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController enameController = TextEditingController();
  TextEditingController econtactController = TextEditingController();
  TextEditingController erelationController = TextEditingController();

  bool loading = false;

  int _currentStep = 0;
  bool complete = false;
  StepperType stepperType = StepperType.vertical;

  String emailValidator(String value) {
    Pattern pattern =
        r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  void _nextpage() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => DashboardPage()),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nextpage();
  }

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        title: Text('Additional Information'),
        centerTitle: true,
        backgroundColor: kThemeColor,
      ),
      body:  Container(
        child: Column(
          children: [
            Expanded(
              child: Stepper(
                type: stepperType,
                physics: ScrollPhysics(),
                currentStep: _currentStep,
                onStepTapped: (step) => next(step),
                onStepContinue:  continued,
                onStepCancel: cancel,
                steps: <Step>[
                  Step(
                    title: new Text('Personal Details'),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 0 ? StepState.complete : StepState.disabled,
                    content: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Email Address'),
                          keyboardType: TextInputType.emailAddress,
                          validator: emailValidator,
                          controller: emailController,
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Contact Number'),
                          keyboardType: TextInputType.phone,
                          controller: contactController,
                        ),
                      ],
                    ),
                  ),
                  Step(
                    title: new Text('Emergency Details (Other than self)'),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 1 ? Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => DashboardPage()),
                    ) : StepState.disabled,
                    content: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Full Name'),
                          keyboardType: TextInputType.name,
                          controller: enameController,
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Emergency Contact Number'),
                          keyboardType: TextInputType.phone,
                          controller: econtactController,
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Relationship', hintText: 'Ex. Mother/Friend'),
                          keyboardType: TextInputType.name,
                          controller: erelationController,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  next(int step) {
    setState(() => _currentStep = step);
  }

  continued(){
    _currentStep < 2 ? setState(() => _currentStep += 1): null;
  }

  cancel(){
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}
