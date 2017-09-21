// Copyright (c) 2016, Open DICOMweb Project. All rights reserved.
// Use of this source code is governed by the open source license
// that can be found in the LICENSE file.
// Original author: Jim Philbin <jfphilbin@gmail.edu> -
// See the AUTHORS file for other contributors.

/*
/// Returns an [AttributeType] corresponding to name.
const keywordToEType = const LookupAttributeByStringTable(
		primaryKeywords, primaryKeywordIndex, secondaryKeywords, secondaryKeywordIndex);
*/

const List<String> primaryKeywords = const [
  "keyword0",
  "keyword1",
  "keyword2",
  "keyword3",
];

const List<int> primaryKeywordIndex = const [3, 2, 1, 0];

const List<String> secondaryKeywords = const [];
const List<int> secondaryKeywordIndex = const [];

String getAttributeKeyword(int index) => primaryKeywords[index];
