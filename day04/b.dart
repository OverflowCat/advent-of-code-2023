import 'dart:io';

void main() async {
  final String input = await new File('input.txt').readAsString();
  final List<String> lines = input.split('\n');
  final numSplitter = RegExp(r'[ ]+');
  var cards = lines.map((line) => 1).toList();
  var cardId = 1;
  for (var line in lines) {
    line = line.split(": ")[1];
    final [winning, mine] = line.split(" | ");
    var winningArr = List.filled(100, false);
    winning.trim().split(numSplitter).forEach((element) {
      winningArr[int.parse(element)] = true;
    });
    var count = 0;
    mine.trim().split(numSplitter).forEach((element) {
      if (winningArr[int.parse(element)]) count++;
    });
    final currentCardCount = cards[cardId - 1];
    for (var i = 0; i < count; i++) cards[cardId + i] += currentCardCount;
    cardId++;
  }

  print(cards);

  final sum = cards.fold(0, (previous, current) => previous + current);
  print(sum);
}
