* Copyright 2019 IBM Corp. All Rights Reserved.
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
"! <h1>Compare and Comply</h1>
"! IBM Watson&trade; Compare and Comply analyzes governing documents to provide
"!  details about critical aspects of the documents. <br/>
class ZCL_IBMC_COMPARE_COMPLY_V1 DEFINITION
  public
  inheriting from ZCL_IBMC_SERVICE_EXT
  create public .

public section.
  types:
    "!   The numeric location of the identified element in the document, represented with
    "!    two integers labeled `begin` and `end`.
    begin of T_LOCATION,
      BEGIN type LONG,
      END type LONG,
    end of T_LOCATION.
  types:
    "!   A pair of `nature` and `party` objects. The `nature` object identifies the
    "!    effect of the element on the identified `party`, and the `party` object
    "!    identifies the affected party.
    begin of T_LABEL,
      NATURE type STRING,
      PARTY type STRING,
    end of T_LABEL.
  types:
    "!   Identification of a specific type.
    begin of T_TYPE_LABEL_COMPARISON,
      LABEL type T_LABEL,
    end of T_TYPE_LABEL_COMPARISON.
  types:
    "!   The locations of each paragraph in the input document.
    begin of T_PARAGRAPHS,
      LOCATION type T_LOCATION,
    end of T_PARAGRAPHS.
  types:
    "!   Document counts.
    begin of T_DOC_COUNTS,
      TOTAL type INTEGER,
      PENDING type INTEGER,
      SUCCESSFUL type INTEGER,
      FAILED type INTEGER,
    end of T_DOC_COUNTS.
  types:
    "!   Identification of a specific type.
    begin of T_TYPE_LABEL,
      LABEL type T_LABEL,
      PROVENANCE_IDS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
    end of T_TYPE_LABEL.
  types:
    "!   Brief information about the input document.
    begin of T_SHORT_DOC,
      TITLE type STRING,
      HASH type STRING,
    end of T_SHORT_DOC.
  types:
    "!   Information defining an element's subject matter.
    begin of T_CATEGORY,
      LABEL type STRING,
      PROVENANCE_IDS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
    end of T_CATEGORY.
  types:
    "!   The original labeling from the input document, without the submitted feedback.
    begin of T_ORIGINAL_LABELS_OUT,
      TYPES type STANDARD TABLE OF T_TYPE_LABEL WITH NON-UNIQUE DEFAULT KEY,
      CATEGORIES type STANDARD TABLE OF T_CATEGORY WITH NON-UNIQUE DEFAULT KEY,
      MODIFICATION type STRING,
    end of T_ORIGINAL_LABELS_OUT.
  types:
    "!   The updated labeling from the input document, accounting for the submitted
    "!    feedback.
    begin of T_UPDATED_LABELS_OUT,
      TYPES type STANDARD TABLE OF T_TYPE_LABEL WITH NON-UNIQUE DEFAULT KEY,
      CATEGORIES type STANDARD TABLE OF T_CATEGORY WITH NON-UNIQUE DEFAULT KEY,
      MODIFICATION type STRING,
    end of T_UPDATED_LABELS_OUT.
  types:
    "!   Pagination details, if required by the length of the output.
    begin of T_PAGINATION,
      REFRESH_CURSOR type STRING,
      NEXT_CURSOR type STRING,
      REFRESH_URL type STRING,
      NEXT_URL type STRING,
      TOTAL type LONG,
    end of T_PAGINATION.
  types:
    "!   Information returned from the **Add Feedback** method.
    begin of T_FEEDBACK_DATA_OUTPUT,
      FEEDBACK_TYPE type STRING,
      DOCUMENT type T_SHORT_DOC,
      MODEL_ID type STRING,
      MODEL_VERSION type STRING,
      LOCATION type T_LOCATION,
      TEXT type STRING,
      ORIGINAL_LABELS type T_ORIGINAL_LABELS_OUT,
      UPDATED_LABELS type T_UPDATED_LABELS_OUT,
      PAGINATION type T_PAGINATION,
    end of T_FEEDBACK_DATA_OUTPUT.
  types:
    "!   List of document attributes.
    begin of T_ATTRIBUTE,
      TYPE type STRING,
      TEXT type STRING,
      LOCATION type T_LOCATION,
    end of T_ATTRIBUTE.
  types:
    "!   Information defining an element's subject matter.
    begin of T_CATEGORY_COMPARISON,
      LABEL type STRING,
    end of T_CATEGORY_COMPARISON.
  types:
    "!   Element that does not align semantically between two compared documents.
    begin of T_UNALIGNED_ELEMENT,
      DOCUMENT_LABEL type STRING,
      LOCATION type T_LOCATION,
      TEXT type STRING,
      TYPES type STANDARD TABLE OF T_TYPE_LABEL_COMPARISON WITH NON-UNIQUE DEFAULT KEY,
      CATEGORIES type STANDARD TABLE OF T_CATEGORY_COMPARISON WITH NON-UNIQUE DEFAULT KEY,
      ATTRIBUTES type STANDARD TABLE OF T_ATTRIBUTE WITH NON-UNIQUE DEFAULT KEY,
    end of T_UNALIGNED_ELEMENT.
  types:
    "!   The updated labeling from the input document, accounting for the submitted
    "!    feedback.
    begin of T_UPDATED_LABELS_IN,
      TYPES type STANDARD TABLE OF T_TYPE_LABEL WITH NON-UNIQUE DEFAULT KEY,
      CATEGORIES type STANDARD TABLE OF T_CATEGORY WITH NON-UNIQUE DEFAULT KEY,
    end of T_UPDATED_LABELS_IN.
  types:
    "!   An array that contains the `text` value of a row header that is applicable to
    "!    this body cell.
      T_ROW_HEADER_TEXTS type TT_String.
  types:
    "!   A list of `begin` and `end` indexes that indicate the locations of the elements
    "!    in the input document.
    begin of T_ELEMENT_LOCATIONS,
      BEGIN type INTEGER,
      END type INTEGER,
    end of T_ELEMENT_LOCATIONS.
  types:
    "!   The leading sentences in a section or subsection of the input document.
    begin of T_LEADING_SENTENCE,
      TEXT type STRING,
      LOCATION type T_LOCATION,
      ELEMENT_LOCATIONS type STANDARD TABLE OF T_ELEMENT_LOCATIONS WITH NON-UNIQUE DEFAULT KEY,
    end of T_LEADING_SENTENCE.
  types:
    "!   An array containing one object per section or subsection detected in the input
    "!    document. Sections and subsections are not nested; instead, they are flattened
    "!    out and can be placed back in order by using the `begin` and `end` values of
    "!    the element and the `level` value of the section.
    begin of T_SECTION_TITLES,
      TEXT type STRING,
      LOCATION type T_LOCATION,
      LEVEL type INTEGER,
      ELEMENT_LOCATIONS type STANDARD TABLE OF T_ELEMENT_LOCATIONS WITH NON-UNIQUE DEFAULT KEY,
    end of T_SECTION_TITLES.
  types:
    "!   The structure of the input document.
    begin of T_DOC_STRUCTURE,
      SECTION_TITLES type STANDARD TABLE OF T_SECTION_TITLES WITH NON-UNIQUE DEFAULT KEY,
      LEADING_SENTENCES type STANDARD TABLE OF T_LEADING_SENTENCE WITH NON-UNIQUE DEFAULT KEY,
      PARAGRAPHS type STANDARD TABLE OF T_PARAGRAPHS WITH NON-UNIQUE DEFAULT KEY,
    end of T_DOC_STRUCTURE.
  types:
    "!   If you provide customization input, the normalized version of the column header
    "!    texts according to the customization; otherwise, the same value as
    "!    `column_header_texts`.
      T_COLUMN_HEADER_TEXTS_NORM type TT_String.
  types:
    "!
    begin of T_ERROR_RESPONSE,
      CODE type INTEGER,
      ERROR type STRING,
    end of T_ERROR_RESPONSE.
  types:
    "!   A contact.
    begin of T_CONTACT,
      NAME type STRING,
      ROLE type STRING,
    end of T_CONTACT.
  types:
    "!   The table's section title, if identified.
    begin of T_SECTION_TITLE,
      TEXT type STRING,
      LOCATION type T_LOCATION,
    end of T_SECTION_TITLE.
  types:
    "!   Column-level cells, each applicable as a header to other cells in the same
    "!    column as itself, of the current table.
    begin of T_COLUMN_HEADERS,
      CELL_ID type STRING,
      LOCATION type JSONOBJECT,
      TEXT type STRING,
      TEXT_NORMALIZED type STRING,
      ROW_INDEX_BEGIN type LONG,
      ROW_INDEX_END type LONG,
      COLUMN_INDEX_BEGIN type LONG,
      COLUMN_INDEX_END type LONG,
    end of T_COLUMN_HEADERS.
  types:
    "!   Text that is related to the contents of the table and that precedes or follows
    "!    the current table.
    begin of T_CONTEXTS,
      TEXT type STRING,
      LOCATION type T_LOCATION,
    end of T_CONTEXTS.
  types:
    "!   If identified, the title or caption of the current table of the form `Table x.:
    "!    ...`. Empty when no title is identified. When exposed, the `title` is also
    "!    excluded from the `contexts` array of the same table.
    begin of T_TABLE_TITLE,
      LOCATION type T_LOCATION,
      TEXT type STRING,
    end of T_TABLE_TITLE.
  types:
    "!   Cells that are not table header, column header, or row header cells.
    begin of T_BODY_CELLS,
      CELL_ID type STRING,
      LOCATION type T_LOCATION,
      TEXT type STRING,
      ROW_INDEX_BEGIN type LONG,
      ROW_INDEX_END type LONG,
      COLUMN_INDEX_BEGIN type LONG,
      COLUMN_INDEX_END type LONG,
      ROW_HEADER_IDS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      ROW_HEADER_TEXTS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      ROW_HEADER_TEXTS_NORMALIZED type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      COLUMN_HEADER_IDS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      COLUMN_HEADER_TEXTS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      COLUMN_HEADER_TEXTS_NORMALIZED type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      ATTRIBUTES type STANDARD TABLE OF T_ATTRIBUTE WITH NON-UNIQUE DEFAULT KEY,
    end of T_BODY_CELLS.
  types:
    "!   A key in a key-value pair.
    begin of T_KEY,
      CELL_ID type STRING,
      LOCATION type T_LOCATION,
      TEXT type STRING,
    end of T_KEY.
  types:
    "!   A value in a key-value pair.
    begin of T_VALUE,
      CELL_ID type STRING,
      LOCATION type T_LOCATION,
      TEXT type STRING,
    end of T_VALUE.
  types:
    "!   Key-value pairs detected across cell boundaries.
    begin of T_KEY_VALUE_PAIR,
      KEY type T_KEY,
      VALUE type STANDARD TABLE OF T_VALUE WITH NON-UNIQUE DEFAULT KEY,
    end of T_KEY_VALUE_PAIR.
  types:
    "!   The contents of the current table's header.
    begin of T_TABLE_HEADERS,
      CELL_ID type STRING,
      LOCATION type JSONOBJECT,
      TEXT type STRING,
      ROW_INDEX_BEGIN type LONG,
      ROW_INDEX_END type LONG,
      COLUMN_INDEX_BEGIN type LONG,
      COLUMN_INDEX_END type LONG,
    end of T_TABLE_HEADERS.
  types:
    "!   Row-level cells, each applicable as a header to other cells in the same row as
    "!    itself, of the current table.
    begin of T_ROW_HEADERS,
      CELL_ID type STRING,
      LOCATION type T_LOCATION,
      TEXT type STRING,
      TEXT_NORMALIZED type STRING,
      ROW_INDEX_BEGIN type LONG,
      ROW_INDEX_END type LONG,
      COLUMN_INDEX_BEGIN type LONG,
      COLUMN_INDEX_END type LONG,
    end of T_ROW_HEADERS.
  types:
    "!   The contents of the tables extracted from a document.
    begin of T_TABLES,
      LOCATION type T_LOCATION,
      TEXT type STRING,
      SECTION_TITLE type T_SECTION_TITLE,
      TITLE type T_TABLE_TITLE,
      TABLE_HEADERS type STANDARD TABLE OF T_TABLE_HEADERS WITH NON-UNIQUE DEFAULT KEY,
      ROW_HEADERS type STANDARD TABLE OF T_ROW_HEADERS WITH NON-UNIQUE DEFAULT KEY,
      COLUMN_HEADERS type STANDARD TABLE OF T_COLUMN_HEADERS WITH NON-UNIQUE DEFAULT KEY,
      BODY_CELLS type STANDARD TABLE OF T_BODY_CELLS WITH NON-UNIQUE DEFAULT KEY,
      CONTEXTS type STANDARD TABLE OF T_CONTEXTS WITH NON-UNIQUE DEFAULT KEY,
      KEY_VALUE_PAIRS type STANDARD TABLE OF T_KEY_VALUE_PAIR WITH NON-UNIQUE DEFAULT KEY,
    end of T_TABLES.
  types:
    "!   Information about the parsed input document.
    begin of T_DOC_INFO,
      HTML type STRING,
      TITLE type STRING,
      HASH type STRING,
    end of T_DOC_INFO.
  types:
    "!   The analysis of the document's tables.
    begin of T_TABLE_RETURN,
      DOCUMENT type T_DOC_INFO,
      MODEL_ID type STRING,
      MODEL_VERSION type STRING,
      TABLES type STANDARD TABLE OF T_TABLES WITH NON-UNIQUE DEFAULT KEY,
    end of T_TABLE_RETURN.
  types:
    "!   Information about the document and the submitted feedback.
    begin of T_FEEDBACK_RETURN,
      FEEDBACK_ID type STRING,
      USER_ID type STRING,
      COMMENT type STRING,
      CREATED type DATETIME,
      FEEDBACK_DATA type T_FEEDBACK_DATA_OUTPUT,
    end of T_FEEDBACK_RETURN.
  types:
    "!   The details of the normalized text, if applicable. This element is optional; it
    "!    is returned only if normalized text exists.
    begin of T_INTERPRETATION,
      VALUE type STRING,
      NUMERIC_VALUE type NUMBER,
      UNIT type STRING,
    end of T_INTERPRETATION.
  types:
    "!   A monetary amount identified in the input document.
    begin of T_CONTRACT_AMTS,
      CONFIDENCE_LEVEL type STRING,
      TEXT type STRING,
      TEXT_NORMALIZED type STRING,
      INTERPRETATION type T_INTERPRETATION,
      PROVENANCE_IDS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      LOCATION type T_LOCATION,
    end of T_CONTRACT_AMTS.
  types:
    "!   The contract currencies that are declared in the document.
    begin of T_CONTRACT_CURRENCIES,
      CONFIDENCE_LEVEL type STRING,
      TEXT type STRING,
      TEXT_NORMALIZED type STRING,
      PROVENANCE_IDS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      LOCATION type T_LOCATION,
    end of T_CONTRACT_CURRENCIES.
  types:
    "!   The document's payment duration or durations.
    begin of T_PAYMENT_TERMS,
      CONFIDENCE_LEVEL type STRING,
      TEXT type STRING,
      TEXT_NORMALIZED type STRING,
      INTERPRETATION type T_INTERPRETATION,
      PROVENANCE_IDS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      LOCATION type T_LOCATION,
    end of T_PAYMENT_TERMS.
  types:
    "!   A component part of the document.
    begin of T_ELEMENT,
      LOCATION type T_LOCATION,
      TEXT type STRING,
      TYPES type STANDARD TABLE OF T_TYPE_LABEL WITH NON-UNIQUE DEFAULT KEY,
      CATEGORIES type STANDARD TABLE OF T_CATEGORY WITH NON-UNIQUE DEFAULT KEY,
      ATTRIBUTES type STANDARD TABLE OF T_ATTRIBUTE WITH NON-UNIQUE DEFAULT KEY,
    end of T_ELEMENT.
  types:
    "!   Termination dates identified in the input document.
    begin of T_TERMINATION_DATES,
      CONFIDENCE_LEVEL type STRING,
      TEXT type STRING,
      TEXT_NORMALIZED type STRING,
      PROVENANCE_IDS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      LOCATION type T_LOCATION,
    end of T_TERMINATION_DATES.
  types:
    "!   The contract type identified in the input document.
    begin of T_CONTRACT_TYPES,
      CONFIDENCE_LEVEL type STRING,
      TEXT type STRING,
      PROVENANCE_IDS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      LOCATION type T_LOCATION,
    end of T_CONTRACT_TYPES.
  types:
    "!   An effective date.
    begin of T_EFFECTIVE_DATES,
      CONFIDENCE_LEVEL type STRING,
      TEXT type STRING,
      TEXT_NORMALIZED type STRING,
      PROVENANCE_IDS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      LOCATION type T_LOCATION,
    end of T_EFFECTIVE_DATES.
  types:
    "!   A mention of a party.
    begin of T_MENTION,
      TEXT type STRING,
      LOCATION type T_LOCATION,
    end of T_MENTION.
  types:
    "!   A party's address.
    begin of T_ADDRESS,
      TEXT type STRING,
      LOCATION type T_LOCATION,
    end of T_ADDRESS.
  types:
    "!   A party and its corresponding role, including address and contact information if
    "!    identified.
    begin of T_PARTIES,
      PARTY type STRING,
      ROLE type STRING,
      IMPORTANCE type STRING,
      ADDRESSES type STANDARD TABLE OF T_ADDRESS WITH NON-UNIQUE DEFAULT KEY,
      CONTACTS type STANDARD TABLE OF T_CONTACT WITH NON-UNIQUE DEFAULT KEY,
      MENTIONS type STANDARD TABLE OF T_MENTION WITH NON-UNIQUE DEFAULT KEY,
    end of T_PARTIES.
  types:
    "!   Basic information about the input document.
    begin of T_DOCUMENT,
      TITLE type STRING,
      HTML type STRING,
      HASH type STRING,
      LABEL type STRING,
    end of T_DOCUMENT.
  types:
    "!   The duration or durations of the contract.
    begin of T_CONTRACT_TERMS,
      CONFIDENCE_LEVEL type STRING,
      TEXT type STRING,
      TEXT_NORMALIZED type STRING,
      INTERPRETATION type T_INTERPRETATION,
      PROVENANCE_IDS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      LOCATION type T_LOCATION,
    end of T_CONTRACT_TERMS.
  types:
    "!   The analysis of objects returned by the **Element classification** method.
    begin of T_CLASSIFY_RETURN,
      DOCUMENT type T_DOCUMENT,
      MODEL_ID type STRING,
      MODEL_VERSION type STRING,
      ELEMENTS type STANDARD TABLE OF T_ELEMENT WITH NON-UNIQUE DEFAULT KEY,
      EFFECTIVE_DATES type STANDARD TABLE OF T_EFFECTIVE_DATES WITH NON-UNIQUE DEFAULT KEY,
      CONTRACT_AMOUNTS type STANDARD TABLE OF T_CONTRACT_AMTS WITH NON-UNIQUE DEFAULT KEY,
      TERMINATION_DATES type STANDARD TABLE OF T_TERMINATION_DATES WITH NON-UNIQUE DEFAULT KEY,
      CONTRACT_TYPES type STANDARD TABLE OF T_CONTRACT_TYPES WITH NON-UNIQUE DEFAULT KEY,
      CONTRACT_TERMS type STANDARD TABLE OF T_CONTRACT_TERMS WITH NON-UNIQUE DEFAULT KEY,
      PAYMENT_TERMS type STANDARD TABLE OF T_PAYMENT_TERMS WITH NON-UNIQUE DEFAULT KEY,
      CONTRACT_CURRENCIES type STANDARD TABLE OF T_CONTRACT_CURRENCIES WITH NON-UNIQUE DEFAULT KEY,
      TABLES type STANDARD TABLE OF T_TABLES WITH NON-UNIQUE DEFAULT KEY,
      DOCUMENT_STRUCTURE type T_DOC_STRUCTURE,
      PARTIES type STANDARD TABLE OF T_PARTIES WITH NON-UNIQUE DEFAULT KEY,
    end of T_CLASSIFY_RETURN.
  types:
    "!   The original labeling from the input document, without the submitted feedback.
    begin of T_ORIGINAL_LABELS_IN,
      TYPES type STANDARD TABLE OF T_TYPE_LABEL WITH NON-UNIQUE DEFAULT KEY,
      CATEGORIES type STANDARD TABLE OF T_CATEGORY WITH NON-UNIQUE DEFAULT KEY,
    end of T_ORIGINAL_LABELS_IN.
  types:
    "!   Details of semantically aligned elements.
    begin of T_ELEMENT_PAIR,
      DOCUMENT_LABEL type STRING,
      TEXT type STRING,
      LOCATION type T_LOCATION,
      TYPES type STANDARD TABLE OF T_TYPE_LABEL_COMPARISON WITH NON-UNIQUE DEFAULT KEY,
      CATEGORIES type STANDARD TABLE OF T_CATEGORY_COMPARISON WITH NON-UNIQUE DEFAULT KEY,
      ATTRIBUTES type STANDARD TABLE OF T_ATTRIBUTE WITH NON-UNIQUE DEFAULT KEY,
    end of T_ELEMENT_PAIR.
  types:
    "!
    begin of T_ALIGNED_ELEMENT,
      ELEMENT_PAIR type STANDARD TABLE OF T_ELEMENT_PAIR WITH NON-UNIQUE DEFAULT KEY,
      IDENTICAL_TEXT type BOOLEAN,
      PROVENANCE_IDS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      SIGNIFICANT_ELEMENTS type BOOLEAN,
    end of T_ALIGNED_ELEMENT.
  types:
    "!   The comparison of the two submitted documents.
    begin of T_COMPARE_RETURN,
      MODEL_ID type STRING,
      MODEL_VERSION type STRING,
      DOCUMENTS type STANDARD TABLE OF T_DOCUMENT WITH NON-UNIQUE DEFAULT KEY,
      ALIGNED_ELEMENTS type STANDARD TABLE OF T_ALIGNED_ELEMENT WITH NON-UNIQUE DEFAULT KEY,
      UNALIGNED_ELEMENTS type STANDARD TABLE OF T_UNALIGNED_ELEMENT WITH NON-UNIQUE DEFAULT KEY,
    end of T_COMPARE_RETURN.
  types:
    "!   The HTML converted from an input document.
    begin of T_HTMLRETURN,
      NUM_PAGES type STRING,
      AUTHOR type STRING,
      PUBLICATION_DATE type STRING,
      TITLE type STRING,
      HTML type STRING,
    end of T_HTMLRETURN.
  types:
    "!   Feedback data for submission.
    begin of T_FEEDBACK_DATA_INPUT,
      FEEDBACK_TYPE type STRING,
      DOCUMENT type T_SHORT_DOC,
      MODEL_ID type STRING,
      MODEL_VERSION type STRING,
      LOCATION type T_LOCATION,
      TEXT type STRING,
      ORIGINAL_LABELS type T_ORIGINAL_LABELS_IN,
      UPDATED_LABELS type T_UPDATED_LABELS_IN,
    end of T_FEEDBACK_DATA_INPUT.
  types:
    "!   An array that contains the `id` value of a row header that is applicable to this
    "!    body cell.
      T_ROW_HEADER_IDS type TT_String.
  types:
    "!   The batch-request status.
    begin of T_BATCH_STATUS,
      FUNCTION type STRING,
      INPUT_BUCKET_LOCATION type STRING,
      INPUT_BUCKET_NAME type STRING,
      OUTPUT_BUCKET_LOCATION type STRING,
      OUTPUT_BUCKET_NAME type STRING,
      BATCH_ID type STRING,
      DOCUMENT_COUNTS type T_DOC_COUNTS,
      STATUS type STRING,
      CREATED type DATETIME,
      UPDATED type DATETIME,
    end of T_BATCH_STATUS.
  types:
    "!   The results of a successful **List Batches** request.
    begin of T_BATCHES,
      BATCHES type STANDARD TABLE OF T_BATCH_STATUS WITH NON-UNIQUE DEFAULT KEY,
    end of T_BATCHES.
  types:
    "!
    begin of T_INLINE_OBJECT,
      FILE type FILE,
    end of T_INLINE_OBJECT.
  types:
    "!   An array that contains the `id` value of a column header that is applicable to
    "!    the current cell.
      T_COLUMN_HEADER_IDS type TT_String.
  types:
    "!   If you provide customization input, the normalized version of the row header
    "!    texts according to the customization; otherwise, the same value as
    "!    `row_header_texts`.
      T_ROW_HEADER_TEXTS_NORMALIZED type TT_String.
  types:
    "!   An array that contains the `text` value of a column header that is applicable to
    "!    the current cell.
      T_COLUMN_HEADER_TEXTS type TT_String.
  types:
    "!   The status and message of the deletion request.
    begin of T_FEEDBACK_DELETED,
      STATUS type INTEGER,
      MESSAGE type STRING,
    end of T_FEEDBACK_DELETED.
  types:
    "!   The feedback to be added to an element in the document.
    begin of T_FEEDBACK_INPUT,
      USER_ID type STRING,
      COMMENT type STRING,
      FEEDBACK_DATA type T_FEEDBACK_DATA_INPUT,
    end of T_FEEDBACK_INPUT.
  types:
    "!
    begin of T_INLINE_OBJECT1,
      FILE type FILE,
    end of T_INLINE_OBJECT1.
  types:
    "!
    begin of T_INLINE_OBJECT2,
      FILE type FILE,
    end of T_INLINE_OBJECT2.
  types:
    "!
    begin of T_INLINE_OBJECT3,
      FILE_1 type FILE,
      FILE_2 type FILE,
    end of T_INLINE_OBJECT3.
  types:
    "!
    begin of T_INLINE_OBJECT4,
      INPUT_CREDENTIALS_FILE type FILE,
      INPUT_BUCKET_LOCATION type STRING,
      INPUT_BUCKET_NAME type STRING,
      OUTPUT_CREDENTIALS_FILE type FILE,
      OUTPUT_BUCKET_LOCATION type STRING,
      OUTPUT_BUCKET_NAME type STRING,
    end of T_INLINE_OBJECT4.
  types:
    "!   The results of a successful **Get Feedback** request for a single feedback
    "!    entry.
    begin of T_GET_FEEDBACK,
      FEEDBACK_ID type STRING,
      CREATED type DATETIME,
      COMMENT type STRING,
      FEEDBACK_DATA type T_FEEDBACK_DATA_OUTPUT,
    end of T_GET_FEEDBACK.
  types:
    "!   The results of a successful **List Feedback** request for all feedback.
    begin of T_FEEDBACK_LIST,
      FEEDBACK type STANDARD TABLE OF T_GET_FEEDBACK WITH NON-UNIQUE DEFAULT KEY,
    end of T_FEEDBACK_LIST.
  types:
    "!   A list of values in a key-value pair.
      T_VALUES type STANDARD TABLE OF T_VALUE WITH NON-UNIQUE DEFAULT KEY.

constants:
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


    "! Convert document to HTML.
    "!
    "! @parameter I_file |
    "!   The document to convert.
    "! @parameter I_file_content_type |
    "!   The content type of file.
    "! @parameter I_model |
    "!   The analysis model to be used by the service. For the **Element classification**
    "!    and **Compare two documents** methods, the default is `contracts`. For the
    "!    **Extract tables** method, the default is `tables`. These defaults apply to the
    "!    standalone methods as well as to the methods' use in batch-processing requests.
    "!
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_HTMLRETURN
    "!
  methods CONVERT_TO_HTML
    importing
      !I_file type FILE
      !I_file_content_type type STRING optional
      !I_model type STRING optional
      !I_contenttype type string default 'multipart/form-data'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_HTMLRETURN
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! Classify the elements of a document.
    "!
    "! @parameter I_file |
    "!   The document to classify.
    "! @parameter I_file_content_type |
    "!   The content type of file.
    "! @parameter I_model |
    "!   The analysis model to be used by the service. For the **Element classification**
    "!    and **Compare two documents** methods, the default is `contracts`. For the
    "!    **Extract tables** method, the default is `tables`. These defaults apply to the
    "!    standalone methods as well as to the methods' use in batch-processing requests.
    "!
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_CLASSIFY_RETURN
    "!
  methods CLASSIFY_ELEMENTS
    importing
      !I_file type FILE
      !I_file_content_type type STRING optional
      !I_model type STRING optional
      !I_contenttype type string default 'multipart/form-data'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_CLASSIFY_RETURN
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! Extract a document's tables.
    "!
    "! @parameter I_file |
    "!   The document on which to run table extraction.
    "! @parameter I_file_content_type |
    "!   The content type of file.
    "! @parameter I_model |
    "!   The analysis model to be used by the service. For the **Element classification**
    "!    and **Compare two documents** methods, the default is `contracts`. For the
    "!    **Extract tables** method, the default is `tables`. These defaults apply to the
    "!    standalone methods as well as to the methods' use in batch-processing requests.
    "!
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_TABLE_RETURN
    "!
  methods EXTRACT_TABLES
    importing
      !I_file type FILE
      !I_file_content_type type STRING optional
      !I_model type STRING optional
      !I_contenttype type string default 'multipart/form-data'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_TABLE_RETURN
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! Compare two documents.
    "!
    "! @parameter I_file_1 |
    "!   The first document to compare.
    "! @parameter I_file_2 |
    "!   The second document to compare.
    "! @parameter I_file_1_content_type |
    "!   The content type of file1.
    "! @parameter I_file_2_content_type |
    "!   The content type of file2.
    "! @parameter I_file_1_label |
    "!   A text label for the first document.
    "! @parameter I_file_2_label |
    "!   A text label for the second document.
    "! @parameter I_model |
    "!   The analysis model to be used by the service. For the **Element classification**
    "!    and **Compare two documents** methods, the default is `contracts`. For the
    "!    **Extract tables** method, the default is `tables`. These defaults apply to the
    "!    standalone methods as well as to the methods' use in batch-processing requests.
    "!
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_COMPARE_RETURN
    "!
  methods COMPARE_DOCUMENTS
    importing
      !I_file_1 type FILE
      !I_file_2 type FILE
      !I_file_1_content_type type STRING optional
      !I_file_2_content_type type STRING optional
      !I_file_1_label type STRING default 'file_1'
      !I_file_2_label type STRING default 'file_2'
      !I_model type STRING optional
      !I_contenttype type string default 'multipart/form-data'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_COMPARE_RETURN
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! Add feedback.
    "!
    "! @parameter I_feedback_data |
    "!   An object that defines the feedback to be submitted.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_FEEDBACK_RETURN
    "!
  methods ADD_FEEDBACK
    importing
      !I_feedback_data type T_FEEDBACK_INPUT
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_FEEDBACK_RETURN
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! List the feedback in a document.
    "!
    "! @parameter I_feedback_type |
    "!   An optional string that filters the output to include only feedback with the
    "!    specified feedback type. The only permitted value is `element_classification`.
    "! @parameter I_before |
    "!   An optional string in the format `YYYY-MM-DD` that filters the output to include
    "!    only feedback that was added before the specified date.
    "! @parameter I_after |
    "!   An optional string in the format `YYYY-MM-DD` that filters the output to include
    "!    only feedback that was added after the specified date.
    "! @parameter I_document_title |
    "!   An optional string that filters the output to include only feedback from the
    "!    document with the specified `document_title`.
    "! @parameter I_model_id |
    "!   An optional string that filters the output to include only feedback with the
    "!    specified `model_id`. The only permitted value is `contracts`.
    "! @parameter I_model_version |
    "!   An optional string that filters the output to include only feedback with the
    "!    specified `model_version`.
    "! @parameter I_category_removed |
    "!   An optional string in the form of a comma-separated list of categories. If it is
    "!    specified, the service filters the output to include only feedback that has at
    "!    least one category from the list removed.
    "! @parameter I_category_added |
    "!   An optional string in the form of a comma-separated list of categories. If this
    "!    is specified, the service filters the output to include only feedback that has
    "!    at least one category from the list added.
    "! @parameter I_category_not_changed |
    "!   An optional string in the form of a comma-separated list of categories. If this
    "!    is specified, the service filters the output to include only feedback that has
    "!    at least one category from the list unchanged.
    "! @parameter I_type_removed |
    "!   An optional string of comma-separated `nature`:`party` pairs. If this is
    "!    specified, the service filters the output to include only feedback that has at
    "!    least one `nature`:`party` pair from the list removed.
    "! @parameter I_type_added |
    "!   An optional string of comma-separated `nature`:`party` pairs. If this is
    "!    specified, the service filters the output to include only feedback that has at
    "!    least one `nature`:`party` pair from the list removed.
    "! @parameter I_type_not_changed |
    "!   An optional string of comma-separated `nature`:`party` pairs. If this is
    "!    specified, the service filters the output to include only feedback that has at
    "!    least one `nature`:`party` pair from the list unchanged.
    "! @parameter I_page_limit |
    "!   An optional integer specifying the number of documents that you want the service
    "!    to return.
    "! @parameter I_cursor |
    "!   An optional string that returns the set of documents after the previous set. Use
    "!    this parameter with the `page_limit` parameter.
    "! @parameter I_sort |
    "!   An optional comma-separated list of fields in the document to sort on. You can
    "!    optionally specify the sort direction by prefixing the value of the field with
    "!    `-` for descending order or `+` for ascending order (the default). Currently
    "!    permitted sorting fields are `created`, `user_id`, and `document_title`.
    "! @parameter I_include_total |
    "!   An optional boolean value. If specified as `true`, the `pagination` object in
    "!    the output includes a value called `total` that gives the total count of
    "!    feedback created.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_FEEDBACK_LIST
    "!
  methods LIST_FEEDBACK
    importing
      !I_feedback_type type STRING optional
      !I_before type DATE optional
      !I_after type DATE optional
      !I_document_title type STRING optional
      !I_model_id type STRING optional
      !I_model_version type STRING optional
      !I_category_removed type STRING optional
      !I_category_added type STRING optional
      !I_category_not_changed type STRING optional
      !I_type_removed type STRING optional
      !I_type_added type STRING optional
      !I_type_not_changed type STRING optional
      !I_page_limit type INTEGER optional
      !I_cursor type STRING optional
      !I_sort type STRING optional
      !I_include_total type BOOLEAN optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_FEEDBACK_LIST
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Get a specified feedback entry.
    "!
    "! @parameter I_feedback_id |
    "!   A string that specifies the feedback entry to be included in the output.
    "! @parameter I_model |
    "!   The analysis model to be used by the service. For the **Element classification**
    "!    and **Compare two documents** methods, the default is `contracts`. For the
    "!    **Extract tables** method, the default is `tables`. These defaults apply to the
    "!    standalone methods as well as to the methods' use in batch-processing requests.
    "!
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_GET_FEEDBACK
    "!
  methods GET_FEEDBACK
    importing
      !I_feedback_id type STRING
      !I_model type STRING optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_GET_FEEDBACK
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Delete a specified feedback entry.
    "!
    "! @parameter I_feedback_id |
    "!   A string that specifies the feedback entry to be deleted from the document.
    "! @parameter I_model |
    "!   The analysis model to be used by the service. For the **Element classification**
    "!    and **Compare two documents** methods, the default is `contracts`. For the
    "!    **Extract tables** method, the default is `tables`. These defaults apply to the
    "!    standalone methods as well as to the methods' use in batch-processing requests.
    "!
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_FEEDBACK_DELETED
    "!
  methods DELETE_FEEDBACK
    importing
      !I_feedback_id type STRING
      !I_model type STRING optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_FEEDBACK_DELETED
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! Submit a batch-processing request.
    "!
    "! @parameter I_function |
    "!   The Compare and Comply method to run across the submitted input documents.
    "! @parameter I_input_credentials_file |
    "!   A JSON file containing the input Cloud Object Storage credentials. At a minimum,
    "!    the credentials must enable `READ` permissions on the bucket defined by the
    "!    `input_bucket_name` parameter.
    "! @parameter I_input_bucket_location |
    "!   The geographical location of the Cloud Object Storage input bucket as listed on
    "!    the **Endpoint** tab of your Cloud Object Storage instance; for example,
    "!    `us-geo`, `eu-geo`, or `ap-geo`.
    "! @parameter I_input_bucket_name |
    "!   The name of the Cloud Object Storage input bucket.
    "! @parameter I_output_credentials_file |
    "!   A JSON file that lists the Cloud Object Storage output credentials. At a
    "!    minimum, the credentials must enable `READ` and `WRITE` permissions on the
    "!    bucket defined by the `output_bucket_name` parameter.
    "! @parameter I_output_bucket_location |
    "!   The geographical location of the Cloud Object Storage output bucket as listed on
    "!    the **Endpoint** tab of your Cloud Object Storage instance; for example,
    "!    `us-geo`, `eu-geo`, or `ap-geo`.
    "! @parameter I_output_bucket_name |
    "!   The name of the Cloud Object Storage output bucket.
    "! @parameter I_model |
    "!   The analysis model to be used by the service. For the **Element classification**
    "!    and **Compare two documents** methods, the default is `contracts`. For the
    "!    **Extract tables** method, the default is `tables`. These defaults apply to the
    "!    standalone methods as well as to the methods' use in batch-processing requests.
    "!
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_BATCH_STATUS
    "!
  methods CREATE_BATCH
    importing
      !I_function type STRING
      !I_input_credentials_file type FILE
      !I_input_bucket_location type STRING
      !I_input_bucket_name type STRING
      !I_output_credentials_file type FILE
      !I_output_bucket_location type STRING
      !I_output_bucket_name type STRING
      !I_model type STRING optional
      !I_input_credentials_file_CT type STRING default ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-ALL
      !I_output_credentials_file_CT type STRING default ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-ALL
      !I_contenttype type string default 'multipart/form-data'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_BATCH_STATUS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! List submitted batch-processing jobs.
    "!
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_BATCHES
    "!
  methods LIST_BATCHES
    importing
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_BATCHES
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Get information about a specific batch-processing job.
    "!
    "! @parameter I_batch_id |
    "!   The ID of the batch-processing job whose information you want to retrieve.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_BATCH_STATUS
    "!
  methods GET_BATCH
    importing
      !I_batch_id type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_BATCH_STATUS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Update a pending or active batch-processing job.
    "!
    "! @parameter I_batch_id |
    "!   The ID of the batch-processing job you want to update.
    "! @parameter I_action |
    "!   The action you want to perform on the specified batch-processing job.
    "! @parameter I_model |
    "!   The analysis model to be used by the service. For the **Element classification**
    "!    and **Compare two documents** methods, the default is `contracts`. For the
    "!    **Extract tables** method, the default is `tables`. These defaults apply to the
    "!    standalone methods as well as to the methods' use in batch-processing requests.
    "!
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_BATCH_STATUS
    "!
  methods UPDATE_BATCH
    importing
      !I_batch_id type STRING
      !I_action type STRING
      !I_model type STRING optional
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

  e_request_prop = super->get_request_prop( ).

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

    e_sdk_version_date = '20191002122838'.

  endmethod.



* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_COMPARE_COMPLY_V1->CONVERT_TO_HTML
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_file        TYPE FILE
* | [--->] I_file_content_type        TYPE STRING(optional)
* | [--->] I_model        TYPE STRING(optional)
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

    if i_model is supplied.
    lv_queryparam = escape( val = i_model format = cl_abap_format=>e_uri_full ).
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




    if not i_file is initial.
      lv_extension = get_file_extension( I_file_content_type ).
      lv_value = `form-data; name="file"; filename="file` && lv_index && `.` && lv_extension && `"`  ##NO_TEXT.
      lv_index = lv_index + 1.
      clear ls_form_part.
      ls_form_part-content_type = I_file_content_type.
      ls_form_part-content_disposition = lv_value.
      ls_form_part-xdata = i_file.
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
* | [--->] I_file        TYPE FILE
* | [--->] I_file_content_type        TYPE STRING(optional)
* | [--->] I_model        TYPE STRING(optional)
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

    if i_model is supplied.
    lv_queryparam = escape( val = i_model format = cl_abap_format=>e_uri_full ).
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




    if not i_file is initial.
      lv_extension = get_file_extension( I_file_content_type ).
      lv_value = `form-data; name="file"; filename="file` && lv_index && `.` && lv_extension && `"`  ##NO_TEXT.
      lv_index = lv_index + 1.
      clear ls_form_part.
      ls_form_part-content_type = I_file_content_type.
      ls_form_part-content_disposition = lv_value.
      ls_form_part-xdata = i_file.
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
* | [--->] I_file        TYPE FILE
* | [--->] I_file_content_type        TYPE STRING(optional)
* | [--->] I_model        TYPE STRING(optional)
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

    if i_model is supplied.
    lv_queryparam = escape( val = i_model format = cl_abap_format=>e_uri_full ).
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




    if not i_file is initial.
      lv_extension = get_file_extension( I_file_content_type ).
      lv_value = `form-data; name="file"; filename="file` && lv_index && `.` && lv_extension && `"`  ##NO_TEXT.
      lv_index = lv_index + 1.
      clear ls_form_part.
      ls_form_part-content_type = I_file_content_type.
      ls_form_part-content_disposition = lv_value.
      ls_form_part-xdata = i_file.
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
* | [--->] I_file_1        TYPE FILE
* | [--->] I_file_2        TYPE FILE
* | [--->] I_file_1_content_type        TYPE STRING(optional)
* | [--->] I_file_2_content_type        TYPE STRING(optional)
* | [--->] I_file_1_label        TYPE STRING (default ='file_1')
* | [--->] I_file_2_label        TYPE STRING (default ='file_2')
* | [--->] I_model        TYPE STRING(optional)
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

    if i_file_1_label is supplied.
    lv_queryparam = escape( val = i_file_1_label format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `file_1_label`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_file_2_label is supplied.
    lv_queryparam = escape( val = i_file_2_label format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `file_2_label`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_model is supplied.
    lv_queryparam = escape( val = i_model format = cl_abap_format=>e_uri_full ).
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




    if not i_file_1 is initial.
      lv_extension = get_file_extension( I_file_1_content_type ).
      lv_value = `form-data; name="file_1"; filename="file` && lv_index && `.` && lv_extension && `"`  ##NO_TEXT.
      lv_index = lv_index + 1.
      clear ls_form_part.
      ls_form_part-content_type = I_file_1_content_type.
      ls_form_part-content_disposition = lv_value.
      ls_form_part-xdata = i_file_1.
      append ls_form_part to lt_form_part.
    endif.

    if not i_file_2 is initial.
      lv_extension = get_file_extension( I_file_2_content_type ).
      lv_value = `form-data; name="file_2"; filename="file` && lv_index && `.` && lv_extension && `"`  ##NO_TEXT.
      lv_index = lv_index + 1.
      clear ls_form_part.
      ls_form_part-content_type = I_file_2_content_type.
      ls_form_part-content_disposition = lv_value.
      ls_form_part-xdata = i_file_2.
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
* | [--->] I_feedback_data        TYPE T_FEEDBACK_INPUT
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
    lv_datatype = get_datatype( i_feedback_data ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_feedback_data i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'feedback_data' i_value = i_feedback_data ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_feedback_data to <lv_text>.
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
* | [--->] I_feedback_type        TYPE STRING(optional)
* | [--->] I_before        TYPE DATE(optional)
* | [--->] I_after        TYPE DATE(optional)
* | [--->] I_document_title        TYPE STRING(optional)
* | [--->] I_model_id        TYPE STRING(optional)
* | [--->] I_model_version        TYPE STRING(optional)
* | [--->] I_category_removed        TYPE STRING(optional)
* | [--->] I_category_added        TYPE STRING(optional)
* | [--->] I_category_not_changed        TYPE STRING(optional)
* | [--->] I_type_removed        TYPE STRING(optional)
* | [--->] I_type_added        TYPE STRING(optional)
* | [--->] I_type_not_changed        TYPE STRING(optional)
* | [--->] I_page_limit        TYPE INTEGER(optional)
* | [--->] I_cursor        TYPE STRING(optional)
* | [--->] I_sort        TYPE STRING(optional)
* | [--->] I_include_total        TYPE BOOLEAN(optional)
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

    if i_feedback_type is supplied.
    lv_queryparam = escape( val = i_feedback_type format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `feedback_type`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_before is supplied.
    lv_queryparam = i_before.
    add_query_parameter(
      exporting
        i_parameter  = `before`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_after is supplied.
    lv_queryparam = i_after.
    add_query_parameter(
      exporting
        i_parameter  = `after`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_document_title is supplied.
    lv_queryparam = escape( val = i_document_title format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `document_title`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_model_id is supplied.
    lv_queryparam = escape( val = i_model_id format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `model_id`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_model_version is supplied.
    lv_queryparam = escape( val = i_model_version format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `model_version`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_category_removed is supplied.
    lv_queryparam = escape( val = i_category_removed format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `category_removed`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_category_added is supplied.
    lv_queryparam = escape( val = i_category_added format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `category_added`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_category_not_changed is supplied.
    lv_queryparam = escape( val = i_category_not_changed format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `category_not_changed`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_type_removed is supplied.
    lv_queryparam = escape( val = i_type_removed format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `type_removed`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_type_added is supplied.
    lv_queryparam = escape( val = i_type_added format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `type_added`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_type_not_changed is supplied.
    lv_queryparam = escape( val = i_type_not_changed format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `type_not_changed`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_page_limit is supplied.
    lv_queryparam = i_page_limit.
    add_query_parameter(
      exporting
        i_parameter  = `page_limit`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_cursor is supplied.
    lv_queryparam = escape( val = i_cursor format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `cursor`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_sort is supplied.
    lv_queryparam = escape( val = i_sort format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `sort`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_include_total is supplied.
    lv_queryparam = i_include_total.
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
* | [--->] I_feedback_id        TYPE STRING
* | [--->] I_model        TYPE STRING(optional)
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
    replace all occurrences of `{feedback_id}` in ls_request_prop-url-path with i_feedback_id ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_model is supplied.
    lv_queryparam = escape( val = i_model format = cl_abap_format=>e_uri_full ).
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
* | [--->] I_feedback_id        TYPE STRING
* | [--->] I_model        TYPE STRING(optional)
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
    replace all occurrences of `{feedback_id}` in ls_request_prop-url-path with i_feedback_id ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_model is supplied.
    lv_queryparam = escape( val = i_model format = cl_abap_format=>e_uri_full ).
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
* | [--->] I_function        TYPE STRING
* | [--->] I_input_credentials_file        TYPE FILE
* | [--->] I_input_bucket_location        TYPE STRING
* | [--->] I_input_bucket_name        TYPE STRING
* | [--->] I_output_credentials_file        TYPE FILE
* | [--->] I_output_bucket_location        TYPE STRING
* | [--->] I_output_bucket_name        TYPE STRING
* | [--->] I_model        TYPE STRING(optional)
* | [--->] I_input_credentials_file_CT     TYPE STRING (default = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-all)
* | [--->] I_output_credentials_file_CT     TYPE STRING (default = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-all)
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

    lv_queryparam = escape( val = i_function format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `function`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.

    if i_model is supplied.
    lv_queryparam = escape( val = i_model format = cl_abap_format=>e_uri_full ).
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


    if not i_input_bucket_location is initial.
      clear ls_form_part.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      ls_form_part-content_disposition = 'form-data; name="input_bucket_location"'  ##NO_TEXT.
      lv_formdata = i_input_bucket_location.
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.

    if not i_input_bucket_name is initial.
      clear ls_form_part.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      ls_form_part-content_disposition = 'form-data; name="input_bucket_name"'  ##NO_TEXT.
      lv_formdata = i_input_bucket_name.
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.

    if not i_output_bucket_location is initial.
      clear ls_form_part.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      ls_form_part-content_disposition = 'form-data; name="output_bucket_location"'  ##NO_TEXT.
      lv_formdata = i_output_bucket_location.
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.

    if not i_output_bucket_name is initial.
      clear ls_form_part.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      ls_form_part-content_disposition = 'form-data; name="output_bucket_name"'  ##NO_TEXT.
      lv_formdata = i_output_bucket_name.
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.



    if not i_input_credentials_file is initial.
      lv_extension = get_file_extension( I_input_credentials_file_CT ).
      lv_value = `form-data; name="input_credentials_file"; filename="file` && lv_index && `.` && lv_extension && `"`  ##NO_TEXT.
      lv_index = lv_index + 1.
      clear ls_form_part.
      ls_form_part-content_type = I_input_credentials_file_CT.
      ls_form_part-content_disposition = lv_value.
      ls_form_part-xdata = i_input_credentials_file.
      append ls_form_part to lt_form_part.
    endif.

    if not i_output_credentials_file is initial.
      lv_extension = get_file_extension( I_output_credentials_file_CT ).
      lv_value = `form-data; name="output_credentials_file"; filename="file` && lv_index && `.` && lv_extension && `"`  ##NO_TEXT.
      lv_index = lv_index + 1.
      clear ls_form_part.
      ls_form_part-content_type = I_output_credentials_file_CT.
      ls_form_part-content_disposition = lv_value.
      ls_form_part-xdata = i_output_credentials_file.
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
* | [--->] I_batch_id        TYPE STRING
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
    replace all occurrences of `{batch_id}` in ls_request_prop-url-path with i_batch_id ignoring case.

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
* | [--->] I_batch_id        TYPE STRING
* | [--->] I_action        TYPE STRING
* | [--->] I_model        TYPE STRING(optional)
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
    replace all occurrences of `{batch_id}` in ls_request_prop-url-path with i_batch_id ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    lv_queryparam = escape( val = i_action format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `action`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.

    if i_model is supplied.
    lv_queryparam = escape( val = i_model format = cl_abap_format=>e_uri_full ).
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
