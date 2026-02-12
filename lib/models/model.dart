import 'package:flutter/material.dart';
import '../models/ticket_model.dart';

import 'package:flutter_svg/flutter_svg.dart';


class TicketCard extends StatelessWidget {
  final TicketModel ticket;
  final int totalTickets;
  final int ticketCount;


  const TicketCard({
    super.key,
    required this.ticket,
    required this.totalTickets,
    required this.ticketCount,

  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // 🔥 Tuned EXACTLY for reference image
    final double headerHeight = size.height * 0.52; // deeper red
    final double overlapOffset = size.height * 0.085; // strong overlap
    final double logoSize = size.width * 0.14;

    return Stack(
      children: [
        // ===== BACKGROUND =====
        Column(
          children: [
            Container(
              height: headerHeight,
              color: Color(ticket.bgColorValue),
            ),
            Expanded(
              child: Container(color: const Color(0xFFF4F4F4)),
            ),
          ],
        ),

        // ===== CLOSE BUTTON (ABSOLUTE POSITION) =====
        Positioned(
          top: MediaQuery.of(context).padding.top + 8,
          right: 14,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () {
                Navigator.of(context).maybePop();
              },
              child: Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black26,
                ),
                child: const Icon(
                  Icons.close,
                  size: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),


        // ===== CONTENT =====
        SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ===== LOGOS =====
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildLogo(ticket.team1Url, logoSize),
                            _buildLogo(ticket.leagueUrl, logoSize * 0.6),
                            _buildLogo(ticket.team2Url, logoSize),
                          ],
                        ),
                      ),

                      // ===== MATCH INFO =====
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ticket.matchName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              "30/08/2025 15:00",
                              style:
                              TextStyle(color: Colors.white, fontSize: 14),
                            ),
                            const Text(
                              "Old Trafford",
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 13),
                            ),
                            const SizedBox(height: 16),
                            const Divider(
                                color: Colors.white24, thickness: 1),
                            const SizedBox(height: 10),
                            Text(
                              "$totalTickets ${totalTickets == 1 ? 'ticket' : 'tickets'}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ===== WHITE CARD OVERLAP =====
                      SizedBox(height: overlapOffset),

                      Transform.translate(
                        offset: Offset(0, -overlapOffset),
                        child: Padding(
                          padding:
                          const EdgeInsets.fromLTRB(16, 0, 16, 24),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.10),
                                  blurRadius: 18,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                // ===== TICKET TYPE BAR =====
                                Container(
                                  height: size.height * 0.05,
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFE31A1A),
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(14),
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    ticket.ticketType,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "NAME",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 10),
                                              ),
                                              Text(
                                                ticket.name,
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          const Text(
                                            "",
                                            style:
                                            TextStyle(color: Colors.grey),
                                          ),
                                          const SizedBox(width: 4),
                                          const Icon(Icons.info_outline,
                                              size: 16,
                                              color: Colors.grey),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      _buildInfoRow("ENTRANCE",
                                          ticket.entrance, "SECTION",
                                          ticket.section),
                                      const SizedBox(height: 14),
                                      _buildInfoRow(
                                          "ROW",
                                          ticket.row,
                                          "SEAT",
                                          ticket.seat),
                                      const Divider(height: 28),
                                      Text(
                                        ticket.seatType,
                                        style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14),
                                      ),
                                    ],
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
        ),
      ],

    );


  }



 /* Widget _buildLogo(String url, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Color(ticket.bgColorValue),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: SvgPicture.network(
        url,
        width: size * 0.65,
        height: size * 0.65,
        color: Colors.white, // optional
      ),
    );
  }

  */


  Widget _buildLogo(String url, double size) {
    return SizedBox(
      width: size,
      height: size,
      child: Center(
        child: SizedBox(
          width: size * 0.65,   // 🔥 controls visual size
          height: size * 0.65,
          child: Image.network(
            url,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => Icon(
              Icons.broken_image_outlined,
              color: Colors.white54,
              size: size * 0.5,
            ),
          ),
        ),
      ),
    );
  }




  Widget _buildInfoRow(
      String l1, String v1, String l2, String v2) {
    return Row(
      children: [
        Expanded(child: _buildInfoItem(l1, v1)),
        Expanded(child: _buildInfoItem(l2, v2)),
      ],
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style:
            const TextStyle(color: Colors.grey, fontSize: 10)),
        Text(value,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
