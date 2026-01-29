import 'package:flutter/material.dart';

class AddressSheet extends StatefulWidget {
  final ValueChanged<String> onSave;

  const AddressSheet({super.key, required this.onSave});

  @override
  State<AddressSheet> createState() => _AddressSheetState();
}

class _AddressSheetState extends State<AddressSheet> {
  final houseCtrl = TextEditingController();
  final streetCtrl = TextEditingController();
  final cityCtrl = TextEditingController();
  final stateCtrl = TextEditingController();
  final pinCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Add Full Address",
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 16),

        _field("House / Flat", houseCtrl),
        _field("Street / Area", streetCtrl),
        _field("City", cityCtrl),
        _field("State", stateCtrl),
        _field("Pincode", pinCtrl),

        const SizedBox(height: 20),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              final address = [
                houseCtrl.text,
                streetCtrl.text,
                cityCtrl.text,
                stateCtrl.text,
                pinCtrl.text,
              ].where((e) => e.trim().isNotEmpty).join(", ");

              widget.onSave(address);
              Navigator.pop(context);
            },
            child: const Text("Save Address"),
          ),
        ),
      ],
    );
  }

  Widget _field(String label, TextEditingController ctrl) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: ctrl,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}
