// Copyright (c) 2016, Open DICOMweb Project. All rights reserved.
// Use of this source code is governed by the open source license
// that can be found in the LICENSE file.
// Author: Jim Philbin <jfphilbin@gmail.edu> -
// See the AUTHORS file for other contributors.

import 'package:collection/collection.dart';

abstract class LookupTable<T> {
  const LookupTable();

  /// A sorted list of primary (most likely) values of type [T].
  List<T> get table1;

  /// A list that maps a value's position in [table1] to its
  /// canonical index in an AttributeTable.
  List<int> get index1;

  /// A sorted list of primary (most likely) values of type [T].
  List<T> get table2;

  /// A list that maps a value's position in [table2] to its
  /// canonical index in an AttributeTable.
  List<int> get index2;

  int operator [](T value);

  int compare(T a, T b);

  int lookup(T value, Comparator<T> compare) {
    print('  lookup 1 v: $value');
    int i = binarySearch(table1, value, compare: compare);
    if (i != -1) {
      int ii = index1[i];
    //     print('  lookup 1: $i, $ii');
      return ii;
    }
    print('  lookup 2 v: $value');
    i = binarySearch(table2, value, compare: compare);
    print('  lookup 2: i: $i');
    int v = index2[i];
    print('  lookup 2: $i, v: $v');
    return (i != -1) ? v : null;
  }
}

class LookupElementByCodeTable extends LookupTable<int> {
  @override
  final List<int> table1;
  @override
  final List<int> index1;
  @override
  final List<int> table2;
  @override
  final List<int> index2;

  const LookupElementByCodeTable(this.table1, this.index1, this.table2, this.index2);

  @override
  int operator [](int code) => lookup(code, compare);

  @override
  int compare(int a, int b) {
    if (a == b) return 0;
    return (a < b) ? -1 : 1;
  }

  @override
  String toString() => 'T1: $table1\n T2: $table2';
}

class LookupElementByStringTable extends LookupTable<String> {
  @override
  final List<String> table1;
  @override
  final List<int> index1;
  @override
  final List<String> table2;
  @override
  final List<int> index2;

  const LookupElementByStringTable(this.table1, this.index1, this.table2, this.index2);

  @override
  int operator [](String code) => lookup(code, compare);

  @override
  int compare(String a, String b) => a.compareTo(b);
}
