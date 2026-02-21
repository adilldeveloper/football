import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'models/ticket_model.dart';
import 'widgets/ticket_card.dart';

void main() => runApp(const TicketMasterApp());

class TicketMasterApp extends StatelessWidget {
  const TicketMasterApp({super.key});
  @override
  Widget build(BuildContext context) => const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: InputScreen(),
  );
}

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});
  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {

  Color ticketTypeColor = const Color(0xFFE31A1A);

  final controllers = List.generate(12, (_) => TextEditingController());
  Color pickerColor = const Color(0xFFD11212);

  @override
  void initState() {
    super.initState();

    controllers[11].text = "1";
    controllers[0].text = "Manchester United v Burnley";
    controllers[1].text = "John Doe";
    controllers[2].text = "N410";
    controllers[3].text = "NE3425";
    controllers[4].text = "28";
    controllers[5].text = "105";
    controllers[9].text = "Padded Seat";
    controllers[10].text = "Adult";

    controllers[6].text =
    "https://brandlogos.net/wp-content/uploads/2025/04/manchester_united_fc_1970-logo_brandlogos.net_vixfj.png";
    controllers[7].text = "https://brandlogos.net/wp-content/uploads/2025/04/manchester_united_fc_1970-logo_brandlogos.net_vixfj.png";
    controllers[8].text =
    "https://static.vecteezy.com/system/resources/previews/066/118/643/non_2x/laliga-logo-transparent-background-football-club-icon-digital-download-free-png.png";
  }

  Future<void> saveTicket() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList('tickets') ?? [];


    final newTicket = TicketModel(
      matchName: controllers[0].text,
      name: controllers[1].text,
      entrance: controllers[2].text,
      section: controllers[3].text,
      row: controllers[4].text,
      seat: controllers[5].text,
      team1Url: controllers[6].text,
      team2Url: controllers[7].text,
      leagueUrl: controllers[8].text,
      seatType: controllers[9].text,
      ticketType: controllers[10].text,
      bgColorValue: pickerColor.value,
      ticketCount: int.tryParse(controllers[11].text) ?? 1,  // ✅ ADD HERE
      ticketTypeColorValue: ticketTypeColor.value,


    );

    saved.add(jsonEncode(newTicket.toMap()));
    await prefs.setStringList('tickets', saved);

    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SavedTicketsListScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Ticket")),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _field(controllers[0], "Team Name of two teams"),
                  _field(controllers[1], "Person Name"),
                  Row(children: [
                    Expanded(child: _field(controllers[2], "Entrance")),
                    const SizedBox(width: 10),
                    Expanded(child: _field(controllers[3], "Section")),
                  ]),
                  Row(children: [
                    Expanded(child: _field(controllers[4], "Row")),
                    const SizedBox(width: 10),
                    Expanded(child: _field(controllers[5], "Seat")),
                  ]),
                  _field(controllers[10], "Ticket Type"),
                  _field(controllers[9], "Seat Type"),
                  _field(controllers[11], "Number of Tickets"),

                  _field(controllers[6], "Home Logo URL"),
                  _field(controllers[7], "Away Logo URL"),
                  _field(controllers[8], "League Logo URL"),
                  ListTile(
                    title: const Text("BG Color"),
                    trailing: CircleAvatar(backgroundColor: pickerColor),
                    onTap: _showPicker,
                  ),

                  ListTile(
                    title: const Text("Ticket Type Color"),
                    trailing: CircleAvatar(
                      backgroundColor: ticketTypeColor,
                    ),
                    onTap: _showTicketTypeColorPicker,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(children: [
                Expanded(
                  child:
                  ElevatedButton(onPressed: saveTicket, child: const Text("GENERATE")),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const SavedTicketsListScreen()),
                    ),
                    child: const Text("GO TO LISTS"),
                  ),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }

  Widget _field(TextEditingController c, String l) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: TextField(
      controller: c,
      decoration:
      InputDecoration(labelText: l, border: const OutlineInputBorder()),
    ),
  );

  void _showPicker() => showDialog(
    context: context,
    builder: (_) => AlertDialog(
      content: ColorPicker(
        pickerColor: pickerColor,
        onColorChanged: (color) => setState(() => pickerColor = color),
      ),
    ),
  );


  void _showTicketTypeColorPicker() {
    showDialog(
      context: context,
      builder: (_) {
        Color tempColor = ticketTypeColor;

        return AlertDialog(
          title: const Text("Select Ticket Type Color"),
          content: ColorPicker(
            pickerColor: ticketTypeColor,
            onColorChanged: (color) => tempColor = color,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() => ticketTypeColor = tempColor);
                Navigator.pop(context);
              },
              child: const Text("Select"),
            ),
          ],
        );
      },
    );
  }

}




//input screen ends here


class SavedTicketsListScreen extends StatefulWidget {
  const SavedTicketsListScreen({super.key});
  @override
  State<SavedTicketsListScreen> createState() =>
      _SavedTicketsListScreenState();
}

class _SavedTicketsListScreenState extends State<SavedTicketsListScreen> {
  List<TicketModel> tickets = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('tickets') ?? [];
    setState(() {
      tickets =
          data.map((e) => TicketModel.fromMap(jsonDecode(e))).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Generated Tickets")),
      body: ListView.builder(
        itemCount: tickets.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(tickets[index].matchName),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TicketSwipeScreen(initialIndex: index),
            ),
          ),
        ),
      ),
    );
  }
}

class TicketSwipeScreen extends StatefulWidget {
  final int initialIndex;
  const TicketSwipeScreen({super.key, required this.initialIndex});

  @override
  State<TicketSwipeScreen> createState() => _TicketSwipeScreenState();
}

class _TicketSwipeScreenState extends State<TicketSwipeScreen> {
  List<TicketModel> tickets = [];
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
    _load();
  }

  void _load() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('tickets') ?? [];
    setState(() {
      tickets =
          data.map((e) => TicketModel.fromMap(jsonDecode(e))).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false, // ❌ kills white back arrow

      //  iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: tickets.length,
              onPageChanged: (i) => setState(() => _currentIndex = i),
              itemBuilder: (_, i) =>
                  TicketCard(
                    ticket: tickets[i],
                    totalTickets: tickets[i].ticketCount,
                  ),

            ),
          ),

          // ✅ CORRECT DOT INDICATOR
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(tickets.length, (i) {
                  final active = _currentIndex == i;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: active ? 9 : 6,
                    height: active ? 9 : 6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: active ? Colors.black54 : Colors.black26,
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
