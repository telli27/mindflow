import 'package:flutter/material.dart';

class StepperPage extends StatefulWidget {
  const StepperPage({super.key});

  @override
  State<StepperPage> createState() => _StepperPageState();
}

class _StepperPageState extends State<StepperPage> {
  int currentStep = 0;
tapped(int step) {
    setState(() => currentStep = step);
  }

  continued() {
    currentStep < 2 ? setState(() => currentStep += 1) : null;
  }

  cancel() {
    currentStep > 0 ? setState(() => currentStep -= 1) : null;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 100
        ),
        child: Stepper(
          type: StepperType.horizontal,
          physics: ScrollPhysics(),
          
          currentStep: currentStep,
          onStepTapped: tapped,
          onStepContinue: continued,
          onStepCancel: cancel,
          steps: [
            Step(
              title: new Text('Account'),
              content: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Email Address'),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Password'),
                  ),
                ],
              ),
              isActive: currentStep ==0,
              state: currentStep == 0 ? StepState.complete : StepState.disabled,
            ),
            Step(
              title: new Text('Account'),
              content: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Email Address'),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Password'),
                  ),
                ],
              ),
                isActive: currentStep == 1,
              state: currentStep == 1 ? StepState.complete : StepState.disabled,
            ),
            Step(
              title: new Text('Account'),
              content: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Email Address'),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Password'),
                  ),
                ],
              ),
                  isActive: currentStep == 2,
              state: currentStep == 2 ? StepState.complete : StepState.disabled,
            ),
          ],
        ),
      ),
    );
  }
}
