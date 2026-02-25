import 'package:flutter/material.dart';
import '../models/ticket_model.dart';
import 'dart:io';


class TicketCard extends StatelessWidget {
  final TicketModel ticket;
  final int totalTickets;


  const TicketCard({
    super.key,
    required this.ticket,
    required this.totalTickets,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;


    final Color baseColor = Color(ticket.bgColorValue);
    final Color darkerColor = darken(baseColor, 0.25);


    // ===== RESPONSIVE METRICS =====
    final double headerHeight = size.height * 0.52;
    final double overlapOffset = size.height * 0.065;
    final double logoSize = size.width * 0.14;

    // ✅ iOS / Android safe close button position
    final double statusBar = MediaQuery.of(context).padding.top;
    final double closeTop = (statusBar * 0.6).clamp(8.0, 22.0);


    return Stack(
      children: [
        // ===== BACKGROUND =====
        Column(
          children: [


            Container(
              height: headerHeight,
              child: Stack(
                children: [

                  // ===== BASE RED GRADIENT =====
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          baseColor,
                          darken(baseColor, 0.15),
                        ],
                      ),
                    ),
                  ),

                  // ===== DIAGONAL DARK OVERLAY =====
                  ClipPath(
                    clipper: DiagonalClipper(),
                    child: Container(
                      color: darken(baseColor, 0.10),
                    ),
                  ),

                  // ===== SHARP EDGE LINE =====
                  CustomPaint(
                    painter: EdgeLinePainter(),
                    size: Size(size.width, headerHeight),
                  ),
                ],
              ),
            ),



            Expanded(
              child: Container(color: const Color(0xFFF4F4F4)),
            ),
          ],
        ),

        // ===== CLOSE BUTTON (FINAL, DEVICE SAFE) =====
        Positioned(
          top: closeTop,
          right: 14,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 26,
              height: 26,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black26,
              ),
              child: const Icon(
                Icons.close,
                size: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),

        // ===== CONTENT =====
        SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ===== LOGOS =====
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [


                      _buildLogo(ticket.team1LocalPath, ticket.team1Url, logoSize),
                      _buildLogo(ticket.leagueLocalPath, ticket.leagueUrl, logoSize * 0.7),
                      _buildLogo(ticket.team2LocalPath, ticket.team2Url, logoSize),

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
                        style:
                        TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                      const SizedBox(height: 16),
                      const Divider(color: Colors.white24, thickness: 1),
                      const SizedBox(height: 10),
                      Text(
                        "$totalTickets ${totalTickets == 1 ? 'ticket' : 'tickets'}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 20), // 👈 THIS LINE fixes Android spacing

                    ],
                  ),
                ),

                // ===== SPACE FOR OVERLAP =====
                SizedBox(height: overlapOffset),

                // ===== WHITE TICKET CARD =====
                Transform.translate(
                  offset: Offset(0, -overlapOffset),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
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
                            decoration: BoxDecoration(
                             // color: Color(0xFFE31A1A),
                              color: Color(ticket.ticketTypeColorValue),

                              borderRadius: const BorderRadius.vertical(
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

                          // ===== DETAILS =====
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                // NAME
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
                                            fontSize: 22, // to make Name More Big
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    const Icon(
                                      Icons.info_outline,
                                      size: 16,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 20),

                                _buildInfoRow(
                                  "ENTRANCE",
                                  ticket.entrance,
                                  "SECTION",
                                  ticket.section,
                                ),

                                const SizedBox(height: 14),

                                _buildInfoRow(
                                  "ROW",
                                  ticket.row,
                                  "SEAT",
                                  ticket.seat,
                                ),

                                const Divider(height: 28),

                                Text(
                                  ticket.seatType,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
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
    );
  }

  // ===== HELPERS =====


  //---------------------------



  Widget _buildLogo(
      String? localPath,
      String? url,
      double size,
      ) {
    return SizedBox(
      width: size,
      height: size,
      child: Center(
        child: _buildImage(localPath, url),
      ),
    );
  }

  Widget _buildImage(String? localPath, String? url) {

    if (localPath != null && localPath.isNotEmpty) {
      return Image.file(
        File(localPath),
        fit: BoxFit.contain,
      );
    }

    if (url != null && url.isNotEmpty) {
      return Image.network(
        url,
        fit: BoxFit.contain,
      );
    }

    return const Icon(Icons.image_not_supported_outlined);
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
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 10,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }




  Color darken(Color color, [double amount = .2]) {
    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness(
      (hsl.lightness - amount).clamp(0.0, 1.0),
    );
    return hslDark.toColor();
  }

}


class DiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width * 0.68, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.65);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}


class EdgeLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.06)
      ..strokeWidth = 2;

    canvas.drawLine(
      Offset(size.width * 0.68, 0),
      Offset(size.width, size.height * 0.65),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
