import 'dart:io';
import 'dart:async';
import 'frame_sets.dart';

Stream<T> loop<T>(Iterable<T> values) async* {
  // Create first iterator
  Iterator<T> iterator = values.iterator;

  // Check if the iterator is empty
  // if (!iterator.moveNext()) {
  //   // TODO: Figure out how to throw an error
  // }

  // Loop over values infinitely
  while (true) {
    // Emit a value
    yield iterator.current;

    // Move forward and restart loop
    if (iterator.moveNext()) continue;

    // If it can't advance (`moveNext()` == `false`), reset iterator
    iterator = values.iterator;
  }
}

void main() {
  stdout.writeln('''
<<< Example animation program for CLI loading bars >>>

(Using ${stdout.encoding.name} encoding)

  ''');
  // Define the list of frames for the animation
  List<String> frames = spinningDots;

  // Length taken up by the animation in columns
  final frameWidth = frames.first.length;

  int currentFrameIndex = 0;

  // Make the cursor invisible
  stdout.write('\x1b[?25l');

  // Write message appearing after animation columns.
  String message = 'Loading...';
  stdout.write('\x1b[${frameWidth + 1}C');
  stdout.write(message); // Note: 'D' is case sensitive!
  stdout.write('\x1b[${message.length + frameWidth + 1}D');

  // Create a timer to update the animation
  Timer.periodic(Duration(milliseconds: 25), (timer) {
    // stdout.write('\x07');  // Bell doesn't work :(

    // Print the current frame
    stdout.write(frames[currentFrameIndex]);

    stdout.write('\x1b[${frameWidth}D');

    // Increment the frame index
    currentFrameIndex = (currentFrameIndex + 1) % frames.length;
  });

  return;
}
