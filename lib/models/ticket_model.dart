class TicketModel {
  String matchName, name, entrance, section, row, seat, team1Url, team2Url, leagueUrl, seatType, ticketType;
  int bgColorValue; int ticketCount; int ticketTypeColorValue;



  TicketModel({
    required this.matchName, required this.name, required this.entrance,
    required this.section, required this.row, required this.seat,
    required this.team1Url, required this.team2Url, required this.leagueUrl,
    required this.seatType, required this.ticketType, required this.bgColorValue,
    required this.ticketCount,   required this.ticketTypeColorValue, // 👈 ADD THIS

  });

  Map<String, dynamic> toMap() => {

    'match': matchName, 'name': name, 'entrance': entrance, 'section': section,
    'row': row, 'seat': seat, 't1': team1Url, 't2': team2Url, 'lg': leagueUrl,
    'st': seatType, 'tt': ticketType, 'bg': bgColorValue,'ticketCount': ticketCount, 'ticketTypeColor': ticketTypeColorValue,


  };

  factory TicketModel.fromMap(Map<String, dynamic> map) => TicketModel(
    matchName: map['match'] ?? '',
    name: map['name'] ?? '',
    entrance: map['entrance'] ?? '',
    section: map['section'] ?? '',
    row: map['row'] ?? '',
    seat: map['seat'] ?? '',
    team1Url: map['t1'] ?? '',
    team2Url: map['t2'] ?? '',
    leagueUrl: map['lg'] ?? '',
    seatType: map['st'] ?? 'Padded Seat',
    ticketType: map['tt'] ?? 'Adult',
    bgColorValue: map['bg'] ?? 0xFFD11212,
    ticketCount: map['ticketCount'] ?? 1,
    ticketTypeColorValue: map['ticketTypeColor'] ?? 0xFFE31A1A,


  );
}