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

void createFileSystemStructure(List<FileNode> allFiles, dataInput) {
  FileNode rootNode = FileNode('/', null, true);

  var currentNode = rootNode;
  for (int i = 1; i < dataInput.length; i++) {
    if (dataInput[i].startsWith('dir ')) {
    } else if (dataInput[i] == '\$ cd ..') {
      currentNode = currentNode.parent!;
    } else if (dataInput[i].startsWith('\$ cd ')) {
      var directory = FileNode('${currentNode.name}/${dataInput[i].split(' ')[2]}', currentNode, true);
      allFiles.add(directory);
      currentNode = directory;
    } else if (dataInput[i] != '\$ ls') {
      var justAFile = FileNode(dataInput[i].split(' ')[1], currentNode, false);
      justAFile.size = int.parse(dataInput[i].split(' ')[0]);
      allFiles.add(justAFile);
    }
  }
}

void updateDirectorySizes(List<FileNode> allFiles) {
  for (int i = 0; i < allFiles.length; i++) {
    if (!allFiles[i].isDirectory) {
      FileNode? parent = allFiles[i].parent;
      while(parent != null) {
        parent.size += allFiles[i].size;
        parent = parent.parent;
      }
    }
  }
}

Future<num> puzzle1() async {
  var lines = await parseInput();
  List<FileNode> fileNodes = <FileNode>[];
  createFileSystemStructure(fileNodes, lines);
  updateDirectorySizes(fileNodes);
  Iterable<num> smallerDirectories = fileNodes.where((element) => element.isDirectory && element.size < 100000).map((element) => element.size);
  num totalSize = smallerDirectories.reduce((value, element) => value + element);

  print('Day 7 Puzzle 1: $totalSize');
  return totalSize;
}


Future<num> puzzle2() async {
  var lines = await parseInput();
  List<FileNode> fileNodes = <FileNode>[];
  createFileSystemStructure(fileNodes, lines);
  updateDirectorySizes(fileNodes);
  // const spaceNeeded = 30000000;
  // var rootNode = fileNodes.firstWhere((element) => element.parent?.name == '/').parent;
  // num currentlyUsedMemory = rootNode != null ? rootNode.size : spaceNeeded;
  // print(currentlyUsedMemory);
  Iterable<num> smallerDirectories = fileNodes.where((element) => element.isDirectory && element.size >= 4804833).map((element) => element.size);
  List<num> smallerDirectoriesList = smallerDirectories.toList();
  smallerDirectoriesList.sort();
  var sizeOfDirectory = smallerDirectoriesList[0];

  print('Day 7 Puzzle 2: $sizeOfDirectory');
  return sizeOfDirectory;
}

