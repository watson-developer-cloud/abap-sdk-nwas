* Copyright 2019, 2020 IBM Corp. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
"! <p class="shorttext synchronized" lang="en">Compare and Comply</p>
"! IBM Watson&trade; Compare and Comply analyzes governing documents to provide
"!  details about critical aspects of the documents. <br/>
class ZCL_IBMC_COMPARE_COMPLY_V1 DEFINITION
  public
  inheriting from ZCL_IBMC_SERVICE_EXT
  create public .

public section.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The numeric location of the identified element in the</p>
    "!     document, represented with two integers labeled `begin` and `end`.
    begin of T_LOCATION,
      "!   The element&apos;s `begin` index.
      BEGIN type LONG,
      "!   The element&apos;s `end` index.
      END type LONG,
    end of T_LOCATION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A pair of `nature` and `party` objects. The `nature` object</p>
    "!     identifies the effect of the element on the identified `party`, and the `party`
    "!     object identifies the affected party.
    begin of T_LABEL,
      "!   The identified `nature` of the element.
      NATURE type STRING,
      "!   The identified `party` of the element.
      PARTY type STRING,
    end of T_LABEL.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Identification of a specific type.</p>
    begin of T_TYPE_LABEL_COMPARISON,
      "!   A pair of `nature` and `party` objects. The `nature` object identifies the
      "!    effect of the element on the identified `party`, and the `party` object
      "!    identifies the affected party.
      LABEL type T_LABEL,
    end of T_TYPE_LABEL_COMPARISON.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The locations of each paragraph in the input document.</p>
    begin of T_PARAGRAPHS,
      "!   The numeric location of the identified element in the document, represented with
      "!    two integers labeled `begin` and `end`.
      LOCATION type T_LOCATION,
    end of T_PARAGRAPHS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Document counts.</p>
    begin of T_DOC_COUNTS,
      "!   Total number of documents.
      TOTAL type INTEGER,
      "!   Number of pending documents.
      PENDING type INTEGER,
      "!   Number of documents successfully processed.
      SUCCESSFUL type INTEGER,
      "!   Number of documents not successfully processed.
      FAILED type INTEGER,
    end of T_DOC_COUNTS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Identification of a specific type.</p>
    begin of T_TYPE_LABEL,
      "!   A pair of `nature` and `party` objects. The `nature` object identifies the
      "!    effect of the element on the identified `party`, and the `party` object
      "!    identifies the affected party.
      LABEL type T_LABEL,
      "!   Hashed values that you can send to IBM to provide feedback or receive support.
      PROVENANCE_IDS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
    end of T_TYPE_LABEL.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Brief information about the input document.</p>
    begin of T_SHORT_DOC,
      "!   The title of the input document, if identified.
      TITLE type STRING,
      "!   The MD5 hash of the input document.
      HASH type STRING,
    end of T_SHORT_DOC.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information defining an element&apos;s subject matter.</p>
    begin of T_CATEGORY,
      "!   The category of the associated element.
      LABEL type STRING,
      "!   Hashed values that you can send to IBM to provide feedback or receive support.
      PROVENANCE_IDS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
    end of T_CATEGORY.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The original labeling from the input document, without the</p>
    "!     submitted feedback.
    begin of T_ORIGINAL_LABELS_OUT,
      "!   Description of the action specified by the element and whom it affects.
      TYPES type STANDARD TABLE OF T_TYPE_LABEL WITH NON-UNIQUE DEFAULT KEY,
      "!   List of functional categories into which the element falls; in other words, the
      "!    subject matter of the element.
      CATEGORIES type STANDARD TABLE OF T_CATEGORY WITH NON-UNIQUE DEFAULT KEY,
      "!   A string identifying the type of modification the feedback entry in the
      "!    `updated_labels` array. Possible values are `added`, `not_changed`, and
      "!    `removed`.
      MODIFICATION type STRING,
    end of T_ORIGINAL_LABELS_OUT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The updated labeling from the input document, accounting for</p>
    "!     the submitted feedback.
    begin of T_UPDATED_LABELS_OUT,
      "!   Description of the action specified by the element and whom it affects.
      TYPES type STANDARD TABLE OF T_TYPE_LABEL WITH NON-UNIQUE DEFAULT KEY,
      "!   List of functional categories into which the element falls; in other words, the
      "!    subject matter of the element.
      CATEGORIES type STANDARD TABLE OF T_CATEGORY WITH NON-UNIQUE DEFAULT KEY,
      "!   The type of modification the feedback entry in the `updated_labels` array.
      "!    Possible values are `added`, `not_changed`, and `removed`.
      MODIFICATION type STRING,
    end of T_UPDATED_LABELS_OUT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Pagination details, if required by the length of the output.</p>
    begin of T_PAGINATION,
      "!   A token identifying the current page of results.
      REFRESH_CURSOR type STRING,
      "!   A token identifying the next page of results.
      NEXT_CURSOR type STRING,
      "!   The URL that returns the current page of results.
      REFRESH_URL type STRING,
      "!   The URL that returns the next page of results.
      NEXT_URL type STRING,
      "!   Reserved for future use.
      TOTAL type LONG,
    end of T_PAGINATION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information returned from the **Add Feedback** method.</p>
    begin of T_FEEDBACK_DATA_OUTPUT,
      "!   A string identifying the user adding the feedback. The only permitted value is
      "!    `element_classification`.
      FEEDBACK_TYPE type STRING,
      "!   Brief information about the input document.
      DOCUMENT type T_SHORT_DOC,
      "!   An optional string identifying the model ID. The only permitted value is
      "!    `contracts`.
      MODEL_ID type STRING,
      "!   An optional string identifying the version of the model used.
      MODEL_VERSION type STRING,
      "!   The numeric location of the identified element in the document, represented with
      "!    two integers labeled `begin` and `end`.
      LOCATION type T_LOCATION,
      "!   The text to which the feedback applies.
      TEXT type STRING,
      "!   The original labeling from the input document, without the submitted feedback.
      ORIGINAL_LABELS type T_ORIGINAL_LABELS_OUT,
      "!   The updated labeling from the input document, accounting for the submitted
      "!    feedback.
      UPDATED_LABELS type T_UPDATED_LABELS_OUT,
      "!   Pagination details, if required by the length of the output.
      PAGINATION type T_PAGINATION,
    end of T_FEEDBACK_DATA_OUTPUT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    List of document attributes.</p>
    begin of T_ATTRIBUTE,
      "!   The type of attribute.
      TYPE type STRING,
      "!   The text associated with the attribute.
      TEXT type STRING,
      "!   The numeric location of the identified element in the document, represented with
      "!    two integers labeled `begin` and `end`.
      LOCATION type T_LOCATION,
    end of T_ATTRIBUTE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information defining an element&apos;s subject matter.</p>
    begin of T_CATEGORY_COMPARISON,
      "!   The category of the associated element.
      LABEL type STRING,
    end of T_CATEGORY_COMPARISON.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Element that does not align semantically between two</p>
    "!     compared documents.
    begin of T_UNALIGNED_ELEMENT,
      "!   The label assigned to the document by the value of the `file_1_label` or
      "!    `file_2_label` parameters on the **Compare two documents** method.
      DOCUMENT_LABEL type STRING,
      "!   The numeric location of the identified element in the document, represented with
      "!    two integers labeled `begin` and `end`.
      LOCATION type T_LOCATION,
      "!   The text of the element.
      TEXT type STRING,
      "!   Description of the action specified by the element and whom it affects.
      TYPES type STANDARD TABLE OF T_TYPE_LABEL_COMPARISON WITH NON-UNIQUE DEFAULT KEY,
      "!   List of functional categories into which the element falls; in other words, the
      "!    subject matter of the element.
      CATEGORIES type STANDARD TABLE OF T_CATEGORY_COMPARISON WITH NON-UNIQUE DEFAULT KEY,
      "!   List of document attributes.
      ATTRIBUTES type STANDARD TABLE OF T_ATTRIBUTE WITH NON-UNIQUE DEFAULT KEY,
    end of T_UNALIGNED_ELEMENT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The updated labeling from the input document, accounting for</p>
    "!     the submitted feedback.
    begin of T_UPDATED_LABELS_IN,
      "!   Description of the action specified by the element and whom it affects.
      TYPES type STANDARD TABLE OF T_TYPE_LABEL WITH NON-UNIQUE DEFAULT KEY,
      "!   List of functional categories into which the element falls; in other words, the
      "!    subject matter of the element.
      CATEGORIES type STANDARD TABLE OF T_CATEGORY WITH NON-UNIQUE DEFAULT KEY,
    end of T_UPDATED_LABELS_IN.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An array that contains the `text` value of a row header that</p>
    "!     is applicable to this body cell.
      T_ROW_HEADER_TEXTS type TT_String.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A list of `begin` and `end` indexes that indicate the</p>
    "!     locations of the elements in the input document.
    begin of T_ELEMENT_LOCATIONS,
      "!   An integer that indicates the starting position of the element in the input
      "!    document.
      BEGIN type INTEGER,
      "!   An integer that indicates the ending position of the element in the input
      "!    document.
      END type INTEGER,
    end of T_ELEMENT_LOCATIONS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The leading sentences in a section or subsection of the</p>
    "!     input document.
    begin of T_LEADING_SENTENCE,
      "!   The text of the leading sentence.
      TEXT type STRING,
      "!   The numeric location of the identified element in the document, represented with
      "!    two integers labeled `begin` and `end`.
      LOCATION type T_LOCATION,
      "!   An array of `location` objects that lists the locations of detected leading
      "!    sentences.
      ELEMENT_LOCATIONS type STANDARD TABLE OF T_ELEMENT_LOCATIONS WITH NON-UNIQUE DEFAULT KEY,
    end of T_LEADING_SENTENCE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An array containing one object per section or subsection</p>
    "!     detected in the input document. Sections and subsections are not nested;
    "!     instead, they are flattened out and can be placed back in order by using the
    "!     `begin` and `end` values of the element and the `level` value of the section.
    begin of T_SECTION_TITLES,
      "!   The text of the section title, if identified.
      TEXT type STRING,
      "!   The numeric location of the identified element in the document, represented with
      "!    two integers labeled `begin` and `end`.
      LOCATION type T_LOCATION,
      "!   An integer indicating the level at which the section is located in the input
      "!    document. For example, `1` represents a top-level section, `2` represents a
      "!    subsection within the level `1` section, and so forth.
      LEVEL type INTEGER,
      "!   An array of `location` objects that lists the locations of detected section
      "!    titles.
      ELEMENT_LOCATIONS type STANDARD TABLE OF T_ELEMENT_LOCATIONS WITH NON-UNIQUE DEFAULT KEY,
    end of T_SECTION_TITLES.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The structure of the input document.</p>
    begin of T_DOC_STRUCTURE,
      "!   An array containing one object per section or subsection identified in the input
      "!    document.
      SECTION_TITLES type STANDARD TABLE OF T_SECTION_TITLES WITH NON-UNIQUE DEFAULT KEY,
      "!   An array containing one object per section or subsection, in parallel with the
      "!    `section_titles` array, that details the leading sentences in the corresponding
      "!    section or subsection.
      LEADING_SENTENCES type STANDARD TABLE OF T_LEADING_SENTENCE WITH NON-UNIQUE DEFAULT KEY,
      "!   An array containing one object per paragraph, in parallel with the
      "!    `section_titles` and `leading_sentences` arrays.
      PARAGRAPHS type STANDARD TABLE OF T_PARAGRAPHS WITH NON-UNIQUE DEFAULT KEY,
    end of T_DOC_STRUCTURE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    If you provide customization input, the normalized version</p>
    "!     of the column header texts according to the customization; otherwise, the same
    "!     value as `column_header_texts`.
      T_COLUMN_HEADER_TEXTS_NORM type TT_String.
  types:
    "! No documentation available.
    begin of T_ERROR_RESPONSE,
      "!   The HTTP error status code.
      CODE type INTEGER,
      "!   A message describing the error.
      ERROR type STRING,
    end of T_ERROR_RESPONSE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A contact.</p>
    begin of T_CONTACT,
      "!   A string listing the name of the contact.
      NAME type STRING,
      "!   A string listing the role of the contact.
      ROLE type STRING,
    end of T_CONTACT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The table&apos;s section title, if identified.</p>
    begin of T_SECTION_TITLE,
      "!   The text of the section title, if identified.
      TEXT type STRING,
      "!   The numeric location of the identified element in the document, represented with
      "!    two integers labeled `begin` and `end`.
      LOCATION type T_LOCATION,
    end of T_SECTION_TITLE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Column-level cells, each applicable as a header to other</p>
    "!     cells in the same column as itself, of the current table.
    begin of T_COLUMN_HEADERS,
      "!   The unique ID of the cell in the current table.
      CELL_ID type STRING,
      "!   The location of the column header cell in the current table as defined by its
      "!    `begin` and `end` offsets, respectfully, in the input document.
      LOCATION type JSONOBJECT,
      "!   The textual contents of this cell from the input document without associated
      "!    markup content.
      TEXT type STRING,
      "!   If you provide customization input, the normalized version of the cell text
      "!    according to the customization; otherwise, the same value as `text`.
      TEXT_NORMALIZED type STRING,
      "!   The `begin` index of this cell&apos;s `row` location in the current table.
      ROW_INDEX_BEGIN type LONG,
      "!   The `end` index of this cell&apos;s `row` location in the current table.
      ROW_INDEX_END type LONG,
      "!   The `begin` index of this cell&apos;s `column` location in the current table.
      COLUMN_INDEX_BEGIN type LONG,
      "!   The `end` index of this cell&apos;s `column` location in the current table.
      COLUMN_INDEX_END type LONG,
    end of T_COLUMN_HEADERS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Text that is related to the contents of the table and that</p>
    "!     precedes or follows the current table.
    begin of T_CONTEXTS,
      "!   The related text.
      TEXT type STRING,
      "!   The numeric location of the identified element in the document, represented with
      "!    two integers labeled `begin` and `end`.
      LOCATION type T_LOCATION,
    end of T_CONTEXTS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    If identified, the title or caption of the current table of</p>
    "!     the form `Table x.: ...`. Empty when no title is identified. When exposed, the
    "!     `title` is also excluded from the `contexts` array of the same table.
    begin of T_TABLE_TITLE,
      "!   The numeric location of the identified element in the document, represented with
      "!    two integers labeled `begin` and `end`.
      LOCATION type T_LOCATION,
      "!   The text of the identified table title or caption.
      TEXT type STRING,
    end of T_TABLE_TITLE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Cells that are not table header, column header, or row</p>
    "!     header cells.
    begin of T_BODY_CELLS,
      "!   The unique ID of the cell in the current table.
      CELL_ID type STRING,
      "!   The numeric location of the identified element in the document, represented with
      "!    two integers labeled `begin` and `end`.
      LOCATION type T_LOCATION,
      "!   The textual contents of this cell from the input document without associated
      "!    markup content.
      TEXT type STRING,
      "!   The `begin` index of this cell&apos;s `row` location in the current table.
      ROW_INDEX_BEGIN type LONG,
      "!   The `end` index of this cell&apos;s `row` location in the current table.
      ROW_INDEX_END type LONG,
      "!   The `begin` index of this cell&apos;s `column` location in the current table.
      COLUMN_INDEX_BEGIN type LONG,
      "!   The `end` index of this cell&apos;s `column` location in the current table.
      COLUMN_INDEX_END type LONG,
      "!   An array that contains the `id` value of a row header that is applicable to this
      "!    body cell.
      ROW_HEADER_IDS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   An array that contains the `text` value of a row header that is applicable to
      "!    this body cell.
      ROW_HEADER_TEXTS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   If you provide customization input, the normalized version of the row header
      "!    texts according to the customization; otherwise, the same value as
      "!    `row_header_texts`.
      ROW_HEADER_TEXTS_NORMALIZED type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   An array that contains the `id` value of a column header that is applicable to
      "!    the current cell.
      COLUMN_HEADER_IDS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   An array that contains the `text` value of a column header that is applicable to
      "!    the current cell.
      COLUMN_HEADER_TEXTS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   If you provide customization input, the normalized version of the column header
      "!    texts according to the customization; otherwise, the same value as
      "!    `column_header_texts`.
      COLUMN_HEADER_TEXTS_NORMALIZED type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   No documentation available.
      ATTRIBUTES type STANDARD TABLE OF T_ATTRIBUTE WITH NON-UNIQUE DEFAULT KEY,
    end of T_BODY_CELLS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A key in a key-value pair.</p>
    begin of T_KEY,
      "!   The unique ID of the key in the table.
      CELL_ID type STRING,
      "!   The numeric location of the identified element in the document, represented with
      "!    two integers labeled `begin` and `end`.
      LOCATION type T_LOCATION,
      "!   The text content of the table cell without HTML markup.
      TEXT type STRING,
    end of T_KEY.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A value in a key-value pair.</p>
    begin of T_VALUE,
      "!   The unique ID of the value in the table.
      CELL_ID type STRING,
      "!   The numeric location of the identified element in the document, represented with
      "!    two integers labeled `begin` and `end`.
      LOCATION type T_LOCATION,
      "!   The text content of the table cell without HTML markup.
      TEXT type STRING,
    end of T_VALUE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Key-value pairs detected across cell boundaries.</p>
    begin of T_KEY_VALUE_PAIR,
      "!   A key in a key-value pair.
      KEY type T_KEY,
      "!   A list of values in a key-value pair.
      VALUE type STANDARD TABLE OF T_VALUE WITH NON-UNIQUE DEFAULT KEY,
    end of T_KEY_VALUE_PAIR.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The contents of the current table&apos;s header.</p>
    begin of T_TABLE_HEADERS,
      "!   The unique ID of the cell in the current table.
      CELL_ID type STRING,
      "!   The location of the table header cell in the current table as defined by its
      "!    `begin` and `end` offsets, respectfully, in the input document.
      LOCATION type JSONOBJECT,
      "!   The textual contents of the cell from the input document without associated
      "!    markup content.
      TEXT type STRING,
      "!   The `begin` index of this cell&apos;s `row` location in the current table.
      ROW_INDEX_BEGIN type LONG,
      "!   The `end` index of this cell&apos;s `row` location in the current table.
      ROW_INDEX_END type LONG,
      "!   The `begin` index of this cell&apos;s `column` location in the current table.
      COLUMN_INDEX_BEGIN type LONG,
      "!   The `end` index of this cell&apos;s `column` location in the current table.
      COLUMN_INDEX_END type LONG,
    end of T_TABLE_HEADERS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Row-level cells, each applicable as a header to other cells</p>
    "!     in the same row as itself, of the current table.
    begin of T_ROW_HEADERS,
      "!   The unique ID of the cell in the current table.
      CELL_ID type STRING,
      "!   The numeric location of the identified element in the document, represented with
      "!    two integers labeled `begin` and `end`.
      LOCATION type T_LOCATION,
      "!   The textual contents of this cell from the input document without associated
      "!    markup content.
      TEXT type STRING,
      "!   If you provide customization input, the normalized version of the cell text
      "!    according to the customization; otherwise, the same value as `text`.
      TEXT_NORMALIZED type STRING,
      "!   The `begin` index of this cell&apos;s `row` location in the current table.
      ROW_INDEX_BEGIN type LONG,
      "!   The `end` index of this cell&apos;s `row` location in the current table.
      ROW_INDEX_END type LONG,
      "!   The `begin` index of this cell&apos;s `column` location in the current table.
      COLUMN_INDEX_BEGIN type LONG,
      "!   The `end` index of this cell&apos;s `column` location in the current table.
      COLUMN_INDEX_END type LONG,
    end of T_ROW_HEADERS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The contents of the tables extracted from a document.</p>
    begin of T_TABLES,
      "!   The numeric location of the identified element in the document, represented with
      "!    two integers labeled `begin` and `end`.
      LOCATION type T_LOCATION,
      "!   The textual contents of the current table from the input document without
      "!    associated markup content.
      TEXT type STRING,
      "!   The table&apos;s section title, if identified.
      SECTION_TITLE type T_SECTION_TITLE,
      "!   If identified, the title or caption of the current table of the form `Table x.:
      "!    ...`. Empty when no title is identified. When exposed, the `title` is also
      "!    excluded from the `contexts` array of the same table.
      TITLE type T_TABLE_TITLE,
      "!   An array of table-level cells that apply as headers to all the other cells in
      "!    the current table.
      TABLE_HEADERS type STANDARD TABLE OF T_TABLE_HEADERS WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of row-level cells, each applicable as a header to other cells in the
      "!    same row as itself, of the current table.
      ROW_HEADERS type STANDARD TABLE OF T_ROW_HEADERS WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of column-level cells, each applicable as a header to other cells in
      "!    the same column as itself, of the current table.
      COLUMN_HEADERS type STANDARD TABLE OF T_COLUMN_HEADERS WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of cells that are neither table header nor column header nor row header
      "!    cells, of the current table with corresponding row and column header
      "!    associations.
      BODY_CELLS type STANDARD TABLE OF T_BODY_CELLS WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of objects that list text that is related to the table contents and
      "!    that precedes or follows the current table.
      CONTEXTS type STANDARD TABLE OF T_CONTEXTS WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of key-value pairs identified in the current table.
      KEY_VALUE_PAIRS type STANDARD TABLE OF T_KEY_VALUE_PAIR WITH NON-UNIQUE DEFAULT KEY,
    end of T_TABLES.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about the parsed input document.</p>
    begin of T_DOC_INFO,
      "!   The full text of the parsed document in HTML format.
      HTML type STRING,
      "!   The title of the parsed document. If the service did not detect a title, the
      "!    value of this element is `null`.
      TITLE type STRING,
      "!   The MD5 hash of the input document.
      HASH type STRING,
    end of T_DOC_INFO.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The analysis of the document&apos;s tables.</p>
    begin of T_TABLE_RETURN,
      "!   Information about the parsed input document.
      DOCUMENT type T_DOC_INFO,
      "!   The ID of the model used to extract the table contents. The value for table
      "!    extraction is `tables`.
      MODEL_ID type STRING,
      "!   The version of the `tables` model ID.
      MODEL_VERSION type STRING,
      "!   Definitions of the tables identified in the input document.
      TABLES type STANDARD TABLE OF T_TABLES WITH NON-UNIQUE DEFAULT KEY,
    end of T_TABLE_RETURN.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about the document and the submitted feedback.</p>
    begin of T_FEEDBACK_RETURN,
      "!   The unique ID of the feedback object.
      FEEDBACK_ID type STRING,
      "!   An optional string identifying the person submitting feedback.
      USER_ID type STRING,
      "!   An optional comment from the person submitting the feedback.
      COMMENT type STRING,
      "!   Timestamp listing the creation time of the feedback submission.
      CREATED type DATETIME,
      "!   Information returned from the **Add Feedback** method.
      FEEDBACK_DATA type T_FEEDBACK_DATA_OUTPUT,
    end of T_FEEDBACK_RETURN.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The details of the normalized text, if applicable. This</p>
    "!     element is optional; it is returned only if normalized text exists.
    begin of T_INTERPRETATION,
      "!   The value that was located in the normalized text.
      VALUE type STRING,
      "!   An integer or float expressing the numeric value of the `value` key.
      NUMERIC_VALUE type NUMBER,
      "!   A string listing the unit of the value that was found in the normalized
      "!    text.<br/>
      "!   <br/>
      "!   **Note:** The value of `unit` is the [ISO-4217 currency
      "!    code](https://www.iso.org/iso-4217-currency-codes.html) identified for the
      "!    currency amount (for example, `USD` or `EUR`). If the service cannot
      "!    disambiguate a currency symbol (for example, `$` or `£`), the value of `unit`
      "!    contains the ambiguous symbol as-is.
      UNIT type STRING,
    end of T_INTERPRETATION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A monetary amount identified in the input document.</p>
    begin of T_CONTRACT_AMTS,
      "!   The confidence level in the identification of the contract amount.
      CONFIDENCE_LEVEL type STRING,
      "!   The monetary amount.
      TEXT type STRING,
      "!   The normalized form of the amount, which is listed as a string. This element is
      "!    optional; it is returned only if normalized text exists.
      TEXT_NORMALIZED type STRING,
      "!   The details of the normalized text, if applicable. This element is optional; it
      "!    is returned only if normalized text exists.
      INTERPRETATION type T_INTERPRETATION,
      "!   Hashed values that you can send to IBM to provide feedback or receive support.
      PROVENANCE_IDS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   The numeric location of the identified element in the document, represented with
      "!    two integers labeled `begin` and `end`.
      LOCATION type T_LOCATION,
    end of T_CONTRACT_AMTS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The contract currencies that are declared in the document.</p>
    begin of T_CONTRACT_CURRENCIES,
      "!   The confidence level in the identification of the contract currency.
      CONFIDENCE_LEVEL type STRING,
      "!   The contract currency.
      TEXT type STRING,
      "!   The normalized form of the contract currency, which is listed as a string in
      "!    [ISO-4217](https://www.iso.org/iso-4217-currency-codes.html) format. This
      "!    element is optional; it is returned only if normalized text exists.
      TEXT_NORMALIZED type STRING,
      "!   Hashed values that you can send to IBM to provide feedback or receive support.
      PROVENANCE_IDS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   The numeric location of the identified element in the document, represented with
      "!    two integers labeled `begin` and `end`.
      LOCATION type T_LOCATION,
    end of T_CONTRACT_CURRENCIES.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The document&apos;s payment duration or durations.</p>
    begin of T_PAYMENT_TERMS,
      "!   The confidence level in the identification of the payment term.
      CONFIDENCE_LEVEL type STRING,
      "!   The payment term (duration).
      TEXT type STRING,
      "!   The normalized form of the payment term, which is listed as a string. This
      "!    element is optional; it is returned only if normalized text exists.
      TEXT_NORMALIZED type STRING,
      "!   The details of the normalized text, if applicable. This element is optional; it
      "!    is returned only if normalized text exists.
      INTERPRETATION type T_INTERPRETATION,
      "!   Hashed values that you can send to IBM to provide feedback or receive support.
      PROVENANCE_IDS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   The numeric location of the identified element in the document, represented with
      "!    two integers labeled `begin` and `end`.
      LOCATION type T_LOCATION,
    end of T_PAYMENT_TERMS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A component part of the document.</p>
    begin of T_ELEMENT,
      "!   The numeric location of the identified element in the document, represented with
      "!    two integers labeled `begin` and `end`.
      LOCATION type T_LOCATION,
      "!   The text of the element.
      TEXT type STRING,
      "!   Description of the action specified by the element  and whom it affects.
      TYPES type STANDARD TABLE OF T_TYPE_LABEL WITH NON-UNIQUE DEFAULT KEY,
      "!   List of functional categories into which the element falls; in other words, the
      "!    subject matter of the element.
      CATEGORIES type STANDARD TABLE OF T_CATEGORY WITH NON-UNIQUE DEFAULT KEY,
      "!   List of document attributes.
      ATTRIBUTES type STANDARD TABLE OF T_ATTRIBUTE WITH NON-UNIQUE DEFAULT KEY,
    end of T_ELEMENT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Termination dates identified in the input document.</p>
    begin of T_TERMINATION_DATES,
      "!   The confidence level in the identification of the termination date.
      CONFIDENCE_LEVEL type STRING,
      "!   The termination date.
      TEXT type STRING,
      "!   The normalized form of the termination date, which is listed as a string. This
      "!    element is optional; it is returned only if normalized text exists.
      TEXT_NORMALIZED type STRING,
      "!   Hashed values that you can send to IBM to provide feedback or receive support.
      PROVENANCE_IDS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   The numeric location of the identified element in the document, represented with
      "!    two integers labeled `begin` and `end`.
      LOCATION type T_LOCATION,
    end of T_TERMINATION_DATES.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The contract type identified in the input document.</p>
    begin of T_CONTRACT_TYPES,
      "!   The confidence level in the identification of the contract type.
      CONFIDENCE_LEVEL type STRING,
      "!   The contract type.
      TEXT type STRING,
      "!   Hashed values that you can send to IBM to provide feedback or receive support.
      PROVENANCE_IDS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   The numeric location of the identified element in the document, represented with
      "!    two integers labeled `begin` and `end`.
      LOCATION type T_LOCATION,
    end of T_CONTRACT_TYPES.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An effective date.</p>
    begin of T_EFFECTIVE_DATES,
      "!   The confidence level in the identification of the effective date.
      CONFIDENCE_LEVEL type STRING,
      "!   The effective date, listed as a string.
      TEXT type STRING,
      "!   The normalized form of the effective date, which is listed as a string. This
      "!    element is optional; it is returned only if normalized text exists.
      TEXT_NORMALIZED type STRING,
      "!   Hashed values that you can send to IBM to provide feedback or receive support.
      PROVENANCE_IDS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   The numeric location of the identified element in the document, represented with
      "!    two integers labeled `begin` and `end`.
      LOCATION type T_LOCATION,
    end of T_EFFECTIVE_DATES.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A mention of a party.</p>
    begin of T_MENTION,
      "!   The name of the party.
      TEXT type STRING,
      "!   The numeric location of the identified element in the document, represented with
      "!    two integers labeled `begin` and `end`.
      LOCATION type T_LOCATION,
    end of T_MENTION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A party&apos;s address.</p>
    begin of T_ADDRESS,
      "!   A string listing the address.
      TEXT type STRING,
      "!   The numeric location of the identified element in the document, represented with
      "!    two integers labeled `begin` and `end`.
      LOCATION type T_LOCATION,
    end of T_ADDRESS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A party and its corresponding role, including address and</p>
    "!     contact information if identified.
    begin of T_PARTIES,
      "!   The normalized form of the party&apos;s name.
      PARTY type STRING,
      "!   A string identifying the party&apos;s role.
      ROLE type STRING,
      "!   A string that identifies the importance of the party.
      IMPORTANCE type STRING,
      "!   A list of the party&apos;s address or addresses.
      ADDRESSES type STANDARD TABLE OF T_ADDRESS WITH NON-UNIQUE DEFAULT KEY,
      "!   A list of the names and roles of contacts identified in the input document.
      CONTACTS type STANDARD TABLE OF T_CONTACT WITH NON-UNIQUE DEFAULT KEY,
      "!   A list of the party&apos;s mentions in the input document.
      MENTIONS type STANDARD TABLE OF T_MENTION WITH NON-UNIQUE DEFAULT KEY,
    end of T_PARTIES.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Basic information about the input document.</p>
    begin of T_DOCUMENT,
      "!   Document title, if detected.
      TITLE type STRING,
      "!   The input document converted into HTML format.
      HTML type STRING,
      "!   The MD5 hash value of the input document.
      HASH type STRING,
      "!   The label applied to the input document with the calling method&apos;s
      "!    `file_1_label` or `file_2_label` value. This field is specified only in the
      "!    output of the **Comparing two documents** method.
      LABEL type STRING,
    end of T_DOCUMENT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The duration or durations of the contract.</p>
    begin of T_CONTRACT_TERMS,
      "!   The confidence level in the identification of the contract term.
      CONFIDENCE_LEVEL type STRING,
      "!   The contract term (duration).
      TEXT type STRING,
      "!   The normalized form of the contract term, which is listed as a string. This
      "!    element is optional; it is returned only if normalized text exists.
      TEXT_NORMALIZED type STRING,
      "!   The details of the normalized text, if applicable. This element is optional; it
      "!    is returned only if normalized text exists.
      INTERPRETATION type T_INTERPRETATION,
      "!   Hashed values that you can send to IBM to provide feedback or receive support.
      PROVENANCE_IDS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   The numeric location of the identified element in the document, represented with
      "!    two integers labeled `begin` and `end`.
      LOCATION type T_LOCATION,
    end of T_CONTRACT_TERMS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The analysis of objects returned by the **Element</p>
    "!     classification** method.
    begin of T_CLASSIFY_RETURN,
      "!   Basic information about the input document.
      DOCUMENT type T_DOCUMENT,
      "!   The analysis model used to classify the input document. For the **Element
      "!    classification** method, the only valid value is `contracts`.
      MODEL_ID type STRING,
      "!   The version of the analysis model identified by the value of the `model_id` key.
      "!
      MODEL_VERSION type STRING,
      "!   Document elements identified by the service.
      ELEMENTS type STANDARD TABLE OF T_ELEMENT WITH NON-UNIQUE DEFAULT KEY,
      "!   The date or dates on which the document becomes effective.
      EFFECTIVE_DATES type STANDARD TABLE OF T_EFFECTIVE_DATES WITH NON-UNIQUE DEFAULT KEY,
      "!   The monetary amounts that identify the total amount of the contract that needs
      "!    to be paid from one party to another.
      CONTRACT_AMOUNTS type STANDARD TABLE OF T_CONTRACT_AMTS WITH NON-UNIQUE DEFAULT KEY,
      "!   The dates on which the document is to be terminated.
      TERMINATION_DATES type STANDARD TABLE OF T_TERMINATION_DATES WITH NON-UNIQUE DEFAULT KEY,
      "!   The contract type as declared in the document.
      CONTRACT_TYPES type STANDARD TABLE OF T_CONTRACT_TYPES WITH NON-UNIQUE DEFAULT KEY,
      "!   The durations of the contract.
      CONTRACT_TERMS type STANDARD TABLE OF T_CONTRACT_TERMS WITH NON-UNIQUE DEFAULT KEY,
      "!   The document&apos;s payment durations.
      PAYMENT_TERMS type STANDARD TABLE OF T_PAYMENT_TERMS WITH NON-UNIQUE DEFAULT KEY,
      "!   The contract currencies as declared in the document.
      CONTRACT_CURRENCIES type STANDARD TABLE OF T_CONTRACT_CURRENCIES WITH NON-UNIQUE DEFAULT KEY,
      "!   Definition of tables identified in the input document.
      TABLES type STANDARD TABLE OF T_TABLES WITH NON-UNIQUE DEFAULT KEY,
      "!   The structure of the input document.
      DOCUMENT_STRUCTURE type T_DOC_STRUCTURE,
      "!   Definitions of the parties identified in the input document.
      PARTIES type STANDARD TABLE OF T_PARTIES WITH NON-UNIQUE DEFAULT KEY,
    end of T_CLASSIFY_RETURN.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The original labeling from the input document, without the</p>
    "!     submitted feedback.
    begin of T_ORIGINAL_LABELS_IN,
      "!   Description of the action specified by the element and whom it affects.
      TYPES type STANDARD TABLE OF T_TYPE_LABEL WITH NON-UNIQUE DEFAULT KEY,
      "!   List of functional categories into which the element falls; in other words, the
      "!    subject matter of the element.
      CATEGORIES type STANDARD TABLE OF T_CATEGORY WITH NON-UNIQUE DEFAULT KEY,
    end of T_ORIGINAL_LABELS_IN.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Details of semantically aligned elements.</p>
    begin of T_ELEMENT_PAIR,
      "!   The label of the document (that is, the value of either the `file_1_label` or
      "!    `file_2_label` parameters) in which the element occurs.
      DOCUMENT_LABEL type STRING,
      "!   The contents of the element.
      TEXT type STRING,
      "!   The numeric location of the identified element in the document, represented with
      "!    two integers labeled `begin` and `end`.
      LOCATION type T_LOCATION,
      "!   Description of the action specified by the element and whom it affects.
      TYPES type STANDARD TABLE OF T_TYPE_LABEL_COMPARISON WITH NON-UNIQUE DEFAULT KEY,
      "!   List of functional categories into which the element falls; in other words, the
      "!    subject matter of the element.
      CATEGORIES type STANDARD TABLE OF T_CATEGORY_COMPARISON WITH NON-UNIQUE DEFAULT KEY,
      "!   List of document attributes.
      ATTRIBUTES type STANDARD TABLE OF T_ATTRIBUTE WITH NON-UNIQUE DEFAULT KEY,
    end of T_ELEMENT_PAIR.
  types:
    "! No documentation available.
    begin of T_ALIGNED_ELEMENT,
      "!   Identifies two elements that semantically align between the compared documents.
      ELEMENT_PAIR type STANDARD TABLE OF T_ELEMENT_PAIR WITH NON-UNIQUE DEFAULT KEY,
      "!   Specifies whether the aligned element is identical. Elements are considered
      "!    identical despite minor differences such as leading punctuation,
      "!    end-of-sentence punctuation, whitespace, the presence or absence of definite or
      "!    indefinite articles, and others.
      IDENTICAL_TEXT type BOOLEAN,
      "!   Hashed values that you can send to IBM to provide feedback or receive support.
      PROVENANCE_IDS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   Indicates that the elements aligned are contractual clauses of significance.
      SIGNIFICANT_ELEMENTS type BOOLEAN,
    end of T_ALIGNED_ELEMENT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The comparison of the two submitted documents.</p>
    begin of T_COMPARE_RETURN,
      "!   The analysis model used to compare the input documents. For the **Compare two
      "!    documents** method, the only valid value is `contracts`.
      MODEL_ID type STRING,
      "!   The version of the analysis model identified by the value of the `model_id` key.
      "!
      MODEL_VERSION type STRING,
      "!   Information about the documents being compared.
      DOCUMENTS type STANDARD TABLE OF T_DOCUMENT WITH NON-UNIQUE DEFAULT KEY,
      "!   A list of pairs of elements that semantically align between the compared
      "!    documents.
      ALIGNED_ELEMENTS type STANDARD TABLE OF T_ALIGNED_ELEMENT WITH NON-UNIQUE DEFAULT KEY,
      "!   A list of elements that do not semantically align between the compared
      "!    documents.
      UNALIGNED_ELEMENTS type STANDARD TABLE OF T_UNALIGNED_ELEMENT WITH NON-UNIQUE DEFAULT KEY,
    end of T_COMPARE_RETURN.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The HTML converted from an input document.</p>
    begin of T_HTMLRETURN,
      "!   The number of pages in the input document.
      NUM_PAGES type STRING,
      "!   The author of the input document, if identified.
      AUTHOR type STRING,
      "!   The publication date of the input document, if identified.
      PUBLICATION_DATE type STRING,
      "!   The title of the input document, if identified.
      TITLE type STRING,
      "!   The HTML version of the input document.
      HTML type STRING,
    end of T_HTMLRETURN.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Feedback data for submission.</p>
    begin of T_FEEDBACK_DATA_INPUT,
      "!   The type of feedback. The only permitted value is `element_classification`.
      FEEDBACK_TYPE type STRING,
      "!   Brief information about the input document.
      DOCUMENT type T_SHORT_DOC,
      "!   An optional string identifying the model ID. The only permitted value is
      "!    `contracts`.
      MODEL_ID type STRING,
      "!   An optional string identifying the version of the model used.
      MODEL_VERSION type STRING,
      "!   The numeric location of the identified element in the document, represented with
      "!    two integers labeled `begin` and `end`.
      LOCATION type T_LOCATION,
      "!   The text on which to submit feedback.
      TEXT type STRING,
      "!   The original labeling from the input document, without the submitted feedback.
      ORIGINAL_LABELS type T_ORIGINAL_LABELS_IN,
      "!   The updated labeling from the input document, accounting for the submitted
      "!    feedback.
      UPDATED_LABELS type T_UPDATED_LABELS_IN,
    end of T_FEEDBACK_DATA_INPUT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An array that contains the `id` value of a row header that</p>
    "!     is applicable to this body cell.
      T_ROW_HEADER_IDS type TT_String.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The batch-request status.</p>
    begin of T_BATCH_STATUS,
      "!   The method to be run against the documents. Possible values are
      "!    `html_conversion`, `element_classification`, and `tables`.
      FUNCTION type STRING,
      "!   The geographical location of the Cloud Object Storage input bucket as listed on
      "!    the **Endpoint** tab of your COS instance; for example, `us-geo`, `eu-geo`, or
      "!    `ap-geo`.
      INPUT_BUCKET_LOCATION type STRING,
      "!   The name of the Cloud Object Storage input bucket.
      INPUT_BUCKET_NAME type STRING,
      "!   The geographical location of the Cloud Object Storage output bucket as listed on
      "!    the **Endpoint** tab of your COS instance; for example, `us-geo`, `eu-geo`, or
      "!    `ap-geo`.
      OUTPUT_BUCKET_LOCATION type STRING,
      "!   The name of the Cloud Object Storage output bucket.
      OUTPUT_BUCKET_NAME type STRING,
      "!   The unique identifier for the batch request.
      BATCH_ID type STRING,
      "!   Document counts.
      DOCUMENT_COUNTS type T_DOC_COUNTS,
      "!   The status of the batch request.
      STATUS type STRING,
      "!   The creation time of the batch request.
      CREATED type DATETIME,
      "!   The time of the most recent update to the batch request.
      UPDATED type DATETIME,
    end of T_BATCH_STATUS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The results of a successful **List Batches** request.</p>
    begin of T_BATCHES,
      "!   A list of the status of all batch requests.
      BATCHES type STANDARD TABLE OF T_BATCH_STATUS WITH NON-UNIQUE DEFAULT KEY,
    end of T_BATCHES.
  types:
    "! No documentation available.
    begin of T_INLINE_OBJECT,
      "!   The document to convert.
      FILE type FILE,
    end of T_INLINE_OBJECT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An array that contains the `id` value of a column header</p>
    "!     that is applicable to the current cell.
      T_COLUMN_HEADER_IDS type TT_String.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    If you provide customization input, the normalized version</p>
    "!     of the row header texts according to the customization; otherwise, the same
    "!     value as `row_header_texts`.
      T_ROW_HEADER_TEXTS_NORMALIZED type TT_String.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An array that contains the `text` value of a column header</p>
    "!     that is applicable to the current cell.
      T_COLUMN_HEADER_TEXTS type TT_String.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The status and message of the deletion request.</p>
    begin of T_FEEDBACK_DELETED,
      "!   HTTP return code.
      STATUS type INTEGER,
      "!   Status message returned from the service.
      MESSAGE type STRING,
    end of T_FEEDBACK_DELETED.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The feedback to be added to an element in the document.</p>
    begin of T_FEEDBACK_INPUT,
      "!   An optional string identifying the user.
      USER_ID type STRING,
      "!   An optional comment on or description of the feedback.
      COMMENT type STRING,
      "!   Feedback data for submission.
      FEEDBACK_DATA type T_FEEDBACK_DATA_INPUT,
    end of T_FEEDBACK_INPUT.
  types:
    "! No documentation available.
    begin of T_INLINE_OBJECT1,
      "!   The document to classify.
      FILE type FILE,
    end of T_INLINE_OBJECT1.
  types:
    "! No documentation available.
    begin of T_INLINE_OBJECT2,
      "!   The document on which to run table extraction.
      FILE type FILE,
    end of T_INLINE_OBJECT2.
  types:
    "! No documentation available.
    begin of T_INLINE_OBJECT3,
      "!   The first document to compare.
      FILE_1 type FILE,
      "!   The second document to compare.
      FILE_2 type FILE,
    end of T_INLINE_OBJECT3.
  types:
    "! No documentation available.
    begin of T_INLINE_OBJECT4,
      "!   A JSON file containing the input Cloud Object Storage credentials. At a minimum,
      "!    the credentials must enable `READ` permissions on the bucket defined by the
      "!    `input_bucket_name` parameter.
      INPUT_CREDENTIALS_FILE type FILE,
      "!   The geographical location of the Cloud Object Storage input bucket as listed on
      "!    the **Endpoint** tab of your Cloud Object Storage instance; for example,
      "!    `us-geo`, `eu-geo`, or `ap-geo`.
      INPUT_BUCKET_LOCATION type STRING,
      "!   The name of the Cloud Object Storage input bucket.
      INPUT_BUCKET_NAME type STRING,
      "!   A JSON file that lists the Cloud Object Storage output credentials. At a
      "!    minimum, the credentials must enable `READ` and `WRITE` permissions on the
      "!    bucket defined by the `output_bucket_name` parameter.
      OUTPUT_CREDENTIALS_FILE type FILE,
      "!   The geographical location of the Cloud Object Storage output bucket as listed on
      "!    the **Endpoint** tab of your Cloud Object Storage instance; for example,
      "!    `us-geo`, `eu-geo`, or `ap-geo`.
      OUTPUT_BUCKET_LOCATION type STRING,
      "!   The name of the Cloud Object Storage output bucket.
      OUTPUT_BUCKET_NAME type STRING,
    end of T_INLINE_OBJECT4.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The results of a successful **Get Feedback** request for a</p>
    "!     single feedback entry.
    begin of T_GET_FEEDBACK,
      "!   A string uniquely identifying the feedback entry.
      FEEDBACK_ID type STRING,
      "!   A timestamp identifying the creation time of the feedback entry.
      CREATED type DATETIME,
      "!   A string containing the user&apos;s comment about the feedback entry.
      COMMENT type STRING,
      "!   Information returned from the **Add Feedback** method.
      FEEDBACK_DATA type T_FEEDBACK_DATA_OUTPUT,
    end of T_GET_FEEDBACK.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The results of a successful **List Feedback** request for</p>
    "!     all feedback.
    begin of T_FEEDBACK_LIST,
      "!   A list of all feedback for the document.
      FEEDBACK type STANDARD TABLE OF T_GET_FEEDBACK WITH NON-UNIQUE DEFAULT KEY,
    end of T_FEEDBACK_LIST.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A list of values in a key-value pair.</p>
      T_VALUES type STANDARD TABLE OF T_VALUE WITH NON-UNIQUE DEFAULT KEY.

constants:
  "! <p class="shorttext synchronized" lang="en">List of required fields per type.</p>
  begin of C_REQUIRED_FIELDS,
    T_LOCATION type string value '|BEGIN|END|',
    T_LABEL type string value '|NATURE|PARTY|',
    T_TYPE_LABEL_COMPARISON type string value '|',
    T_PARAGRAPHS type string value '|',
    T_DOC_COUNTS type string value '|',
    T_TYPE_LABEL type string value '|',
    T_SHORT_DOC type string value '|',
    T_CATEGORY type string value '|',
    T_ORIGINAL_LABELS_OUT type string value '|',
    T_UPDATED_LABELS_OUT type string value '|',
    T_PAGINATION type string value '|',
    T_FEEDBACK_DATA_OUTPUT type string value '|',
    T_ATTRIBUTE type string value '|',
    T_CATEGORY_COMPARISON type string value '|',
    T_UNALIGNED_ELEMENT type string value '|',
    T_UPDATED_LABELS_IN type string value '|TYPES|CATEGORIES|',
    T_ELEMENT_LOCATIONS type string value '|',
    T_LEADING_SENTENCE type string value '|',
    T_SECTION_TITLES type string value '|',
    T_DOC_STRUCTURE type string value '|',
    T_ERROR_RESPONSE type string value '|CODE|ERROR|',
    T_CONTACT type string value '|',
    T_SECTION_TITLE type string value '|',
    T_COLUMN_HEADERS type string value '|',
    T_CONTEXTS type string value '|',
    T_TABLE_TITLE type string value '|',
    T_BODY_CELLS type string value '|',
    T_KEY type string value '|',
    T_VALUE type string value '|',
    T_KEY_VALUE_PAIR type string value '|',
    T_TABLE_HEADERS type string value '|',
    T_ROW_HEADERS type string value '|',
    T_TABLES type string value '|',
    T_DOC_INFO type string value '|',
    T_TABLE_RETURN type string value '|',
    T_FEEDBACK_RETURN type string value '|',
    T_INTERPRETATION type string value '|',
    T_CONTRACT_AMTS type string value '|',
    T_CONTRACT_CURRENCIES type string value '|',
    T_PAYMENT_TERMS type string value '|',
    T_ELEMENT type string value '|',
    T_TERMINATION_DATES type string value '|',
    T_CONTRACT_TYPES type string value '|',
    T_EFFECTIVE_DATES type string value '|',
    T_MENTION type string value '|',
    T_ADDRESS type string value '|',
    T_PARTIES type string value '|',
    T_DOCUMENT type string value '|',
    T_CONTRACT_TERMS type string value '|',
    T_CLASSIFY_RETURN type string value '|',
    T_ORIGINAL_LABELS_IN type string value '|TYPES|CATEGORIES|',
    T_ELEMENT_PAIR type string value '|',
    T_ALIGNED_ELEMENT type string value '|',
    T_COMPARE_RETURN type string value '|',
    T_HTMLRETURN type string value '|',
    T_FEEDBACK_DATA_INPUT type string value '|FEEDBACK_TYPE|LOCATION|TEXT|ORIGINAL_LABELS|UPDATED_LABELS|',
    T_BATCH_STATUS type string value '|',
    T_BATCHES type string value '|',
    T_INLINE_OBJECT type string value '|FILE|',
    T_FEEDBACK_DELETED type string value '|',
    T_FEEDBACK_INPUT type string value '|FEEDBACK_DATA|',
    T_INLINE_OBJECT1 type string value '|FILE|',
    T_INLINE_OBJECT2 type string value '|FILE|',
    T_INLINE_OBJECT3 type string value '|FILE_1|FILE_2|',
    T_INLINE_OBJECT4 type string value '|INPUT_CREDENTIALS_FILE|INPUT_BUCKET_LOCATION|INPUT_BUCKET_NAME|OUTPUT_CREDENTIALS_FILE|OUTPUT_BUCKET_LOCATION|OUTPUT_BUCKET_NAME|',
    T_GET_FEEDBACK type string value '|',
    T_FEEDBACK_LIST type string value '|',
    __DUMMY type string value SPACE,
  end of C_REQUIRED_FIELDS .

constants:
  "! <p class="shorttext synchronized" lang="en">Map ABAP identifiers to service identifiers.</p>
  begin of C_ABAPNAME_DICTIONARY,
     NUM_PAGES type string value 'num_pages',
     AUTHOR type string value 'author',
     PUBLICATION_DATE type string value 'publication_date',
     TITLE type string value 'title',
     HTML type string value 'html',
     DOCUMENT type string value 'document',
     MODEL_ID type string value 'model_id',
     MODEL_VERSION type string value 'model_version',
     ELEMENTS type string value 'elements',
     EFFECTIVE_DATES type string value 'effective_dates',
     EFFECTIVEDATES type string value 'effectiveDates',
     CONTRACT_AMOUNTS type string value 'contract_amounts',
     CONTRACTAMOUNTS type string value 'contractAmounts',
     TERMINATION_DATES type string value 'termination_dates',
     TERMINATIONDATES type string value 'terminationDates',
     CONTRACT_TYPES type string value 'contract_types',
     CONTRACTTYPES type string value 'contractTypes',
     CONTRACT_TERMS type string value 'contract_terms',
     CONTRACTTERMS type string value 'contractTerms',
     PAYMENT_TERMS type string value 'payment_terms',
     PAYMENTTERMS type string value 'paymentTerms',
     CONTRACT_CURRENCIES type string value 'contract_currencies',
     CONTRACTCURRENCIES type string value 'contractCurrencies',
     TABLES type string value 'tables',
     DOCUMENT_STRUCTURE type string value 'document_structure',
     PARTIES type string value 'parties',
     SECTION_TITLES type string value 'section_titles',
     SECTIONTITLES type string value 'sectionTitles',
     LEADING_SENTENCES type string value 'leading_sentences',
     LEADINGSENTENCES type string value 'leadingSentences',
     PARAGRAPHS type string value 'paragraphs',
     DOCUMENTS type string value 'documents',
     ALIGNED_ELEMENTS type string value 'aligned_elements',
     ALIGNEDELEMENTS type string value 'alignedElements',
     UNALIGNED_ELEMENTS type string value 'unaligned_elements',
     UNALIGNEDELEMENTS type string value 'unalignedElements',
     ELEMENT_PAIR type string value 'element_pair',
     ELEMENTPAIR type string value 'elementPair',
     IDENTICAL_TEXT type string value 'identical_text',
     PROVENANCE_IDS type string value 'provenance_ids',
     PROVENANCEIDS type string value 'provenanceIds',
     SIGNIFICANT_ELEMENTS type string value 'significant_elements',
     DOCUMENT_LABEL type string value 'document_label',
     LOCATION type string value 'location',
     TEXT type string value 'text',
     TYPES type string value 'types',
     CATEGORIES type string value 'categories',
     ATTRIBUTES type string value 'attributes',
     LABEL type string value 'label',
     HASH type string value 'hash',
     CODE type string value 'code',
     ERROR type string value 'error',
     SECTION_TITLE type string value 'section_title',
     TABLE_HEADERS type string value 'table_headers',
     TABLEHEADERS type string value 'tableHeaders',
     ROW_HEADERS type string value 'row_headers',
     ROWHEADERS type string value 'rowHeaders',
     COLUMN_HEADERS type string value 'column_headers',
     COLUMNHEADERS type string value 'columnHeaders',
     BODY_CELLS type string value 'body_cells',
     BODYCELLS type string value 'bodyCells',
     CONTEXTS type string value 'contexts',
     KEY_VALUE_PAIRS type string value 'key_value_pairs',
     KEYVALUEPAIRS type string value 'keyValuePairs',
     LEVEL type string value 'level',
     ELEMENT_LOCATIONS type string value 'element_locations',
     ELEMENTLOCATIONS type string value 'elementLocations',
     BEGIN type string value 'begin',
     END type string value 'end',
     CELL_ID type string value 'cell_id',
     ROW_INDEX_BEGIN type string value 'row_index_begin',
     ROW_INDEX_END type string value 'row_index_end',
     COLUMN_INDEX_BEGIN type string value 'column_index_begin',
     COLUMN_INDEX_END type string value 'column_index_end',
     TEXT_NORMALIZED type string value 'text_normalized',
     KEY type string value 'key',
     VALUE type string value 'value',
     ROW_HEADER_IDS type string value 'row_header_ids',
     ROWHEADERIDS type string value 'rowHeaderIds',
     ROW_HEADER_TEXTS type string value 'row_header_texts',
     ROWHEADERTEXTS type string value 'rowHeaderTexts',
     ROW_HEADER_TEXTS_NORMALIZED type string value 'row_header_texts_normalized',
     ROWHEADERTEXTSNORMALIZED type string value 'rowHeaderTextsNormalized',
     COLUMN_HEADER_IDS type string value 'column_header_ids',
     COLUMNHEADERIDS type string value 'columnHeaderIds',
     COLUMN_HEADER_TEXTS type string value 'column_header_texts',
     COLUMNHEADERTEXTS type string value 'columnHeaderTexts',
     COLUMN_HEADER_TEXTS_NORMALIZED type string value 'column_header_texts_normalized',
     COLUMNHEADERTEXTSNORMALIZED type string value 'columnHeaderTextsNormalized',
     USER_ID type string value 'user_id',
     COMMENT type string value 'comment',
     FEEDBACK_DATA type string value 'feedback_data',
     FEEDBACK_ID type string value 'feedback_id',
     CREATED type string value 'created',
     FEEDBACK_TYPE type string value 'feedback_type',
     ORIGINAL_LABELS type string value 'original_labels',
     UPDATED_LABELS type string value 'updated_labels',
     PAGINATION type string value 'pagination',
     REFRESH_CURSOR type string value 'refresh_cursor',
     NEXT_CURSOR type string value 'next_cursor',
     REFRESH_URL type string value 'refresh_url',
     NEXT_URL type string value 'next_url',
     TOTAL type string value 'total',
     MODIFICATION type string value 'modification',
     FEEDBACK type string value 'feedback',
     STATUS type string value 'status',
     MESSAGE type string value 'message',
     TYPE type string value 'type',
     NATURE type string value 'nature',
     PARTY type string value 'party',
     FUNCTION type string value 'function',
     INPUT_BUCKET_LOCATION type string value 'input_bucket_location',
     INPUT_BUCKET_NAME type string value 'input_bucket_name',
     OUTPUT_BUCKET_LOCATION type string value 'output_bucket_location',
     OUTPUT_BUCKET_NAME type string value 'output_bucket_name',
     BATCH_ID type string value 'batch_id',
     DOCUMENT_COUNTS type string value 'document_counts',
     UPDATED type string value 'updated',
     BATCHES type string value 'batches',
     PENDING type string value 'pending',
     SUCCESSFUL type string value 'successful',
     FAILED type string value 'failed',
     ROLE type string value 'role',
     IMPORTANCE type string value 'importance',
     ADDRESSES type string value 'addresses',
     CONTACTS type string value 'contacts',
     MENTIONS type string value 'mentions',
     NAME type string value 'name',
     CONFIDENCE_LEVEL type string value 'confidence_level',
     INTERPRETATION type string value 'interpretation',
     NUMERIC_VALUE type string value 'numeric_value',
     UNIT type string value 'unit',
     FILE type string value 'file',
     FILE_1 type string value 'file_1',
     FILE_2 type string value 'file_2',
     INPUT_CREDENTIALS_FILE type string value 'input_credentials_file',
     OUTPUT_CREDENTIALS_FILE type string value 'output_credentials_file',
  end of C_ABAPNAME_DICTIONARY .


  methods GET_APPNAME
    redefinition .
  methods GET_REQUEST_PROP
    redefinition .
  methods GET_SDK_VERSION_DATE
    redefinition .


    "! <p class="shorttext synchronized" lang="en">Convert document to HTML</p>
    "!   Converts a document to HTML.
    "!
    "! @parameter I_FILE |
    "!   The document to convert.
    "! @parameter I_FILE_CONTENT_TYPE |
    "!   The content type of file.
    "! @parameter I_MODEL |
    "!   The analysis model to be used by the service. For the **Element classification**
    "!    and **Compare two documents** methods, the default is `contracts`. For the
    "!    **Extract tables** method, the default is `tables`. These defaults apply to the
    "!    standalone methods as well as to the methods&apos; use in batch-processing
    "!    requests.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_HTMLRETURN
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods CONVERT_TO_HTML
    importing
      !I_FILE type FILE
      !I_FILE_CONTENT_TYPE type STRING optional
      !I_MODEL type STRING optional
      !I_contenttype type string default 'multipart/form-data'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_HTMLRETURN
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">Classify the elements of a document</p>
    "!   Analyzes the structural and semantic elements of a document.
    "!
    "! @parameter I_FILE |
    "!   The document to classify.
    "! @parameter I_FILE_CONTENT_TYPE |
    "!   The content type of file.
    "! @parameter I_MODEL |
    "!   The analysis model to be used by the service. For the **Element classification**
    "!    and **Compare two documents** methods, the default is `contracts`. For the
    "!    **Extract tables** method, the default is `tables`. These defaults apply to the
    "!    standalone methods as well as to the methods&apos; use in batch-processing
    "!    requests.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_CLASSIFY_RETURN
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods CLASSIFY_ELEMENTS
    importing
      !I_FILE type FILE
      !I_FILE_CONTENT_TYPE type STRING optional
      !I_MODEL type STRING optional
      !I_contenttype type string default 'multipart/form-data'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_CLASSIFY_RETURN
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">Extract a document's tables</p>
    "!   Analyzes the tables in a document.
    "!
    "! @parameter I_FILE |
    "!   The document on which to run table extraction.
    "! @parameter I_FILE_CONTENT_TYPE |
    "!   The content type of file.
    "! @parameter I_MODEL |
    "!   The analysis model to be used by the service. For the **Element classification**
    "!    and **Compare two documents** methods, the default is `contracts`. For the
    "!    **Extract tables** method, the default is `tables`. These defaults apply to the
    "!    standalone methods as well as to the methods&apos; use in batch-processing
    "!    requests.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_TABLE_RETURN
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods EXTRACT_TABLES
    importing
      !I_FILE type FILE
      !I_FILE_CONTENT_TYPE type STRING optional
      !I_MODEL type STRING optional
      !I_contenttype type string default 'multipart/form-data'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_TABLE_RETURN
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">Compare two documents</p>
    "!   Compares two input documents. Documents must be in the same format.
    "!
    "! @parameter I_FILE_1 |
    "!   The first document to compare.
    "! @parameter I_FILE_2 |
    "!   The second document to compare.
    "! @parameter I_FILE_1_CONTENT_TYPE |
    "!   The content type of file1.
    "! @parameter I_FILE_2_CONTENT_TYPE |
    "!   The content type of file2.
    "! @parameter I_FILE_1_LABEL |
    "!   A text label for the first document.
    "! @parameter I_FILE_2_LABEL |
    "!   A text label for the second document.
    "! @parameter I_MODEL |
    "!   The analysis model to be used by the service. For the **Element classification**
    "!    and **Compare two documents** methods, the default is `contracts`. For the
    "!    **Extract tables** method, the default is `tables`. These defaults apply to the
    "!    standalone methods as well as to the methods&apos; use in batch-processing
    "!    requests.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_COMPARE_RETURN
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods COMPARE_DOCUMENTS
    importing
      !I_FILE_1 type FILE
      !I_FILE_2 type FILE
      !I_FILE_1_CONTENT_TYPE type STRING optional
      !I_FILE_2_CONTENT_TYPE type STRING optional
      !I_FILE_1_LABEL type STRING default 'file_1'
      !I_FILE_2_LABEL type STRING default 'file_2'
      !I_MODEL type STRING optional
      !I_contenttype type string default 'multipart/form-data'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_COMPARE_RETURN
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">Add feedback</p>
    "!   Adds feedback in the form of _labels_ from a subject-matter expert (SME) to a
    "!    governing document. <br/>
    "!   **Important:** Feedback is not immediately incorporated into the training model,
    "!    nor is it guaranteed to be incorporated at a later date. Instead, submitted
    "!    feedback is used to suggest future updates to the training model.
    "!
    "! @parameter I_FEEDBACK_DATA |
    "!   An object that defines the feedback to be submitted.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_FEEDBACK_RETURN
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods ADD_FEEDBACK
    importing
      !I_FEEDBACK_DATA type T_FEEDBACK_INPUT
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_FEEDBACK_RETURN
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">List the feedback in a document</p>
    "!   Lists the feedback in a document.
    "!
    "! @parameter I_FEEDBACK_TYPE |
    "!   An optional string that filters the output to include only feedback with the
    "!    specified feedback type. The only permitted value is `element_classification`.
    "! @parameter I_BEFORE |
    "!   An optional string in the format `YYYY-MM-DD` that filters the output to include
    "!    only feedback that was added before the specified date.
    "! @parameter I_AFTER |
    "!   An optional string in the format `YYYY-MM-DD` that filters the output to include
    "!    only feedback that was added after the specified date.
    "! @parameter I_DOCUMENT_TITLE |
    "!   An optional string that filters the output to include only feedback from the
    "!    document with the specified `document_title`.
    "! @parameter I_MODEL_ID |
    "!   An optional string that filters the output to include only feedback with the
    "!    specified `model_id`. The only permitted value is `contracts`.
    "! @parameter I_MODEL_VERSION |
    "!   An optional string that filters the output to include only feedback with the
    "!    specified `model_version`.
    "! @parameter I_CATEGORY_REMOVED |
    "!   An optional string in the form of a comma-separated list of categories. If it is
    "!    specified, the service filters the output to include only feedback that has at
    "!    least one category from the list removed.
    "! @parameter I_CATEGORY_ADDED |
    "!   An optional string in the form of a comma-separated list of categories. If this
    "!    is specified, the service filters the output to include only feedback that has
    "!    at least one category from the list added.
    "! @parameter I_CATEGORY_NOT_CHANGED |
    "!   An optional string in the form of a comma-separated list of categories. If this
    "!    is specified, the service filters the output to include only feedback that has
    "!    at least one category from the list unchanged.
    "! @parameter I_TYPE_REMOVED |
    "!   An optional string of comma-separated `nature`:`party` pairs. If this is
    "!    specified, the service filters the output to include only feedback that has at
    "!    least one `nature`:`party` pair from the list removed.
    "! @parameter I_TYPE_ADDED |
    "!   An optional string of comma-separated `nature`:`party` pairs. If this is
    "!    specified, the service filters the output to include only feedback that has at
    "!    least one `nature`:`party` pair from the list removed.
    "! @parameter I_TYPE_NOT_CHANGED |
    "!   An optional string of comma-separated `nature`:`party` pairs. If this is
    "!    specified, the service filters the output to include only feedback that has at
    "!    least one `nature`:`party` pair from the list unchanged.
    "! @parameter I_PAGE_LIMIT |
    "!   An optional integer specifying the number of documents that you want the service
    "!    to return.
    "! @parameter I_CURSOR |
    "!   An optional string that returns the set of documents after the previous set. Use
    "!    this parameter with the `page_limit` parameter.
    "! @parameter I_SORT |
    "!   An optional comma-separated list of fields in the document to sort on. You can
    "!    optionally specify the sort direction by prefixing the value of the field with
    "!    `-` for descending order or `+` for ascending order (the default). Currently
    "!    permitted sorting fields are `created`, `user_id`, and `document_title`.
    "! @parameter I_INCLUDE_TOTAL |
    "!   An optional boolean value. If specified as `true`, the `pagination` object in
    "!    the output includes a value called `total` that gives the total count of
    "!    feedback created.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_FEEDBACK_LIST
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_FEEDBACK
    importing
      !I_FEEDBACK_TYPE type STRING optional
      !I_BEFORE type DATE optional
      !I_AFTER type DATE optional
      !I_DOCUMENT_TITLE type STRING optional
      !I_MODEL_ID type STRING optional
      !I_MODEL_VERSION type STRING optional
      !I_CATEGORY_REMOVED type STRING optional
      !I_CATEGORY_ADDED type STRING optional
      !I_CATEGORY_NOT_CHANGED type STRING optional
      !I_TYPE_REMOVED type STRING optional
      !I_TYPE_ADDED type STRING optional
      !I_TYPE_NOT_CHANGED type STRING optional
      !I_PAGE_LIMIT type INTEGER optional
      !I_CURSOR type STRING optional
      !I_SORT type STRING optional
      !I_INCLUDE_TOTAL type BOOLEAN optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_FEEDBACK_LIST
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Get a specified feedback entry</p>
    "!   Gets a feedback entry with a specified `feedback_id`.
    "!
    "! @parameter I_FEEDBACK_ID |
    "!   A string that specifies the feedback entry to be included in the output.
    "! @parameter I_MODEL |
    "!   The analysis model to be used by the service. For the **Element classification**
    "!    and **Compare two documents** methods, the default is `contracts`. For the
    "!    **Extract tables** method, the default is `tables`. These defaults apply to the
    "!    standalone methods as well as to the methods&apos; use in batch-processing
    "!    requests.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_GET_FEEDBACK
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_FEEDBACK
    importing
      !I_FEEDBACK_ID type STRING
      !I_MODEL type STRING optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_GET_FEEDBACK
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Delete a specified feedback entry</p>
    "!   Deletes a feedback entry with a specified `feedback_id`.
    "!
    "! @parameter I_FEEDBACK_ID |
    "!   A string that specifies the feedback entry to be deleted from the document.
    "! @parameter I_MODEL |
    "!   The analysis model to be used by the service. For the **Element classification**
    "!    and **Compare two documents** methods, the default is `contracts`. For the
    "!    **Extract tables** method, the default is `tables`. These defaults apply to the
    "!    standalone methods as well as to the methods&apos; use in batch-processing
    "!    requests.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_FEEDBACK_DELETED
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_FEEDBACK
    importing
      !I_FEEDBACK_ID type STRING
      !I_MODEL type STRING optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_FEEDBACK_DELETED
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">Submit a batch-processing request</p>
    "!   Run Compare and Comply methods over a collection of input documents.<br/>
    "!   <br/>
    "!   **Important:** Batch processing requires the use of the [IBM Cloud Object
    "!    Storage
    "!    service](https://cloud.ibm.com/docs/services/cloud-object-storage?topic=cloud-o
    "!   bject-storage-about#about-ibm-cloud-object-storage). The use of IBM Cloud Object
    "!    Storage with Compare and Comply is discussed at [Using batch
    "!    processing](https://cloud.ibm.com/docs/services/compare-comply?topic=compare-co
    "!   mply-batching#before-you-batch).
    "!
    "! @parameter I_FUNCTION |
    "!   The Compare and Comply method to run across the submitted input documents.
    "! @parameter I_INPUT_CREDENTIALS_FILE |
    "!   A JSON file containing the input Cloud Object Storage credentials. At a minimum,
    "!    the credentials must enable `READ` permissions on the bucket defined by the
    "!    `input_bucket_name` parameter.
    "! @parameter I_INPUT_BUCKET_LOCATION |
    "!   The geographical location of the Cloud Object Storage input bucket as listed on
    "!    the **Endpoint** tab of your Cloud Object Storage instance; for example,
    "!    `us-geo`, `eu-geo`, or `ap-geo`.
    "! @parameter I_INPUT_BUCKET_NAME |
    "!   The name of the Cloud Object Storage input bucket.
    "! @parameter I_OUTPUT_CREDENTIALS_FILE |
    "!   A JSON file that lists the Cloud Object Storage output credentials. At a
    "!    minimum, the credentials must enable `READ` and `WRITE` permissions on the
    "!    bucket defined by the `output_bucket_name` parameter.
    "! @parameter I_OUTPUT_BUCKET_LOCATION |
    "!   The geographical location of the Cloud Object Storage output bucket as listed on
    "!    the **Endpoint** tab of your Cloud Object Storage instance; for example,
    "!    `us-geo`, `eu-geo`, or `ap-geo`.
    "! @parameter I_OUTPUT_BUCKET_NAME |
    "!   The name of the Cloud Object Storage output bucket.
    "! @parameter I_MODEL |
    "!   The analysis model to be used by the service. For the **Element classification**
    "!    and **Compare two documents** methods, the default is `contracts`. For the
    "!    **Extract tables** method, the default is `tables`. These defaults apply to the
    "!    standalone methods as well as to the methods&apos; use in batch-processing
    "!    requests.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_BATCH_STATUS
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods CREATE_BATCH
    importing
      !I_FUNCTION type STRING
      !I_INPUT_CREDENTIALS_FILE type FILE
      !I_INPUT_BUCKET_LOCATION type STRING
      !I_INPUT_BUCKET_NAME type STRING
      !I_OUTPUT_CREDENTIALS_FILE type FILE
      !I_OUTPUT_BUCKET_LOCATION type STRING
      !I_OUTPUT_BUCKET_NAME type STRING
      !I_MODEL type STRING optional
      !I_INPUT_CREDENTIALS_FILE_CT type STRING default ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-ALL
      !I_OUTPUT_CREDENTIALS_FILE_CT type STRING default ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-ALL
      !I_contenttype type string default 'multipart/form-data'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_BATCH_STATUS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">List submitted batch-processing jobs</p>
    "!   Lists batch-processing jobs submitted by users.
    "!
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_BATCHES
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_BATCHES
    importing
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_BATCHES
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Get information about a specific batch-processing job</p>
    "!   Gets information about a batch-processing job with a specified ID.
    "!
    "! @parameter I_BATCH_ID |
    "!   The ID of the batch-processing job whose information you want to retrieve.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_BATCH_STATUS
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_BATCH
    importing
      !I_BATCH_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_BATCH_STATUS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Update a pending or active batch-processing job</p>
    "!   Updates a pending or active batch-processing job. You can rescan the input
    "!    bucket to check for new documents or cancel a job.
    "!
    "! @parameter I_BATCH_ID |
    "!   The ID of the batch-processing job you want to update.
    "! @parameter I_ACTION |
    "!   The action you want to perform on the specified batch-processing job.
    "! @parameter I_MODEL |
    "!   The analysis model to be used by the service. For the **Element classification**
    "!    and **Compare two documents** methods, the default is `contracts`. For the
    "!    **Extract tables** method, the default is `tables`. These defaults apply to the
    "!    standalone methods as well as to the methods&apos; use in batch-processing
    "!    requests.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_BATCH_STATUS
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods UPDATE_BATCH
    importing
      !I_BATCH_ID type STRING
      !I_ACTION type STRING
      !I_MODEL type STRING optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_BATCH_STATUS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .


protected section.

private section.

  methods SET_DEFAULT_QUERY_PARAMETERS
    changing
      !C_URL type TS_URL .

ENDCLASS.

class ZCL_IBMC_COMPARE_COMPLY_V1 IMPLEMENTATION.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_COMPARE_COMPLY_V1->GET_APPNAME
* +-------------------------------------------------------------------------------------------------+
* | [<-()] E_APPNAME                      TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method GET_APPNAME.

    e_appname = 'Compare and Comply'.

  endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Protected Method ZCL_IBMC_COMPARE_COMPLY_V1->GET_REQUEST_PROP
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_AUTH_METHOD                  TYPE        STRING (default =C_DEFAULT)
* | [<-()] E_REQUEST_PROP                 TYPE        TS_REQUEST_PROP
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_REQUEST_PROP.

  data:
    lv_auth_method type string  ##NEEDED.

  e_request_prop = super->get_request_prop( i_auth_method = i_auth_method ).

  lv_auth_method = i_auth_method.
  if lv_auth_method eq c_default.
    lv_auth_method = 'IAM'.
  endif.
  if lv_auth_method is initial.
    e_request_prop-auth_basic      = c_boolean_false.
    e_request_prop-auth_oauth      = c_boolean_false.
    e_request_prop-auth_apikey     = c_boolean_false.
  elseif lv_auth_method eq 'IAM'.
    e_request_prop-auth_name       = 'IAM'.
    e_request_prop-auth_type       = 'apiKey'.
    e_request_prop-auth_headername = 'Authorization'.
    e_request_prop-auth_header     = c_boolean_true.
  elseif lv_auth_method eq 'ICP4D'.
    e_request_prop-auth_name       = 'ICP4D'.
    e_request_prop-auth_type       = 'apiKey'.
    e_request_prop-auth_headername = 'Authorization'.
    e_request_prop-auth_header     = c_boolean_true.
  elseif lv_auth_method eq 'basicAuth'.
    e_request_prop-auth_name       = 'basicAuth'.
    e_request_prop-auth_type       = 'http'.
    e_request_prop-auth_basic      = c_boolean_true.
  else.
  endif.

  e_request_prop-url-protocol    = 'http'.
  e_request_prop-url-host        = 'localhost'.
  e_request_prop-url-path_base   = '/compare-comply/api'.

endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_COMPARE_COMPLY_V1->GET_SDK_VERSION_DATE
* +-------------------------------------------------------------------------------------------------+
* | [<-()] E_SDK_VERSION_DATE             TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method get_sdk_version_date.

    e_sdk_version_date = '20200310173424'.

  endmethod.



* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_COMPARE_COMPLY_V1->CONVERT_TO_HTML
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_FILE        TYPE FILE
* | [--->] I_FILE_CONTENT_TYPE        TYPE STRING(optional)
* | [--->] I_MODEL        TYPE STRING(optional)
* | [--->] I_contenttype       TYPE string (default ='multipart/form-data')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_HTMLRETURN
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CONVERT_TO_HTML.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/html_conversion'.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_MODEL is supplied.
    lv_queryparam = escape( val = i_MODEL format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `model`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.



    " process form parameters
    data:
      ls_form_part     type ts_form_part,
      lt_form_part     type tt_form_part,
      lv_formdata      type string value is initial ##NEEDED,
      lv_value         type string ##NEEDED,
      lv_index(3)      type n value '000' ##NEEDED,
      lv_keypattern    type string ##NEEDED,
      lv_base_name     type string ##NEEDED,
      lv_extension     type string ##NEEDED.




    if not i_FILE is initial.
      lv_extension = get_file_extension( I_file_content_type ).
      lv_value = `form-data; name="file"; filename="file` && lv_index && `.` && lv_extension && `"`  ##NO_TEXT.
      lv_index = lv_index + 1.
      clear ls_form_part.
      ls_form_part-content_type = I_file_content_type.
      ls_form_part-content_disposition = lv_value.
      ls_form_part-xdata = i_FILE.
      append ls_form_part to lt_form_part.
    endif.


    " execute HTTP POST request
    lo_response = HTTP_POST_MULTIPART( i_request_prop = ls_request_prop it_form_part = lt_form_part ).




    " retrieve JSON data
    lv_json = get_response_string( lo_response ).
    parse_json(
      exporting
        i_json       = lv_json
        i_dictionary = c_abapname_dictionary
      changing
        c_abap       = e_response ).

endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_COMPARE_COMPLY_V1->CLASSIFY_ELEMENTS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_FILE        TYPE FILE
* | [--->] I_FILE_CONTENT_TYPE        TYPE STRING(optional)
* | [--->] I_MODEL        TYPE STRING(optional)
* | [--->] I_contenttype       TYPE string (default ='multipart/form-data')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_CLASSIFY_RETURN
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CLASSIFY_ELEMENTS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/element_classification'.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_MODEL is supplied.
    lv_queryparam = escape( val = i_MODEL format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `model`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.



    " process form parameters
    data:
      ls_form_part     type ts_form_part,
      lt_form_part     type tt_form_part,
      lv_formdata      type string value is initial ##NEEDED,
      lv_value         type string ##NEEDED,
      lv_index(3)      type n value '000' ##NEEDED,
      lv_keypattern    type string ##NEEDED,
      lv_base_name     type string ##NEEDED,
      lv_extension     type string ##NEEDED.




    if not i_FILE is initial.
      lv_extension = get_file_extension( I_file_content_type ).
      lv_value = `form-data; name="file"; filename="file` && lv_index && `.` && lv_extension && `"`  ##NO_TEXT.
      lv_index = lv_index + 1.
      clear ls_form_part.
      ls_form_part-content_type = I_file_content_type.
      ls_form_part-content_disposition = lv_value.
      ls_form_part-xdata = i_FILE.
      append ls_form_part to lt_form_part.
    endif.


    " execute HTTP POST request
    lo_response = HTTP_POST_MULTIPART( i_request_prop = ls_request_prop it_form_part = lt_form_part ).




    " retrieve JSON data
    lv_json = get_response_string( lo_response ).
    parse_json(
      exporting
        i_json       = lv_json
        i_dictionary = c_abapname_dictionary
      changing
        c_abap       = e_response ).

endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_COMPARE_COMPLY_V1->EXTRACT_TABLES
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_FILE        TYPE FILE
* | [--->] I_FILE_CONTENT_TYPE        TYPE STRING(optional)
* | [--->] I_MODEL        TYPE STRING(optional)
* | [--->] I_contenttype       TYPE string (default ='multipart/form-data')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_TABLE_RETURN
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method EXTRACT_TABLES.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/tables'.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_MODEL is supplied.
    lv_queryparam = escape( val = i_MODEL format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `model`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.



    " process form parameters
    data:
      ls_form_part     type ts_form_part,
      lt_form_part     type tt_form_part,
      lv_formdata      type string value is initial ##NEEDED,
      lv_value         type string ##NEEDED,
      lv_index(3)      type n value '000' ##NEEDED,
      lv_keypattern    type string ##NEEDED,
      lv_base_name     type string ##NEEDED,
      lv_extension     type string ##NEEDED.




    if not i_FILE is initial.
      lv_extension = get_file_extension( I_file_content_type ).
      lv_value = `form-data; name="file"; filename="file` && lv_index && `.` && lv_extension && `"`  ##NO_TEXT.
      lv_index = lv_index + 1.
      clear ls_form_part.
      ls_form_part-content_type = I_file_content_type.
      ls_form_part-content_disposition = lv_value.
      ls_form_part-xdata = i_FILE.
      append ls_form_part to lt_form_part.
    endif.


    " execute HTTP POST request
    lo_response = HTTP_POST_MULTIPART( i_request_prop = ls_request_prop it_form_part = lt_form_part ).




    " retrieve JSON data
    lv_json = get_response_string( lo_response ).
    parse_json(
      exporting
        i_json       = lv_json
        i_dictionary = c_abapname_dictionary
      changing
        c_abap       = e_response ).

endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_COMPARE_COMPLY_V1->COMPARE_DOCUMENTS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_FILE_1        TYPE FILE
* | [--->] I_FILE_2        TYPE FILE
* | [--->] I_FILE_1_CONTENT_TYPE        TYPE STRING(optional)
* | [--->] I_FILE_2_CONTENT_TYPE        TYPE STRING(optional)
* | [--->] I_FILE_1_LABEL        TYPE STRING (default ='file_1')
* | [--->] I_FILE_2_LABEL        TYPE STRING (default ='file_2')
* | [--->] I_MODEL        TYPE STRING(optional)
* | [--->] I_contenttype       TYPE string (default ='multipart/form-data')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_COMPARE_RETURN
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method COMPARE_DOCUMENTS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/comparison'.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_FILE_1_LABEL is supplied.
    lv_queryparam = escape( val = i_FILE_1_LABEL format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `file_1_label`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_FILE_2_LABEL is supplied.
    lv_queryparam = escape( val = i_FILE_2_LABEL format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `file_2_label`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_MODEL is supplied.
    lv_queryparam = escape( val = i_MODEL format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `model`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.



    " process form parameters
    data:
      ls_form_part     type ts_form_part,
      lt_form_part     type tt_form_part,
      lv_formdata      type string value is initial ##NEEDED,
      lv_value         type string ##NEEDED,
      lv_index(3)      type n value '000' ##NEEDED,
      lv_keypattern    type string ##NEEDED,
      lv_base_name     type string ##NEEDED,
      lv_extension     type string ##NEEDED.




    if not i_FILE_1 is initial.
      lv_extension = get_file_extension( I_file_1_content_type ).
      lv_value = `form-data; name="file_1"; filename="file` && lv_index && `.` && lv_extension && `"`  ##NO_TEXT.
      lv_index = lv_index + 1.
      clear ls_form_part.
      ls_form_part-content_type = I_file_1_content_type.
      ls_form_part-content_disposition = lv_value.
      ls_form_part-xdata = i_FILE_1.
      append ls_form_part to lt_form_part.
    endif.

    if not i_FILE_2 is initial.
      lv_extension = get_file_extension( I_file_2_content_type ).
      lv_value = `form-data; name="file_2"; filename="file` && lv_index && `.` && lv_extension && `"`  ##NO_TEXT.
      lv_index = lv_index + 1.
      clear ls_form_part.
      ls_form_part-content_type = I_file_2_content_type.
      ls_form_part-content_disposition = lv_value.
      ls_form_part-xdata = i_FILE_2.
      append ls_form_part to lt_form_part.
    endif.


    " execute HTTP POST request
    lo_response = HTTP_POST_MULTIPART( i_request_prop = ls_request_prop it_form_part = lt_form_part ).




    " retrieve JSON data
    lv_json = get_response_string( lo_response ).
    parse_json(
      exporting
        i_json       = lv_json
        i_dictionary = c_abapname_dictionary
      changing
        c_abap       = e_response ).

endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_COMPARE_COMPLY_V1->ADD_FEEDBACK
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_FEEDBACK_DATA        TYPE T_FEEDBACK_INPUT
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_FEEDBACK_RETURN
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method ADD_FEEDBACK.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/feedback'.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).






    " process body parameters
    data:
      lv_body      type string,
      lv_bodyparam type string,
      lv_datatype  type char.
    field-symbols:
      <lv_text> type any.
    lv_separator = ''.
    lv_datatype = get_datatype( i_FEEDBACK_DATA ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_FEEDBACK_DATA i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'feedback_data' i_value = i_FEEDBACK_DATA ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_FEEDBACK_DATA to <lv_text>.
      lv_bodyparam = <lv_text>.
      concatenate lv_body lv_bodyparam into lv_body.
    endif.
    if ls_request_prop-header_content_type cp '*json*' and lv_body(1) ne '{'.
	  lv_body = `{` && lv_body && `}`.
	endif.

	if ls_request_prop-header_content_type cp '*charset=utf-8*'.
	  ls_request_prop-body_bin = convert_string_to_utf8( i_string = lv_body ).
	  replace all occurrences of regex ';\s*charset=utf-8' in ls_request_prop-header_content_type with '' ignoring case.
	else.
	  ls_request_prop-body = lv_body.
	endif.


    " execute HTTP POST request
    lo_response = HTTP_POST( i_request_prop = ls_request_prop ).


    " retrieve JSON data
    lv_json = get_response_string( lo_response ).
    parse_json(
      exporting
        i_json       = lv_json
        i_dictionary = c_abapname_dictionary
      changing
        c_abap       = e_response ).

endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_COMPARE_COMPLY_V1->LIST_FEEDBACK
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_FEEDBACK_TYPE        TYPE STRING(optional)
* | [--->] I_BEFORE        TYPE DATE(optional)
* | [--->] I_AFTER        TYPE DATE(optional)
* | [--->] I_DOCUMENT_TITLE        TYPE STRING(optional)
* | [--->] I_MODEL_ID        TYPE STRING(optional)
* | [--->] I_MODEL_VERSION        TYPE STRING(optional)
* | [--->] I_CATEGORY_REMOVED        TYPE STRING(optional)
* | [--->] I_CATEGORY_ADDED        TYPE STRING(optional)
* | [--->] I_CATEGORY_NOT_CHANGED        TYPE STRING(optional)
* | [--->] I_TYPE_REMOVED        TYPE STRING(optional)
* | [--->] I_TYPE_ADDED        TYPE STRING(optional)
* | [--->] I_TYPE_NOT_CHANGED        TYPE STRING(optional)
* | [--->] I_PAGE_LIMIT        TYPE INTEGER(optional)
* | [--->] I_CURSOR        TYPE STRING(optional)
* | [--->] I_SORT        TYPE STRING(optional)
* | [--->] I_INCLUDE_TOTAL        TYPE BOOLEAN(optional)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_FEEDBACK_LIST
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_FEEDBACK.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/feedback'.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_FEEDBACK_TYPE is supplied.
    lv_queryparam = escape( val = i_FEEDBACK_TYPE format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `feedback_type`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_BEFORE is supplied.
    lv_queryparam = i_BEFORE.
    add_query_parameter(
      exporting
        i_parameter  = `before`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_AFTER is supplied.
    lv_queryparam = i_AFTER.
    add_query_parameter(
      exporting
        i_parameter  = `after`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_DOCUMENT_TITLE is supplied.
    lv_queryparam = escape( val = i_DOCUMENT_TITLE format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `document_title`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_MODEL_ID is supplied.
    lv_queryparam = escape( val = i_MODEL_ID format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `model_id`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_MODEL_VERSION is supplied.
    lv_queryparam = escape( val = i_MODEL_VERSION format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `model_version`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_CATEGORY_REMOVED is supplied.
    lv_queryparam = escape( val = i_CATEGORY_REMOVED format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `category_removed`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_CATEGORY_ADDED is supplied.
    lv_queryparam = escape( val = i_CATEGORY_ADDED format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `category_added`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_CATEGORY_NOT_CHANGED is supplied.
    lv_queryparam = escape( val = i_CATEGORY_NOT_CHANGED format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `category_not_changed`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_TYPE_REMOVED is supplied.
    lv_queryparam = escape( val = i_TYPE_REMOVED format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `type_removed`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_TYPE_ADDED is supplied.
    lv_queryparam = escape( val = i_TYPE_ADDED format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `type_added`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_TYPE_NOT_CHANGED is supplied.
    lv_queryparam = escape( val = i_TYPE_NOT_CHANGED format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `type_not_changed`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_PAGE_LIMIT is supplied.
    lv_queryparam = i_PAGE_LIMIT.
    add_query_parameter(
      exporting
        i_parameter  = `page_limit`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_CURSOR is supplied.
    lv_queryparam = escape( val = i_CURSOR format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `cursor`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_SORT is supplied.
    lv_queryparam = escape( val = i_SORT format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `sort`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_INCLUDE_TOTAL is supplied.
    lv_queryparam = i_INCLUDE_TOTAL.
    add_query_parameter(
      exporting
        i_parameter  = `include_total`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.






    " execute HTTP GET request
    lo_response = HTTP_GET( i_request_prop = ls_request_prop ).


    " retrieve JSON data
    lv_json = get_response_string( lo_response ).
    parse_json(
      exporting
        i_json       = lv_json
        i_dictionary = c_abapname_dictionary
      changing
        c_abap       = e_response ).

endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_COMPARE_COMPLY_V1->GET_FEEDBACK
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_FEEDBACK_ID        TYPE STRING
* | [--->] I_MODEL        TYPE STRING(optional)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_GET_FEEDBACK
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_FEEDBACK.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/feedback/{feedback_id}'.
    replace all occurrences of `{feedback_id}` in ls_request_prop-url-path with i_FEEDBACK_ID ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_MODEL is supplied.
    lv_queryparam = escape( val = i_MODEL format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `model`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.






    " execute HTTP GET request
    lo_response = HTTP_GET( i_request_prop = ls_request_prop ).


    " retrieve JSON data
    lv_json = get_response_string( lo_response ).
    parse_json(
      exporting
        i_json       = lv_json
        i_dictionary = c_abapname_dictionary
      changing
        c_abap       = e_response ).

endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_COMPARE_COMPLY_V1->DELETE_FEEDBACK
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_FEEDBACK_ID        TYPE STRING
* | [--->] I_MODEL        TYPE STRING(optional)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_FEEDBACK_DELETED
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_FEEDBACK.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/feedback/{feedback_id}'.
    replace all occurrences of `{feedback_id}` in ls_request_prop-url-path with i_FEEDBACK_ID ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_MODEL is supplied.
    lv_queryparam = escape( val = i_MODEL format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `model`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.






    " execute HTTP DELETE request
    lo_response = HTTP_DELETE( i_request_prop = ls_request_prop ).


    " retrieve JSON data
    lv_json = get_response_string( lo_response ).
    parse_json(
      exporting
        i_json       = lv_json
        i_dictionary = c_abapname_dictionary
      changing
        c_abap       = e_response ).

endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_COMPARE_COMPLY_V1->CREATE_BATCH
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_FUNCTION        TYPE STRING
* | [--->] I_INPUT_CREDENTIALS_FILE        TYPE FILE
* | [--->] I_INPUT_BUCKET_LOCATION        TYPE STRING
* | [--->] I_INPUT_BUCKET_NAME        TYPE STRING
* | [--->] I_OUTPUT_CREDENTIALS_FILE        TYPE FILE
* | [--->] I_OUTPUT_BUCKET_LOCATION        TYPE STRING
* | [--->] I_OUTPUT_BUCKET_NAME        TYPE STRING
* | [--->] I_MODEL        TYPE STRING(optional)
* | [--->] I_INPUT_CREDENTIALS_FILE_CT     TYPE STRING (default = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-all)
* | [--->] I_OUTPUT_CREDENTIALS_FILE_CT     TYPE STRING (default = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-all)
* | [--->] I_contenttype       TYPE string (default ='multipart/form-data')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_BATCH_STATUS
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CREATE_BATCH.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/batches'.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    lv_queryparam = escape( val = i_FUNCTION format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `function`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.

    if i_MODEL is supplied.
    lv_queryparam = escape( val = i_MODEL format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `model`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.



    " process form parameters
    data:
      ls_form_part     type ts_form_part,
      lt_form_part     type tt_form_part,
      lv_formdata      type string value is initial ##NEEDED,
      lv_value         type string ##NEEDED,
      lv_index(3)      type n value '000' ##NEEDED,
      lv_keypattern    type string ##NEEDED,
      lv_base_name     type string ##NEEDED,
      lv_extension     type string ##NEEDED.


    if not i_INPUT_BUCKET_LOCATION is initial.
      clear ls_form_part.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      ls_form_part-content_disposition = 'form-data; name="input_bucket_location"'  ##NO_TEXT.
      lv_formdata = i_INPUT_BUCKET_LOCATION.
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.

    if not i_INPUT_BUCKET_NAME is initial.
      clear ls_form_part.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      ls_form_part-content_disposition = 'form-data; name="input_bucket_name"'  ##NO_TEXT.
      lv_formdata = i_INPUT_BUCKET_NAME.
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.

    if not i_OUTPUT_BUCKET_LOCATION is initial.
      clear ls_form_part.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      ls_form_part-content_disposition = 'form-data; name="output_bucket_location"'  ##NO_TEXT.
      lv_formdata = i_OUTPUT_BUCKET_LOCATION.
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.

    if not i_OUTPUT_BUCKET_NAME is initial.
      clear ls_form_part.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      ls_form_part-content_disposition = 'form-data; name="output_bucket_name"'  ##NO_TEXT.
      lv_formdata = i_OUTPUT_BUCKET_NAME.
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.



    if not i_INPUT_CREDENTIALS_FILE is initial.
      lv_extension = get_file_extension( I_INPUT_CREDENTIALS_FILE_CT ).
      lv_value = `form-data; name="input_credentials_file"; filename="file` && lv_index && `.` && lv_extension && `"`  ##NO_TEXT.
      lv_index = lv_index + 1.
      clear ls_form_part.
      ls_form_part-content_type = I_INPUT_CREDENTIALS_FILE_CT.
      ls_form_part-content_disposition = lv_value.
      ls_form_part-xdata = i_INPUT_CREDENTIALS_FILE.
      append ls_form_part to lt_form_part.
    endif.

    if not i_OUTPUT_CREDENTIALS_FILE is initial.
      lv_extension = get_file_extension( I_OUTPUT_CREDENTIALS_FILE_CT ).
      lv_value = `form-data; name="output_credentials_file"; filename="file` && lv_index && `.` && lv_extension && `"`  ##NO_TEXT.
      lv_index = lv_index + 1.
      clear ls_form_part.
      ls_form_part-content_type = I_OUTPUT_CREDENTIALS_FILE_CT.
      ls_form_part-content_disposition = lv_value.
      ls_form_part-xdata = i_OUTPUT_CREDENTIALS_FILE.
      append ls_form_part to lt_form_part.
    endif.


    " execute HTTP POST request
    lo_response = HTTP_POST_MULTIPART( i_request_prop = ls_request_prop it_form_part = lt_form_part ).




    " retrieve JSON data
    lv_json = get_response_string( lo_response ).
    parse_json(
      exporting
        i_json       = lv_json
        i_dictionary = c_abapname_dictionary
      changing
        c_abap       = e_response ).

endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_COMPARE_COMPLY_V1->LIST_BATCHES
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_BATCHES
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_BATCHES.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/batches'.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








    " execute HTTP GET request
    lo_response = HTTP_GET( i_request_prop = ls_request_prop ).


    " retrieve JSON data
    lv_json = get_response_string( lo_response ).
    parse_json(
      exporting
        i_json       = lv_json
        i_dictionary = c_abapname_dictionary
      changing
        c_abap       = e_response ).

endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_COMPARE_COMPLY_V1->GET_BATCH
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_BATCH_ID        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_BATCH_STATUS
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_BATCH.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/batches/{batch_id}'.
    replace all occurrences of `{batch_id}` in ls_request_prop-url-path with i_BATCH_ID ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








    " execute HTTP GET request
    lo_response = HTTP_GET( i_request_prop = ls_request_prop ).


    " retrieve JSON data
    lv_json = get_response_string( lo_response ).
    parse_json(
      exporting
        i_json       = lv_json
        i_dictionary = c_abapname_dictionary
      changing
        c_abap       = e_response ).

endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_COMPARE_COMPLY_V1->UPDATE_BATCH
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_BATCH_ID        TYPE STRING
* | [--->] I_ACTION        TYPE STRING
* | [--->] I_MODEL        TYPE STRING(optional)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_BATCH_STATUS
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method UPDATE_BATCH.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/batches/{batch_id}'.
    replace all occurrences of `{batch_id}` in ls_request_prop-url-path with i_BATCH_ID ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    lv_queryparam = escape( val = i_ACTION format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `action`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.

    if i_MODEL is supplied.
    lv_queryparam = escape( val = i_MODEL format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `model`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.






    " execute HTTP PUT request
    lo_response = HTTP_PUT( i_request_prop = ls_request_prop ).


    " retrieve JSON data
    lv_json = get_response_string( lo_response ).
    parse_json(
      exporting
        i_json       = lv_json
        i_dictionary = c_abapname_dictionary
      changing
        c_abap       = e_response ).

endmethod.




* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method ZCL_IBMC_COMPARE_COMPLY_V1->SET_DEFAULT_QUERY_PARAMETERS
* +-------------------------------------------------------------------------------------------------+
* | [<-->] C_URL                          TYPE        TS_URL
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method set_default_query_parameters.
    if not p_version is initial.
      add_query_parameter(
        exporting
          i_parameter = `version`
          i_value     = p_version
        changing
          c_url       = c_url ).
    endif.
  endmethod.

ENDCLASS.
