import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

class EmailValidator extends StatefulWidget {
  const EmailValidator({super.key});

  @override
  State<EmailValidator> createState() => _EmailValidatorState();
}

class _EmailValidatorState extends State<EmailValidator> {
  final _formKey = GlobalKey<FormState>();
  String? _email;

  void _validateAndSave() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Email is valid: $_email')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Invalid email')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Validation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                validator: ValidationBuilder().email().maxLength(50).build(),
                onSaved: (value) {
                  _email = value;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _validateAndSave,
                child: const Text('Validate'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(
      home: EmailValidator(),
    ));
