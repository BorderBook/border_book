class Booking {
  final String firstName;
  final String lastName;
  final String birthdate;
  final String timeSlot;

  Booking({this.firstName, this.lastName, this.birthdate, this.timeSlot});

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'birthdate': birthdate,
      'timeSlot': timeSlot,
    };
  }
}