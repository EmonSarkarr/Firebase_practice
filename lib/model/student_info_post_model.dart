class StudentInfoPost {
  String name;
  int rollNumber;
  String department;
  int sClass;

  StudentInfoPost(
      {required this.name,
      required this.rollNumber,
      required this.department,
      required this.sClass});

  @override
  String toString() {
    return 'StudentInfoPost{name: $name, roll_number: $rollNumber, department: $department, s_class: $sClass}';
  }
}

