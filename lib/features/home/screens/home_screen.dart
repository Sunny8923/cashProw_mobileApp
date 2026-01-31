import 'package:cash_prow/features/home/widgets/home_drawer.dart';
import 'package:cash_prow/features/home/widgets/home_summary_card.dart';
import 'package:cash_prow/features/leads/presentation/providers/leads_controller.dart';
import 'package:cash_prow/features/referal/presentation/screens/add_referral_screen.dart';
import 'package:cash_prow/features/home/widgets/expandable_lead_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedTab = 0; // 0 = Self, 1 = Referral
  String _statusFilter = "All";

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(leadsControllerProvider.notifier).fetchLeads();
    });
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    final leadsState = ref.watch(leadsControllerProvider);
    final allLeads = leadsState.leads;

    // ---------------- SUMMARY CALCULATIONS ----------------

    final totalPoints = allLeads.fold<int>(0, (sum, l) => sum + l.points);

    final selfLeads = allLeads
        .where((l) => l.type.toLowerCase().contains("self"))
        .length;

    final referralLeads = allLeads
        .where((l) => l.type.toLowerCase().contains("referral"))
        .length;

    final approvedLeads = allLeads.where((l) {
      final s = (l.status ?? "").toLowerCase();
      return s.contains("approved") || s.contains("disbursed");
    }).length;

    final pendingLeads = allLeads.where((l) {
      final s = (l.status ?? "").toLowerCase();
      return s.contains("pending") ||
          s.contains("new") ||
          s.contains("progress");
    }).length;

    // ---------------- FILTERED LIST ----------------

    final leads = allLeads.where((lead) {
      final type = lead.type.trim().toLowerCase();
      final status = (lead.status ?? "").trim().toLowerCase();

      final matchesType = _selectedTab == 0
          ? type.contains("self")
          : type.contains("referral");

      if (!matchesType) return false;

      if (_statusFilter == "All") return true;

      if (_statusFilter == "Pending") {
        return status.contains("pending") ||
            status.contains("new") ||
            status.contains("progress");
      }

      if (_statusFilter == "Approved") {
        return status.contains("approved") || status.contains("disbursed");
      }

      if (_statusFilter == "Rejected") {
        return status.contains("rejected");
      }

      return true;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        elevation: 0,
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu_rounded, color: Colors.white, size: 28),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: SizedBox(
          height: 36,
          child: Image.asset("assets/images/logo_white.png"),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.person_add_alt_1_rounded,
              color: Colors.white,
              size: 26,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddReferralScreen()),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),

      drawer: const HomeDrawer(),

      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(leadsControllerProvider.notifier).fetchLeads();
        },
        child: Builder(
          builder: (_) {
            if (leadsState.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (leadsState.error != null) {
              return Center(child: Text(leadsState.error!));
            }

            return Column(
              children: [
                // 📊 SUMMARY CARD
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                  child: HomeSummaryCard(
                    totalPoints: totalPoints,
                    selfLeads: selfLeads,
                    referralLeads: referralLeads,
                    approvedLeads: approvedLeads,
                    pendingLeads: pendingLeads,
                  ),
                ),

                // 🔁 Self | Referral + Filter Button Row
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                  child: Row(
                    children: [
                      // Slider takes most space
                      Expanded(child: _leadTypeSlider(primary)),

                      const SizedBox(width: 10),

                      // Filter Icon
                      _statusFilterMenu(primary),
                    ],
                  ),
                ),

                // 📋 LIST AREA (or Lottie)
                Expanded(
                  child: leads.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 220,
                                child: Lottie.asset(
                                  "assets/lottie/no_data.json",
                                ),
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                "No leads yet",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                "Try changing filters or add new leads",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                          itemCount: leads.length,
                          itemBuilder: (context, index) {
                            return ExpandableLeadCard(lead: leads[index]);
                          },
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // ================= SLIDER =================

  Widget _leadTypeSlider(Color primary) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          _sliderTab("Self", 0, primary),
          _sliderTab("Referral", 1, primary),
        ],
      ),
    );
  }

  Widget _sliderTab(String label, int index, Color primary) {
    final active = _selectedTab == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: active ? primary : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: active ? Colors.white : Colors.black87,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _statusFilterMenu(Color primary) {
    return PopupMenuButton<String>(
      tooltip: "Filter status",
      onSelected: (value) {
        setState(() => _statusFilter = value);
      },
      itemBuilder: (context) => const [
        PopupMenuItem(value: "All", child: Text("All")),
        PopupMenuItem(value: "Pending", child: Text("Pending")),
        PopupMenuItem(value: "Approved", child: Text("Approved")),
        PopupMenuItem(value: "Rejected", child: Text("Rejected")),
      ],
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(Icons.filter_list_rounded, color: primary),
      ),
    );
  }
}
