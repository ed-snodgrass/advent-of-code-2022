import 'dart:io';
import 'dart:async';

Future<List<String>> parseInput() async {
  final file = File('inputs/day_7_puzzle.txt');
  return file.readAsLines();
}

class FileNode {
  FileNode? parent;
  List<FileNode>? children;
  num size = 0;
  String name;
  bool isDirectory;

  FileNode (this.name, this.parent, this.isDirectory);

  @override
  String toString() {
    return 'parent: $parent, name: $name, size: $size\n';
  }
}

Future<num> puzzle1() async {
  var lines = await parseInput();
  List<FileNode> fileNodes = <FileNode>[];
  FileNode rootNode = FileNode('/', null, true);
  var currentNode = rootNode;
  for (int i = 1; i < lines.length; i++) {
    if (lines[i].startsWith('dir ')) {
      // print('found directory ${lines[i]}');
    } else if (lines[i] == '\$ cd ..') {
      print('going up from: ${currentNode.name} to ${currentNode.parent?.name}');
      currentNode = currentNode.parent!;
    } else if (lines[i].startsWith('\$ cd ')) {
      print('changing to: ${lines[i].split(' ')[2]}');
      var directory = FileNode('${currentNode.name}/${lines[i].split(' ')[2]}', currentNode, true);
      fileNodes.add(directory);
      currentNode = directory;
    } else if (lines[i] != '\$ ls') {
      var justAFile = FileNode(lines[i].split(' ')[1], currentNode, false);
      justAFile.size = int.parse(lines[i].split(' ')[0]);
      fileNodes.add(justAFile);
    }
  }
  for (int i = 0; i < fileNodes.length; i++) {
    if (!fileNodes[i].isDirectory) {
      FileNode? parent = fileNodes[i].parent;
      while(parent != null) {
        parent.size += fileNodes[i].size;
        parent = parent.parent;
      }
    }
  }
  // var dirs = lines.where((line) => line.contains('dir'));
  Iterable<num> smallerDirectories = fileNodes.where((element) => element.isDirectory && element.size < 100000).map((element) => element.size);
  num totalSize = smallerDirectories.reduce((value, element) => value + element);

  print('Day 7 Puzzle 1: $totalSize');
  return totalSize;
}


Future<num> puzzle2() async {
  //70000000
  //30000000
  var lines = await parseInput();
  List<FileNode> fileNodes = <FileNode>[];
  FileNode rootNode = FileNode('/', null, true);
  var currentNode = rootNode;
  for (int i = 1; i < lines.length; i++) {
    if (lines[i].startsWith('dir ')) {
      // print('found directory ${lines[i]}');
    } else if (lines[i] == '\$ cd ..') {
      // print('going up from: ${currentNode.name} to ${currentNode.parent?.name}');
      currentNode = currentNode.parent!;
    } else if (lines[i].startsWith('\$ cd ')) {
      // print('changing to: ${lines[i].split(' ')[2]}');
      var directory = FileNode('${currentNode.name}/${lines[i].split(' ')[2]}', currentNode, true);
      fileNodes.add(directory);
      currentNode = directory;
    } else if (lines[i] != '\$ ls') {
      var justAFile = FileNode(lines[i].split(' ')[1], currentNode, false);
      justAFile.size = int.parse(lines[i].split(' ')[0]);
      fileNodes.add(justAFile);
    }
  }
  for (int i = 0; i < fileNodes.length; i++) {
    if (!fileNodes[i].isDirectory) {
      FileNode? parent = fileNodes[i].parent;
      while(parent != null) {
        parent.size += fileNodes[i].size;
        parent = parent.parent;
      }
    }
  }
  var rootNodeSize = rootNode.size;
  var unusedSpace = 70000000 - rootNodeSize;
  var toClean = 30000000 - unusedSpace;
  print('rootNode.size: $rootNodeSize');
  print('unusedSpace: $unusedSpace');
  print('toClean: $toClean');
  // var dirs = lines.where((line) => line.contains('dir'));
  Iterable<num> smallerDirectories = fileNodes.where((element) => element.isDirectory && element.size >= 4804833).map((element) => element.size);
  // num totalSize = smallerDirectories.reduce((value, element) => value + element);
  List<num> smallerDirectoriesList = smallerDirectories.toList();
  smallerDirectoriesList.sort();
  var sizeOfDirectory = smallerDirectoriesList[0];

  print('Day 7 Puzzle 2: $sizeOfDirectory');
  return sizeOfDirectory;
}

