import 'package:cash_prow/features/referal/presentation/controllers/leads_controller.dart';
import 'package:cash_prow/features/referal/presentation/utils/product_mapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddReferralScreen extends ConsumerStatefulWidget {
  const AddReferralScreen({super.key});

  @override
  ConsumerState<AddReferralScreen> createState() => _AddReferralScreenState();
}

class _AddReferralScreenState extends ConsumerState<AddReferralScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameCtrl = TextEditingController();
  final _mobileCtrl = TextEditingController();
  final _locationCtrl = TextEditingController();

  String? _selectedProduct;

  static const _products = [
    "Personal Loan",
    "Business Loan",
    "Home Loan",
    "Property Loan",
    "Overdraft Limit",
    "New Car Loan",
    "Used Car Loan",
    "Machinery Loan",
    "Education Loan",
    "Credit Card",
  ];

  @override
  void dispose() {
    _nameCtrl.dispose();
    _mobileCtrl.dispose();
    _locationCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final leadState = ref.watch(leadsControllerProvider);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          /// 🔝 GRADIENT HEADER (same app style)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 52, bottom: 32),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primary, primary.withOpacity(0.75)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: Row(
              children: [
                const SizedBox(width: 16),

                /// 🔙 CUSTOM BACK BUTTON
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.25),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 6,
                          color: Colors.black.withOpacity(0.15),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                const Text(
                  "Add Referral",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          /// 📋 CONTENT (scrollable)
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  /// 🔥 Top Info Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [primary, primary.withOpacity(0.85)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.person_add_alt_1_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            "Add a new referral lead and start earning rewards",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  /// 🧾 Form Card
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            _field(
                              controller: _nameCtrl,
                              label: "Referral Name",
                              icon: Icons.person_outline_rounded,
                            ),

                            _field(
                              controller: _mobileCtrl,
                              label: "Reference Mobile No",
                              icon: Icons.phone_outlined,
                              keyboard: TextInputType.phone,
                              maxLength: 10,
                            ),

                            _productDropdown(),

                            _field(
                              controller: _locationCtrl,
                              label: "Location",
                              icon: Icons.location_on_outlined,
                            ),

                            const SizedBox(height: 24),

                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primary,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                onPressed: leadState.loading ? null : _submit,
                                child: leadState.loading
                                    ? const SizedBox(
                                        width: 22,
                                        height: 22,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Text("Submit Referral"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- UI WIDGETS ----------------

  Widget _field({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboard = TextInputType.text,
    int? maxLength,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboard,
        maxLength: maxLength,
        validator: (v) => v == null || v.trim().isEmpty ? "Required" : null,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          counterText: "",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
    );
  }

  Widget _productDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: DropdownButtonFormField<String>(
        value: _selectedProduct,
        items: _products.map((p) {
          return DropdownMenuItem(value: p, child: Text(p));
        }).toList(),
        onChanged: (v) => setState(() => _selectedProduct = v),
        validator: (v) => v == null ? "Select product" : null,
        decoration: InputDecoration(
          labelText: "Product",
          prefixIcon: const Icon(Icons.shopping_bag_outlined),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
    );
  }

  // ---------------- ACTION ----------------

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final apiProduct = productMap[_selectedProduct];

    try {
      await ref
          .read(leadsControllerProvider.notifier)
          .createReferralLead(
            name: _nameCtrl.text.trim(),
            phone: _mobileCtrl.text.trim(),
            product: apiProduct!,
            location: _locationCtrl.text.trim(),
          );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Referral added successfully ✅")),
        );

        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Failed to add referral")));
    }
  }
}
