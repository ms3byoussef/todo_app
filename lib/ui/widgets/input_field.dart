import 'package:flutter/material.dart';
import 'package:todo/ui/theme.dart';

class InputField extends StatelessWidget {
  const InputField({
    this.controller,
    this.label,
    this.hintText,
    this.validator,
    this.keyboardType,
    this.suffixIcon,
    this.readOnly = false,
    Key? key,
  }) : super(key: key);
  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(label!, style: AppTheme.labelText),
            const SizedBox(height: 5.0),
            TextFormField(
                readOnly: readOnly,
                controller: controller,
                keyboardType: keyboardType ?? TextInputType.none,
                onSaved: (newValue) => controller!.text = newValue!,
                decoration: InputDecoration(
                  hintText: hintText!,
                  suffixIcon: suffixIcon,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
                validator: validator),
          ],
        ),
      ),
    );
  }
}
