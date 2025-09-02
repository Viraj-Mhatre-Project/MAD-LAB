import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Ensure to add intl package to pubspec.yaml

void main() {
  runApp(MaterialApp(
    title: 'Flutter Forms Task 2',
    debugShowCheckedModeBanner: false,
    home: Task2MenuPage(),
  ));
}

class Task2MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task 2: Forms Menu')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => MultiStepRegistrationForm())),
                child: Text('2.1 Multi-Step Registration Form'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => DynamicFieldsForm())),
                child: Text('2.2 Dynamic Fields Form'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => DatePickerForm())),
                child: Text('2.3 Date Picker Form'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- 2.1 Multi-Step Registration Form ---
class MultiStepRegistrationForm extends StatefulWidget {
  @override
  _MultiStepRegistrationFormState createState() => _MultiStepRegistrationFormState();
}

class _MultiStepRegistrationFormState extends State<MultiStepRegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;
  String _email = '';
  String _password = '';
  String _name = '';
  String _phone = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Multi-Step Registration')),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 400),
                child: _currentStep == 0
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Email'),
                            validator: (val) => val != null && val.contains('@') ? null : 'Enter valid email',
                            onSaved: (val) => _email = val ?? '',
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Password'),
                            obscureText: true,
                            validator: (val) => val != null && val.length >= 6 ? null : 'Password min 6 chars',
                            onSaved: (val) => _password = val ?? '',
                          ),
                          SizedBox(height: 24),
                          ElevatedButton(
                            child: Text('Next'),
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                _formKey.currentState?.save();
                                setState(() => _currentStep = 1);
                              }
                            },
                          )
                        ],
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Name'),
                            validator: (val) => val != null && val.isNotEmpty ? null : 'Enter name',
                            onSaved: (val) => _name = val ?? '',
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Phone Number'),
                            keyboardType: TextInputType.phone,
                            validator: (val) => val != null && val.length == 10 ? null : 'Enter 10-digit phone',
                            onSaved: (val) => _phone = val ?? '',
                          ),
                          SizedBox(height: 24),
                          ElevatedButton(
                            child: Text('Submit'),
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                _formKey.currentState?.save();
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content: Text('Registration Successful!\n'
                                        'Email: $_email\n'
                                        'Name: $_name\n'
                                        'Phone: $_phone'),
                                  ),
                                );
                              }
                            },
                          )
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// --- 2.2 Dynamic Fields Form ---
class DynamicFieldsForm extends StatefulWidget {
  @override
  _DynamicFieldsFormState createState() => _DynamicFieldsFormState();
}

class _DynamicFieldsFormState extends State<DynamicFieldsForm> {
  final _formKey = GlobalKey<FormState>();
  List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    _addTextField();
  }

  void _addTextField() {
    setState(() {
      _controllers.add(TextEditingController());
    });
  }

  void _removeTextField(int index) {
    setState(() {
      _controllers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dynamic Fields Form')),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 400),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _controllers.length,
                      itemBuilder: (context, index) => Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _controllers[index],
                              decoration: InputDecoration(labelText: 'Field ${index + 1}'),
                              validator: (val) =>
                                  val != null && val.isNotEmpty ? null : 'This field is required',
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.remove_circle),
                            onPressed: () => _removeTextField(index),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          child: Text('Add Field'),
                          onPressed: _addTextField,
                        ),
                        SizedBox(width: 12),
                        ElevatedButton(
                          child: Text('Submit'),
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Form Submitted! Values: ${_controllers.map((c) => c.text).join(', ')}')),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// --- 2.3 Form with Date Picker ---
class DatePickerForm extends StatefulWidget {
  @override
  _DatePickerFormState createState() => _DatePickerFormState();
}

class _DatePickerFormState extends State<DatePickerForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  DateTime? _selectedDate;

  Future<void> _pickDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (date != null) setState(() => _selectedDate = date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Date Picker Form')),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 400),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(labelText: 'Name'),
                      validator: (val) => val != null && val.isNotEmpty ? null : 'Enter name',
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () => _pickDate(context),
                      child: InputDecorator(
                        decoration: InputDecoration(labelText: 'Date of Birth'),
                        child: Text(
                          _selectedDate == null
                              ? 'Select date'
                              : DateFormat.yMMMMd().format(_selectedDate!),
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    ElevatedButton(
                      child: Text('Submit'),
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          if (_selectedDate == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Please select a date!')),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Form Submitted!\n'
                                  'Name: ${_nameController.text}\n'
                                  'DOB: ${DateFormat.yMMMMd().format(_selectedDate!)}'),
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
