import 'package:flutter/material.dart';

class CreateUser extends StatefulWidget {
    @override
    _CreateUserState createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
    final _formKey = GlobalKey<FormState>();
    String? _selectedSex;

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: Text('Create User')),
            body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                        children: [
                            TextFormField(
                                decoration: InputDecoration(labelText: 'First Name'),
                                validator: (value) => value!.isEmpty ? 'Enter first name' : null,
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                                decoration: InputDecoration(labelText: 'Last Name'),
                                validator: (value) => value!.isEmpty ? 'Enter last name' : null,
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Date of Birth',
                                    suffixIcon: Icon(Icons.calendar_today),
                                ),
                                readOnly: true,
                                onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime.now(),
                                    );
                                    if (pickedDate != null) {

                                    }
                                },
                                validator: (value) => value!.isEmpty ? 'Select date of birth' : null,
                            ),
                            SizedBox(height: 10),
                            DropdownButtonFormField<String>(
                                decoration: InputDecoration(labelText: 'Sex'),
                                value: _selectedSex,
                                items: ['Male', 'Female']
                                    .map((sex) => DropdownMenuItem(value: sex, child: Text(sex)))
                                    .toList(),
                                onChanged: (value) => setState(() => _selectedSex = value),
                                validator: (value) => value == null ? 'Select sex' : null,
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                                decoration: InputDecoration(labelText: 'Height (cm)'),
                                keyboardType: TextInputType.number,
                                validator: (value) => value!.isEmpty ? 'Enter height' : null,
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                                onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text('User Created Successfully!')),
                                        );
                                    }
                                },
                                child: Text('Submit'),
                            ),
                        ],
                    ),
                ),
            ),
        );
    }
}

