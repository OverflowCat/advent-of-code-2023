import 'dart:io';
import 'dart:math';

void main() async {
  final String input = await new File('input.txt').readAsString();
  final List<String> lines = input.split('\n');
  num sum = 0;
  final numSplitter = RegExp(r'[ ]+');
  for (var line in lines) {
    line = line.split(": ")[1];
    final [winning, mine] = line.split(" | ");
    var winningArr = List.filled(100, false);
    winning.trim().split(numSplitter).forEach((element) {
      winningArr[int.parse(element)] = true;
    });
    var power = -1;
    mine.trim().split(numSplitter).forEach((element) {
      if (winningArr[int.parse(element)]) power++;
    });
    var result = (power == -1 ? 0 : pow(2, power));
    sum += result;
  }
  print(sum);
}
