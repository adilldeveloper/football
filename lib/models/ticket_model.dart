class TicketModel {
  String matchName;
  String name;
  String entrance;
  String section;
  String row;
  String seat;

  String? team1Url;
  String? team2Url;
  String? leagueUrl;

  String seatType;
  String ticketType;

  int bgColorValue;
  int ticketCount;
  int ticketTypeColorValue;

  String? team1LocalPath;
  String? team2LocalPath;
  String? leagueLocalPath;

  TicketModel({
    required this.matchName,
    required this.name,
    required this.entrance,
    required this.section,
    required this.row,
    required this.seat,
    this.team1Url,
    this.team2Url,
    this.leagueUrl,
    required this.seatType,
    required this.ticketType,
    required this.bgColorValue,
    required this.ticketCount,
    required this.ticketTypeColorValue,
    this.team1LocalPath,
    this.team2LocalPath,
    this.leagueLocalPath,
  });

  Map<String, dynamic> toMap() => {
    'match': matchName,
    'name': name,
    'entrance': entrance,
    'section': section,
    'row': row,
    'seat': seat,
    't1': team1Url,
    't2': team2Url,
    'lg': leagueUrl,
    'st': seatType,
    'tt': ticketType,
    'bg': bgColorValue,
    'ticketCount': ticketCount,
    'ticketTypeColor': ticketTypeColorValue,
    't1Local': team1LocalPath,
    't2Local': team2LocalPath,
    'lgLocal': leagueLocalPath,
  };

  factory TicketModel.fromMap(Map<String, dynamic> map) => TicketModel(
    matchName: map['match'] ?? '',
    name: map['name'] ?? '',
    entrance: map['entrance'] ?? '',
    section: map['section'] ?? '',
    row: map['row'] ?? '',
    seat: map['seat'] ?? '',
    team1Url: map['t1'],
    team2Url: map['t2'],
    leagueUrl: map['lg'],
    seatType: map['st'] ?? 'Padded Seat',
    ticketType: map['tt'] ?? 'Adult',
    bgColorValue: map['bg'] ?? 0xFFD11212,
    ticketCount: map['ticketCount'] ?? 1,
    ticketTypeColorValue: map['ticketTypeColor'] ?? 0xFFE31A1A,
    team1LocalPath: map['t1Local'],
    team2LocalPath: map['t2Local'],
    leagueLocalPath: map['lgLocal'],
  );
}