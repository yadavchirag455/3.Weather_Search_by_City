import 'dart:io';

void main() {
  performTasks();
}

void performTasks() {
  task1();
  task2();
  task3();
}

void task1() {
  print('Person 1 hello Chirag');
}

void task2() {
  Duration threesecond = Duration(seconds: 3);
  // sleep(threesecond);
  Future.delayed(
    threesecond,
    () {
      print('Person 2 hello Heet');
    },
  );
}

void task3() {
  print('Person 3 heelo Neha');
}
