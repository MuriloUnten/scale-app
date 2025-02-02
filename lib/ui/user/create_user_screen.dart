import 'package:flutter_app_test/ui/user/create_user_viewmodel.dart';
import "package:flutter_app_test/utils/format.dart";

import 'package:flutter/material.dart';
import 'package:flutter_app_test/utils/result.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:go_router/go_router.dart';

class CreateUser extends StatefulWidget {
    const CreateUser({
        super.key,
        required this.viewModel,
    });

    final CreateUserViewmodel viewModel;

    @override
    State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
    final _formKey = GlobalKey<FormState>();
    final _firstNameController = TextEditingController();
    final _lastNameController = TextEditingController();
    final _dateOfBirthController = TextEditingController();
    final _heightController = TextEditingController();
    String? _selectedSex;

    @override
    void dispose() {
        _firstNameController.dispose();
        _lastNameController .dispose();
        _dateOfBirthController.dispose();
        _heightController.dispose();
        _selectedSex = null;
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: Text('Create User')),
            body: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                    key: _formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            TextFormField(
                                controller: _firstNameController,
                                decoration: InputDecoration(labelText: 'First Name'),
                                validator: (value) => value!.isEmpty ? 'Enter first name' : null,
                                autofocus: true,
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                                controller: _lastNameController,
                                decoration: InputDecoration(labelText: 'Last Name'),
                                validator: (value) => value!.isEmpty ? 'Enter last name' : null,
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                                controller: _dateOfBirthController,
                                decoration: InputDecoration(
                                    labelText: 'Date of Birth',
                                    suffixIcon: Icon(Icons.calendar_today),
                                ),
                                readOnly: true,
                                onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.parse("2000-01-01"),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime.now(),
                                    );
                                    if (pickedDate != null) {
                                        _dateOfBirthController.text = formatDate(pickedDate);
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
                                controller: _heightController,
                                decoration: InputDecoration(labelText: 'Height (cm)'),
                                keyboardType: TextInputType.number,
                                validator: (value) => value!.isEmpty ? 'Enter height' : null,
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                                onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                        widget.viewModel.createUser((
                                            _firstNameController.text,
                                            _lastNameController.text,
                                            _dateOfBirthController.text,
                                            _selectedSex!,
                                            _heightController.text,
                                        ));
                                        widget.viewModel.createUser.listen((result, _) {
                                            switch (result) {
                                                case Ok(): {
                                                    if (result.value.id != null) {
                                                        context.goNamed("home");
                                                    }
                                                }
                                                case Error(): {
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                        SnackBar(content: Text('Failed to create User. Error: ${result.error}')),
                                                    );
                                                }
                                            }
                                        });
                                    }
                                },
                                child: Text('Create'),
                            ),
                        ],
                    ),
                ),
            ),
        );
    }
}

