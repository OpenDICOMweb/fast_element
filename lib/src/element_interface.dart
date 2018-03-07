// Copyright (c) 2016, Open DICOMweb Project. All rights reserved.
// Use of this source code is governed by the open source license
// that can be found in the LICENSE file.
// Author: Jim Philbin <jfphilbin@gmail.edu> - 
// See the AUTHORS file for other contributors.

import 'package:core/core.dart';

/// The lowest level primitive that must be supplied by any implementation
abstract class ElementInterface<V> {
  /// The internal index of this Attribute
  int get index;
  /// The 32-bit code that identifies the Tag (Semantic Identifier) of this.
  int get code;
  /// The [keyword] associated with this Element
  String get keyword;
  /// The [name] of this Element.
  String get name;
  /// An integer (0 <= x < 30) that identifies the Value Representation of
  /// this Element
  String get vrIndex;
  /// The minimum number of values this Element may have (not including zero)
  int get minValues;
  /// The maximum number of values this Element may have (not including zero)
  int get maxValues;
  /// The width of the array [value] for this Element.
  int get width;
  /// The Information Entity Number that identifies the IE Type of this.
  int get ieIndex;
  /// The Element Type Number (0 <= x < 5) that identifies the IE Type of this.
  int get eTypeIndex;

  ///
  int get vfLengthField;

  /// The [value] as a byte array.
  /// _Note_ does not include padding character.
  Bytes get vfBytes;

  int get vfLength => vfBytes.length;

  /// The value of this Element.
  ///
  /// This can be a single values such as double, int,
  /// A Typed String that can be parsed into
  ///    an Object such as int, double, Age, Date, DcmDateTime, Time, Uid, Url,
  /// An Ascii String
  /// ...
  /// Or, an array of the primitive values above
  dynamic get value;


}

// Build a Type correspondence for each VR
// VR BaseType ParsedType