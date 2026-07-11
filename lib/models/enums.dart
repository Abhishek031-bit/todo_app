enum Category {
  general,
  work,
  personal,
  finances,
  health;

  static Category fromString(String category) {
    if (category == Category.work.name) {
      return Category.work;
    } else if (category == Category.health.name) {
      return Category.health;
    } else if (category == Category.personal.name) {
      return Category.personal;
    } else if (category == Category.general.name) {
      return Category.general;
    }
    return Category.work;
  }
}

enum Priority {
  high,
  medium,
  low,
  urgent;

  static Priority fromString(String priority) {
    if (priority == Priority.high.name) {
      return Priority.high;
    } else if (priority == Priority.medium.name) {
      return Priority.medium;
    } else if (priority == Priority.low.name) {
      return Priority.low;
    } else if (priority == Priority.urgent.name) {
      return Priority.urgent;
    }
    return Priority.low;
  }
}

enum SaveAction { add, update }
