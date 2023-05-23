class DashboardDto {
  int? messagesCount;
  int? contactsCount;
  bool? activeSubscription;
  DateTime? nextPayDate;
  String? userName;
  DashboardDto(
      {required this.messagesCount,
      required this.contactsCount,
      required this.activeSubscription,
      required this.nextPayDate,
      required this.userName});
  factory DashboardDto.fromJson(Map<String, dynamic> json) {
    return DashboardDto(
        messagesCount: json["messagesCount"],
        contactsCount: json["contactsCount"],
        activeSubscription: json["activeSubscription"],
        nextPayDate: DateTime.parse(json["nextPayDate"]),
        userName: json["userName"]);
  }
  bool nodata() {
    if (messagesCount == null ||
        contactsCount == null ||
        activeSubscription == null ||
        userName == null) {
      return true;
    }
    return false;
  }
}
