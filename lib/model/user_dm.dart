class UserDM {
  static UserDM? currentUser;
  String id;
  String email;
  String userName;

  UserDM({required this.id, required this.email, required this.userName});
}
