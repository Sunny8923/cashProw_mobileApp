import 'package:flutter/material.dart';
import 'field_card.dart';

class SupportForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String subject;
  final List<String> subjects;
  final TextEditingController emailCtrl;
  final TextEditingController messageCtrl;
  final ValueChanged<String> onSubjectChanged;

  const SupportForm({
    super.key,
    required this.formKey,
    required this.subject,
    required this.subjects,
    required this.emailCtrl,
    required this.messageCtrl,
    required this.onSubjectChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          FieldCard(
            child: DropdownButtonFormField<String>(
              value: subject,
              items: subjects
                  .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                  .toList(),
              onChanged: (v) => onSubjectChanged(v!),
              decoration: const InputDecoration(
                labelText: "Subject",
                border: InputBorder.none,
              ),
            ),
          ),

          const SizedBox(height: 14),

          FieldCard(
            child: TextFormField(
              controller: emailCtrl,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Email (optional)",
                hintText: "your@email.com",
                border: InputBorder.none,
              ),
            ),
          ),

          const SizedBox(height: 14),

          FieldCard(
            child: TextFormField(
              controller: messageCtrl,
              maxLines: 6,
              decoration: const InputDecoration(
                labelText: "Your Message",
                hintText: "Describe your issue or feedback...",
                border: InputBorder.none,
              ),
            ),
          ),

          const SizedBox(height: 26),

          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () {
                FocusScope.of(context).unfocus();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Message ready to send (API later)"),
                  ),
                );
              },
              child: const Text(
                "Send Message",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
