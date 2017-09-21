// Copyright (c) 2016, Open DICOMweb Project. All rights reserved.
// Use of this source code is governed by the open source license
// that can be found in the LICENSE file.
// Original author: Jim Philbin <jfphilbin@gmail.edu> -
// See the AUTHORS file for other contributors.

/*
/// Returns an [AttributeType] corresponding to name.
const nameToEType = const LookupAttributeByStringTable(
		primaryNames, primaryNameIndex, secondaryNames, secondaryNameIndex);
*/

const List<String> primaryNames = const ["name0", "name1", "name2", "name3"];

const List<int> primaryNameIndex = const [100, 101, 102, 102];

const List<String> secondaryNames = const [];
const List<int> secondaryNameIndex = const [];

String getAttributeName(int index) => primaryNames[index];
