import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/help_header.dart';
import '../widgets/contact_card.dart';
import '../widgets/support_form.dart';

class HelpSupportScreen extends ConsumerStatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  ConsumerState<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends ConsumerState<HelpSupportScreen> {
  final _formKey = GlobalKey<FormState>();

  String _subject = "Account Issue";
  final _messageCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();

  final List<String> _subjects = const [
    "Account Issue",
    "Payment & Rewards",
    "App Bug",
    "Suggestion",
    "Other",
  ];

  @override
  void dispose() {
    _messageCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HelpHeader(),

            const SizedBox(height: 22),

            const ContactCard(),

            const SizedBox(height: 24),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SupportForm(
                formKey: _formKey,
                subject: _subject,
                subjects: _subjects,
                emailCtrl: _emailCtrl,
                messageCtrl: _messageCtrl,
                onSubjectChanged: (v) => setState(() => _subject = v),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
