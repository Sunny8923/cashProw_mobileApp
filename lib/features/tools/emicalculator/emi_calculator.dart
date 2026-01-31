import 'dart:math';
import 'package:flutter/material.dart';

class EmiCalculatorScreen extends StatefulWidget {
  const EmiCalculatorScreen({super.key});

  @override
  State<EmiCalculatorScreen> createState() => _EmiCalculatorScreenState();
}

class _EmiCalculatorScreenState extends State<EmiCalculatorScreen> {
  double loanAmount = 500000;
  double interestRate = 10;
  int tenureMonths = 60;

  double get monthlyRate => interestRate / 12 / 100;

  double get emi {
    if (monthlyRate == 0) return loanAmount / tenureMonths;
    return loanAmount *
        monthlyRate *
        pow(1 + monthlyRate, tenureMonths) /
        (pow(1 + monthlyRate, tenureMonths) - 1);
  }

  double get totalPayable => emi * tenureMonths;
  double get totalInterest => totalPayable - loanAmount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 52, bottom: 32),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primary,
                    theme.colorScheme.primary.withOpacity(0.75),
                  ],
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

                  Text(
                    "EMI Calculator",
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            /// 📋 CONTENT
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _InputCard(
                    title: "Loan Amount",
                    value: "₹ ${loanAmount.toStringAsFixed(0)}",
                    child: Slider(
                      min: 50000,
                      max: 5000000,
                      divisions: 99,
                      value: loanAmount,
                      onChanged: (v) => setState(() => loanAmount = v),
                    ),
                  ),

                  _InputCard(
                    title: "Interest Rate (% p.a.)",
                    value: interestRate.toStringAsFixed(2),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "Enter interest rate",
                        border: InputBorder.none,
                      ),
                      onChanged: (v) => setState(
                        () => interestRate = double.tryParse(v) ?? 0,
                      ),
                    ),
                  ),

                  _InputCard(
                    title: "Tenure (Months)",
                    value: "$tenureMonths months",
                    child: Slider(
                      min: 6,
                      max: 360,
                      divisions: 59,
                      value: tenureMonths.toDouble(),
                      onChanged: (v) =>
                          setState(() => tenureMonths = v.round()),
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// 📊 RESULT CARD
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _ResultRow(
                          "Monthly EMI",
                          "₹ ${emi.toStringAsFixed(0)}",
                          highlight: true,
                        ),
                        const Divider(),
                        _ResultRow(
                          "Total Interest",
                          "₹ ${totalInterest.toStringAsFixed(0)}",
                        ),
                        const SizedBox(height: 6),
                        _ResultRow(
                          "Total Payable",
                          "₹ ${totalPayable.toStringAsFixed(0)}",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

/// 🔹 Input card (same design system)
class _InputCard extends StatelessWidget {
  final String title;
  final String value;
  final Widget child;

  const _InputCard({
    required this.title,
    required this.value,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

/// 🔹 Result row
class _ResultRow extends StatelessWidget {
  final String label;
  final String value;
  final bool highlight;

  const _ResultRow(this.label, this.value, {this.highlight = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: highlight ? FontWeight.w800 : FontWeight.w600,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: highlight ? 18 : 14,
            color: highlight
                ? theme.colorScheme.primary
                : theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
