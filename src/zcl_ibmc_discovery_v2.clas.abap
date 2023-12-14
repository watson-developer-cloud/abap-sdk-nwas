* Copyright 2019, 2023 IBM Corp. All Rights Reserved.
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
"! <p class="shorttext synchronized" lang="en">Discovery v2</p>
"! IBM Watson&reg; Discovery is a cognitive search and content analytics engine
"!  that you can add to applications to identify patterns, trends and actionable
"!  insights to drive better decision-making. Securely unify structured and
"!  unstructured data with pre-enriched content, and use a simplified query
"!  language to eliminate the need for manual filtering of results. <br/>
class ZCL_IBMC_DISCOVERY_V2 DEFINITION
  public
  inheriting from ZCL_IBMC_SERVICE_EXT
  create public .

public section.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A macro-average computes metric independently for each class</p>
    "!     and then takes the average. Class refers to the classification label that is
    "!     specified in the **answer_field**.
    begin of T_MDL_EVALUATION_MACRO_AVERAGE,
      "!   A metric that measures how many of the overall documents are classified
      "!    correctly.
      PRECISION type DOUBLE,
      "!   A metric that measures how often documents that should be classified into
      "!    certain classes are classified into those classes.
      RECALL type DOUBLE,
      "!   A metric that measures whether the optimal balance between precision and recall
      "!    is reached. The F1 score can be interpreted as a weighted average of the
      "!    precision and recall values. An F1 score reaches its best value at 1 and worst
      "!    value at 0.
      F1 type DOUBLE,
    end of T_MDL_EVALUATION_MACRO_AVERAGE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object that measures the metrics from a training run for</p>
    "!     each classification label separately.
    begin of T_PER_CLASS_MODEL_EVALUATION,
      "!   Class name. Each class name is derived from a value in the **answer_field**.
      NAME type STRING,
      "!   A metric that measures how many of the overall documents are classified
      "!    correctly.
      PRECISION type DOUBLE,
      "!   A metric that measures how often documents that should be classified into
      "!    certain classes are classified into those classes.
      RECALL type DOUBLE,
      "!   A metric that measures whether the optimal balance between precision and recall
      "!    is reached. The F1 score can be interpreted as a weighted average of the
      "!    precision and recall values. An F1 score reaches its best value at 1 and worst
      "!    value at 0.
      F1 type DOUBLE,
    end of T_PER_CLASS_MODEL_EVALUATION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A micro-average aggregates the contributions of all classes</p>
    "!     to compute the average metric. Classes refers to the classification labels that
    "!     are specified in the **answer_field**.
    begin of T_MDL_EVALUATION_MICRO_AVERAGE,
      "!   A metric that measures how many of the overall documents are classified
      "!    correctly.
      PRECISION type DOUBLE,
      "!   A metric that measures how often documents that should be classified into
      "!    certain classes are classified into those classes.
      RECALL type DOUBLE,
      "!   A metric that measures whether the optimal balance between precision and recall
      "!    is reached. The F1 score can be interpreted as a weighted average of the
      "!    precision and recall values. An F1 score reaches its best value at 1 and worst
      "!    value at 0.
      F1 type DOUBLE,
    end of T_MDL_EVALUATION_MICRO_AVERAGE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object that contains information about a trained document</p>
    "!     classifier model.
    begin of T_CLASSIFIER_MODEL_EVALUATION,
      "!   A micro-average aggregates the contributions of all classes to compute the
      "!    average metric. Classes refers to the classification labels that are specified
      "!    in the **answer_field**.
      MICRO_AVERAGE type T_MDL_EVALUATION_MICRO_AVERAGE,
      "!   A macro-average computes metric independently for each class and then takes the
      "!    average. Class refers to the classification label that is specified in the
      "!    **answer_field**.
      MACRO_AVERAGE type T_MDL_EVALUATION_MACRO_AVERAGE,
      "!   An array of evaluation metrics, one set of metrics for each class, where class
      "!    refers to the classification label that is specified in the **answer_field**.
      PER_CLASS type STANDARD TABLE OF T_PER_CLASS_MODEL_EVALUATION WITH NON-UNIQUE DEFAULT KEY,
    end of T_CLASSIFIER_MODEL_EVALUATION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about a document classifier model.</p>
    begin of T_DOCUMENT_CLASSIFIER_MODEL,
      "!   A unique identifier of the document classifier model.
      MODEL_ID type STRING,
      "!   A human-readable name of the document classifier model.
      NAME type STRING,
      "!   A description of the document classifier model.
      DESCRIPTION type STRING,
      "!   The date that the document classifier model was created.
      CREATED type DATETIME,
      "!   The date that the document classifier model was last updated.
      UPDATED type DATETIME,
      "!   Name of the CSV file that contains the training data that is used to train the
      "!    document classifier model.
      TRAINING_DATA_FILE type STRING,
      "!   Name of the CSV file that contains data that is used to test the document
      "!    classifier model. If no test data is provided, a subset of the training data is
      "!    used for testing purposes.
      TEST_DATA_FILE type STRING,
      "!   The status of the training run.
      STATUS type STRING,
      "!   An object that contains information about a trained document classifier model.
      EVALUATION type T_CLASSIFIER_MODEL_EVALUATION,
      "!   A unique identifier of the enrichment that is generated by this document
      "!    classifier model.
      ENRICHMENT_ID type STRING,
      "!   The date that the document classifier model was deployed.
      DEPLOYED_AT type DATETIME,
    end of T_DOCUMENT_CLASSIFIER_MODEL.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Relevancy training status information for this project.</p>
    begin of T_PRJCT_LST_DTLS_RLVNCY_TRNNG1,
      "!   When the training data was updated.
      DATA_UPDATED type STRING,
      "!   The total number of examples.
      TOTAL_EXAMPLES type INTEGER,
      "!   When `true`, sufficient label diversity is present to allow training for this
      "!    project.
      SUFFICIENT_LABEL_DIVERSITY type BOOLEAN,
      "!   When `true`, the relevancy training is in processing.
      PROCESSING type BOOLEAN,
      "!   When `true`, the minimum number of examples required to train has been met.
      MINIMUM_EXAMPLES_ADDED type BOOLEAN,
      "!   The time that the most recent successful training occurred.
      SUCCESSFULLY_TRAINED type STRING,
      "!   When `true`, relevancy training is available when querying collections in the
      "!    project.
      AVAILABLE type BOOLEAN,
      "!   The number of notices generated during the relevancy training.
      NOTICES type INTEGER,
      "!   When `true`, the minimum number of queries required to train has been met.
      MINIMUM_QUERIES_ADDED type BOOLEAN,
    end of T_PRJCT_LST_DTLS_RLVNCY_TRNNG1.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Details about a specific project.</p>
    begin of T_PROJECT_LIST_DETAILS,
      "!   The unique identifier of this project.
      PROJECT_ID type STRING,
      "!   The human readable name of this project.
      NAME type STRING,
      "!   The type of project.<br/>
      "!   <br/>
      "!   The `content_intelligence` type is a *Document Retrieval for Contracts* project
      "!    and the `other` type is a *Custom* project.<br/>
      "!   <br/>
      "!   The `content_mining` and `content_intelligence` types are available with Premium
      "!    plan managed deployments and installed deployments only.
      TYPE type STRING,
      "!   Relevancy training status information for this project.
      RELEVANCY_TRAINING_STATUS type T_PRJCT_LST_DTLS_RLVNCY_TRNNG1,
      "!   The number of collections configured in this project.
      COLLECTION_COUNT type INTEGER,
    end of T_PROJECT_LIST_DETAILS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A list of projects in this instance.</p>
    begin of T_LIST_PROJECTS_RESPONSE,
      "!   An array of project details.
      PROJECTS type STANDARD TABLE OF T_PROJECT_LIST_DETAILS WITH NON-UNIQUE DEFAULT KEY,
    end of T_LIST_PROJECTS_RESPONSE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Result for the `pair` aggregation.</p>
    begin of T_QUERY_PAIR_AGGR_RESULT,
      "!   Array of subaggregations of type `term`, `group_by`, `histogram`, or
      "!    `timeslice`. Each element of the matrix that is returned contains a
      "!    **relevancy** value that is calculated from the combination of each value from
      "!    the first and second aggregations.
      AGGREGATIONS type STANDARD TABLE OF JSONOBJECT WITH NON-UNIQUE DEFAULT KEY,
    end of T_QUERY_PAIR_AGGR_RESULT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Calculates relevancy values using combinations of document</p>
    "!     sets from results of the specified pair of aggregations.
    begin of T_QUERY_AGGR_QUERY_PAIR_AGGR,
      "!   Specifies that the aggregation type is `pair`.
      TYPE type STRING,
      "!   Specifies the first aggregation in the pair. The aggregation must be a `term`,
      "!    `group_by`, `histogram`, or `timeslice` aggregation type.
      FIRST type STRING,
      "!   Specifies the second aggregation in the pair. The aggregation must be a `term`,
      "!    `group_by`, `histogram`, or `timeslice` aggregation type.
      SECOND type STRING,
      "!   Indicates whether to include estimated matching result information.
      SHW_ESTIMATED_MATCHING_RESULTS type BOOLEAN,
      "!   Indicates whether to include total matching documents information.
      SHOW_TOTAL_MATCHING_DOCUMENTS type BOOLEAN,
      "!   An array of aggregations.
      RESULTS type STANDARD TABLE OF T_QUERY_PAIR_AGGR_RESULT WITH NON-UNIQUE DEFAULT KEY,
    end of T_QUERY_AGGR_QUERY_PAIR_AGGR.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Configuration for table retrieval.</p>
    begin of T_QUERY_LARGE_TABLE_RESULTS,
      "!   Whether to enable table retrieval.
      ENABLED type BOOLEAN,
      "!   Maximum number of tables to return.
      COUNT type INTEGER,
    end of T_QUERY_LARGE_TABLE_RESULTS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Result information for a curated query.</p>
    begin of T_CURATION_RESULT,
      "!   The document ID of the curated result.
      DOCUMENT_ID type STRING,
      "!   The collection ID of the curated result.
      COLLECTION_ID type STRING,
      "!   Text to return in the `passage_text` field when this curated document is
      "!    returned for the specified natural language query. If **passages.per_document**
      "!    is `true`, the text snippet that you specify is returned as the top passage
      "!    instead of the original passage that is chosen by search. Only one text snippet
      "!    can be specified per document. If **passages.max_per_document** is greater than
      "!    `1`, the snippet is returned first, followed by the passages that are chosen by
      "!    search.
      SNIPPET type STRING,
    end of T_CURATION_RESULT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Object that contains an array of curated results.</p>
    begin of T_CURATED_RESULTS,
      "!   Array of curated results.
      CURATED_RESULTS type STANDARD TABLE OF T_CURATION_RESULT WITH NON-UNIQUE DEFAULT KEY,
    end of T_CURATED_RESULTS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The numeric location of the identified element in the</p>
    "!     document, represented with two integers labeled `begin` and `end`.
    begin of T_TABLE_ELEMENT_LOCATION,
      "!   The element&apos;s `begin` index.
      BEGIN type LONG,
      "!   The element&apos;s `end` index.
      END type LONG,
    end of T_TABLE_ELEMENT_LOCATION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Object that contains example response details for a training</p>
    "!     query.
    begin of T_TRAINING_EXAMPLE,
      "!   The document ID associated with this training example.
      DOCUMENT_ID type STRING,
      "!   The collection ID associated with this training example.
      COLLECTION_ID type STRING,
      "!   The relevance of the training example.
      RELEVANCE type INTEGER,
      "!   The date and time the example was created.
      CREATED type DATETIME,
      "!   The date and time the example was updated.
      UPDATED type DATETIME,
    end of T_TRAINING_EXAMPLE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Object that contains training query details.</p>
    begin of T_TRAINING_QUERY,
      "!   The query ID associated with the training query.
      QUERY_ID type STRING,
      "!   The natural text query that is used as the training query.
      NATURAL_LANGUAGE_QUERY type STRING,
      "!   The filter used on the collection before the **natural_language_query** is
      "!    applied.
      FILTER type STRING,
      "!   The date and time the query was created.
      CREATED type DATETIME,
      "!   The date and time the query was updated.
      UPDATED type DATETIME,
      "!   Array of training examples.
      EXAMPLES type STANDARD TABLE OF T_TRAINING_EXAMPLE WITH NON-UNIQUE DEFAULT KEY,
    end of T_TRAINING_QUERY.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A value in a key-value pair.</p>
    begin of T_TABLE_CELL_VALUES,
      "!   The unique ID of the value in the table.
      CELL_ID type STRING,
      "!   The numeric location of the identified element in the document, represented with
      "!    two integers labeled `begin` and `end`.
      LOCATION type T_TABLE_ELEMENT_LOCATION,
      "!   The text content of the table cell without HTML markup.
      TEXT type STRING,
    end of T_TABLE_CELL_VALUES.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A key in a key-value pair.</p>
    begin of T_TABLE_CELL_KEY,
      "!   The unique ID of the key in the table.
      CELL_ID type STRING,
      "!   The numeric location of the identified element in the document, represented with
      "!    two integers labeled `begin` and `end`.
      LOCATION type T_TABLE_ELEMENT_LOCATION,
      "!   The text content of the table cell without HTML markup.
      TEXT type STRING,
    end of T_TABLE_CELL_KEY.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Key-value pairs detected across cell boundaries.</p>
    begin of T_TABLE_KEY_VALUE_PAIRS,
      "!   A key in a key-value pair.
      KEY type T_TABLE_CELL_KEY,
      "!   A list of values in a key-value pair.
      VALUE type STANDARD TABLE OF T_TABLE_CELL_VALUES WITH NON-UNIQUE DEFAULT KEY,
    end of T_TABLE_KEY_VALUE_PAIRS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Aggregation results. For more information about supported</p>
    "!     aggregation types, see the [product
    "!     documentation](/docs/discovery-data?topic=discovery-data-query-aggregations).
      T_QUERY_SUB_AGGREGATION type JSONOBJECT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Curation status information.</p>
    begin of T_CURATION_STATUS,
      "!   The curation ID of the curation.
      CURATION_ID type STRING,
      "!   The current status of the specified curation.
      STATUS type STRING,
    end of T_CURATION_STATUS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A query response that contains the matching documents for</p>
    "!     the preceding aggregations.
    begin of T_QUERY_TOP_HITS_AGGR_RESULT,
      "!   Number of matching results.
      MATCHING_RESULTS type INTEGER,
      "!   An array of the document results in an ordered list.
      HITS type STANDARD TABLE OF JSONOBJECT WITH NON-UNIQUE DEFAULT KEY,
    end of T_QUERY_TOP_HITS_AGGR_RESULT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Curated query and responses.</p>
    begin of T_CURATION,
      "!   The curation ID of this curation.
      CURATION_ID type STRING,
      "!   The curated natural language query.
      NATURAL_LANGUAGE_QUERY type STRING,
      "!   Array of curated results.
      CURATED_RESULTS type STANDARD TABLE OF T_CURATION_RESULT WITH NON-UNIQUE DEFAULT KEY,
    end of T_CURATION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Title label.</p>
    begin of T_CMPNNT_STTNGS_FLDS_SHWN_TTL,
      "!   Use a specific field as the title.
      FIELD type STRING,
    end of T_CMPNNT_STTNGS_FLDS_SHWN_TTL.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Display settings for aggregations.</p>
    begin of T_COMPONENT_SETTINGS_AGGR,
      "!   Identifier used to map aggregation settings to aggregation configuration.
      NAME type STRING,
      "!   User-friendly alias for the aggregation.
      LABEL type STRING,
      "!   Whether users is allowed to select more than one of the aggregation terms.
      MULTIPLE_SELECTIONS_ALLOWED type BOOLEAN,
      "!   Type of visualization to use when rendering the aggregation.
      VISUALIZATION_TYPE type STRING,
    end of T_COMPONENT_SETTINGS_AGGR.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Body label.</p>
    begin of T_CMPNNT_STTNGS_FLDS_SHWN_BODY,
      "!   Use the whole passage as the body.
      USE_PASSAGE type BOOLEAN,
      "!   Use a specific field as the title.
      FIELD type STRING,
    end of T_CMPNNT_STTNGS_FLDS_SHWN_BODY.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Fields shown in the results section of the UI.</p>
    begin of T_CMPNNT_SETTINGS_FIELDS_SHOWN,
      "!   Body label.
      BODY type T_CMPNNT_STTNGS_FLDS_SHWN_BODY,
      "!   Title label.
      TITLE type T_CMPNNT_STTNGS_FLDS_SHWN_TTL,
    end of T_CMPNNT_SETTINGS_FIELDS_SHOWN.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The default component settings for this project.</p>
    begin of T_COMPONENT_SETTINGS_RESPONSE,
      "!   Fields shown in the results section of the UI.
      FIELDS_SHOWN type T_CMPNNT_SETTINGS_FIELDS_SHOWN,
      "!   Whether or not autocomplete is enabled.
      AUTOCOMPLETE type BOOLEAN,
      "!   Whether or not structured search is enabled.
      STRUCTURED_SEARCH type BOOLEAN,
      "!   Number or results shown per page.
      RESULTS_PER_PAGE type INTEGER,
      "!   a list of component setting aggregations.
      AGGREGATIONS type STANDARD TABLE OF T_COMPONENT_SETTINGS_AGGR WITH NON-UNIQUE DEFAULT KEY,
    end of T_COMPONENT_SETTINGS_RESPONSE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Object that contains suggested refinement settings.</p><br/>
    "!    <br/>
    "!    **Note**: The `suggested_refinements` parameter that identified dynamic facets
    "!     from the data is deprecated.
    begin of T_DFLT_QRY_PRMS_SGGSTD_RFNMNTS,
      "!   When `true`, suggested refinements for the query are returned by default.
      ENABLED type BOOLEAN,
      "!   The number of suggested refinements to return by default.
      COUNT type INTEGER,
    end of T_DFLT_QRY_PRMS_SGGSTD_RFNMNTS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Default project query settings for table results.</p>
    begin of T_DFLT_QRY_PARAMS_TAB_RESULTS,
      "!   When `true`, a table results for the query are returned by default.
      ENABLED type BOOLEAN,
      "!   The number of table results to return by default.
      COUNT type INTEGER,
      "!   The number of table results to include in each result document.
      PER_DOCUMENT type INTEGER,
    end of T_DFLT_QRY_PARAMS_TAB_RESULTS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Default settings configuration for passage search options.</p>
    begin of T_DFLT_QUERY_PARAMS_PASSAGES,
      "!   When `true`, a passage search is performed by default.
      ENABLED type BOOLEAN,
      "!   The number of passages to return.
      COUNT type INTEGER,
      "!   An array of field names to perform the passage search on.
      FIELDS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   The approximate number of characters that each returned passage will contain.
      CHARACTERS type INTEGER,
      "!   When `true` the number of passages that can be returned from a single document
      "!    is restricted to the *max_per_document* value.
      PER_DOCUMENT type BOOLEAN,
      "!   The default maximum number of passages that can be taken from a single document
      "!    as the result of a passage query.
      MAX_PER_DOCUMENT type INTEGER,
    end of T_DFLT_QUERY_PARAMS_PASSAGES.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Default query parameters for this project.</p>
    begin of T_DEFAULT_QUERY_PARAMS,
      "!   An array of collection identifiers to query. If empty or omitted all collections
      "!    in the project are queried.
      COLLECTION_IDS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   Default settings configuration for passage search options.
      PASSAGES type T_DFLT_QUERY_PARAMS_PASSAGES,
      "!   Default project query settings for table results.
      TABLE_RESULTS type T_DFLT_QRY_PARAMS_TAB_RESULTS,
      "!   A string representing the default aggregation query for the project.
      AGGREGATION type STRING,
      "!   Object that contains suggested refinement settings.<br/>
      "!   <br/>
      "!   **Note**: The `suggested_refinements` parameter that identified dynamic facets
      "!    from the data is deprecated.
      SUGGESTED_REFINEMENTS type T_DFLT_QRY_PRMS_SGGSTD_RFNMNTS,
      "!   When `true`, a spelling suggestions for the query are returned by default.
      SPELLING_SUGGESTIONS type BOOLEAN,
      "!   When `true`, highlights for the query are returned by default.
      HIGHLIGHT type BOOLEAN,
      "!   The number of document results returned by default.
      COUNT type INTEGER,
      "!   A comma separated list of document fields to sort results by default.
      SORT type STRING,
      "!   An array of field names to return in document results if present by default.
      RETURN type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
    end of T_DEFAULT_QUERY_PARAMS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Detailed information about the specified project.</p>
    begin of T_PROJECT_DETAILS,
      "!   The unique identifier of this project.
      PROJECT_ID type STRING,
      "!   The human readable name of this project.
      NAME type STRING,
      "!   The type of project.<br/>
      "!   <br/>
      "!   The `content_intelligence` type is a *Document Retrieval for Contracts* project
      "!    and the `other` type is a *Custom* project.<br/>
      "!   <br/>
      "!   The `content_mining` and `content_intelligence` types are available with Premium
      "!    plan managed deployments and installed deployments only.
      TYPE type STRING,
      "!   Relevancy training status information for this project.
      RELEVANCY_TRAINING_STATUS type T_PRJCT_LST_DTLS_RLVNCY_TRNNG1,
      "!   The number of collections configured in this project.
      COLLECTION_COUNT type INTEGER,
      "!   Default query parameters for this project.
      DEFAULT_QUERY_PARAMETERS type T_DEFAULT_QUERY_PARAMS,
    end of T_PROJECT_DETAILS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information returned after an uploaded document is accepted.</p>
    begin of T_DOCUMENT_ACCEPTED,
      "!   The unique identifier of the ingested document.
      DOCUMENT_ID type STRING,
      "!   Status of the document in the ingestion process. A status of `processing` is
      "!    returned for documents that are ingested with a *version* date before
      "!    `2019-01-01`. The `pending` status is returned for all others.
      STATUS type STRING,
    end of T_DOCUMENT_ACCEPTED.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Result for the `trend` aggregation.</p>
    begin of T_QUERY_TREND_AGGR_RESULT,
      "!   Array of subaggregations of type `term` or `group_by` and `timeslice`. Each
      "!    element of the matrix that is returned contains a **trend_indicator** that is
      "!    calculated from the combination of each aggregation value and segment of time.
      AGGREGATIONS type STANDARD TABLE OF JSONOBJECT WITH NON-UNIQUE DEFAULT KEY,
    end of T_QUERY_TREND_AGGR_RESULT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Detects sharp and unexpected changes in the frequency of a</p>
    "!     facet or facet value over time based on the past history of frequency changes
    "!     of the facet value.
    begin of T_QUERY_TREND_AGGREGATION,
      "!   Specifies that the aggregation type is `trend`.
      TYPE type STRING,
      "!   Specifies the `term` or `group_by` aggregation for the facet that you want to
      "!    analyze.
      FACET type STRING,
      "!   Specifies the `timeslice` aggregation that defines the time segments.
      TIME_SEGMENTS type STRING,
      "!   Indicates whether to include estimated matching result information.
      SHW_ESTIMATED_MATCHING_RESULTS type BOOLEAN,
      "!   Indicates whether to include total matching documents information.
      SHOW_TOTAL_MATCHING_DOCUMENTS type BOOLEAN,
      "!   An array of aggregations.
      RESULTS type STANDARD TABLE OF T_QUERY_TREND_AGGR_RESULT WITH NON-UNIQUE DEFAULT KEY,
    end of T_QUERY_TREND_AGGREGATION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Object that contains a potential answer to the specified</p>
    "!     query.
    begin of T_RESULT_PASSAGE_ANSWER,
      "!   Answer text for the specified query as identified by Discovery.
      ANSWER_TEXT type STRING,
      "!   The position of the first character of the extracted answer in the originating
      "!    field.
      START_OFFSET type INTEGER,
      "!   The position after the last character of the extracted answer in the originating
      "!    field.
      END_OFFSET type INTEGER,
      "!   An estimate of the probability that the answer is relevant.
      CONFIDENCE type DOUBLE,
    end of T_RESULT_PASSAGE_ANSWER.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A passage query response.</p>
    begin of T_QUERY_RESPONSE_PASSAGE,
      "!   The content of the extracted passage.
      PASSAGE_TEXT type STRING,
      "!   The confidence score of the passage&apos;s analysis. A higher score indicates
      "!    greater confidence. The score is used to rank the passages from all documents
      "!    and is returned only if **passages.per_document** is `false`.
      PASSAGE_SCORE type DOUBLE,
      "!   The unique identifier of the ingested document.
      DOCUMENT_ID type STRING,
      "!   The unique identifier of the collection.
      COLLECTION_ID type STRING,
      "!   The position of the first character of the extracted passage in the originating
      "!    field.
      START_OFFSET type INTEGER,
      "!   The position after the last character of the extracted passage in the
      "!    originating field.
      END_OFFSET type INTEGER,
      "!   The label of the field from which the passage has been extracted.
      FIELD type STRING,
      "!   An array of extracted answers to the specified query. Returned for natural
      "!    language queries when **passages.per_document** is `false`.
      ANSWERS type STANDARD TABLE OF T_RESULT_PASSAGE_ANSWER WITH NON-UNIQUE DEFAULT KEY,
    end of T_QUERY_RESPONSE_PASSAGE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object that contains configuration settings for a</p>
    "!     document classifier model training run.
    begin of T_DOC_CLASSIFIER_MODEL_TRAIN,
      "!   The name of the document classifier model.
      NAME type STRING,
      "!   A description of the document classifier model.
      DESCRIPTION type STRING,
      "!   A tuning parameter in an optimization algorithm that determines the step size at
      "!    each iteration of the training process. It influences how much of any newly
      "!    acquired information overrides the existing information, and therefore is said
      "!    to represent the speed at which a machine learning model learns. The default
      "!    value is `0.1`.
      LEARNING_RATE type DOUBLE,
      "!   Avoids overfitting by shrinking the coefficient of less important features to
      "!    zero, which removes some features altogether. You can specify many values for
      "!    hyper-parameter optimization. The default value is `[0.000001]`.
      L1_REGULARIZATION_STRENGTHS type STANDARD TABLE OF DOUBLE WITH NON-UNIQUE DEFAULT KEY,
      "!   A method you can apply to avoid overfitting your model on the training data. You
      "!    can specify many values for hyper-parameter optimization. The default value is
      "!    `[0.000001]`.
      L2_REGULARIZATION_STRENGTHS type STANDARD TABLE OF DOUBLE WITH NON-UNIQUE DEFAULT KEY,
      "!   Maximum number of training steps to complete. This setting is useful if you need
      "!    the training process to finish in a specific time frame to fit into an
      "!    automated process. The default value is ten million.
      TRAINING_MAX_STEPS type INTEGER,
      "!   Stops the training run early if the improvement ratio is not met by the time the
      "!    process reaches a certain point. The default value is `0.00001`.
      IMPROVEMENT_RATIO type DOUBLE,
    end of T_DOC_CLASSIFIER_MODEL_TRAIN.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Calculates relevancy values using combinations of document</p>
    "!     sets from results of the specified pair of aggregations.
    begin of T_QUERY_PAIR_AGGREGATION,
      "!   Specifies that the aggregation type is `pair`.
      TYPE type STRING,
      "!   Specifies the first aggregation in the pair. The aggregation must be a `term`,
      "!    `group_by`, `histogram`, or `timeslice` aggregation type.
      FIRST type STRING,
      "!   Specifies the second aggregation in the pair. The aggregation must be a `term`,
      "!    `group_by`, `histogram`, or `timeslice` aggregation type.
      SECOND type STRING,
      "!   Indicates whether to include estimated matching result information.
      SHW_ESTIMATED_MATCHING_RESULTS type BOOLEAN,
      "!   Indicates whether to include total matching documents information.
      SHOW_TOTAL_MATCHING_DOCUMENTS type BOOLEAN,
      "!   An array of aggregations.
      RESULTS type STANDARD TABLE OF T_QUERY_PAIR_AGGR_RESULT WITH NON-UNIQUE DEFAULT KEY,
    end of T_QUERY_PAIR_AGGREGATION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Returns a scalar calculation across all documents for the</p>
    "!     field specified. Possible calculations include min, max, sum, average, and
    "!     unique_count.
    begin of T_QUERY_CALCULATION_AGGR,
      "!   Specifies the calculation type, such as &apos;average`, `max`, `min`, `sum`, or
      "!    `unique_count`.
      TYPE type STRING,
      "!   The field to perform the calculation on.
      FIELD type STRING,
      "!   The value of the calculation.
      VALUE type DOUBLE,
    end of T_QUERY_CALCULATION_AGGR.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object that describes the Smart Document Understanding</p>
    "!     model for a collection.
    begin of T_CLLCTN_DTLS_SMRT_DOC_UNDRST1,
      "!   When `true`, smart document understanding conversion is enabled for the
      "!    collection.
      ENABLED type BOOLEAN,
      "!   Specifies the type of Smart Document Understanding (SDU) model that is enabled
      "!    for the collection. The following types of models are supported:<br/>
      "!   <br/>
      "!    * `custom`: A user-trained model is applied.<br/>
      "!   <br/>
      "!    * `pre_trained`: A pretrained model is applied. This type of model is applied
      "!    automatically to *Document Retrieval for Contracts* projects.<br/>
      "!   <br/>
      "!    * `text_extraction`: An SDU model that extracts text and metadata from the
      "!    content. This model is enabled in collections by default regardless of the
      "!    types of documents in the collection (as long as the service plan supports SDU
      "!    models).<br/>
      "!   <br/>
      "!   You can apply user-trained or pretrained models to collections from the
      "!    *Identify fields* page of the product user interface. For more information, see
      "!    [the product
      "!    documentation](/docs/discovery-data?topic=discovery-data-configuring-fields).
      MODEL type STRING,
    end of T_CLLCTN_DTLS_SMRT_DOC_UNDRST1.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object describing an enrichment for a collection.</p>
    begin of T_COLLECTION_ENRICHMENT,
      "!   The unique identifier of this enrichment. For more information about how to
      "!    determine the ID of an enrichment, see [the product
      "!    documentation](/docs/discovery-data?topic=discovery-data-manage-enrichments#enr
      "!   ichments-ids).
      ENRICHMENT_ID type STRING,
      "!   An array of field names that the enrichment is applied to.<br/>
      "!   <br/>
      "!   If you apply an enrichment to a field from a JSON file, the data is converted to
      "!    an array automatically, even if the field contains a single value.
      FIELDS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
    end of T_COLLECTION_ENRICHMENT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A collection for storing documents.</p>
    begin of T_COLLECTION_DETAILS,
      "!   The unique identifier of the collection.
      COLLECTION_ID type STRING,
      "!   The name of the collection.
      NAME type STRING,
      "!   A description of the collection.
      DESCRIPTION type STRING,
      "!   The date that the collection was created.
      CREATED type DATETIME,
      "!   The language of the collection. For a list of supported languages, see the
      "!    [product
      "!    documentation](/docs/discovery-data?topic=discovery-data-language-support).
      LANGUAGE type STRING,
      "!   An array of enrichments that are applied to this collection. To get a list of
      "!    enrichments that are available for a project, use the [List
      "!    enrichments](#listenrichments) method.<br/>
      "!   <br/>
      "!   If no enrichments are specified when the collection is created, the default
      "!    enrichments for the project type are applied. For more information about
      "!    project default settings, see the [product
      "!    documentation](/docs/discovery-data?topic=discovery-data-project-defaults).
      ENRICHMENTS type STANDARD TABLE OF T_COLLECTION_ENRICHMENT WITH NON-UNIQUE DEFAULT KEY,
      "!   An object that describes the Smart Document Understanding model for a
      "!    collection.
      SMART_DOCUMENT_UNDERSTANDING type T_CLLCTN_DTLS_SMRT_DOC_UNDRST1,
    end of T_COLLECTION_DETAILS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object with details for creating federated document</p>
    "!     classifier models.
    begin of T_CLASSIFIER_FEDERATED_MODEL,
      "!   Name of the field that contains the values from which multiple classifier models
      "!    are defined. For example, you can specify a field that lists product lines to
      "!    create a separate model per product line.
      FIELD type STRING,
    end of T_CLASSIFIER_FEDERATED_MODEL.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object that describes enrichments that are applied to the</p>
    "!     training and test data that is used by the document classifier.
    begin of T_DOC_CLASSIFIER_ENRICHMENT,
      "!   A unique identifier of the enrichment.
      ENRICHMENT_ID type STRING,
      "!   An array of field names where the enrichment is applied.
      FIELDS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
    end of T_DOC_CLASSIFIER_ENRICHMENT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about a document classifier.</p>
    begin of T_DOCUMENT_CLASSIFIER,
      "!   A unique identifier of the document classifier.
      CLASSIFIER_ID type STRING,
      "!   A human-readable name of the document classifier.
      NAME type STRING,
      "!   A description of the document classifier.
      DESCRIPTION type STRING,
      "!   The date that the document classifier was created.
      CREATED type DATETIME,
      "!   The language of the training data that is associated with the document
      "!    classifier. Language is specified by using the ISO 639-1 language code, such as
      "!    `en` for English or `ja` for Japanese.
      LANGUAGE type STRING,
      "!   An array of enrichments to apply to the data that is used to train and test the
      "!    document classifier. The output from the enrichments is used as features by the
      "!    classifier to classify the document content both during training and at run
      "!    time.
      ENRICHMENTS type STANDARD TABLE OF T_DOC_CLASSIFIER_ENRICHMENT WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of fields that are used to train the document classifier. The same set
      "!    of fields must exist in the training data, the test data, and the documents
      "!    where the resulting document classifier enrichment is applied at run time.
      RECOGNIZED_FIELDS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   The name of the field from the training and test data that contains the
      "!    classification labels.
      ANSWER_FIELD type STRING,
      "!   Name of the CSV file with training data that is used to train the document
      "!    classifier.
      TRAINING_DATA_FILE type STRING,
      "!   Name of the CSV file with data that is used to test the document classifier. If
      "!    no test data is provided, a subset of the training data is used for testing
      "!    purposes.
      TEST_DATA_FILE type STRING,
      "!   An object with details for creating federated document classifier models.
      FEDERATED_CLASSIFICATION type T_CLASSIFIER_FEDERATED_MODEL,
    end of T_DOCUMENT_CLASSIFIER.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object that contains a list of document classifier</p>
    "!     definitions.
    begin of T_DOCUMENT_CLASSIFIERS,
      "!   An array of document classifier definitions.
      CLASSIFIERS type STANDARD TABLE OF T_DOCUMENT_CLASSIFIER WITH NON-UNIQUE DEFAULT KEY,
    end of T_DOCUMENT_CLASSIFIERS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Top value result for the `term` aggregation.</p>
    begin of T_QUERY_TERM_AGGR_RESULT,
      "!   Value of the field with a nonzero frequency in the document set.
      KEY type STRING,
      "!   Number of documents that contain the &apos;key&apos;.
      MATCHING_RESULTS type INTEGER,
      "!   The relevancy score for this result. Returned only if `relevancy:true` is
      "!    specified in the request.
      RELEVANCY type DOUBLE,
      "!   Number of documents in the collection that contain the term in the specified
      "!    field. Returned only when `relevancy:true` is specified in the request.
      TOTAL_MATCHING_DOCUMENTS type INTEGER,
      "!   Number of documents that are estimated to match the query and also meet the
      "!    condition. Returned only when `relevancy:true` is specified in the request.
      ESTIMATED_MATCHING_RESULTS type DOUBLE,
      "!   An array of subaggregations. Returned only when this aggregation is combined
      "!    with other aggregations in the request or is returned as a subaggregation.
      AGGREGATIONS type STANDARD TABLE OF JSONOBJECT WITH NON-UNIQUE DEFAULT KEY,
    end of T_QUERY_TERM_AGGR_RESULT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An array of values, each being the `id` value of a column</p>
    "!     header that is applicable to the current cell.
    begin of T_TABLE_COLUMN_HEADER_IDS,
      "!   The `id` value of a column header.
      ID type STRING,
    end of T_TABLE_COLUMN_HEADER_IDS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A list of values in a key-value pair.</p>
      T_TABLE_CELL_VALUE type STANDARD TABLE OF T_TABLE_CELL_VALUES WITH NON-UNIQUE DEFAULT KEY.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A timeslice interval segment.</p>
    begin of T_QUERY_TIMESLICE_AGGR_RESULT,
      "!   String date value of the upper bound for the timeslice interval in ISO-8601
      "!    format.
      KEY_AS_STRING type STRING,
      "!   Numeric date value of the upper bound for the timeslice interval in UNIX
      "!    milliseconds since epoch.
      KEY type LONG,
      "!   Number of documents with the specified key as the upper bound.
      MATCHING_RESULTS type LONG,
      "!   An array of subaggregations. Returned only when this aggregation is returned as
      "!    a subaggregation.
      AGGREGATIONS type STANDARD TABLE OF JSONOBJECT WITH NON-UNIQUE DEFAULT KEY,
    end of T_QUERY_TIMESLICE_AGGR_RESULT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A specialized histogram aggregation that uses dates to</p>
    "!     create interval segments.
    begin of T_QRY_AGGR_QRY_TIMESLICE_AGGR,
      "!   Specifies that the aggregation type is `timeslice`.
      TYPE type STRING,
      "!   The date field name used to create the timeslice.
      FIELD type STRING,
      "!   The date interval value. Valid values are seconds, minutes, hours, days, weeks,
      "!    and years.
      INTERVAL type STRING,
      "!   Identifier that can optionally be specified in the query request of this
      "!    aggregation.
      NAME type STRING,
      "!   Array of aggregation results.
      RESULTS type STANDARD TABLE OF T_QUERY_TIMESLICE_AGGR_RESULT WITH NON-UNIQUE DEFAULT KEY,
    end of T_QRY_AGGR_QRY_TIMESLICE_AGGR.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Object that contains field details.</p>
    begin of T_FIELD,
      "!   The name of the field.
      FIELD type STRING,
      "!   The type of the field.
      TYPE type STRING,
      "!   The collection Id of the collection where the field was found.
      COLLECTION_ID type STRING,
    end of T_FIELD.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Finds results from documents that are similar to documents</p>
    "!     of interest. Use this parameter to add a *More like these* function to your
    "!     search. You can include this parameter with or without a **query**, **filter**
    "!     or **natural_language_query** parameter.
    begin of T_QUERY_LARGE_SIMILAR,
      "!   When `true`, includes documents in the query results that are similar to
      "!    documents you specify.
      ENABLED type BOOLEAN,
      "!   The list of documents of interest. Required if **enabled** is `true`.
      DOCUMENT_IDS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   Looks for similarities in the specified subset of fields in the documents. If
      "!    not specified, all of the document fields are used.
      FIELDS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
    end of T_QUERY_LARGE_SIMILAR.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Histogram numeric interval result.</p>
    begin of T_QUERY_HISTOGRAM_AGGR_RESULT,
      "!   The value of the upper bound for the numeric segment.
      KEY type LONG,
      "!   Number of documents with the specified key as the upper bound.
      MATCHING_RESULTS type INTEGER,
      "!   An array of subaggregations. Returned only when this aggregation is returned as
      "!    a subaggregation.
      AGGREGATIONS type STANDARD TABLE OF JSONOBJECT WITH NON-UNIQUE DEFAULT KEY,
    end of T_QUERY_HISTOGRAM_AGGR_RESULT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Numeric interval segments to categorize documents by using</p>
    "!     field values from a single numeric field to describe the category.
    begin of T_QUERY_HISTOGRAM_AGGREGATION,
      "!   Specifies that the aggregation type is `histogram`.
      TYPE type STRING,
      "!   The numeric field name used to create the histogram.
      FIELD type STRING,
      "!   The size of the sections that the results are split into.
      INTERVAL type INTEGER,
      "!   Identifier that can optionally be specified in the query request of this
      "!    aggregation.
      NAME type STRING,
      "!   Array of numeric intervals.
      RESULTS type STANDARD TABLE OF T_QUERY_HISTOGRAM_AGGR_RESULT WITH NON-UNIQUE DEFAULT KEY,
    end of T_QUERY_HISTOGRAM_AGGREGATION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An array of values, each being the `id` value of a row</p>
    "!     header that is applicable to this body cell.
    begin of T_TABLE_ROW_HEADER_IDS,
      "!   The `id` values of a row header.
      ID type STRING,
    end of T_TABLE_ROW_HEADER_IDS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Relevancy training status information for this project.</p>
    begin of T_PROJECT_REL_TRAIN_STATUS,
      "!   When the training data was updated.
      DATA_UPDATED type STRING,
      "!   The total number of examples.
      TOTAL_EXAMPLES type INTEGER,
      "!   When `true`, sufficient label diversity is present to allow training for this
      "!    project.
      SUFFICIENT_LABEL_DIVERSITY type BOOLEAN,
      "!   When `true`, the relevancy training is in processing.
      PROCESSING type BOOLEAN,
      "!   When `true`, the minimum number of examples required to train has been met.
      MINIMUM_EXAMPLES_ADDED type BOOLEAN,
      "!   The time that the most recent successful training occurred.
      SUCCESSFULLY_TRAINED type STRING,
      "!   When `true`, relevancy training is available when querying collections in the
      "!    project.
      AVAILABLE type BOOLEAN,
      "!   The number of notices generated during the relevancy training.
      NOTICES type INTEGER,
      "!   When `true`, the minimum number of queries required to train has been met.
      MINIMUM_QUERIES_ADDED type BOOLEAN,
    end of T_PROJECT_REL_TRAIN_STATUS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object that defines how to aggregate query results.</p>
      T_QUERY_AGGREGATION type JSONOBJECT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Numeric interval segments to categorize documents by using</p>
    "!     field values from a single numeric field to describe the category.
    begin of T_QRY_AGGR_QRY_HISTOGRAM_AGGR,
      "!   Specifies that the aggregation type is `histogram`.
      TYPE type STRING,
      "!   The numeric field name used to create the histogram.
      FIELD type STRING,
      "!   The size of the sections that the results are split into.
      INTERVAL type INTEGER,
      "!   Identifier that can optionally be specified in the query request of this
      "!    aggregation.
      NAME type STRING,
      "!   Array of numeric intervals.
      RESULTS type STANDARD TABLE OF T_QUERY_HISTOGRAM_AGGR_RESULT WITH NON-UNIQUE DEFAULT KEY,
    end of T_QRY_AGGR_QRY_HISTOGRAM_AGGR.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Result of the document analysis.</p>
    begin of T_ANALYZED_RESULT,
      "!   Metadata that was specified with the request.
      METADATA type JSONOBJECT,
    end of T_ANALYZED_RESULT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Configuration for passage retrieval.</p>
    begin of T_QUERY_LARGE_PASSAGES,
      "!   A passages query that returns the most relevant passages from the results.
      ENABLED type BOOLEAN,
      "!   If `true`, ranks the documents by document quality, and then returns the
      "!    highest-ranked passages per document in a `document_passages` field for each
      "!    document entry in the results list of the response.<br/>
      "!   <br/>
      "!   If `false`, ranks the passages from all of the documents by passage quality
      "!    regardless of the document quality and returns them in a separate `passages`
      "!    field in the response.
      PER_DOCUMENT type BOOLEAN,
      "!   Maximum number of passages to return per document in the result. Ignored if
      "!    **passages.per_document** is `false`.
      MAX_PER_DOCUMENT type INTEGER,
      "!   A list of fields to extract passages from. By default, passages are extracted
      "!    from the `text` and `title` fields only. If you add this parameter and specify
      "!    an empty list (`[]`) as its value, then the service searches all root-level
      "!    fields for suitable passages.
      FIELDS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   The maximum number of passages to return. Ignored if **passages.per_document**
      "!    is `true`.
      COUNT type INTEGER,
      "!   The approximate number of characters that any one passage will have.
      CHARACTERS type INTEGER,
      "!   When true, `answer` objects are returned as part of each passage in the query
      "!    results. The primary difference between an `answer` and a `passage` is that the
      "!    length of a passage is defined by the query, where the length of an `answer` is
      "!    calculated by Discovery based on how much text is needed to answer the
      "!    question.<br/>
      "!   <br/>
      "!   This parameter is ignored if passages are not enabled for the query, or no
      "!    **natural_language_query** is specified.<br/>
      "!   <br/>
      "!   If the **find_answers** parameter is set to `true` and **per_document**
      "!    parameter is also set to `true`, then the document search results and the
      "!    passage search results within each document are reordered using the answer
      "!    confidences. The goal of this reordering is to place the best answer as the
      "!    first answer of the first passage of the first document. Similarly, if the
      "!    **find_answers** parameter is set to `true` and **per_document** parameter is
      "!    set to `false`, then the passage search results are reordered in decreasing
      "!    order of the highest confidence answer for each document and passage.<br/>
      "!   <br/>
      "!   The **find_answers** parameter is available only on managed instances of
      "!    Discovery.
      FIND_ANSWERS type BOOLEAN,
      "!   The number of `answer` objects to return per passage if the **find_answers**
      "!    parmeter is specified as `true`.
      MAX_ANSWERS_PER_PASSAGE type INTEGER,
    end of T_QUERY_LARGE_PASSAGES.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Configuration for suggested refinements.</p><br/>
    "!    <br/>
    "!    **Note**: The **suggested_refinements** parameter that identified dynamic facets
    "!     from the data is deprecated.
    begin of T_QRY_LRG_SGGSTD_REFINEMENTS,
      "!   Whether to perform suggested refinements.
      ENABLED type BOOLEAN,
      "!   Maximum number of suggested refinements texts to be returned. The maximum is
      "!    `100`.
      COUNT type INTEGER,
    end of T_QRY_LRG_SGGSTD_REFINEMENTS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Object that describes a long query.</p>
    begin of T_QUERY_LARGE,
      "!   A comma-separated list of collection IDs to be queried against.
      COLLECTION_IDS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   Searches for documents that match the Discovery Query Language criteria that is
      "!    specified as input. Filter calls are cached and are faster than query calls
      "!    because the results are not ordered by relevance. When used with the
      "!    **aggregation**, **query**, or **natural_language_query** parameters, the
      "!    **filter** parameter runs first. This parameter is useful for limiting results
      "!    to those that contain specific metadata values.
      FILTER type STRING,
      "!   A query search that is written in the Discovery Query Language and returns all
      "!    matching documents in your data set with full enrichments and full text, and
      "!    with the most relevant documents listed first. Use a query search when you want
      "!    to find the most relevant search results.
      QUERY type STRING,
      "!   A natural language query that returns relevant documents by using training data
      "!    and natural language understanding.
      NATURAL_LANGUAGE_QUERY type STRING,
      "!   An aggregation search that returns an exact answer by combining query search
      "!    with filters. Useful for applications to build lists, tables, and time series.
      "!    For more information about the supported types of aggregations, see the
      "!    [Discovery
      "!    documentation](/docs/discovery-data?topic=discovery-data-query-aggregations).
      AGGREGATION type STRING,
      "!   Number of results to return.
      COUNT type INTEGER,
      "!   A list of the fields in the document hierarchy to return. You can specify both
      "!    root-level (`text`) and nested (`extracted_metadata.filename`) fields. If this
      "!    parameter is an empty list, then all fields are returned.
      RETURN type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   The number of query results to skip at the beginning. For example, if the total
      "!    number of results that are returned is 10 and the offset is 8, it returns the
      "!    last two results.
      OFFSET type INTEGER,
      "!   A comma-separated list of fields in the document to sort on. You can optionally
      "!    specify a sort direction by prefixing the field with `-` for descending or `+`
      "!    for ascending. Ascending is the default sort direction if no prefix is
      "!    specified.
      SORT type STRING,
      "!   When `true`, a highlight field is returned for each result that contains fields
      "!    that match the query. The matching query terms are emphasized with surrounding
      "!    `&lt;em&gt;&lt;/em&gt;` tags. This parameter is ignored if **passages.enabled**
      "!    and **passages.per_document** are `true`, in which case passages are returned
      "!    for each document instead of highlights.
      HIGHLIGHT type BOOLEAN,
      "!   When `true` and the **natural_language_query** parameter is used, the
      "!    **natural_language_query** parameter is spell checked. The most likely
      "!    correction is returned in the **suggested_query** field of the response (if one
      "!    exists).
      SPELLING_SUGGESTIONS type BOOLEAN,
      "!   Configuration for table retrieval.
      TABLE_RESULTS type T_QUERY_LARGE_TABLE_RESULTS,
      "!   Configuration for suggested refinements.<br/>
      "!   <br/>
      "!   **Note**: The **suggested_refinements** parameter that identified dynamic facets
      "!    from the data is deprecated.
      SUGGESTED_REFINEMENTS type T_QRY_LRG_SGGSTD_REFINEMENTS,
      "!   Configuration for passage retrieval.
      PASSAGES type T_QUERY_LARGE_PASSAGES,
      "!   Finds results from documents that are similar to documents of interest. Use this
      "!    parameter to add a *More like these* function to your search. You can include
      "!    this parameter with or without a **query**, **filter** or
      "!    **natural_language_query** parameter.
      SIMILAR type T_QUERY_LARGE_SIMILAR,
    end of T_QUERY_LARGE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object that contains options for the current enrichment.</p>
    "!     Starting with version `2020-08-30`, the enrichment options are not included in
    "!     responses from the List Enrichments method.
    begin of T_ENRICHMENT_OPTIONS,
      "!   An array of supported languages for this enrichment. When creating an
      "!    enrichment, only specify a language that is used by the model or in the
      "!    dictionary. Required when **type** is `dictionary`. Optional when **type** is
      "!    `rule_based`. Not valid when creating any other type of enrichment.
      LANGUAGES type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   The name of the entity type. This value is used as the field name in the index.
      "!    Required when **type** is `dictionary` or `regular_expression`. Not valid when
      "!    creating any other type of enrichment.
      ENTITY_TYPE type STRING,
      "!   The regular expression to apply for this enrichment. Required when **type** is
      "!    `regular_expression`. Not valid when creating any other type of enrichment.
      REGULAR_EXPRESSION type STRING,
      "!   The name of the result document field that this enrichment creates. Required
      "!    when **type** is `rule_based` or `classifier`. Not valid when creating any
      "!    other type of enrichment.
      RESULT_FIELD type STRING,
      "!   A unique identifier of the document classifier. Required when **type** is
      "!    `classifier`. Not valid when creating any other type of enrichment.
      CLASSIFIER_ID type STRING,
      "!   A unique identifier of the document classifier model. Required when **type** is
      "!    `classifier`. Not valid when creating any other type of enrichment.
      MODEL_ID type STRING,
      "!   Specifies a threshold. Only classes with evaluation confidence scores that are
      "!    higher than the specified threshold are included in the output. Optional when
      "!    **type** is `classifier`. Not valid when creating any other type of enrichment.
      "!
      CONFIDENCE_THRESHOLD type DOUBLE,
      "!   Evaluates only the classes that fall in the top set of results when ranked by
      "!    confidence. For example, if set to `5`, then the top five classes for each
      "!    document are evaluated. If set to 0, the **confidence_threshold** is used to
      "!    determine the predicted classes. Optional when **type** is `classifier`. Not
      "!    valid when creating any other type of enrichment.
      TOP_K type INTEGER,
    end of T_ENRICHMENT_OPTIONS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about a specific enrichment.</p>
    begin of T_ENRICHMENT,
      "!   The unique identifier of this enrichment.
      ENRICHMENT_ID type STRING,
      "!   The human readable name for this enrichment.
      NAME type STRING,
      "!   The description of this enrichment.
      DESCRIPTION type STRING,
      "!   The type of this enrichment.
      TYPE type STRING,
      "!   An object that contains options for the current enrichment. Starting with
      "!    version `2020-08-30`, the enrichment options are not included in responses from
      "!    the List Enrichments method.
      OPTIONS type T_ENRICHMENT_OPTIONS,
    end of T_ENRICHMENT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Result group for the `group_by` aggregation.</p>
    begin of T_QUERY_GROUP_BY_AGGR_RESULT,
      "!   The condition that is met by the documents in this group. For example,
      "!    `YEARTXT&lt;2000`.
      KEY type STRING,
      "!   Number of documents that meet the query and condition.
      MATCHING_RESULTS type INTEGER,
      "!   The relevancy for this group. Returned only if `relevancy:true` is specified in
      "!    the request.
      RELEVANCY type DOUBLE,
      "!   Number of documents that meet the condition in the whole set of documents in
      "!    this collection. Returned only when `relevancy:true` is specified in the
      "!    request.
      TOTAL_MATCHING_DOCUMENTS type INTEGER,
      "!   The number of documents that are estimated to match the query and condition.
      "!    Returned only when `relevancy:true` is specified in the request.
      ESTIMATED_MATCHING_RESULTS type DOUBLE,
      "!   An array of subaggregations. Returned only when this aggregation is returned as
      "!    a subaggregation.
      AGGREGATIONS type STANDARD TABLE OF JSONOBJECT WITH NON-UNIQUE DEFAULT KEY,
    end of T_QUERY_GROUP_BY_AGGR_RESULT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Separates document results into groups that meet the</p>
    "!     conditions you specify.
    begin of T_QRY_AGGR_QUERY_GROUP_BY_AGGR,
      "!   Specifies that the aggregation type is `group_by`.
      TYPE type STRING,
      "!   An array of results.
      RESULTS type STANDARD TABLE OF T_QUERY_GROUP_BY_AGGR_RESULT WITH NON-UNIQUE DEFAULT KEY,
    end of T_QRY_AGGR_QUERY_GROUP_BY_AGGR.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A collection for storing documents.</p>
    begin of T_COLLECTION,
      "!   The unique identifier of the collection.
      COLLECTION_ID type STRING,
      "!   The name of the collection.
      NAME type STRING,
    end of T_COLLECTION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object that contains a list of document classifier model</p>
    "!     definitions.
    begin of T_DOCUMENT_CLASSIFIER_MODELS,
      "!   An array of document classifier model definitions.
      MODELS type STANDARD TABLE OF T_DOCUMENT_CLASSIFIER_MODEL WITH NON-UNIQUE DEFAULT KEY,
    end of T_DOCUMENT_CLASSIFIER_MODELS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    If you provide customization input, the normalized version</p>
    "!     of the row header texts according to the customization; otherwise, the same
    "!     value as `row_header_texts`.
    begin of T_TAB_ROW_HEADER_TEXTS_NORM,
      "!   The normalized version of a row header text.
      TEXT_NORMALIZED type STRING,
    end of T_TAB_ROW_HEADER_TEXTS_NORM.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    List of document attributes.</p>
    begin of T_DOCUMENT_ATTRIBUTE,
      "!   The type of attribute.
      TYPE type STRING,
      "!   The text associated with the attribute.
      TEXT type STRING,
      "!   The numeric location of the identified element in the document, represented with
      "!    two integers labeled `begin` and `end`.
      LOCATION type T_TABLE_ELEMENT_LOCATION,
    end of T_DOCUMENT_ATTRIBUTE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An array of values, each being the `text` value of a row</p>
    "!     header that is applicable to this body cell.
    begin of T_TABLE_ROW_HEADER_TEXTS,
      "!   The `text` value of a row header.
      TEXT type STRING,
    end of T_TABLE_ROW_HEADER_TEXTS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An array of values, each being the `text` value of a column</p>
    "!     header that is applicable to the current cell.
    begin of T_TABLE_COLUMN_HEADER_TEXTS,
      "!   The `text` value of a column header.
      TEXT type STRING,
    end of T_TABLE_COLUMN_HEADER_TEXTS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    If you provide customization input, the normalized version</p>
    "!     of the column header texts according to the customization; otherwise, the same
    "!     value as `column_header_texts`.
    begin of T_TAB_COLUMN_HEADER_TEXTS_NORM,
      "!   The normalized version of a column header text.
      TEXT_NORMALIZED type STRING,
    end of T_TAB_COLUMN_HEADER_TEXTS_NORM.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Cells that are not table header, column header, or row</p>
    "!     header cells.
    begin of T_TABLE_BODY_CELLS,
      "!   The unique ID of the cell in the current table.
      CELL_ID type STRING,
      "!   The numeric location of the identified element in the document, represented with
      "!    two integers labeled `begin` and `end`.
      LOCATION type T_TABLE_ELEMENT_LOCATION,
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
      "!   A list of table row header ids.
      ROW_HEADER_IDS type STANDARD TABLE OF T_TABLE_ROW_HEADER_IDS WITH NON-UNIQUE DEFAULT KEY,
      "!   A list of table row header texts.
      ROW_HEADER_TEXTS type STANDARD TABLE OF T_TABLE_ROW_HEADER_TEXTS WITH NON-UNIQUE DEFAULT KEY,
      "!   A list of table row header texts normalized.
      ROW_HEADER_TEXTS_NORMALIZED type STANDARD TABLE OF T_TAB_ROW_HEADER_TEXTS_NORM WITH NON-UNIQUE DEFAULT KEY,
      "!   A list of table column header ids.
      COLUMN_HEADER_IDS type STANDARD TABLE OF T_TABLE_COLUMN_HEADER_IDS WITH NON-UNIQUE DEFAULT KEY,
      "!   A list of table column header texts.
      COLUMN_HEADER_TEXTS type STANDARD TABLE OF T_TABLE_COLUMN_HEADER_TEXTS WITH NON-UNIQUE DEFAULT KEY,
      "!   A list of table column header texts normalized.
      COLUMN_HEADER_TEXTS_NORMALIZED type STANDARD TABLE OF T_TAB_COLUMN_HEADER_TEXTS_NORM WITH NON-UNIQUE DEFAULT KEY,
      "!   A list of document attributes.
      ATTRIBUTES type STANDARD TABLE OF T_DOCUMENT_ATTRIBUTE WITH NON-UNIQUE DEFAULT KEY,
    end of T_TABLE_BODY_CELLS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Text and associated location within a table.</p>
    begin of T_TABLE_TEXT_LOCATION,
      "!   The text retrieved.
      TEXT type STRING,
      "!   The numeric location of the identified element in the document, represented with
      "!    two integers labeled `begin` and `end`.
      LOCATION type T_TABLE_ELEMENT_LOCATION,
    end of T_TABLE_TEXT_LOCATION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Returns the top documents ranked by the score of the query.</p>
    begin of T_QUERY_TOP_HITS_AGGREGATION,
      "!   Specifies that the aggregation type is `top_hits`.
      TYPE type STRING,
      "!   The number of documents to return.
      SIZE type INTEGER,
      "!   Identifier specified in the query request of this aggregation.
      NAME type STRING,
      "!   A query response that contains the matching documents for the preceding
      "!    aggregations.
      HITS type T_QUERY_TOP_HITS_AGGR_RESULT,
    end of T_QUERY_TOP_HITS_AGGREGATION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about the child documents that are generated</p>
    "!     from a single document during ingestion or other processing.
    begin of T_DOCUMENT_DETAILS_CHILDREN,
      "!   Indicates whether the child documents have any notices. The value is `false` if
      "!    the document does not have child documents.
      HAVE_NOTICES type BOOLEAN,
      "!   Number of child documents. The value is `0` when processing of the document
      "!    doesn&apos;t generate any child documents.
      COUNT type INTEGER,
    end of T_DOCUMENT_DETAILS_CHILDREN.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A notice produced for the collection.</p>
    begin of T_NOTICE,
      "!   Identifies the notice. Many notices might have the same ID. This field exists so
      "!    that user applications can programmatically identify a notice and take
      "!    automatic corrective action. Typical notice IDs include:<br/>
      "!   <br/>
      "!   `index_failed`, `index_failed_too_many_requests`,
      "!    `index_failed_incompatible_field`, `index_failed_cluster_unavailable`,
      "!    `ingestion_timeout`, `ingestion_error`, `bad_request`, `internal_error`,
      "!    `missing_model`, `unsupported_model`,
      "!    `smart_document_understanding_failed_incompatible_field`,
      "!    `smart_document_understanding_failed_internal_error`,
      "!    `smart_document_understanding_failed_internal_error`,
      "!    `smart_document_understanding_failed_warning`,
      "!    `smart_document_understanding_page_error`,
      "!    `smart_document_understanding_page_warning`. **Note:** This is not a complete
      "!    list. Other values might be returned.
      NOTICE_ID type STRING,
      "!   The creation date of the collection in the format
      "!    yyyy-MM-dd&apos;T&apos;HH:mm:ss.SSS&apos;Z&apos;.
      CREATED type DATETIME,
      "!   Unique identifier of the document.
      DOCUMENT_ID type STRING,
      "!   Unique identifier of the collection.
      COLLECTION_ID type STRING,
      "!   Unique identifier of the query used for relevance training.
      QUERY_ID type STRING,
      "!   Severity level of the notice.
      SEVERITY type STRING,
      "!   Ingestion or training step in which the notice occurred.
      STEP type STRING,
      "!   The description of the notice.
      DESCRIPTION type STRING,
    end of T_NOTICE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about a document.</p>
    begin of T_DOCUMENT_DETAILS,
      "!   The unique identifier of the document.
      DOCUMENT_ID type STRING,
      "!   Date and time that the document is added to the collection. For a child
      "!    document, the date and time when the process that generates the child document
      "!    runs. The date-time format is
      "!    `yyyy-MM-dd&apos;T&apos;HH:mm:ss.SSS&apos;Z&apos;`.
      CREATED type DATETIME,
      "!   Date and time that the document is finished being processed and is indexed. This
      "!    date changes whenever the document is reprocessed, including for enrichment
      "!    changes. The date-time format is
      "!    `yyyy-MM-dd&apos;T&apos;HH:mm:ss.SSS&apos;Z&apos;`.
      UPDATED type DATETIME,
      "!   The status of the ingestion of the document. The possible values are:<br/>
      "!   <br/>
      "!   * `available`: Ingestion is finished and the document is indexed.<br/>
      "!   <br/>
      "!   * `failed`: Ingestion is finished, but the document is not indexed because of an
      "!    error.<br/>
      "!   <br/>
      "!   * `pending`: The document is uploaded, but the ingestion process is not
      "!    started.<br/>
      "!   <br/>
      "!   * `processing`: Ingestion is in progress.
      STATUS type STRING,
      "!   Array of JSON objects for notices, meaning warning or error messages, that are
      "!    produced by the document ingestion process. The array does not include notices
      "!    that are produced for child documents that are generated when a document is
      "!    processed.
      NOTICES type STANDARD TABLE OF T_NOTICE WITH NON-UNIQUE DEFAULT KEY,
      "!   Information about the child documents that are generated from a single document
      "!    during ingestion or other processing.
      CHILDREN type T_DOCUMENT_DETAILS_CHILDREN,
      "!   Name of the original source file (if available).
      FILENAME type STRING,
      "!   The type of the original source file, such as `csv`, `excel`, `html`, `json`,
      "!    `pdf`, `text`, `word`, and so on.
      FILE_TYPE type STRING,
      "!   The SHA-256 hash of the original source file. The hash is formatted as a
      "!    hexadecimal string.
      SHA256 type STRING,
    end of T_DOCUMENT_DETAILS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A restriction that alters the document set that is used by</p>
    "!     the aggregations that it precedes. Subsequent aggregations are applied to
    "!     nested documents from the specified field.
    begin of T_QUERY_AGGR_QUERY_NESTED_AGGR,
      "!   Specifies that the aggregation type is `nested`.
      TYPE type STRING,
      "!   The path to the document field to scope subsequent aggregations to.
      PATH type STRING,
      "!   Number of nested documents found in the specified field.
      MATCHING_RESULTS type LONG,
      "!   An array of subaggregations.
      AGGREGATIONS type STANDARD TABLE OF JSONOBJECT WITH NON-UNIQUE DEFAULT KEY,
    end of T_QUERY_AGGR_QUERY_NESTED_AGGR.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object that contains an array of autocompletion</p>
    "!     suggestions.
    begin of T_COMPLETIONS,
      "!   Array of autocomplete suggestion based on the provided prefix.
      COMPLETIONS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
    end of T_COMPLETIONS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object that contains a new name and description for an</p>
    "!     enrichment.
    begin of T_UPDATE_ENRICHMENT,
      "!   A new name for the enrichment.
      NAME type STRING,
      "!   A new description for the enrichment.
      DESCRIPTION type STRING,
    end of T_UPDATE_ENRICHMENT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A suggested additional query term or terms user to filter</p>
    "!     results. **Note**: The `suggested_refinements` parameter is deprecated.
    begin of T_QUERY_SUGGESTED_REFINEMENT,
      "!   The text used to filter.
      TEXT type STRING,
    end of T_QUERY_SUGGESTED_REFINEMENT.
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
    "!    An object contain retrieval type information.</p>
    begin of T_RETRIEVAL_DETAILS,
      "!   Identifies the document retrieval strategy used for this query.
      "!    `relevancy_training` indicates that the results were returned using a relevancy
      "!    trained model. <br/>
      "!   <br/>
      "!   **Note**: In the event of trained collections being queried, but the trained
      "!    model is not used to return results, the **document_retrieval_strategy** is
      "!    listed as `untrained`.
      DOCUMENT_RETRIEVAL_STRATEGY type STRING,
    end of T_RETRIEVAL_DETAILS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about a specific enrichment.</p>
    begin of T_CREATE_ENRICHMENT,
      "!   The human readable name for this enrichment.
      NAME type STRING,
      "!   The description of this enrichment.
      DESCRIPTION type STRING,
      "!   The type of this enrichment. The following types are supported:<br/>
      "!   <br/>
      "!   * `classifier`: Creates a document classifier enrichment from a document
      "!    classifier model that you create by using the [Document classifier
      "!    API](/apidocs/discovery-data#createdocumentclassifier). **Note**: A text
      "!    classifier enrichment can be created only from the product user interface.<br/>
      "!   <br/>
      "!   * `dictionary`: Creates a custom dictionary enrichment that you define in a CSV
      "!    file.<br/>
      "!   <br/>
      "!   * `regular_expression`: Creates a custom regular expression enrichment from
      "!    regex syntax that you specify in the request.<br/>
      "!   <br/>
      "!   * `rule_based`: Creates an enrichment from an advanced rules model that is
      "!    created and exported as a ZIP file from Watson Knowledge Studio.<br/>
      "!   <br/>
      "!   * `uima_annotator`: Creates an enrichment from a custom UIMA text analysis model
      "!    that is defined in a PEAR file created in one of the following ways:<br/>
      "!   <br/>
      "!       * Watson Explorer Content Analytics Studio. **Note**: Supported in IBM Cloud
      "!    Pak for Data instances only.<br/>
      "!   <br/>
      "!       * Rule-based model that is created in Watson Knowledge Studio.<br/>
      "!   <br/>
      "!   * `watson_knowledge_studio_model`: Creates an enrichment from a Watson Knowledge
      "!    Studio machine learning model that is defined in a ZIP file.
      TYPE type STRING,
      "!   An object that contains options for the current enrichment. Starting with
      "!    version `2020-08-30`, the enrichment options are not included in responses from
      "!    the List Enrichments method.
      OPTIONS type T_ENRICHMENT_OPTIONS,
    end of T_CREATE_ENRICHMENT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The list of fetched fields.</p><br/>
    "!    <br/>
    "!    The fields are returned using a fully qualified name format, however, the format
    "!     differs slightly from that used by the query operations.<br/>
    "!    <br/>
    "!      * Fields which contain nested objects are assigned a type of
    "!     &quot;nested&quot;.<br/>
    "!    <br/>
    "!      * Fields which belong to a nested object are prefixed with `.properties` (for
    "!     example, `warnings.properties.severity` means that the `warnings` object has a
    "!     property called `severity`).
    begin of T_LIST_FIELDS_RESPONSE,
      "!   An array that contains information about each field in the collections.
      FIELDS type STANDARD TABLE OF T_FIELD WITH NON-UNIQUE DEFAULT KEY,
    end of T_LIST_FIELDS_RESPONSE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Returns the top documents ranked by the score of the query.</p>
    begin of T_QRY_AGGR_QUERY_TOP_HITS_AGGR,
      "!   Specifies that the aggregation type is `top_hits`.
      TYPE type STRING,
      "!   The number of documents to return.
      SIZE type INTEGER,
      "!   Identifier specified in the query request of this aggregation.
      NAME type STRING,
      "!   A query response that contains the matching documents for the preceding
      "!    aggregations.
      HITS type T_QUERY_TOP_HITS_AGGR_RESULT,
    end of T_QRY_AGGR_QUERY_TOP_HITS_AGGR.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A passage query result.</p>
    begin of T_QUERY_RESULT_PASSAGE,
      "!   The content of the extracted passage.
      PASSAGE_TEXT type STRING,
      "!   The position of the first character of the extracted passage in the originating
      "!    field.
      START_OFFSET type INTEGER,
      "!   The position after the last character of the extracted passage in the
      "!    originating field.
      END_OFFSET type INTEGER,
      "!   The label of the field from which the passage has been extracted.
      FIELD type STRING,
      "!   An arry of extracted answers to the specified query. Returned for natural
      "!    language queries when **passages.per_document** is `true`.
      ANSWERS type STANDARD TABLE OF T_RESULT_PASSAGE_ANSWER WITH NON-UNIQUE DEFAULT KEY,
    end of T_QUERY_RESULT_PASSAGE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    List of words to filter out of text that is submitted in</p>
    "!     queries.
    begin of T_STOP_WORD_LIST,
      "!   List of stop words.
      STOPWORDS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
    end of T_STOP_WORD_LIST.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Object specifying the training queries contained in the</p>
    "!     identified training set.
    begin of T_TRAINING_QUERY_SET,
      "!   Array of training queries. At least 50 queries are required for training to
      "!    begin. A maximum of 10,000 queries are returned.
      QUERIES type STANDARD TABLE OF T_TRAINING_QUERY WITH NON-UNIQUE DEFAULT KEY,
    end of T_TRAINING_QUERY_SET.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Metadata of a query result.</p>
    begin of T_QUERY_RESULT_METADATA,
      "!   The document retrieval source that produced this search result.
      DOCUMENT_RETRIEVAL_SOURCE type STRING,
      "!   The collection id associated with this training data set.
      COLLECTION_ID type STRING,
      "!   The confidence score for the given result. Calculated based on how relevant the
      "!    result is estimated to be. The score can range from `0.0` to `1.0`. The higher
      "!    the number, the more relevant the document. The `confidence` value for a result
      "!    was calculated using the model specified in the `document_retrieval_strategy`
      "!    field of the result set. This field is returned only if the
      "!    **natural_language_query** parameter is specified in the query.
      CONFIDENCE type DOUBLE,
    end of T_QUERY_RESULT_METADATA.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Result document for the specified query.</p>
    begin of T_QUERY_RESULT,
      "!   The unique identifier of the document.
      DOCUMENT_ID type STRING,
      "!   Metadata of the document.
      METADATA type JSONOBJECT,
      "!   Metadata of a query result.
      RESULT_METADATA type T_QUERY_RESULT_METADATA,
      "!   Passages from the document that best matches the query. Returned if
      "!    **passages.per_document** is `true`.
      DOCUMENT_PASSAGES type STANDARD TABLE OF T_QUERY_RESULT_PASSAGE WITH NON-UNIQUE DEFAULT KEY,
    end of T_QUERY_RESULT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Column-level cells, each applicable as a header to other</p>
    "!     cells in the same column as itself, of the current table.
    begin of T_TABLE_COLUMN_HEADERS,
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
    end of T_TABLE_COLUMN_HEADERS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Row-level cells, each applicable as a header to other cells</p>
    "!     in the same row as itself, of the current table.
    begin of T_TABLE_ROW_HEADERS,
      "!   The unique ID of the cell in the current table.
      CELL_ID type STRING,
      "!   The numeric location of the identified element in the document, represented with
      "!    two integers labeled `begin` and `end`.
      LOCATION type T_TABLE_ELEMENT_LOCATION,
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
    end of T_TABLE_ROW_HEADERS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Full table object retrieved from Table Understanding</p>
    "!     Enrichment.
    begin of T_TABLE_RESULT_TABLE,
      "!   The numeric location of the identified element in the document, represented with
      "!    two integers labeled `begin` and `end`.
      LOCATION type T_TABLE_ELEMENT_LOCATION,
      "!   The textual contents of the current table from the input document without
      "!    associated markup content.
      TEXT type STRING,
      "!   Text and associated location within a table.
      SECTION_TITLE type T_TABLE_TEXT_LOCATION,
      "!   Text and associated location within a table.
      TITLE type T_TABLE_TEXT_LOCATION,
      "!   An array of table-level cells that apply as headers to all the other cells in
      "!    the current table.
      TABLE_HEADERS type STANDARD TABLE OF T_TABLE_HEADERS WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of row-level cells, each applicable as a header to other cells in the
      "!    same row as itself, of the current table.
      ROW_HEADERS type STANDARD TABLE OF T_TABLE_ROW_HEADERS WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of column-level cells, each applicable as a header to other cells in
      "!    the same column as itself, of the current table.
      COLUMN_HEADERS type STANDARD TABLE OF T_TABLE_COLUMN_HEADERS WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of key-value pairs identified in the current table.
      KEY_VALUE_PAIRS type STANDARD TABLE OF T_TABLE_KEY_VALUE_PAIRS WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of cells that are neither table header nor column header nor row header
      "!    cells, of the current table with corresponding row and column header
      "!    associations.
      BODY_CELLS type STANDARD TABLE OF T_TABLE_BODY_CELLS WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of lists of textual entries across the document related to the current
      "!    table being parsed.
      CONTEXTS type STANDARD TABLE OF T_TABLE_TEXT_LOCATION WITH NON-UNIQUE DEFAULT KEY,
    end of T_TABLE_RESULT_TABLE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A tables whose content or context match a search query.</p>
    begin of T_QUERY_TABLE_RESULT,
      "!   The identifier for the retrieved table.
      TABLE_ID type STRING,
      "!   The identifier of the document the table was retrieved from.
      SOURCE_DOCUMENT_ID type STRING,
      "!   The identifier of the collection the table was retrieved from.
      COLLECTION_ID type STRING,
      "!   HTML snippet of the table info.
      TABLE_HTML type STRING,
      "!   The offset of the table html snippet in the original document html.
      TABLE_HTML_OFFSET type INTEGER,
      "!   Full table object retrieved from Table Understanding Enrichment.
      TABLE type T_TABLE_RESULT_TABLE,
    end of T_QUERY_TABLE_RESULT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A response that contains the documents and aggregations for</p>
    "!     the query.
    begin of T_QUERY_RESPONSE,
      "!   The number of matching results for the query. Results that match due to a
      "!    curation only are not counted in the total.
      MATCHING_RESULTS type INTEGER,
      "!   Array of document results for the query.
      RESULTS type STANDARD TABLE OF T_QUERY_RESULT WITH NON-UNIQUE DEFAULT KEY,
      "!   Array of aggregations for the query.
      AGGREGATIONS type STANDARD TABLE OF T_QUERY_AGGREGATION WITH NON-UNIQUE DEFAULT KEY,
      "!   An object contain retrieval type information.
      RETRIEVAL_DETAILS type T_RETRIEVAL_DETAILS,
      "!   Suggested correction to the submitted **natural_language_query** value.
      SUGGESTED_QUERY type STRING,
      "!   Array of suggested refinements. **Note**: The `suggested_refinements` parameter
      "!    that identified dynamic facets from the data is deprecated.
      SUGGESTED_REFINEMENTS type STANDARD TABLE OF T_QUERY_SUGGESTED_REFINEMENT WITH NON-UNIQUE DEFAULT KEY,
      "!   Array of table results.
      TABLE_RESULTS type STANDARD TABLE OF T_QUERY_TABLE_RESULT WITH NON-UNIQUE DEFAULT KEY,
      "!   Passages that best match the query from across all of the collections in the
      "!    project. Returned if **passages.per_document** is `false`.
      PASSAGES type STANDARD TABLE OF T_QUERY_RESPONSE_PASSAGE WITH NON-UNIQUE DEFAULT KEY,
    end of T_QUERY_RESPONSE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object that contains the converted document and any</p>
    "!     identified enrichments. Root-level fields from the original file are returned
    "!     also.
    begin of T_ANALYZED_DOCUMENT,
      "!   Array of notices that are triggered when the files are processed.
      NOTICES type STANDARD TABLE OF T_NOTICE WITH NON-UNIQUE DEFAULT KEY,
      "!   Result of the document analysis.
      RESULT type T_ANALYZED_RESULT,
    end of T_ANALYZED_DOCUMENT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A specialized histogram aggregation that uses dates to</p>
    "!     create interval segments.
    begin of T_QUERY_TIMESLICE_AGGREGATION,
      "!   Specifies that the aggregation type is `timeslice`.
      TYPE type STRING,
      "!   The date field name used to create the timeslice.
      FIELD type STRING,
      "!   The date interval value. Valid values are seconds, minutes, hours, days, weeks,
      "!    and years.
      INTERVAL type STRING,
      "!   Identifier that can optionally be specified in the query request of this
      "!    aggregation.
      NAME type STRING,
      "!   Array of aggregation results.
      RESULTS type STANDARD TABLE OF T_QUERY_TIMESLICE_AGGR_RESULT WITH NON-UNIQUE DEFAULT KEY,
    end of T_QUERY_TIMESLICE_AGGREGATION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Error response information.</p>
    begin of T_ERROR_RESPONSE,
      "!   The HTTP error status code.
      CODE type INTEGER,
      "!   A message describing the error.
      ERROR type STRING,
    end of T_ERROR_RESPONSE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An expansion definition. Each object respresents one set of</p>
    "!     expandable strings. For example, you could have expansions for the word `hot`
    "!     in one object, and expansions for the word `cold` in another. Follow these
    "!     guidelines when you add terms:<br/>
    "!    <br/>
    "!    * Specify the terms in lowercase. Lowercase terms expand to uppercase.<br/>
    "!    <br/>
    "!    * Multiword terms are supported only in bidirectional expansions.<br/>
    "!    <br/>
    "!    * Do not specify a term that is specified in the stop words list for the
    "!     collection.
    begin of T_EXPANSION,
      "!   A list of terms that will be expanded for this expansion. If specified, only the
      "!    items in this list are expanded.
      INPUT_TERMS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   A list of terms that this expansion will be expanded to. If specified without
      "!    **input_terms**, the list also functions as the input term list.
      EXPANDED_TERMS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
    end of T_EXPANSION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The query expansion definitions for the specified</p>
    "!     collection.
    begin of T_EXPANSIONS,
      "!   An array of query expansion definitions. <br/>
      "!   <br/>
      "!    Each object in the **expansions** array represents a term or set of terms that
      "!    will be expanded into other terms. Each expansion object can be configured as
      "!    `bidirectional` or `unidirectional`. <br/>
      "!   <br/>
      "!   * **Bidirectional**: Each entry in the `expanded_terms` list expands to include
      "!    all expanded terms. For example, a query for `ibm` expands to `ibm OR
      "!    international business machines OR big blue`.<br/>
      "!   <br/>
      "!   * **Unidirectional**: The terms in `input_terms` in the query are replaced by
      "!    the terms in `expanded_terms`. For example, a query for the often misused term
      "!    `on premise` is converted to `on premises OR on-premises` and does not contain
      "!    the original term. If you want an input term to be included in the query, then
      "!    repeat the input term in the expanded terms list.
      EXPANSIONS type STANDARD TABLE OF T_EXPANSION WITH NON-UNIQUE DEFAULT KEY,
    end of T_EXPANSIONS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object that contains a new name or description for a</p>
    "!     document classifier model.
    begin of T_UPD_DOC_CLASSIFIER_MODEL,
      "!   A new name for the enrichment.
      NAME type STRING,
      "!   A new description for the enrichment.
      DESCRIPTION type STRING,
    end of T_UPD_DOC_CLASSIFIER_MODEL.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object that contains an array of enrichment definitions.</p>
    begin of T_ENRICHMENTS,
      "!   An array of enrichment definitions.
      ENRICHMENTS type STANDARD TABLE OF T_ENRICHMENT WITH NON-UNIQUE DEFAULT KEY,
    end of T_ENRICHMENTS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information returned when a document is deleted.</p>
    begin of T_DELETE_DOCUMENT_RESPONSE,
      "!   The unique identifier of the document.
      DOCUMENT_ID type STRING,
      "!   Status of the document. A deleted document has the status deleted.
      STATUS type STRING,
    end of T_DELETE_DOCUMENT_RESPONSE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Detects sharp and unexpected changes in the frequency of a</p>
    "!     facet or facet value over time based on the past history of frequency changes
    "!     of the facet value.
    begin of T_QUERY_AGGR_QUERY_TREND_AGGR,
      "!   Specifies that the aggregation type is `trend`.
      TYPE type STRING,
      "!   Specifies the `term` or `group_by` aggregation for the facet that you want to
      "!    analyze.
      FACET type STRING,
      "!   Specifies the `timeslice` aggregation that defines the time segments.
      TIME_SEGMENTS type STRING,
      "!   Indicates whether to include estimated matching result information.
      SHW_ESTIMATED_MATCHING_RESULTS type BOOLEAN,
      "!   Indicates whether to include total matching documents information.
      SHOW_TOTAL_MATCHING_DOCUMENTS type BOOLEAN,
      "!   An array of aggregations.
      RESULTS type STANDARD TABLE OF T_QUERY_TREND_AGGR_RESULT WITH NON-UNIQUE DEFAULT KEY,
    end of T_QUERY_AGGR_QUERY_TREND_AGGR.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A modifier that narrows the document set of the</p>
    "!     subaggregations it precedes.
    begin of T_QUERY_AGGR_QUERY_FILTER_AGGR,
      "!   Specifies that the aggregation type is `filter`.
      TYPE type STRING,
      "!   The filter that is written in Discovery Query Language syntax and is applied to
      "!    the documents before subaggregations are run.
      MATCH type STRING,
      "!   Number of documents that match the filter.
      MATCHING_RESULTS type LONG,
      "!   An array of subaggregations.
      AGGREGATIONS type STANDARD TABLE OF JSONOBJECT WITH NON-UNIQUE DEFAULT KEY,
    end of T_QUERY_AGGR_QUERY_FILTER_AGGR.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object that contains a new name or description for a</p>
    "!     document classifier, updated training data, or new or updated test data.
    begin of T_UPDATE_DOCUMENT_CLASSIFIER,
      "!   A new name for the classifier.
      NAME type STRING,
      "!   A new description for the classifier.
      DESCRIPTION type STRING,
    end of T_UPDATE_DOCUMENT_CLASSIFIER.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Array of queries with curated responses for the specified</p>
    "!     project.
    begin of T_CURATIONS,
      "!   The project ID of the project that contains these curations.
      PROJECT_ID type STRING,
      "!   Array of curated queries and responses.
      CURATIONS type STANDARD TABLE OF T_CURATION WITH NON-UNIQUE DEFAULT KEY,
    end of T_CURATIONS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Detailed information about the specified project.</p>
    begin of T_PROJECT_CREATION,
      "!   The human readable name of this project.
      NAME type STRING,
      "!   The type of project.<br/>
      "!   <br/>
      "!   The `content_intelligence` type is a *Document Retrieval for Contracts* project
      "!    and the `other` type is a *Custom* project.<br/>
      "!   <br/>
      "!   The `content_mining` and `content_intelligence` types are available with Premium
      "!    plan managed deployments and installed deployments only.
      TYPE type STRING,
      "!   Default query parameters for this project.
      DEFAULT_QUERY_PARAMETERS type T_DEFAULT_QUERY_PARAMS,
    end of T_PROJECT_CREATION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Returns results from the field that is specified.</p>
    begin of T_QUERY_TERM_AGGREGATION,
      "!   Specifies that the aggregation type is `term`.
      TYPE type STRING,
      "!   The field in the document where the values come from.
      FIELD type STRING,
      "!   The number of results returned. Not returned if `relevancy:true` is specified in
      "!    the request.
      COUNT type INTEGER,
      "!   Identifier specified in the query request of this aggregation. Not returned if
      "!    `relevancy:true` is specified in the request.
      NAME type STRING,
      "!   An array of results.
      RESULTS type STANDARD TABLE OF T_QUERY_TERM_AGGR_RESULT WITH NON-UNIQUE DEFAULT KEY,
    end of T_QUERY_TERM_AGGREGATION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A restriction that alters the document set that is used by</p>
    "!     the aggregations that it precedes. Subsequent aggregations are applied to
    "!     nested documents from the specified field.
    begin of T_QUERY_NESTED_AGGREGATION,
      "!   Specifies that the aggregation type is `nested`.
      TYPE type STRING,
      "!   The path to the document field to scope subsequent aggregations to.
      PATH type STRING,
      "!   Number of nested documents found in the specified field.
      MATCHING_RESULTS type LONG,
      "!   An array of subaggregations.
      AGGREGATIONS type STANDARD TABLE OF JSONOBJECT WITH NON-UNIQUE DEFAULT KEY,
    end of T_QUERY_NESTED_AGGREGATION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Object that contains a new name for the specified project.</p>
    begin of T_PROJECT_NAME,
      "!   The new name to give this project.
      NAME type STRING,
    end of T_PROJECT_NAME.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Response object that contains an array of documents.</p>
    begin of T_LIST_DOCUMENTS_RESPONSE,
      "!   The number of matching results for the document query.
      MATCHING_RESULTS type INTEGER,
      "!   An array that lists the documents in a collection. Only the document ID of each
      "!    document is returned in the list. You can use the [Get document](#getdocument)
      "!    method to get more information about an individual document.
      DOCUMENTS type STANDARD TABLE OF T_DOCUMENT_DETAILS WITH NON-UNIQUE DEFAULT KEY,
    end of T_LIST_DOCUMENTS_RESPONSE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Result for the `topic` aggregation.</p>
    begin of T_QUERY_TOPIC_AGGR_RESULT,
      "!   Array of subaggregations  of type `term` or `group_by` and `timeslice`. Each
      "!    element of the matrix that is returned contains a **topic_indicator** that is
      "!    calculated from the combination of each aggregation value and segment of time.
      AGGREGATIONS type STANDARD TABLE OF JSONOBJECT WITH NON-UNIQUE DEFAULT KEY,
    end of T_QUERY_TOPIC_AGGR_RESULT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Detects how much the frequency of a given facet value</p>
    "!     deviates from the expected average for the given time period. This aggregation
    "!     type does not use data from previous time periods. It calculates an index by
    "!     using the averages of frequency counts of other facet values for the given time
    "!     period.
    begin of T_QUERY_AGGR_QUERY_TOPIC_AGGR,
      "!   Specifies that the aggregation type is `topic`.
      TYPE type STRING,
      "!   Specifies the `term` or `group_by` aggregation for the facet that you want to
      "!    analyze.
      FACET type STRING,
      "!   Specifies the `timeslice` aggregation that defines the time segments.
      TIME_SEGMENTS type STRING,
      "!   Indicates whether to include estimated matching result information.
      SHW_ESTIMATED_MATCHING_RESULTS type BOOLEAN,
      "!   Indicates whether to include total matching documents information.
      SHOW_TOTAL_MATCHING_DOCUMENTS type BOOLEAN,
      "!   An array of aggregations.
      RESULTS type STANDARD TABLE OF T_QUERY_TOPIC_AGGR_RESULT WITH NON-UNIQUE DEFAULT KEY,
    end of T_QUERY_AGGR_QUERY_TOPIC_AGGR.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Details about a specific project.</p>
    begin of T_PROJECT_CREATION_DETAILS,
      "!   The human readable name of this project.
      NAME type STRING,
      "!   The type of project.<br/>
      "!   <br/>
      "!   The `content_intelligence` type is a *Document Retrieval for Contracts* project
      "!    and the `other` type is a *Custom* project.<br/>
      "!   <br/>
      "!   The `content_mining` and `content_intelligence` types are available with Premium
      "!    plan managed deployments and installed deployments only.
      TYPE type STRING,
    end of T_PROJECT_CREATION_DETAILS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Separates document results into groups that meet the</p>
    "!     conditions you specify.
    begin of T_QUERY_GROUP_BY_AGGREGATION,
      "!   Specifies that the aggregation type is `group_by`.
      TYPE type STRING,
      "!   An array of results.
      RESULTS type STANDARD TABLE OF T_QUERY_GROUP_BY_AGGR_RESULT WITH NON-UNIQUE DEFAULT KEY,
    end of T_QUERY_GROUP_BY_AGGREGATION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object that manages the settings and data that is</p>
    "!     required to train a document classification model.
    begin of T_CREATE_DOCUMENT_CLASSIFIER,
      "!   A human-readable name of the document classifier.
      NAME type STRING,
      "!   A description of the document classifier.
      DESCRIPTION type STRING,
      "!   The language of the training data that is associated with the document
      "!    classifier. Language is specified by using the ISO 639-1 language code, such as
      "!    `en` for English or `ja` for Japanese.
      LANGUAGE type STRING,
      "!   The name of the field from the training and test data that contains the
      "!    classification labels.
      ANSWER_FIELD type STRING,
      "!   An array of enrichments to apply to the data that is used to train and test the
      "!    document classifier. The output from the enrichments is used as features by the
      "!    classifier to classify the document content both during training and at run
      "!    time.
      ENRICHMENTS type STANDARD TABLE OF T_DOC_CLASSIFIER_ENRICHMENT WITH NON-UNIQUE DEFAULT KEY,
      "!   An object with details for creating federated document classifier models.
      FEDERATED_CLASSIFICATION type T_CLASSIFIER_FEDERATED_MODEL,
    end of T_CREATE_DOCUMENT_CLASSIFIER.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Returns results from the field that is specified.</p>
    begin of T_QUERY_AGGR_QUERY_TERM_AGGR,
      "!   Specifies that the aggregation type is `term`.
      TYPE type STRING,
      "!   The field in the document where the values come from.
      FIELD type STRING,
      "!   The number of results returned. Not returned if `relevancy:true` is specified in
      "!    the request.
      COUNT type INTEGER,
      "!   Identifier specified in the query request of this aggregation. Not returned if
      "!    `relevancy:true` is specified in the request.
      NAME type STRING,
      "!   An array of results.
      RESULTS type STANDARD TABLE OF T_QUERY_TERM_AGGR_RESULT WITH NON-UNIQUE DEFAULT KEY,
    end of T_QUERY_AGGR_QUERY_TERM_AGGR.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Detects how much the frequency of a given facet value</p>
    "!     deviates from the expected average for the given time period. This aggregation
    "!     type does not use data from previous time periods. It calculates an index by
    "!     using the averages of frequency counts of other facet values for the given time
    "!     period.
    begin of T_QUERY_TOPIC_AGGREGATION,
      "!   Specifies that the aggregation type is `topic`.
      TYPE type STRING,
      "!   Specifies the `term` or `group_by` aggregation for the facet that you want to
      "!    analyze.
      FACET type STRING,
      "!   Specifies the `timeslice` aggregation that defines the time segments.
      TIME_SEGMENTS type STRING,
      "!   Indicates whether to include estimated matching result information.
      SHW_ESTIMATED_MATCHING_RESULTS type BOOLEAN,
      "!   Indicates whether to include total matching documents information.
      SHOW_TOTAL_MATCHING_DOCUMENTS type BOOLEAN,
      "!   An array of aggregations.
      RESULTS type STANDARD TABLE OF T_QUERY_TOPIC_AGGR_RESULT WITH NON-UNIQUE DEFAULT KEY,
    end of T_QUERY_TOPIC_AGGREGATION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Response object that contains an array of collection</p>
    "!     details.
    begin of T_LIST_COLLECTIONS_RESPONSE,
      "!   An array that contains information about each collection in the project.
      COLLECTIONS type STANDARD TABLE OF T_COLLECTION WITH NON-UNIQUE DEFAULT KEY,
    end of T_LIST_COLLECTIONS_RESPONSE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A modifier that narrows the document set of the</p>
    "!     subaggregations it precedes.
    begin of T_QUERY_FILTER_AGGREGATION,
      "!   Specifies that the aggregation type is `filter`.
      TYPE type STRING,
      "!   The filter that is written in Discovery Query Language syntax and is applied to
      "!    the documents before subaggregations are run.
      MATCH type STRING,
      "!   Number of documents that match the filter.
      MATCHING_RESULTS type LONG,
      "!   An array of subaggregations.
      AGGREGATIONS type STANDARD TABLE OF JSONOBJECT WITH NON-UNIQUE DEFAULT KEY,
    end of T_QUERY_FILTER_AGGREGATION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object that represents the collection to be updated.</p>
    begin of T_UPDATE_COLLECTION,
      "!   The new name of the collection.
      NAME type STRING,
      "!   The new description of the collection.
      DESCRIPTION type STRING,
      "!   An array of enrichments that are applied to this collection.
      ENRICHMENTS type STANDARD TABLE OF T_COLLECTION_ENRICHMENT WITH NON-UNIQUE DEFAULT KEY,
    end of T_UPDATE_COLLECTION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Object that contains notice query results.</p>
    begin of T_QUERY_NOTICES_RESPONSE,
      "!   The number of matching results.
      MATCHING_RESULTS type INTEGER,
      "!   Array of document results that match the query.
      NOTICES type STANDARD TABLE OF T_NOTICE WITH NON-UNIQUE DEFAULT KEY,
    end of T_QUERY_NOTICES_RESPONSE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Returns a scalar calculation across all documents for the</p>
    "!     field specified. Possible calculations include min, max, sum, average, and
    "!     unique_count.
    begin of T_QRY_AGGR_QRY_CLCLTN_AGGR,
      "!   Specifies the calculation type, such as &apos;average`, `max`, `min`, `sum`, or
      "!    `unique_count`.
      TYPE type STRING,
      "!   The field to perform the calculation on.
      FIELD type STRING,
      "!   The value of the calculation.
      VALUE type DOUBLE,
    end of T_QRY_AGGR_QRY_CLCLTN_AGGR.

constants:
  "! <p class="shorttext synchronized" lang="en">List of required fields per type.</p>
  begin of C_REQUIRED_FIELDS,
    T_MDL_EVALUATION_MACRO_AVERAGE type string value '|PRECISION|RECALL|F1|',
    T_PER_CLASS_MODEL_EVALUATION type string value '|NAME|PRECISION|RECALL|F1|',
    T_MDL_EVALUATION_MICRO_AVERAGE type string value '|PRECISION|RECALL|F1|',
    T_CLASSIFIER_MODEL_EVALUATION type string value '|MICRO_AVERAGE|MACRO_AVERAGE|PER_CLASS|',
    T_DOCUMENT_CLASSIFIER_MODEL type string value '|NAME|',
    T_PRJCT_LST_DTLS_RLVNCY_TRNNG1 type string value '|',
    T_PROJECT_LIST_DETAILS type string value '|',
    T_LIST_PROJECTS_RESPONSE type string value '|',
    T_QUERY_PAIR_AGGR_RESULT type string value '|',
    T_QUERY_AGGR_QUERY_PAIR_AGGR type string value '|',
    T_QUERY_LARGE_TABLE_RESULTS type string value '|',
    T_CURATION_RESULT type string value '|',
    T_CURATED_RESULTS type string value '|',
    T_TABLE_ELEMENT_LOCATION type string value '|BEGIN|END|',
    T_TRAINING_EXAMPLE type string value '|DOCUMENT_ID|COLLECTION_ID|RELEVANCE|',
    T_TRAINING_QUERY type string value '|NATURAL_LANGUAGE_QUERY|EXAMPLES|',
    T_TABLE_CELL_VALUES type string value '|',
    T_TABLE_CELL_KEY type string value '|',
    T_TABLE_KEY_VALUE_PAIRS type string value '|',
    T_CURATION_STATUS type string value '|',
    T_QUERY_TOP_HITS_AGGR_RESULT type string value '|MATCHING_RESULTS|',
    T_CURATION type string value '|',
    T_CMPNNT_STTNGS_FLDS_SHWN_TTL type string value '|',
    T_COMPONENT_SETTINGS_AGGR type string value '|',
    T_CMPNNT_STTNGS_FLDS_SHWN_BODY type string value '|',
    T_CMPNNT_SETTINGS_FIELDS_SHOWN type string value '|',
    T_COMPONENT_SETTINGS_RESPONSE type string value '|',
    T_DFLT_QRY_PRMS_SGGSTD_RFNMNTS type string value '|',
    T_DFLT_QRY_PARAMS_TAB_RESULTS type string value '|',
    T_DFLT_QUERY_PARAMS_PASSAGES type string value '|',
    T_DEFAULT_QUERY_PARAMS type string value '|',
    T_PROJECT_DETAILS type string value '|',
    T_DOCUMENT_ACCEPTED type string value '|',
    T_QUERY_TREND_AGGR_RESULT type string value '|',
    T_QUERY_TREND_AGGREGATION type string value '|',
    T_RESULT_PASSAGE_ANSWER type string value '|',
    T_QUERY_RESPONSE_PASSAGE type string value '|',
    T_DOC_CLASSIFIER_MODEL_TRAIN type string value '|NAME|',
    T_QUERY_PAIR_AGGREGATION type string value '|',
    T_QUERY_CALCULATION_AGGR type string value '|FIELD|',
    T_CLLCTN_DTLS_SMRT_DOC_UNDRST1 type string value '|',
    T_COLLECTION_ENRICHMENT type string value '|',
    T_COLLECTION_DETAILS type string value '|NAME|',
    T_CLASSIFIER_FEDERATED_MODEL type string value '|FIELD|',
    T_DOC_CLASSIFIER_ENRICHMENT type string value '|ENRICHMENT_ID|FIELDS|',
    T_DOCUMENT_CLASSIFIER type string value '|NAME|',
    T_DOCUMENT_CLASSIFIERS type string value '|',
    T_QUERY_TERM_AGGR_RESULT type string value '|KEY|MATCHING_RESULTS|',
    T_TABLE_COLUMN_HEADER_IDS type string value '|',
    T_QUERY_TIMESLICE_AGGR_RESULT type string value '|KEY_AS_STRING|KEY|MATCHING_RESULTS|',
    T_QRY_AGGR_QRY_TIMESLICE_AGGR type string value '|FIELD|INTERVAL|',
    T_FIELD type string value '|',
    T_QUERY_LARGE_SIMILAR type string value '|',
    T_QUERY_HISTOGRAM_AGGR_RESULT type string value '|KEY|MATCHING_RESULTS|',
    T_QUERY_HISTOGRAM_AGGREGATION type string value '|FIELD|INTERVAL|',
    T_TABLE_ROW_HEADER_IDS type string value '|',
    T_PROJECT_REL_TRAIN_STATUS type string value '|',
    T_QRY_AGGR_QRY_HISTOGRAM_AGGR type string value '|FIELD|INTERVAL|',
    T_ANALYZED_RESULT type string value '|',
    T_QUERY_LARGE_PASSAGES type string value '|',
    T_QRY_LRG_SGGSTD_REFINEMENTS type string value '|',
    T_QUERY_LARGE type string value '|',
    T_ENRICHMENT_OPTIONS type string value '|',
    T_ENRICHMENT type string value '|',
    T_QUERY_GROUP_BY_AGGR_RESULT type string value '|KEY|MATCHING_RESULTS|',
    T_QRY_AGGR_QUERY_GROUP_BY_AGGR type string value '|',
    T_COLLECTION type string value '|',
    T_DOCUMENT_CLASSIFIER_MODELS type string value '|',
    T_TAB_ROW_HEADER_TEXTS_NORM type string value '|',
    T_DOCUMENT_ATTRIBUTE type string value '|',
    T_TABLE_ROW_HEADER_TEXTS type string value '|',
    T_TABLE_COLUMN_HEADER_TEXTS type string value '|',
    T_TAB_COLUMN_HEADER_TEXTS_NORM type string value '|',
    T_TABLE_BODY_CELLS type string value '|',
    T_TABLE_TEXT_LOCATION type string value '|',
    T_QUERY_TOP_HITS_AGGREGATION type string value '|SIZE|',
    T_DOCUMENT_DETAILS_CHILDREN type string value '|',
    T_NOTICE type string value '|',
    T_DOCUMENT_DETAILS type string value '|',
    T_QUERY_AGGR_QUERY_NESTED_AGGR type string value '|PATH|MATCHING_RESULTS|',
    T_COMPLETIONS type string value '|',
    T_UPDATE_ENRICHMENT type string value '|NAME|',
    T_QUERY_SUGGESTED_REFINEMENT type string value '|',
    T_TABLE_HEADERS type string value '|',
    T_RETRIEVAL_DETAILS type string value '|',
    T_CREATE_ENRICHMENT type string value '|',
    T_LIST_FIELDS_RESPONSE type string value '|',
    T_QRY_AGGR_QUERY_TOP_HITS_AGGR type string value '|SIZE|',
    T_QUERY_RESULT_PASSAGE type string value '|',
    T_STOP_WORD_LIST type string value '|STOPWORDS|',
    T_TRAINING_QUERY_SET type string value '|',
    T_QUERY_RESULT_METADATA type string value '|COLLECTION_ID|',
    T_QUERY_RESULT type string value '|DOCUMENT_ID|RESULT_METADATA|',
    T_TABLE_COLUMN_HEADERS type string value '|',
    T_TABLE_ROW_HEADERS type string value '|',
    T_TABLE_RESULT_TABLE type string value '|',
    T_QUERY_TABLE_RESULT type string value '|',
    T_QUERY_RESPONSE type string value '|',
    T_ANALYZED_DOCUMENT type string value '|',
    T_QUERY_TIMESLICE_AGGREGATION type string value '|FIELD|INTERVAL|',
    T_ERROR_RESPONSE type string value '|CODE|ERROR|',
    T_EXPANSION type string value '|EXPANDED_TERMS|',
    T_EXPANSIONS type string value '|EXPANSIONS|',
    T_UPD_DOC_CLASSIFIER_MODEL type string value '|',
    T_ENRICHMENTS type string value '|',
    T_DELETE_DOCUMENT_RESPONSE type string value '|',
    T_QUERY_AGGR_QUERY_TREND_AGGR type string value '|',
    T_QUERY_AGGR_QUERY_FILTER_AGGR type string value '|MATCH|MATCHING_RESULTS|',
    T_UPDATE_DOCUMENT_CLASSIFIER type string value '|',
    T_CURATIONS type string value '|',
    T_PROJECT_CREATION type string value '|NAME|TYPE|',
    T_QUERY_TERM_AGGREGATION type string value '|',
    T_QUERY_NESTED_AGGREGATION type string value '|PATH|MATCHING_RESULTS|',
    T_PROJECT_NAME type string value '|',
    T_LIST_DOCUMENTS_RESPONSE type string value '|',
    T_QUERY_TOPIC_AGGR_RESULT type string value '|',
    T_QUERY_AGGR_QUERY_TOPIC_AGGR type string value '|',
    T_PROJECT_CREATION_DETAILS type string value '|NAME|TYPE|',
    T_QUERY_GROUP_BY_AGGREGATION type string value '|',
    T_CREATE_DOCUMENT_CLASSIFIER type string value '|NAME|LANGUAGE|ANSWER_FIELD|',
    T_QUERY_AGGR_QUERY_TERM_AGGR type string value '|',
    T_QUERY_TOPIC_AGGREGATION type string value '|',
    T_LIST_COLLECTIONS_RESPONSE type string value '|',
    T_QUERY_FILTER_AGGREGATION type string value '|MATCH|MATCHING_RESULTS|',
    T_UPDATE_COLLECTION type string value '|',
    T_QUERY_NOTICES_RESPONSE type string value '|',
    T_QRY_AGGR_QRY_CLCLTN_AGGR type string value '|FIELD|',
    __DUMMY type string value SPACE,
  end of C_REQUIRED_FIELDS .

constants:
  "! <p class="shorttext synchronized" lang="en">Map ABAP identifiers to service identifiers.</p>
  begin of C_ABAPNAME_DICTIONARY,
     COLLECTIONS type string value 'collections',
     MATCHING_RESULTS type string value 'matching_results',
     DOCUMENTS type string value 'documents',
     BEGIN type string value 'begin',
     END type string value 'end',
     RESULTS type string value 'results',
     AGGREGATIONS type string value 'aggregations',
     RETRIEVAL_DETAILS type string value 'retrieval_details',
     SUGGESTED_QUERY type string value 'suggested_query',
     SUGGESTED_REFINEMENTS type string value 'suggested_refinements',
     TABLE_RESULTS type string value 'table_results',
     PASSAGES type string value 'passages',
     DOCUMENT_ID type string value 'document_id',
     METADATA type string value 'metadata',
     INNER type string value 'inner',
     RESULT_METADATA type string value 'result_metadata',
     DOCUMENT_PASSAGES type string value 'document_passages',
     DOCUMENT_RETRIEVAL_SOURCE type string value 'document_retrieval_source',
     COLLECTION_ID type string value 'collection_id',
     CONFIDENCE type string value 'confidence',
     PASSAGE_TEXT type string value 'passage_text',
     START_OFFSET type string value 'start_offset',
     END_OFFSET type string value 'end_offset',
     FIELD type string value 'field',
     ANSWERS type string value 'answers',
     PASSAGE_SCORE type string value 'passage_score',
     TABLE_ID type string value 'table_id',
     SOURCE_DOCUMENT_ID type string value 'source_document_id',
     TABLE_HTML type string value 'table_html',
     TABLE_HTML_OFFSET type string value 'table_html_offset',
     TABLE type string value 'table',
     TEXT type string value 'text',
     TYPE type string value 'type',
     COUNT type string value 'count',
     NAME type string value 'name',
     KEY type string value 'key',
     RELEVANCY type string value 'relevancy',
     TOTAL_MATCHING_DOCUMENTS type string value 'total_matching_documents',
     ESTIMATED_MATCHING_RESULTS type string value 'estimated_matching_results',
     INTERVAL type string value 'interval',
     KEY_AS_STRING type string value 'key_as_string',
     PATH type string value 'path',
     MATCH type string value 'match',
     VALUE type string value 'value',
     SIZE type string value 'size',
     HITS type string value 'hits',
     FIRST type string value 'first',
     SECOND type string value 'second',
     SHW_ESTIMATED_MATCHING_RESULTS type string value 'show_estimated_matching_results',
     SHOW_TOTAL_MATCHING_DOCUMENTS type string value 'show_total_matching_documents',
     FACET type string value 'facet',
     TIME_SEGMENTS type string value 'time_segments',
     CELL_ID type string value 'cell_id',
     LOCATION type string value 'location',
     ROW_INDEX_BEGIN type string value 'row_index_begin',
     ROW_INDEX_END type string value 'row_index_end',
     COLUMN_INDEX_BEGIN type string value 'column_index_begin',
     COLUMN_INDEX_END type string value 'column_index_end',
     TEXT_NORMALIZED type string value 'text_normalized',
     ROW_HEADER_IDS type string value 'row_header_ids',
     ROW_HEADER_TEXTS type string value 'row_header_texts',
     ROW_HEADER_TEXTS_NORMALIZED type string value 'row_header_texts_normalized',
     COLUMN_HEADER_IDS type string value 'column_header_ids',
     COLUMN_HEADER_TEXTS type string value 'column_header_texts',
     COLUMN_HEADER_TEXTS_NORMALIZED type string value 'column_header_texts_normalized',
     ATTRIBUTES type string value 'attributes',
     ID type string value 'id',
     SECTION_TITLE type string value 'section_title',
     TITLE type string value 'title',
     TABLE_HEADERS type string value 'table_headers',
     ROW_HEADERS type string value 'row_headers',
     COLUMN_HEADERS type string value 'column_headers',
     KEY_VALUE_PAIRS type string value 'key_value_pairs',
     BODY_CELLS type string value 'body_cells',
     CONTEXTS type string value 'contexts',
     CODE type string value 'code',
     ERROR type string value 'error',
     COLLECTION_IDS type string value 'collection_ids',
     FILTER type string value 'filter',
     QUERY type string value 'query',
     NATURAL_LANGUAGE_QUERY type string value 'natural_language_query',
     AGGREGATION type string value 'aggregation',
     RETURN type string value 'return',
     RETURN_FIELD type string value 'return_field',
     OFFSET type string value 'offset',
     SORT type string value 'sort',
     HIGHLIGHT type string value 'highlight',
     SPELLING_SUGGESTIONS type string value 'spelling_suggestions',
     SIMILAR type string value 'similar',
     DOCUMENT_RETRIEVAL_STRATEGY type string value 'document_retrieval_strategy',
     COMPLETIONS type string value 'completions',
     FIELDS_SHOWN type string value 'fields_shown',
     AUTOCOMPLETE type string value 'autocomplete',
     STRUCTURED_SEARCH type string value 'structured_search',
     RESULTS_PER_PAGE type string value 'results_per_page',
     BODY type string value 'body',
     USE_PASSAGE type string value 'use_passage',
     LABEL type string value 'label',
     MULTIPLE_SELECTIONS_ALLOWED type string value 'multiple_selections_allowed',
     VISUALIZATION_TYPE type string value 'visualization_type',
     STATUS type string value 'status',
     QUERY_ID type string value 'query_id',
     CREATED type string value 'created',
     UPDATED type string value 'updated',
     EXAMPLES type string value 'examples',
     RELEVANCE type string value 'relevance',
     QUERIES type string value 'queries',
     FIELDS type string value 'fields',
     NOTICES type string value 'notices',
     NOTICE_ID type string value 'notice_id',
     SEVERITY type string value 'severity',
     STEP type string value 'step',
     DESCRIPTION type string value 'description',
     PROJECT_ID type string value 'project_id',
     CURATIONS type string value 'curations',
     CURATION_ID type string value 'curation_id',
     CURATED_RESULTS type string value 'curated_results',
     SNIPPET type string value 'snippet',
     LANGUAGE type string value 'language',
     ENRICHMENTS type string value 'enrichments',
     SMART_DOCUMENT_UNDERSTANDING type string value 'smart_document_understanding',
     CHILDREN type string value 'children',
     FILENAME type string value 'filename',
     FILE_TYPE type string value 'file_type',
     SHA256 type string value 'sha256',
     ENRICHMENT_ID type string value 'enrichment_id',
     PROJECTS type string value 'projects',
     RELEVANCY_TRAINING_STATUS type string value 'relevancy_training_status',
     COLLECTION_COUNT type string value 'collection_count',
     DEFAULT_QUERY_PARAMETERS type string value 'default_query_parameters',
     DATA_UPDATED type string value 'data_updated',
     TOTAL_EXAMPLES type string value 'total_examples',
     SUFFICIENT_LABEL_DIVERSITY type string value 'sufficient_label_diversity',
     PROCESSING type string value 'processing',
     MINIMUM_EXAMPLES_ADDED type string value 'minimum_examples_added',
     SUCCESSFULLY_TRAINED type string value 'successfully_trained',
     AVAILABLE type string value 'available',
     MINIMUM_QUERIES_ADDED type string value 'minimum_queries_added',
     OPTIONS type string value 'options',
     LANGUAGES type string value 'languages',
     ENTITY_TYPE type string value 'entity_type',
     REGULAR_EXPRESSION type string value 'regular_expression',
     RESULT_FIELD type string value 'result_field',
     CLASSIFIER_ID type string value 'classifier_id',
     MODEL_ID type string value 'model_id',
     CONFIDENCE_THRESHOLD type string value 'confidence_threshold',
     TOP_K type string value 'top_k',
     RESULT type string value 'result',
     ANSWER_TEXT type string value 'answer_text',
     CLASSIFIERS type string value 'classifiers',
     RECOGNIZED_FIELDS type string value 'recognized_fields',
     ANSWER_FIELD type string value 'answer_field',
     TRAINING_DATA_FILE type string value 'training_data_file',
     TEST_DATA_FILE type string value 'test_data_file',
     FEDERATED_CLASSIFICATION type string value 'federated_classification',
     MODELS type string value 'models',
     EVALUATION type string value 'evaluation',
     DEPLOYED_AT type string value 'deployed_at',
     MICRO_AVERAGE type string value 'micro_average',
     MACRO_AVERAGE type string value 'macro_average',
     PER_CLASS type string value 'per_class',
     PRECISION type string value 'precision',
     RECALL type string value 'recall',
     F1 type string value 'f1',
     LEARNING_RATE type string value 'learning_rate',
     L1_REGULARIZATION_STRENGTHS type string value 'l1_regularization_strengths',
     L2_REGULARIZATION_STRENGTHS type string value 'l2_regularization_strengths',
     TRAINING_MAX_STEPS type string value 'training_max_steps',
     IMPROVEMENT_RATIO type string value 'improvement_ratio',
     STOPWORDS type string value 'stopwords',
     EXPANSIONS type string value 'expansions',
     INPUT_TERMS type string value 'input_terms',
     EXPANDED_TERMS type string value 'expanded_terms',
     HAVE_NOTICES type string value 'have_notices',
     ENABLED type string value 'enabled',
     CHARACTERS type string value 'characters',
     PER_DOCUMENT type string value 'per_document',
     MAX_PER_DOCUMENT type string value 'max_per_document',
     FIND_ANSWERS type string value 'find_answers',
     MAX_ANSWERS_PER_PASSAGE type string value 'max_answers_per_passage',
     DOCUMENT_IDS type string value 'document_ids',
     MODEL type string value 'model',
  end of C_ABAPNAME_DICTIONARY .


  methods GET_APPNAME
    redefinition .
  methods GET_REQUEST_PROP
    redefinition .
  methods GET_SDK_VERSION_DATE
    redefinition .


    "! <p class="shorttext synchronized" lang="en">List projects</p>
    "!   Lists existing projects for this instance.
    "!
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_LIST_PROJECTS_RESPONSE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_PROJECTS
    importing
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_LIST_PROJECTS_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Create a project</p>
    "!   Create a new project for this instance
    "!
    "! @parameter I_PROJECTCREATION |
    "!   An object that represents the project to be created.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_PROJECT_DETAILS
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods CREATE_PROJECT
    importing
      !I_PROJECTCREATION type T_PROJECT_CREATION
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_PROJECT_DETAILS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Get project</p>
    "!   Get details on the specified project.
    "!
    "! @parameter I_PROJECT_ID |
    "!   The ID of the project. This information can be found from the *Integrate and
    "!    Deploy* page in Discovery.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_PROJECT_DETAILS
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_PROJECT
    importing
      !I_PROJECT_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_PROJECT_DETAILS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Update a project</p>
    "!   Update the specified project&apos;s name.
    "!
    "! @parameter I_PROJECT_ID |
    "!   The ID of the project. This information can be found from the *Integrate and
    "!    Deploy* page in Discovery.
    "! @parameter I_PROJECTNAME |
    "!   An object that represents the new name of the project.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_PROJECT_DETAILS
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods UPDATE_PROJECT
    importing
      !I_PROJECT_ID type STRING
      !I_PROJECTNAME type T_PROJECT_NAME optional
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_PROJECT_DETAILS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Delete a project</p>
    "!   Deletes the specified project. <br/>
    "!   <br/>
    "!   **Important:** Deleting a project deletes everything that is part of the
    "!    specified project, including all collections.
    "!
    "! @parameter I_PROJECT_ID |
    "!   The ID of the project. This information can be found from the *Integrate and
    "!    Deploy* page in Discovery.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_PROJECT
    importing
      !I_PROJECT_ID type STRING
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">List fields</p>
    "!   Gets a list of the unique fields (and their types) stored in the specified
    "!    collections.
    "!
    "! @parameter I_PROJECT_ID |
    "!   The ID of the project. This information can be found from the *Integrate and
    "!    Deploy* page in Discovery.
    "! @parameter I_COLLECTION_IDS |
    "!   Comma separated list of the collection IDs. If this parameter is not specified,
    "!    all collections in the project are used.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_LIST_FIELDS_RESPONSE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_FIELDS
    importing
      !I_PROJECT_ID type STRING
      !I_COLLECTION_IDS type TT_STRING optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_LIST_FIELDS_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">List collections</p>
    "!   Lists existing collections for the specified project.
    "!
    "! @parameter I_PROJECT_ID |
    "!   The ID of the project. This information can be found from the *Integrate and
    "!    Deploy* page in Discovery.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_LIST_COLLECTIONS_RESPONSE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_COLLECTIONS
    importing
      !I_PROJECT_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_LIST_COLLECTIONS_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Create a collection</p>
    "!   Create a new collection in the specified project.
    "!
    "! @parameter I_PROJECT_ID |
    "!   The ID of the project. This information can be found from the *Integrate and
    "!    Deploy* page in Discovery.
    "! @parameter I_COLLECTIONDETAILS |
    "!   An object that represents the collection to be created.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_COLLECTION_DETAILS
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods CREATE_COLLECTION
    importing
      !I_PROJECT_ID type STRING
      !I_COLLECTIONDETAILS type T_COLLECTION_DETAILS
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_COLLECTION_DETAILS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Get collection</p>
    "!   Get details about the specified collection.
    "!
    "! @parameter I_PROJECT_ID |
    "!   The ID of the project. This information can be found from the *Integrate and
    "!    Deploy* page in Discovery.
    "! @parameter I_COLLECTION_ID |
    "!   The ID of the collection.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_COLLECTION_DETAILS
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_COLLECTION
    importing
      !I_PROJECT_ID type STRING
      !I_COLLECTION_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_COLLECTION_DETAILS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Update a collection</p>
    "!   Updates the specified collection&apos;s name, description, and enrichments.
    "!
    "! @parameter I_PROJECT_ID |
    "!   The ID of the project. This information can be found from the *Integrate and
    "!    Deploy* page in Discovery.
    "! @parameter I_COLLECTION_ID |
    "!   The ID of the collection.
    "! @parameter I_UPDATECOLLECTION |
    "!   An object that represents the collection to be updated.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_COLLECTION_DETAILS
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods UPDATE_COLLECTION
    importing
      !I_PROJECT_ID type STRING
      !I_COLLECTION_ID type STRING
      !I_UPDATECOLLECTION type T_UPDATE_COLLECTION
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_COLLECTION_DETAILS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Delete a collection</p>
    "!   Deletes the specified collection from the project. All documents stored in the
    "!    specified collection and not shared is also deleted.
    "!
    "! @parameter I_PROJECT_ID |
    "!   The ID of the project. This information can be found from the *Integrate and
    "!    Deploy* page in Discovery.
    "! @parameter I_COLLECTION_ID |
    "!   The ID of the collection.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_COLLECTION
    importing
      !I_PROJECT_ID type STRING
      !I_COLLECTION_ID type STRING
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">List documents</p>
    "!   Lists the documents in the specified collection. The list includes only the
    "!    document ID of each document and returns information for up to 10,000
    "!    documents.<br/>
    "!   <br/>
    "!   **Note**: This method is available only from Cloud Pak for Data version 4.0.9
    "!    and later installed instances and from Plus and Enterprise plan IBM
    "!    Cloud-managed instances. It is not currently available from Premium plan
    "!    instances.
    "!
    "! @parameter I_PROJECT_ID |
    "!   The ID of the project. This information can be found from the *Integrate and
    "!    Deploy* page in Discovery.
    "! @parameter I_COLLECTION_ID |
    "!   The ID of the collection.
    "! @parameter I_COUNT |
    "!   The maximum number of documents to return. Up to 1,000 documents are returned by
    "!    default. The maximum number allowed is 10,000.
    "! @parameter I_STATUS |
    "!   Filters the documents to include only documents with the specified ingestion
    "!    status. The options include:<br/>
    "!   <br/>
    "!   * `available`: Ingestion is finished and the document is indexed.<br/>
    "!   <br/>
    "!   * `failed`: Ingestion is finished, but the document is not indexed because of an
    "!    error.<br/>
    "!   <br/>
    "!   * `pending`: The document is uploaded, but the ingestion process is not
    "!    started.<br/>
    "!   <br/>
    "!   * `processing`: Ingestion is in progress.<br/>
    "!   <br/>
    "!   You can specify one status value or add a comma-separated list of more than one
    "!    status value. For example, `available,failed`.
    "! @parameter I_HAS_NOTICES |
    "!   If set to `true`, only documents that have notices, meaning documents for which
    "!    warnings or errors were generated during the ingestion, are returned. If set to
    "!    `false`, only documents that don&apos;t have notices are returned. If
    "!    unspecified, no filter based on notices is applied.<br/>
    "!   <br/>
    "!   Notice details are not available in the result, but you can use the [Query
    "!    collection notices](#querycollectionnotices) method to find details by adding
    "!    the parameter `query=notices.document_id:&#123;document-id&#125;`.
    "! @parameter I_IS_PARENT |
    "!   If set to `true`, only parent documents, meaning documents that were split
    "!    during the ingestion process and resulted in two or more child documents, are
    "!    returned. If set to `false`, only child documents are returned. If unspecified,
    "!    no filter based on the parent or child relationship is applied.<br/>
    "!   <br/>
    "!   CSV files, for example, are split into separate documents per line and JSON
    "!    files are split into separate documents per object.
    "! @parameter I_PARENT_DOCUMENT_ID |
    "!   Filters the documents to include only child documents that were generated when
    "!    the specified parent document was processed.
    "! @parameter I_SHA256 |
    "!   Filters the documents to include only documents with the specified SHA-256 hash.
    "!    Format the hash as a hexadecimal string.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_LIST_DOCUMENTS_RESPONSE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_DOCUMENTS
    importing
      !I_PROJECT_ID type STRING
      !I_COLLECTION_ID type STRING
      !I_COUNT type INTEGER default 1000
      !I_STATUS type STRING optional
      !I_HAS_NOTICES type BOOLEAN optional
      !I_IS_PARENT type BOOLEAN optional
      !I_PARENT_DOCUMENT_ID type STRING optional
      !I_SHA256 type STRING optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_LIST_DOCUMENTS_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Add a document</p>
    "!   Add a document to a collection with optional metadata.<br/>
    "!   <br/>
    "!   Returns immediately after the system has accepted the document for
    "!    processing.<br/>
    "!   <br/>
    "!   Use this method to upload a file to the collection. You cannot use this method
    "!    to crawl an external data source.<br/>
    "!   <br/>
    "!    * For a list of supported file types, see the [product
    "!    documentation](/docs/discovery-data?topic=discovery-data-collections#supportedf
    "!   iletypes).<br/>
    "!   <br/>
    "!    * You must provide document content, metadata, or both. If the request is
    "!    missing both document content and metadata, it is rejected.<br/>
    "!   <br/>
    "!     * You can set the **Content-Type** parameter on the **file** part to indicate
    "!    the media type of the document. If the **Content-Type** parameter is missing or
    "!    is one of the generic media types (for example, `application/octet-stream`),
    "!    then the service attempts to automatically detect the document&apos;s media
    "!    type.<br/>
    "!   <br/>
    "!    *  If the document is uploaded to a collection that shares its data with
    "!    another collection, the **X-Watson-Discovery-Force** header must be set to
    "!    `true`.<br/>
    "!   <br/>
    "!    * In curl requests only, you can assign an ID to a document that you add by
    "!    appending the ID to the endpoint
    "!    (`/v2/projects/&#123;project_id&#125;/collections/&#123;collection_id&#125;/doc
    "!   uments/&#123;document_id&#125;`). If a document already exists with the
    "!    specified ID, it is replaced.<br/>
    "!   <br/>
    "!   For more information about how certain file types and field names are handled
    "!    when a file is added to a collection, see the [product
    "!    documentation](/docs/discovery-data?topic=discovery-data-index-overview#field-n
    "!   ame-limits).
    "!
    "! @parameter I_PROJECT_ID |
    "!   The ID of the project. This information can be found from the *Integrate and
    "!    Deploy* page in Discovery.
    "! @parameter I_COLLECTION_ID |
    "!   The ID of the collection.
    "! @parameter I_FILE |
    "!   When adding a document, the content of the document to ingest. For maximum
    "!    supported file size limits, see [the
    "!    documentation](/docs/discovery-data?topic=discovery-data-collections#collection
    "!   s-doc-limits).<br/>
    "!   <br/>
    "!   When analyzing a document, the content of the document to analyze but not
    "!    ingest. Only the `application/json` content type is supported currently. For
    "!    maximum supported file size limits, see [the product
    "!    documentation](/docs/discovery-data?topic=discovery-data-analyzeapi#analyzeapi-
    "!   limits).
    "! @parameter I_FILENAME |
    "!   The filename for file.
    "! @parameter I_FILE_CONTENT_TYPE |
    "!   The content type of file.
    "! @parameter I_METADATA |
    "!   Add information about the file that you want to include in the response.<br/>
    "!   <br/>
    "!   The maximum supported metadata file size is 1 MB. Metadata parts larger than 1
    "!    MB are rejected.<br/>
    "!   <br/>
    "!   Example:<br/>
    "!   <br/>
    "!    ``` <br/>
    "!    &#123; <br/>
    "!     &quot;filename&quot;: &quot;favorites2.json&quot;,<br/>
    "!     &quot;file_type&quot;: &quot;json&quot;<br/>
    "!    &#125;.
    "! @parameter I_X_WATSON_DISCOVERY_FORCE |
    "!   When `true`, the uploaded document is added to the collection even if the data
    "!    for that collection is shared with other collections.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_DOCUMENT_ACCEPTED
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods ADD_DOCUMENT
    importing
      !I_PROJECT_ID type STRING
      !I_COLLECTION_ID type STRING
      !I_FILE type FILE optional
      !I_FILENAME type STRING optional
      !I_FILE_CONTENT_TYPE type STRING optional
      !I_METADATA type STRING optional
      !I_X_WATSON_DISCOVERY_FORCE type BOOLEAN default c_boolean_false
      !I_contenttype type string default 'multipart/form-data'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_DOCUMENT_ACCEPTED
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Get document details</p>
    "!   Get details about a specific document, whether the document is added by
    "!    uploading a file or by crawling an external data source.<br/>
    "!   <br/>
    "!   **Note**: This method is available only from Cloud Pak for Data version 4.0.9
    "!    and later installed instances and from Plus and Enterprise plan IBM
    "!    Cloud-managed instances. It is not currently available from Premium plan
    "!    instances.
    "!
    "! @parameter I_PROJECT_ID |
    "!   The ID of the project. This information can be found from the *Integrate and
    "!    Deploy* page in Discovery.
    "! @parameter I_COLLECTION_ID |
    "!   The ID of the collection.
    "! @parameter I_DOCUMENT_ID |
    "!   The ID of the document.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_DOCUMENT_DETAILS
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_DOCUMENT
    importing
      !I_PROJECT_ID type STRING
      !I_COLLECTION_ID type STRING
      !I_DOCUMENT_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_DOCUMENT_DETAILS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Update a document</p>
    "!   Replace an existing document or add a document with a specified document ID.
    "!    Starts ingesting a document with optional metadata.<br/>
    "!   <br/>
    "!   Use this method to upload a file to a collection. You cannot use this method to
    "!    crawl an external data source.<br/>
    "!   <br/>
    "!   If the document is uploaded to a collection that shares its data with another
    "!    collection, the **X-Watson-Discovery-Force** header must be set to `true`.<br/>
    "!   <br/>
    "!   **Notes:**<br/>
    "!   <br/>
    "!    * Uploading a new document with this method automatically replaces any existing
    "!    document stored with the same document ID.<br/>
    "!   <br/>
    "!    * If an uploaded document is split into child documents during ingestion, all
    "!    existing child documents are overwritten, even if the updated version of the
    "!    document has fewer child documents.
    "!
    "! @parameter I_PROJECT_ID |
    "!   The ID of the project. This information can be found from the *Integrate and
    "!    Deploy* page in Discovery.
    "! @parameter I_COLLECTION_ID |
    "!   The ID of the collection.
    "! @parameter I_DOCUMENT_ID |
    "!   The ID of the document.
    "! @parameter I_FILE |
    "!   When adding a document, the content of the document to ingest. For maximum
    "!    supported file size limits, see [the
    "!    documentation](/docs/discovery-data?topic=discovery-data-collections#collection
    "!   s-doc-limits).<br/>
    "!   <br/>
    "!   When analyzing a document, the content of the document to analyze but not
    "!    ingest. Only the `application/json` content type is supported currently. For
    "!    maximum supported file size limits, see [the product
    "!    documentation](/docs/discovery-data?topic=discovery-data-analyzeapi#analyzeapi-
    "!   limits).
    "! @parameter I_FILENAME |
    "!   The filename for file.
    "! @parameter I_FILE_CONTENT_TYPE |
    "!   The content type of file.
    "! @parameter I_METADATA |
    "!   Add information about the file that you want to include in the response.<br/>
    "!   <br/>
    "!   The maximum supported metadata file size is 1 MB. Metadata parts larger than 1
    "!    MB are rejected.<br/>
    "!   <br/>
    "!   Example:<br/>
    "!   <br/>
    "!    ``` <br/>
    "!    &#123; <br/>
    "!     &quot;filename&quot;: &quot;favorites2.json&quot;,<br/>
    "!     &quot;file_type&quot;: &quot;json&quot;<br/>
    "!    &#125;.
    "! @parameter I_X_WATSON_DISCOVERY_FORCE |
    "!   When `true`, the uploaded document is added to the collection even if the data
    "!    for that collection is shared with other collections.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_DOCUMENT_ACCEPTED
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods UPDATE_DOCUMENT
    importing
      !I_PROJECT_ID type STRING
      !I_COLLECTION_ID type STRING
      !I_DOCUMENT_ID type STRING
      !I_FILE type FILE optional
      !I_FILENAME type STRING optional
      !I_FILE_CONTENT_TYPE type STRING optional
      !I_METADATA type STRING optional
      !I_X_WATSON_DISCOVERY_FORCE type BOOLEAN default c_boolean_false
      !I_contenttype type string default 'multipart/form-data'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_DOCUMENT_ACCEPTED
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Delete a document</p>
    "!   Deletes the document with the document ID that you specify from the collection.
    "!    Removes uploaded documents from the collection permanently. If you delete a
    "!    document that was added by crawling an external data source, the document will
    "!    be added again with the next scheduled crawl of the data source. The delete
    "!    function removes the document from the collection, not from the external data
    "!    source.<br/>
    "!   <br/>
    "!   **Note:** Files such as CSV or JSON files generate subdocuments when they are
    "!    added to a collection. If you delete a subdocument, and then repeat the action
    "!    that created it, the deleted document is added back in to your collection. To
    "!    remove subdocuments that are generated by an uploaded file, delete the original
    "!    document instead. You can get the document ID of the original document from the
    "!    `parent_document_id` of the subdocument result.
    "!
    "! @parameter I_PROJECT_ID |
    "!   The ID of the project. This information can be found from the *Integrate and
    "!    Deploy* page in Discovery.
    "! @parameter I_COLLECTION_ID |
    "!   The ID of the collection.
    "! @parameter I_DOCUMENT_ID |
    "!   The ID of the document.
    "! @parameter I_X_WATSON_DISCOVERY_FORCE |
    "!   When `true`, the uploaded document is added to the collection even if the data
    "!    for that collection is shared with other collections.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_DELETE_DOCUMENT_RESPONSE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_DOCUMENT
    importing
      !I_PROJECT_ID type STRING
      !I_COLLECTION_ID type STRING
      !I_DOCUMENT_ID type STRING
      !I_X_WATSON_DISCOVERY_FORCE type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_DELETE_DOCUMENT_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">Query a project</p>
    "!   Search your data by submitting queries that are written in natural language or
    "!    formatted in the Discovery Query Language. For more information, see the
    "!    [Discovery
    "!    documentation](/docs/discovery-data?topic=discovery-data-query-concepts). The
    "!    default query parameters differ by project type. For more information about the
    "!    project default settings, see the [Discovery
    "!    documentation](/docs/discovery-data?topic=discovery-data-query-defaults). See
    "!    [the Projects API documentation](#create-project) for details about how to set
    "!    custom default query settings. <br/>
    "!   <br/>
    "!   The length of the UTF-8 encoding of the POST body cannot exceed 10,000 bytes,
    "!    which is roughly equivalent to 10,000 characters in English.
    "!
    "! @parameter I_PROJECT_ID |
    "!   The ID of the project. This information can be found from the *Integrate and
    "!    Deploy* page in Discovery.
    "! @parameter I_QUERY_LONG |
    "!   An object that represents the query to be submitted.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_QUERY_RESPONSE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods QUERY
    importing
      !I_PROJECT_ID type STRING
      !I_QUERY_LONG type T_QUERY_LARGE optional
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_QUERY_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Get Autocomplete Suggestions</p>
    "!   Returns completion query suggestions for the specified prefix.
    "!
    "! @parameter I_PROJECT_ID |
    "!   The ID of the project. This information can be found from the *Integrate and
    "!    Deploy* page in Discovery.
    "! @parameter I_PREFIX |
    "!   The prefix to use for autocompletion. For example, the prefix `Ho` could
    "!    autocomplete to `hot`, `housing`, or `how`.
    "! @parameter I_COLLECTION_IDS |
    "!   Comma separated list of the collection IDs. If this parameter is not specified,
    "!    all collections in the project are used.
    "! @parameter I_FIELD |
    "!   The field in the result documents that autocompletion suggestions are identified
    "!    from.
    "! @parameter I_COUNT |
    "!   The number of autocompletion suggestions to return.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_COMPLETIONS
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_AUTOCOMPLETION
    importing
      !I_PROJECT_ID type STRING
      !I_PREFIX type STRING
      !I_COLLECTION_IDS type TT_STRING optional
      !I_FIELD type STRING optional
      !I_COUNT type INTEGER default 5
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_COMPLETIONS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Query collection notices</p>
    "!   Finds collection-level notices (errors and warnings) that are generated when
    "!    documents are ingested.
    "!
    "! @parameter I_PROJECT_ID |
    "!   The ID of the project. This information can be found from the *Integrate and
    "!    Deploy* page in Discovery.
    "! @parameter I_COLLECTION_ID |
    "!   The ID of the collection.
    "! @parameter I_FILTER |
    "!   Searches for documents that match the Discovery Query Language criteria that is
    "!    specified as input. Filter calls are cached and are faster than query calls
    "!    because the results are not ordered by relevance. When used with the
    "!    `aggregation`, `query`, or `natural_language_query` parameters, the `filter`
    "!    parameter runs first. This parameter is useful for limiting results to those
    "!    that contain specific metadata values.
    "! @parameter I_QUERY |
    "!   A query search that is written in the Discovery Query Language and returns all
    "!    matching documents in your data set with full enrichments and full text, and
    "!    with the most relevant documents listed first.
    "! @parameter I_NATURAL_LANGUAGE_QUERY |
    "!   A natural language query that returns relevant documents by using training data
    "!    and natural language understanding.
    "! @parameter I_COUNT |
    "!   Number of results to return. The maximum for the **count** and **offset** values
    "!    together in any one query is **10,000**.
    "! @parameter I_OFFSET |
    "!   The number of query results to skip at the beginning. For example, if the total
    "!    number of results that are returned is 10 and the offset is 8, it returns the
    "!    last two results. The maximum for the **count** and **offset** values together
    "!    in any one query is **10000**.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_QUERY_NOTICES_RESPONSE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods QUERY_COLLECTION_NOTICES
    importing
      !I_PROJECT_ID type STRING
      !I_COLLECTION_ID type STRING
      !I_FILTER type STRING optional
      !I_QUERY type STRING optional
      !I_NATURAL_LANGUAGE_QUERY type STRING optional
      !I_COUNT type INTEGER default 10
      !I_OFFSET type INTEGER optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_QUERY_NOTICES_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Query project notices</p>
    "!   Finds project-level notices (errors and warnings). Currently, project-level
    "!    notices are generated by relevancy training.
    "!
    "! @parameter I_PROJECT_ID |
    "!   The ID of the project. This information can be found from the *Integrate and
    "!    Deploy* page in Discovery.
    "! @parameter I_FILTER |
    "!   Searches for documents that match the Discovery Query Language criteria that is
    "!    specified as input. Filter calls are cached and are faster than query calls
    "!    because the results are not ordered by relevance. When used with the
    "!    `aggregation`, `query`, or `natural_language_query` parameters, the `filter`
    "!    parameter runs first. This parameter is useful for limiting results to those
    "!    that contain specific metadata values.
    "! @parameter I_QUERY |
    "!   A query search that is written in the Discovery Query Language and returns all
    "!    matching documents in your data set with full enrichments and full text, and
    "!    with the most relevant documents listed first.
    "! @parameter I_NATURAL_LANGUAGE_QUERY |
    "!   A natural language query that returns relevant documents by using training data
    "!    and natural language understanding.
    "! @parameter I_COUNT |
    "!   Number of results to return. The maximum for the **count** and **offset** values
    "!    together in any one query is **10,000**.
    "! @parameter I_OFFSET |
    "!   The number of query results to skip at the beginning. For example, if the total
    "!    number of results that are returned is 10 and the offset is 8, it returns the
    "!    last two results. The maximum for the **count** and **offset** values together
    "!    in any one query is **10000**.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_QUERY_NOTICES_RESPONSE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods QUERY_NOTICES
    importing
      !I_PROJECT_ID type STRING
      !I_FILTER type STRING optional
      !I_QUERY type STRING optional
      !I_NATURAL_LANGUAGE_QUERY type STRING optional
      !I_COUNT type INTEGER default 10
      !I_OFFSET type INTEGER optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_QUERY_NOTICES_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">Get a custom stop words list</p>
    "!   Returns the custom stop words list that is used by the collection. For
    "!    information about the default stop words lists that are applied to queries, see
    "!    [the product
    "!    documentation](/docs/discovery-data?topic=discovery-data-stopwords).
    "!
    "! @parameter I_PROJECT_ID |
    "!   The ID of the project. This information can be found from the *Integrate and
    "!    Deploy* page in Discovery.
    "! @parameter I_COLLECTION_ID |
    "!   The ID of the collection.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_STOP_WORD_LIST
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_STOPWORD_LIST
    importing
      !I_PROJECT_ID type STRING
      !I_COLLECTION_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_STOP_WORD_LIST
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Create a custom stop words list</p>
    "!   Adds a list of custom stop words. Stop words are words that you want the service
    "!    to ignore when they occur in a query because they&apos;re not useful in
    "!    distinguishing the semantic meaning of the query. The stop words list cannot
    "!    contain more than 1 million characters.<br/>
    "!   <br/>
    "!   A default stop words list is used by all collections. The default list is
    "!    applied both at indexing time and at query time. A custom stop words list that
    "!    you add is used at query time only.<br/>
    "!   <br/>
    "!   The custom stop words list augments the default stop words list; you cannot
    "!    remove stop words. For information about the default stop words lists per
    "!    language, see [the product
    "!    documentation](/docs/discovery-data?topic=discovery-data-stopwords).
    "!
    "! @parameter I_PROJECT_ID |
    "!   The ID of the project. This information can be found from the *Integrate and
    "!    Deploy* page in Discovery.
    "! @parameter I_COLLECTION_ID |
    "!   The ID of the collection.
    "! @parameter I_STOPWORDLIST |
    "!   No documentation available.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_STOP_WORD_LIST
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods CREATE_STOPWORD_LIST
    importing
      !I_PROJECT_ID type STRING
      !I_COLLECTION_ID type STRING
      !I_STOPWORDLIST type T_STOP_WORD_LIST optional
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_STOP_WORD_LIST
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Delete a custom stop words list</p>
    "!   Deletes a custom stop words list to stop using it in queries against the
    "!    collection. After a custom stop words list is deleted, the default stop words
    "!    list is used.
    "!
    "! @parameter I_PROJECT_ID |
    "!   The ID of the project. This information can be found from the *Integrate and
    "!    Deploy* page in Discovery.
    "! @parameter I_COLLECTION_ID |
    "!   The ID of the collection.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_STOPWORD_LIST
    importing
      !I_PROJECT_ID type STRING
      !I_COLLECTION_ID type STRING
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Get the expansion list</p>
    "!   Returns the current expansion list for the specified collection. If an expansion
    "!    list is not specified, an empty expansions array is returned.
    "!
    "! @parameter I_PROJECT_ID |
    "!   The ID of the project. This information can be found from the *Integrate and
    "!    Deploy* page in Discovery.
    "! @parameter I_COLLECTION_ID |
    "!   The ID of the collection.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_EXPANSIONS
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_EXPANSIONS
    importing
      !I_PROJECT_ID type STRING
      !I_COLLECTION_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_EXPANSIONS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Create or update an expansion list</p>
    "!   Creates or replaces the expansion list for this collection. An expansion list
    "!    introduces alternative wording for key terms that are mentioned in your
    "!    collection. By identifying synonyms or common misspellings, you expand the
    "!    scope of a query beyond exact matches. The maximum number of expanded terms
    "!    allowed per collection is 5,000.
    "!
    "! @parameter I_PROJECT_ID |
    "!   The ID of the project. This information can be found from the *Integrate and
    "!    Deploy* page in Discovery.
    "! @parameter I_COLLECTION_ID |
    "!   The ID of the collection.
    "! @parameter I_BODY |
    "!   An object that defines the expansion list.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_EXPANSIONS
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods CREATE_EXPANSIONS
    importing
      !I_PROJECT_ID type STRING
      !I_COLLECTION_ID type STRING
      !I_BODY type T_EXPANSIONS
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_EXPANSIONS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Delete the expansion list</p>
    "!   Removes the expansion information for this collection. To disable query
    "!    expansion for a collection, delete the expansion list.
    "!
    "! @parameter I_PROJECT_ID |
    "!   The ID of the project. This information can be found from the *Integrate and
    "!    Deploy* page in Discovery.
    "! @parameter I_COLLECTION_ID |
    "!   The ID of the collection.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_EXPANSIONS
    importing
      !I_PROJECT_ID type STRING
      !I_COLLECTION_ID type STRING
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">List component settings</p>
    "!   Returns default configuration settings for components.
    "!
    "! @parameter I_PROJECT_ID |
    "!   The ID of the project. This information can be found from the *Integrate and
    "!    Deploy* page in Discovery.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_COMPONENT_SETTINGS_RESPONSE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_COMPONENT_SETTINGS
    importing
      !I_PROJECT_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_COMPONENT_SETTINGS_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">List training queries</p>
    "!   List the training queries for the specified project.
    "!
    "! @parameter I_PROJECT_ID |
    "!   The ID of the project. This information can be found from the *Integrate and
    "!    Deploy* page in Discovery.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_TRAINING_QUERY_SET
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_TRAINING_QUERIES
    importing
      !I_PROJECT_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_TRAINING_QUERY_SET
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Delete training queries</p>
    "!   Removes all training queries for the specified project.
    "!
    "! @parameter I_PROJECT_ID |
    "!   The ID of the project. This information can be found from the *Integrate and
    "!    Deploy* page in Discovery.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_TRAINING_QUERIES
    importing
      !I_PROJECT_ID type STRING
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Create training query</p>
    "!   Add a query to the training data for this project. The query can contain a
    "!    filter and natural language query.
    "!
    "! @parameter I_PROJECT_ID |
    "!   The ID of the project. This information can be found from the *Integrate and
    "!    Deploy* page in Discovery.
    "! @parameter I_TRAININGQUERY |
    "!   An object that represents the query to be submitted. At least 50 queries are
    "!    required for training to begin. A maximum of 10,000 queries are allowed.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_TRAINING_QUERY
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods CREATE_TRAINING_QUERY
    importing
      !I_PROJECT_ID type STRING
      !I_TRAININGQUERY type T_TRAINING_QUERY
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_TRAINING_QUERY
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Get a training data query</p>
    "!   Get details for a specific training data query, including the query string and
    "!    all examples
    "!
    "! @parameter I_PROJECT_ID |
    "!   The ID of the project. This information can be found from the *Integrate and
    "!    Deploy* page in Discovery.
    "! @parameter I_QUERY_ID |
    "!   The ID of the query used for training.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_TRAINING_QUERY
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_TRAINING_QUERY
    importing
      !I_PROJECT_ID type STRING
      !I_QUERY_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_TRAINING_QUERY
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Update a training query</p>
    "!   Updates an existing training query and it&apos;s examples.
    "!
    "! @parameter I_PROJECT_ID |
    "!   The ID of the project. This information can be found from the *Integrate and
    "!    Deploy* page in Discovery.
    "! @parameter I_QUERY_ID |
    "!   The ID of the query used for training.
    "! @parameter I_BODY |
    "!   The body of the example that is to be added to the specified query.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_TRAINING_QUERY
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods UPDATE_TRAINING_QUERY
    importing
      !I_PROJECT_ID type STRING
      !I_QUERY_ID type STRING
      !I_BODY type T_TRAINING_QUERY
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_TRAINING_QUERY
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Delete a training data query</p>
    "!   Removes details from a training data query, including the query string and all
    "!    examples.
    "!
    "! @parameter I_PROJECT_ID |
    "!   The ID of the project. This information can be found from the *Integrate and
    "!    Deploy* page in Discovery.
    "! @parameter I_QUERY_ID |
    "!   The ID of the query used for training.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_TRAINING_QUERY
    importing
      !I_PROJECT_ID type STRING
      !I_QUERY_ID type STRING
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">List enrichments</p>
    "!   Lists the enrichments available to this project. The *Part of Speech* and
    "!    *Sentiment of Phrases* enrichments might be listed, but are reserved for
    "!    internal use only.
    "!
    "! @parameter I_PROJECT_ID |
    "!   The ID of the project. This information can be found from the *Integrate and
    "!    Deploy* page in Discovery.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_ENRICHMENTS
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_ENRICHMENTS
    importing
      !I_PROJECT_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_ENRICHMENTS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Create an enrichment</p>
    "!   Create an enrichment for use with the specified project. To apply the enrichment
    "!    to a collection in the project, use the [Collections
    "!    API](/apidocs/discovery-data#createcollection).
    "!
    "! @parameter I_PROJECT_ID |
    "!   The ID of the project. This information can be found from the *Integrate and
    "!    Deploy* page in Discovery.
    "! @parameter I_ENRICHMENT |
    "!   Information about a specific enrichment.
    "! @parameter I_FILE |
    "!   The enrichment file to upload. Expected file types per enrichment are as
    "!    follows:<br/>
    "!   <br/>
    "!   * CSV for `dictionary`<br/>
    "!   <br/>
    "!   * PEAR for `uima_annotator` and `rule_based` (Explorer)<br/>
    "!   <br/>
    "!   * ZIP for `watson_knowledge_studio_model` and `rule_based` (Studio Advanced Rule
    "!    Editor).
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_ENRICHMENT
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods CREATE_ENRICHMENT
    importing
      !I_PROJECT_ID type STRING
      !I_ENRICHMENT type T_CREATE_ENRICHMENT
      !I_FILE type FILE optional
      !I_FILE_CT type STRING default ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-ALL
      !I_contenttype type string default 'multipart/form-data'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_ENRICHMENT
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Get enrichment</p>
    "!   Get details about a specific enrichment.
    "!
    "! @parameter I_PROJECT_ID |
    "!   The ID of the project. This information can be found from the *Integrate and
    "!    Deploy* page in Discovery.
    "! @parameter I_ENRICHMENT_ID |
    "!   The ID of the enrichment.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_ENRICHMENT
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_ENRICHMENT
    importing
      !I_PROJECT_ID type STRING
      !I_ENRICHMENT_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_ENRICHMENT
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Update an enrichment</p>
    "!   Updates an existing enrichment&apos;s name and description.
    "!
    "! @parameter I_PROJECT_ID |
    "!   The ID of the project. This information can be found from the *Integrate and
    "!    Deploy* page in Discovery.
    "! @parameter I_ENRICHMENT_ID |
    "!   The ID of the enrichment.
    "! @parameter I_UPDATEENRICHMENT |
    "!   An object that lists the new name and description for an enrichment.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_ENRICHMENT
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods UPDATE_ENRICHMENT
    importing
      !I_PROJECT_ID type STRING
      !I_ENRICHMENT_ID type STRING
      !I_UPDATEENRICHMENT type T_UPDATE_ENRICHMENT
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_ENRICHMENT
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Delete an enrichment</p>
    "!   Deletes an existing enrichment from the specified project. <br/>
    "!   <br/>
    "!   **Note:** Only enrichments that have been manually created can be deleted.
    "!
    "! @parameter I_PROJECT_ID |
    "!   The ID of the project. This information can be found from the *Integrate and
    "!    Deploy* page in Discovery.
    "! @parameter I_ENRICHMENT_ID |
    "!   The ID of the enrichment.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_ENRICHMENT
    importing
      !I_PROJECT_ID type STRING
      !I_ENRICHMENT_ID type STRING
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">List document classifiers</p>
    "!   Get a list of the document classifiers in a project. Returns only the name and
    "!    classifier ID of each document classifier.
    "!
    "! @parameter I_PROJECT_ID |
    "!   The ID of the project. This information can be found from the *Integrate and
    "!    Deploy* page in Discovery.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_DOCUMENT_CLASSIFIERS
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_DOCUMENT_CLASSIFIERS
    importing
      !I_PROJECT_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_DOCUMENT_CLASSIFIERS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Create a document classifier</p>
    "!   Create a document classifier. You can use the API to create a document
    "!    classifier in any project type. After you create a document classifier, you can
    "!    use the Enrichments API to create a classifier enrichment, and then the
    "!    Collections API to apply the enrichment to a collection in the project.<br/>
    "!   <br/>
    "!   **Note:** This method is supported on installed instances (IBM Cloud Pak for
    "!    Data) or IBM Cloud-managed Premium or Enterprise plan instances.
    "!
    "! @parameter I_PROJECT_ID |
    "!   The ID of the project. This information can be found from the *Integrate and
    "!    Deploy* page in Discovery.
    "! @parameter I_TRAINING_DATA |
    "!   The training data CSV file to upload. The CSV file must have headers. The file
    "!    must include a field that contains the text you want to classify and a field
    "!    that contains the classification labels that you want to use to classify your
    "!    data. If you want to specify multiple values in a single field, use a semicolon
    "!    as the value separator. For a sample file, see [the product
    "!    documentation](/docs/discovery-data?topic=discovery-data-cm-doc-classifier).
    "! @parameter I_CLASSIFIER |
    "!   An object that manages the settings and data that is required to train a
    "!    document classification model.
    "! @parameter I_TEST_DATA |
    "!   The CSV with test data to upload. The column values in the test file must be the
    "!    same as the column values in the training data file. If no test data is
    "!    provided, the training data is split into two separate groups of training and
    "!    test data.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_DOCUMENT_CLASSIFIER
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods CREATE_DOCUMENT_CLASSIFIER
    importing
      !I_PROJECT_ID type STRING
      !I_TRAINING_DATA type FILE
      !I_CLASSIFIER type T_CREATE_DOCUMENT_CLASSIFIER
      !I_TEST_DATA type FILE optional
      !I_TRAINING_DATA_CT type STRING default ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-ALL
      !I_TEST_DATA_CT type STRING default ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-ALL
      !I_contenttype type string default 'multipart/form-data'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_DOCUMENT_CLASSIFIER
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Get a document classifier</p>
    "!   Get details about a specific document classifier.
    "!
    "! @parameter I_PROJECT_ID |
    "!   The ID of the project. This information can be found from the *Integrate and
    "!    Deploy* page in Discovery.
    "! @parameter I_CLASSIFIER_ID |
    "!   The ID of the classifier.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_DOCUMENT_CLASSIFIER
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_DOCUMENT_CLASSIFIER
    importing
      !I_PROJECT_ID type STRING
      !I_CLASSIFIER_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_DOCUMENT_CLASSIFIER
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Update a document classifier</p>
    "!   Update the document classifier name or description, update the training data, or
    "!    add or update the test data.
    "!
    "! @parameter I_PROJECT_ID |
    "!   The ID of the project. This information can be found from the *Integrate and
    "!    Deploy* page in Discovery.
    "! @parameter I_CLASSIFIER_ID |
    "!   The ID of the classifier.
    "! @parameter I_CLASSIFIER |
    "!   An object that contains a new name or description for a document classifier,
    "!    updated training data, or new or updated test data.
    "! @parameter I_TRAINING_DATA |
    "!   The training data CSV file to upload. The CSV file must have headers. The file
    "!    must include a field that contains the text you want to classify and a field
    "!    that contains the classification labels that you want to use to classify your
    "!    data. If you want to specify multiple values in a single column, use a
    "!    semicolon as the value separator. For a sample file, see [the product
    "!    documentation](/docs/discovery-data?topic=discovery-data-cm-doc-classifier).
    "! @parameter I_TEST_DATA |
    "!   The CSV with test data to upload. The column values in the test file must be the
    "!    same as the column values in the training data file. If no test data is
    "!    provided, the training data is split into two separate groups of training and
    "!    test data.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_DOCUMENT_CLASSIFIER
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods UPDATE_DOCUMENT_CLASSIFIER
    importing
      !I_PROJECT_ID type STRING
      !I_CLASSIFIER_ID type STRING
      !I_CLASSIFIER type T_UPDATE_DOCUMENT_CLASSIFIER
      !I_TRAINING_DATA type FILE optional
      !I_TEST_DATA type FILE optional
      !I_TRAINING_DATA_CT type STRING default ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-ALL
      !I_TEST_DATA_CT type STRING default ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-ALL
      !I_contenttype type string default 'multipart/form-data'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_DOCUMENT_CLASSIFIER
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Delete a document classifier</p>
    "!   Deletes an existing document classifier from the specified project.
    "!
    "! @parameter I_PROJECT_ID |
    "!   The ID of the project. This information can be found from the *Integrate and
    "!    Deploy* page in Discovery.
    "! @parameter I_CLASSIFIER_ID |
    "!   The ID of the classifier.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_DOCUMENT_CLASSIFIER
    importing
      !I_PROJECT_ID type STRING
      !I_CLASSIFIER_ID type STRING
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">List document classifier models</p>
    "!   Get a list of the document classifier models in a project. Returns only the name
    "!    and model ID of each document classifier model.
    "!
    "! @parameter I_PROJECT_ID |
    "!   The ID of the project. This information can be found from the *Integrate and
    "!    Deploy* page in Discovery.
    "! @parameter I_CLASSIFIER_ID |
    "!   The ID of the classifier.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_DOCUMENT_CLASSIFIER_MODELS
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LST_DOCUMENT_CLASSIFIER_MODELS
    importing
      !I_PROJECT_ID type STRING
      !I_CLASSIFIER_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_DOCUMENT_CLASSIFIER_MODELS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Create a document classifier model</p>
    "!   Create a document classifier model by training a model that uses the data and
    "!    classifier settings defined in the specified document classifier.<br/>
    "!   <br/>
    "!   **Note:** This method is supported on installed intances (IBM Cloud Pak for
    "!    Data) or IBM Cloud-managed Premium or Enterprise plan instances.
    "!
    "! @parameter I_PROJECT_ID |
    "!   The ID of the project. This information can be found from the *Integrate and
    "!    Deploy* page in Discovery.
    "! @parameter I_CLASSIFIER_ID |
    "!   The ID of the classifier.
    "! @parameter I_DOCUMENTCLASSIFIERMODELTRAIN |
    "!   An object that contains the training configuration information for the document
    "!    classifier to be trained.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_DOCUMENT_CLASSIFIER_MODEL
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods CRE_DOCUMENT_CLASSIFIER_MODEL
    importing
      !I_PROJECT_ID type STRING
      !I_CLASSIFIER_ID type STRING
      !I_DOCUMENTCLASSIFIERMODELTRAIN type T_DOC_CLASSIFIER_MODEL_TRAIN
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_DOCUMENT_CLASSIFIER_MODEL
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Get a document classifier model</p>
    "!   Get details about a specific document classifier model.
    "!
    "! @parameter I_PROJECT_ID |
    "!   The ID of the project. This information can be found from the *Integrate and
    "!    Deploy* page in Discovery.
    "! @parameter I_CLASSIFIER_ID |
    "!   The ID of the classifier.
    "! @parameter I_MODEL_ID |
    "!   The ID of the classifier model.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_DOCUMENT_CLASSIFIER_MODEL
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_DOCUMENT_CLASSIFIER_MODEL
    importing
      !I_PROJECT_ID type STRING
      !I_CLASSIFIER_ID type STRING
      !I_MODEL_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_DOCUMENT_CLASSIFIER_MODEL
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Update a document classifier model</p>
    "!   Update the document classifier model name or description.
    "!
    "! @parameter I_PROJECT_ID |
    "!   The ID of the project. This information can be found from the *Integrate and
    "!    Deploy* page in Discovery.
    "! @parameter I_CLASSIFIER_ID |
    "!   The ID of the classifier.
    "! @parameter I_MODEL_ID |
    "!   The ID of the classifier model.
    "! @parameter I_UPDTDCMNTCLSSFRMDL |
    "!   An object that lists a new name or description for a document classifier model.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_DOCUMENT_CLASSIFIER_MODEL
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods UPD_DOCUMENT_CLASSIFIER_MODEL
    importing
      !I_PROJECT_ID type STRING
      !I_CLASSIFIER_ID type STRING
      !I_MODEL_ID type STRING
      !I_UPDTDCMNTCLSSFRMDL type T_UPD_DOC_CLASSIFIER_MODEL
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_DOCUMENT_CLASSIFIER_MODEL
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Delete a document classifier model</p>
    "!   Deletes an existing document classifier model from the specified project.
    "!
    "! @parameter I_PROJECT_ID |
    "!   The ID of the project. This information can be found from the *Integrate and
    "!    Deploy* page in Discovery.
    "! @parameter I_CLASSIFIER_ID |
    "!   The ID of the classifier.
    "! @parameter I_MODEL_ID |
    "!   The ID of the classifier model.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DEL_DOCUMENT_CLASSIFIER_MODEL
    importing
      !I_PROJECT_ID type STRING
      !I_CLASSIFIER_ID type STRING
      !I_MODEL_ID type STRING
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">Analyze a Document</p>
    "!   Process a document and return it for realtime use. Supports JSON files
    "!    only.<br/>
    "!   <br/>
    "!   The file is not stored in the collection, but is processed according to the
    "!    collection&apos;s configuration settings. To get results, enrichments must be
    "!    applied to a field in the collection that also exists in the file that you want
    "!    to analyze. For example, to analyze text in a `Quote` field, you must apply
    "!    enrichments to the `Quote` field in the collection configuration. Then, when
    "!    you analyze the file, the text in the `Quote` field is analyzed and results are
    "!    written to a field named `enriched_Quote`.<br/>
    "!   <br/>
    "!   **Note:** This method is supported with Enterprise plan deployments and
    "!    installed deployments only.
    "!
    "! @parameter I_PROJECT_ID |
    "!   The ID of the project. This information can be found from the *Integrate and
    "!    Deploy* page in Discovery.
    "! @parameter I_COLLECTION_ID |
    "!   The ID of the collection.
    "! @parameter I_FILE |
    "!   When adding a document, the content of the document to ingest. For maximum
    "!    supported file size limits, see [the
    "!    documentation](/docs/discovery-data?topic=discovery-data-collections#collection
    "!   s-doc-limits).<br/>
    "!   <br/>
    "!   When analyzing a document, the content of the document to analyze but not
    "!    ingest. Only the `application/json` content type is supported currently. For
    "!    maximum supported file size limits, see [the product
    "!    documentation](/docs/discovery-data?topic=discovery-data-analyzeapi#analyzeapi-
    "!   limits).
    "! @parameter I_FILENAME |
    "!   The filename for file.
    "! @parameter I_FILE_CONTENT_TYPE |
    "!   The content type of file.
    "! @parameter I_METADATA |
    "!   Add information about the file that you want to include in the response.<br/>
    "!   <br/>
    "!   The maximum supported metadata file size is 1 MB. Metadata parts larger than 1
    "!    MB are rejected.<br/>
    "!   <br/>
    "!   Example:<br/>
    "!   <br/>
    "!    ``` <br/>
    "!    &#123; <br/>
    "!     &quot;filename&quot;: &quot;favorites2.json&quot;,<br/>
    "!     &quot;file_type&quot;: &quot;json&quot;<br/>
    "!    &#125;.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_ANALYZED_DOCUMENT
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods ANALYZE_DOCUMENT
    importing
      !I_PROJECT_ID type STRING
      !I_COLLECTION_ID type STRING
      !I_FILE type FILE optional
      !I_FILENAME type STRING optional
      !I_FILE_CONTENT_TYPE type STRING optional
      !I_METADATA type STRING optional
      !I_contenttype type string default 'multipart/form-data'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_ANALYZED_DOCUMENT
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">Delete labeled data</p>
    "!   Deletes all data associated with a specified customer ID. The method has no
    "!    effect if no data is associated with the customer ID. <br/>
    "!   <br/>
    "!   You associate a customer ID with data by passing the **X-Watson-Metadata**
    "!    header with a request that passes data. For more information about personal
    "!    data and customer IDs, see [Information
    "!    security](/docs/discovery-data?topic=discovery-data-information-security#inform
    "!   ation-security). <br/>
    "!   <br/>
    "!   **Note:** This method is only supported on IBM Cloud instances of Discovery.
    "!
    "! @parameter I_CUSTOMER_ID |
    "!   The customer ID for which all data is to be deleted.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_USER_DATA
    importing
      !I_CUSTOMER_ID type STRING
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .


protected section.

private section.

ENDCLASS.

class ZCL_IBMC_DISCOVERY_V2 IMPLEMENTATION.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->GET_APPNAME
* +-------------------------------------------------------------------------------------------------+
* | [<-()] E_APPNAME                      TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method GET_APPNAME.

    e_appname = 'Discovery v2'.

  endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Protected Method ZCL_IBMC_DISCOVERY_V2->GET_REQUEST_PROP
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
    e_request_prop-auth_query      = c_boolean_false.
    e_request_prop-auth_header     = c_boolean_true.
  else.
  endif.

  e_request_prop-url-protocol    = 'https'.
  e_request_prop-url-host        = 'api.us-south.discovery.watson.cloud.ibm.com'.
  e_request_prop-url-path_base   = ''.

endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->GET_SDK_VERSION_DATE
* +-------------------------------------------------------------------------------------------------+
* | [<-()] E_SDK_VERSION_DATE             TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method get_sdk_version_date.

    e_sdk_version_date = '20231212104233'.

  endmethod.



* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->LIST_PROJECTS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_LIST_PROJECTS_RESPONSE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_PROJECTS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/projects'.

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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->CREATE_PROJECT
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PROJECTCREATION        TYPE T_PROJECT_CREATION
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_PROJECT_DETAILS
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CREATE_PROJECT.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/projects'.

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
    lv_datatype = get_datatype( i_PROJECTCREATION ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_PROJECTCREATION i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'ProjectCreation' i_value = i_PROJECTCREATION ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_PROJECTCREATION to <lv_text>.
      lv_bodyparam = <lv_text>.
      concatenate lv_body lv_bodyparam into lv_body.
    endif.
    if ls_request_prop-header_content_type cp '*json*'.
      if lv_body is initial.
        lv_body = '{}'.
      elseif lv_body(1) ne '{'.
        lv_body = `{` && lv_body && `}`.
      endif.
    endif.

    if ls_request_prop-header_content_type cp '*charset=utf-8*'.
      ls_request_prop-body_bin = convert_string_to_utf8( i_string = lv_body ).
      "replace all occurrences of regex ';\s*charset=utf-8' in ls_request_prop-header_content_type with '' ignoring case.
      find_regex(
        exporting
          i_regex = ';\s*charset=utf-8'
          i_with = ''
          i_ignoring_case = 'X'
        changing
          c_in = ls_request_prop-header_content_type ).
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->GET_PROJECT
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PROJECT_ID        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_PROJECT_DETAILS
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_PROJECT.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/projects/{project_id}'.
    replace all occurrences of `{project_id}` in ls_request_prop-url-path with i_PROJECT_ID ignoring case.

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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->UPDATE_PROJECT
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PROJECT_ID        TYPE STRING
* | [--->] I_PROJECTNAME        TYPE T_PROJECT_NAME(optional)
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_PROJECT_DETAILS
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method UPDATE_PROJECT.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/projects/{project_id}'.
    replace all occurrences of `{project_id}` in ls_request_prop-url-path with i_PROJECT_ID ignoring case.

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
    if not i_PROJECTNAME is initial.
    lv_datatype = get_datatype( i_PROJECTNAME ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_PROJECTNAME i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'ProjectName' i_value = i_PROJECTNAME ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_PROJECTNAME to <lv_text>.
      lv_bodyparam = <lv_text>.
      concatenate lv_body lv_bodyparam into lv_body.
    endif.
    endif.
    if ls_request_prop-header_content_type cp '*json*'.
      if lv_body is initial.
        lv_body = '{}'.
      elseif lv_body(1) ne '{'.
        lv_body = `{` && lv_body && `}`.
      endif.
    endif.

    if ls_request_prop-header_content_type cp '*charset=utf-8*'.
      ls_request_prop-body_bin = convert_string_to_utf8( i_string = lv_body ).
      "replace all occurrences of regex ';\s*charset=utf-8' in ls_request_prop-header_content_type with '' ignoring case.
      find_regex(
        exporting
          i_regex = ';\s*charset=utf-8'
          i_with = ''
          i_ignoring_case = 'X'
        changing
          c_in = ls_request_prop-header_content_type ).
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->DELETE_PROJECT
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PROJECT_ID        TYPE STRING
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_PROJECT.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/projects/{project_id}'.
    replace all occurrences of `{project_id}` in ls_request_prop-url-path with i_PROJECT_ID ignoring case.

    " standard headers
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








    " execute HTTP DELETE request
    lo_response = HTTP_DELETE( i_request_prop = ls_request_prop ).



endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->LIST_FIELDS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PROJECT_ID        TYPE STRING
* | [--->] I_COLLECTION_IDS        TYPE TT_STRING(optional)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_LIST_FIELDS_RESPONSE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_FIELDS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/projects/{project_id}/fields'.
    replace all occurrences of `{project_id}` in ls_request_prop-url-path with i_PROJECT_ID ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_COLLECTION_IDS is supplied.
    data:
      lv_item_COLLECTION_IDS type STRING.
    clear: lv_queryparam, lv_sep.
    loop at i_COLLECTION_IDS into lv_item_COLLECTION_IDS.
      lv_queryparam = lv_queryparam && lv_sep && lv_item_COLLECTION_IDS.
      lv_sep = ','.
    endloop.
    lv_queryparam = escape( val = lv_queryparam format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `collection_ids`
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->LIST_COLLECTIONS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PROJECT_ID        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_LIST_COLLECTIONS_RESPONSE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_COLLECTIONS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/projects/{project_id}/collections'.
    replace all occurrences of `{project_id}` in ls_request_prop-url-path with i_PROJECT_ID ignoring case.

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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->CREATE_COLLECTION
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PROJECT_ID        TYPE STRING
* | [--->] I_COLLECTIONDETAILS        TYPE T_COLLECTION_DETAILS
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_COLLECTION_DETAILS
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CREATE_COLLECTION.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/projects/{project_id}/collections'.
    replace all occurrences of `{project_id}` in ls_request_prop-url-path with i_PROJECT_ID ignoring case.

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
    lv_datatype = get_datatype( i_COLLECTIONDETAILS ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_COLLECTIONDETAILS i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'CollectionDetails' i_value = i_COLLECTIONDETAILS ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_COLLECTIONDETAILS to <lv_text>.
      lv_bodyparam = <lv_text>.
      concatenate lv_body lv_bodyparam into lv_body.
    endif.
    if ls_request_prop-header_content_type cp '*json*'.
      if lv_body is initial.
        lv_body = '{}'.
      elseif lv_body(1) ne '{'.
        lv_body = `{` && lv_body && `}`.
      endif.
    endif.

    if ls_request_prop-header_content_type cp '*charset=utf-8*'.
      ls_request_prop-body_bin = convert_string_to_utf8( i_string = lv_body ).
      "replace all occurrences of regex ';\s*charset=utf-8' in ls_request_prop-header_content_type with '' ignoring case.
      find_regex(
        exporting
          i_regex = ';\s*charset=utf-8'
          i_with = ''
          i_ignoring_case = 'X'
        changing
          c_in = ls_request_prop-header_content_type ).
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->GET_COLLECTION
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PROJECT_ID        TYPE STRING
* | [--->] I_COLLECTION_ID        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_COLLECTION_DETAILS
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_COLLECTION.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/projects/{project_id}/collections/{collection_id}'.
    replace all occurrences of `{project_id}` in ls_request_prop-url-path with i_PROJECT_ID ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_COLLECTION_ID ignoring case.

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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->UPDATE_COLLECTION
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PROJECT_ID        TYPE STRING
* | [--->] I_COLLECTION_ID        TYPE STRING
* | [--->] I_UPDATECOLLECTION        TYPE T_UPDATE_COLLECTION
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_COLLECTION_DETAILS
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method UPDATE_COLLECTION.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/projects/{project_id}/collections/{collection_id}'.
    replace all occurrences of `{project_id}` in ls_request_prop-url-path with i_PROJECT_ID ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_COLLECTION_ID ignoring case.

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
    lv_datatype = get_datatype( i_UPDATECOLLECTION ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_UPDATECOLLECTION i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'UpdateCollection' i_value = i_UPDATECOLLECTION ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_UPDATECOLLECTION to <lv_text>.
      lv_bodyparam = <lv_text>.
      concatenate lv_body lv_bodyparam into lv_body.
    endif.
    if ls_request_prop-header_content_type cp '*json*'.
      if lv_body is initial.
        lv_body = '{}'.
      elseif lv_body(1) ne '{'.
        lv_body = `{` && lv_body && `}`.
      endif.
    endif.

    if ls_request_prop-header_content_type cp '*charset=utf-8*'.
      ls_request_prop-body_bin = convert_string_to_utf8( i_string = lv_body ).
      "replace all occurrences of regex ';\s*charset=utf-8' in ls_request_prop-header_content_type with '' ignoring case.
      find_regex(
        exporting
          i_regex = ';\s*charset=utf-8'
          i_with = ''
          i_ignoring_case = 'X'
        changing
          c_in = ls_request_prop-header_content_type ).
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->DELETE_COLLECTION
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PROJECT_ID        TYPE STRING
* | [--->] I_COLLECTION_ID        TYPE STRING
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_COLLECTION.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/projects/{project_id}/collections/{collection_id}'.
    replace all occurrences of `{project_id}` in ls_request_prop-url-path with i_PROJECT_ID ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_COLLECTION_ID ignoring case.

    " standard headers
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








    " execute HTTP DELETE request
    lo_response = HTTP_DELETE( i_request_prop = ls_request_prop ).



endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->LIST_DOCUMENTS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PROJECT_ID        TYPE STRING
* | [--->] I_COLLECTION_ID        TYPE STRING
* | [--->] I_COUNT        TYPE INTEGER (default =1000)
* | [--->] I_STATUS        TYPE STRING(optional)
* | [--->] I_HAS_NOTICES        TYPE BOOLEAN(optional)
* | [--->] I_IS_PARENT        TYPE BOOLEAN(optional)
* | [--->] I_PARENT_DOCUMENT_ID        TYPE STRING(optional)
* | [--->] I_SHA256        TYPE STRING(optional)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_LIST_DOCUMENTS_RESPONSE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_DOCUMENTS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/projects/{project_id}/collections/{collection_id}/documents'.
    replace all occurrences of `{project_id}` in ls_request_prop-url-path with i_PROJECT_ID ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_COLLECTION_ID ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_COUNT is supplied.
    lv_queryparam = i_COUNT.
    add_query_parameter(
      exporting
        i_parameter  = `count`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_STATUS is supplied.
    lv_queryparam = escape( val = i_STATUS format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `status`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_HAS_NOTICES is supplied.
    lv_queryparam = i_HAS_NOTICES.
    add_query_parameter(
      exporting
        i_parameter  = `has_notices`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_IS_PARENT is supplied.
    lv_queryparam = i_IS_PARENT.
    add_query_parameter(
      exporting
        i_parameter  = `is_parent`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_PARENT_DOCUMENT_ID is supplied.
    lv_queryparam = escape( val = i_PARENT_DOCUMENT_ID format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `parent_document_id`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_SHA256 is supplied.
    lv_queryparam = escape( val = i_SHA256 format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `sha256`
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->ADD_DOCUMENT
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PROJECT_ID        TYPE STRING
* | [--->] I_COLLECTION_ID        TYPE STRING
* | [--->] I_FILE        TYPE FILE(optional)
* | [--->] I_FILENAME        TYPE STRING(optional)
* | [--->] I_FILE_CONTENT_TYPE        TYPE STRING(optional)
* | [--->] I_METADATA        TYPE STRING(optional)
* | [--->] I_X_WATSON_DISCOVERY_FORCE        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_contenttype       TYPE string (default ='multipart/form-data')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_DOCUMENT_ACCEPTED
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method ADD_DOCUMENT.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/projects/{project_id}/collections/{collection_id}/documents'.
    replace all occurrences of `{project_id}` in ls_request_prop-url-path with i_PROJECT_ID ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_COLLECTION_ID ignoring case.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).



    " process header parameters
    data:
      lv_headerparam type string  ##NEEDED.

    if i_X_WATSON_DISCOVERY_FORCE is supplied.
    lv_headerparam = I_X_WATSON_DISCOVERY_FORCE.
    add_header_parameter(
      exporting
        i_parameter  = 'X-Watson-Discovery-Force'
        i_value      = lv_headerparam
        i_is_boolean = c_boolean_true
      changing
        c_headers    = ls_request_prop-headers )  ##NO_TEXT.
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


    if not i_METADATA is initial.
      clear ls_form_part.
      ls_form_part-content_disposition = 'form-data; name="metadata"'  ##NO_TEXT.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      lv_formdata = i_METADATA.
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.



    if not i_FILE is initial.
      if not I_filename is initial.
        lv_value = `form-data; name="file"; filename="` && I_filename && `"`  ##NO_TEXT.
      else.
      lv_extension = get_file_extension( I_file_content_type ).
      lv_value = `form-data; name="file"; filename="file` && lv_index && `.` && lv_extension && `"`  ##NO_TEXT.
      endif.
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->GET_DOCUMENT
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PROJECT_ID        TYPE STRING
* | [--->] I_COLLECTION_ID        TYPE STRING
* | [--->] I_DOCUMENT_ID        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_DOCUMENT_DETAILS
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_DOCUMENT.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/projects/{project_id}/collections/{collection_id}/documents/{document_id}'.
    replace all occurrences of `{project_id}` in ls_request_prop-url-path with i_PROJECT_ID ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_COLLECTION_ID ignoring case.
    replace all occurrences of `{document_id}` in ls_request_prop-url-path with i_DOCUMENT_ID ignoring case.

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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->UPDATE_DOCUMENT
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PROJECT_ID        TYPE STRING
* | [--->] I_COLLECTION_ID        TYPE STRING
* | [--->] I_DOCUMENT_ID        TYPE STRING
* | [--->] I_FILE        TYPE FILE(optional)
* | [--->] I_FILENAME        TYPE STRING(optional)
* | [--->] I_FILE_CONTENT_TYPE        TYPE STRING(optional)
* | [--->] I_METADATA        TYPE STRING(optional)
* | [--->] I_X_WATSON_DISCOVERY_FORCE        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_contenttype       TYPE string (default ='multipart/form-data')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_DOCUMENT_ACCEPTED
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method UPDATE_DOCUMENT.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/projects/{project_id}/collections/{collection_id}/documents/{document_id}'.
    replace all occurrences of `{project_id}` in ls_request_prop-url-path with i_PROJECT_ID ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_COLLECTION_ID ignoring case.
    replace all occurrences of `{document_id}` in ls_request_prop-url-path with i_DOCUMENT_ID ignoring case.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).



    " process header parameters
    data:
      lv_headerparam type string  ##NEEDED.

    if i_X_WATSON_DISCOVERY_FORCE is supplied.
    lv_headerparam = I_X_WATSON_DISCOVERY_FORCE.
    add_header_parameter(
      exporting
        i_parameter  = 'X-Watson-Discovery-Force'
        i_value      = lv_headerparam
        i_is_boolean = c_boolean_true
      changing
        c_headers    = ls_request_prop-headers )  ##NO_TEXT.
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


    if not i_METADATA is initial.
      clear ls_form_part.
      ls_form_part-content_disposition = 'form-data; name="metadata"'  ##NO_TEXT.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      lv_formdata = i_METADATA.
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.



    if not i_FILE is initial.
      if not I_filename is initial.
        lv_value = `form-data; name="file"; filename="` && I_filename && `"`  ##NO_TEXT.
      else.
      lv_extension = get_file_extension( I_file_content_type ).
      lv_value = `form-data; name="file"; filename="file` && lv_index && `.` && lv_extension && `"`  ##NO_TEXT.
      endif.
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->DELETE_DOCUMENT
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PROJECT_ID        TYPE STRING
* | [--->] I_COLLECTION_ID        TYPE STRING
* | [--->] I_DOCUMENT_ID        TYPE STRING
* | [--->] I_X_WATSON_DISCOVERY_FORCE        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_DELETE_DOCUMENT_RESPONSE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_DOCUMENT.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/projects/{project_id}/collections/{collection_id}/documents/{document_id}'.
    replace all occurrences of `{project_id}` in ls_request_prop-url-path with i_PROJECT_ID ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_COLLECTION_ID ignoring case.
    replace all occurrences of `{document_id}` in ls_request_prop-url-path with i_DOCUMENT_ID ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).



    " process header parameters
    data:
      lv_headerparam type string  ##NEEDED.

    if i_X_WATSON_DISCOVERY_FORCE is supplied.
    lv_headerparam = I_X_WATSON_DISCOVERY_FORCE.
    add_header_parameter(
      exporting
        i_parameter  = 'X-Watson-Discovery-Force'
        i_value      = lv_headerparam
        i_is_boolean = c_boolean_true
      changing
        c_headers    = ls_request_prop-headers )  ##NO_TEXT.
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->QUERY
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PROJECT_ID        TYPE STRING
* | [--->] I_QUERY_LONG        TYPE T_QUERY_LARGE(optional)
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_QUERY_RESPONSE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method QUERY.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/projects/{project_id}/query'.
    replace all occurrences of `{project_id}` in ls_request_prop-url-path with i_PROJECT_ID ignoring case.

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
    if not i_QUERY_LONG is initial.
    lv_datatype = get_datatype( i_QUERY_LONG ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_QUERY_LONG i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'query_long' i_value = i_QUERY_LONG ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_QUERY_LONG to <lv_text>.
      lv_bodyparam = <lv_text>.
      concatenate lv_body lv_bodyparam into lv_body.
    endif.
    endif.
    if ls_request_prop-header_content_type cp '*json*'.
      if lv_body is initial.
        lv_body = '{}'.
      elseif lv_body(1) ne '{'.
        lv_body = `{` && lv_body && `}`.
      endif.
    endif.

    if ls_request_prop-header_content_type cp '*charset=utf-8*'.
      ls_request_prop-body_bin = convert_string_to_utf8( i_string = lv_body ).
      "replace all occurrences of regex ';\s*charset=utf-8' in ls_request_prop-header_content_type with '' ignoring case.
      find_regex(
        exporting
          i_regex = ';\s*charset=utf-8'
          i_with = ''
          i_ignoring_case = 'X'
        changing
          c_in = ls_request_prop-header_content_type ).
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->GET_AUTOCOMPLETION
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PROJECT_ID        TYPE STRING
* | [--->] I_PREFIX        TYPE STRING
* | [--->] I_COLLECTION_IDS        TYPE TT_STRING(optional)
* | [--->] I_FIELD        TYPE STRING(optional)
* | [--->] I_COUNT        TYPE INTEGER (default =5)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_COMPLETIONS
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_AUTOCOMPLETION.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/projects/{project_id}/autocompletion'.
    replace all occurrences of `{project_id}` in ls_request_prop-url-path with i_PROJECT_ID ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    lv_queryparam = escape( val = i_PREFIX format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `prefix`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.

    if i_COLLECTION_IDS is supplied.
    data:
      lv_item_COLLECTION_IDS type STRING.
    clear: lv_queryparam, lv_sep.
    loop at i_COLLECTION_IDS into lv_item_COLLECTION_IDS.
      lv_queryparam = lv_queryparam && lv_sep && lv_item_COLLECTION_IDS.
      lv_sep = ','.
    endloop.
    lv_queryparam = escape( val = lv_queryparam format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `collection_ids`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_FIELD is supplied.
    lv_queryparam = escape( val = i_FIELD format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `field`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_COUNT is supplied.
    lv_queryparam = i_COUNT.
    add_query_parameter(
      exporting
        i_parameter  = `count`
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->QUERY_COLLECTION_NOTICES
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PROJECT_ID        TYPE STRING
* | [--->] I_COLLECTION_ID        TYPE STRING
* | [--->] I_FILTER        TYPE STRING(optional)
* | [--->] I_QUERY        TYPE STRING(optional)
* | [--->] I_NATURAL_LANGUAGE_QUERY        TYPE STRING(optional)
* | [--->] I_COUNT        TYPE INTEGER (default =10)
* | [--->] I_OFFSET        TYPE INTEGER(optional)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_QUERY_NOTICES_RESPONSE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method QUERY_COLLECTION_NOTICES.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/projects/{project_id}/collections/{collection_id}/notices'.
    replace all occurrences of `{project_id}` in ls_request_prop-url-path with i_PROJECT_ID ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_COLLECTION_ID ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_FILTER is supplied.
    lv_queryparam = escape( val = i_FILTER format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `filter`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_QUERY is supplied.
    lv_queryparam = escape( val = i_QUERY format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `query`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_NATURAL_LANGUAGE_QUERY is supplied.
    lv_queryparam = escape( val = i_NATURAL_LANGUAGE_QUERY format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `natural_language_query`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_COUNT is supplied.
    lv_queryparam = i_COUNT.
    add_query_parameter(
      exporting
        i_parameter  = `count`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_OFFSET is supplied.
    lv_queryparam = i_OFFSET.
    add_query_parameter(
      exporting
        i_parameter  = `offset`
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->QUERY_NOTICES
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PROJECT_ID        TYPE STRING
* | [--->] I_FILTER        TYPE STRING(optional)
* | [--->] I_QUERY        TYPE STRING(optional)
* | [--->] I_NATURAL_LANGUAGE_QUERY        TYPE STRING(optional)
* | [--->] I_COUNT        TYPE INTEGER (default =10)
* | [--->] I_OFFSET        TYPE INTEGER(optional)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_QUERY_NOTICES_RESPONSE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method QUERY_NOTICES.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/projects/{project_id}/notices'.
    replace all occurrences of `{project_id}` in ls_request_prop-url-path with i_PROJECT_ID ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_FILTER is supplied.
    lv_queryparam = escape( val = i_FILTER format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `filter`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_QUERY is supplied.
    lv_queryparam = escape( val = i_QUERY format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `query`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_NATURAL_LANGUAGE_QUERY is supplied.
    lv_queryparam = escape( val = i_NATURAL_LANGUAGE_QUERY format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `natural_language_query`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_COUNT is supplied.
    lv_queryparam = i_COUNT.
    add_query_parameter(
      exporting
        i_parameter  = `count`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_OFFSET is supplied.
    lv_queryparam = i_OFFSET.
    add_query_parameter(
      exporting
        i_parameter  = `offset`
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->GET_STOPWORD_LIST
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PROJECT_ID        TYPE STRING
* | [--->] I_COLLECTION_ID        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_STOP_WORD_LIST
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_STOPWORD_LIST.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/projects/{project_id}/collections/{collection_id}/stopwords'.
    replace all occurrences of `{project_id}` in ls_request_prop-url-path with i_PROJECT_ID ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_COLLECTION_ID ignoring case.

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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->CREATE_STOPWORD_LIST
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PROJECT_ID        TYPE STRING
* | [--->] I_COLLECTION_ID        TYPE STRING
* | [--->] I_STOPWORDLIST        TYPE T_STOP_WORD_LIST(optional)
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_STOP_WORD_LIST
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CREATE_STOPWORD_LIST.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/projects/{project_id}/collections/{collection_id}/stopwords'.
    replace all occurrences of `{project_id}` in ls_request_prop-url-path with i_PROJECT_ID ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_COLLECTION_ID ignoring case.

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
    if not i_STOPWORDLIST is initial.
    lv_datatype = get_datatype( i_STOPWORDLIST ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_STOPWORDLIST i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'StopWordList' i_value = i_STOPWORDLIST ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_STOPWORDLIST to <lv_text>.
      lv_bodyparam = <lv_text>.
      concatenate lv_body lv_bodyparam into lv_body.
    endif.
    endif.
    if ls_request_prop-header_content_type cp '*json*'.
      if lv_body is initial.
        lv_body = '{}'.
      elseif lv_body(1) ne '{'.
        lv_body = `{` && lv_body && `}`.
      endif.
    endif.

    if ls_request_prop-header_content_type cp '*charset=utf-8*'.
      ls_request_prop-body_bin = convert_string_to_utf8( i_string = lv_body ).
      "replace all occurrences of regex ';\s*charset=utf-8' in ls_request_prop-header_content_type with '' ignoring case.
      find_regex(
        exporting
          i_regex = ';\s*charset=utf-8'
          i_with = ''
          i_ignoring_case = 'X'
        changing
          c_in = ls_request_prop-header_content_type ).
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->DELETE_STOPWORD_LIST
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PROJECT_ID        TYPE STRING
* | [--->] I_COLLECTION_ID        TYPE STRING
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_STOPWORD_LIST.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/projects/{project_id}/collections/{collection_id}/stopwords'.
    replace all occurrences of `{project_id}` in ls_request_prop-url-path with i_PROJECT_ID ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_COLLECTION_ID ignoring case.

    " standard headers
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








    " execute HTTP DELETE request
    lo_response = HTTP_DELETE( i_request_prop = ls_request_prop ).



endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->LIST_EXPANSIONS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PROJECT_ID        TYPE STRING
* | [--->] I_COLLECTION_ID        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_EXPANSIONS
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_EXPANSIONS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/projects/{project_id}/collections/{collection_id}/expansions'.
    replace all occurrences of `{project_id}` in ls_request_prop-url-path with i_PROJECT_ID ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_COLLECTION_ID ignoring case.

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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->CREATE_EXPANSIONS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PROJECT_ID        TYPE STRING
* | [--->] I_COLLECTION_ID        TYPE STRING
* | [--->] I_BODY        TYPE T_EXPANSIONS
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_EXPANSIONS
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CREATE_EXPANSIONS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/projects/{project_id}/collections/{collection_id}/expansions'.
    replace all occurrences of `{project_id}` in ls_request_prop-url-path with i_PROJECT_ID ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_COLLECTION_ID ignoring case.

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
    lv_datatype = get_datatype( i_BODY ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_BODY i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'body' i_value = i_BODY ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_BODY to <lv_text>.
      lv_bodyparam = <lv_text>.
      concatenate lv_body lv_bodyparam into lv_body.
    endif.
    if ls_request_prop-header_content_type cp '*json*'.
      if lv_body is initial.
        lv_body = '{}'.
      elseif lv_body(1) ne '{'.
        lv_body = `{` && lv_body && `}`.
      endif.
    endif.

    if ls_request_prop-header_content_type cp '*charset=utf-8*'.
      ls_request_prop-body_bin = convert_string_to_utf8( i_string = lv_body ).
      "replace all occurrences of regex ';\s*charset=utf-8' in ls_request_prop-header_content_type with '' ignoring case.
      find_regex(
        exporting
          i_regex = ';\s*charset=utf-8'
          i_with = ''
          i_ignoring_case = 'X'
        changing
          c_in = ls_request_prop-header_content_type ).
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->DELETE_EXPANSIONS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PROJECT_ID        TYPE STRING
* | [--->] I_COLLECTION_ID        TYPE STRING
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_EXPANSIONS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/projects/{project_id}/collections/{collection_id}/expansions'.
    replace all occurrences of `{project_id}` in ls_request_prop-url-path with i_PROJECT_ID ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_COLLECTION_ID ignoring case.

    " standard headers
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








    " execute HTTP DELETE request
    lo_response = HTTP_DELETE( i_request_prop = ls_request_prop ).



endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->GET_COMPONENT_SETTINGS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PROJECT_ID        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_COMPONENT_SETTINGS_RESPONSE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_COMPONENT_SETTINGS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/projects/{project_id}/component_settings'.
    replace all occurrences of `{project_id}` in ls_request_prop-url-path with i_PROJECT_ID ignoring case.

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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->LIST_TRAINING_QUERIES
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PROJECT_ID        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_TRAINING_QUERY_SET
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_TRAINING_QUERIES.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/projects/{project_id}/training_data/queries'.
    replace all occurrences of `{project_id}` in ls_request_prop-url-path with i_PROJECT_ID ignoring case.

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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->DELETE_TRAINING_QUERIES
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PROJECT_ID        TYPE STRING
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_TRAINING_QUERIES.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/projects/{project_id}/training_data/queries'.
    replace all occurrences of `{project_id}` in ls_request_prop-url-path with i_PROJECT_ID ignoring case.

    " standard headers
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








    " execute HTTP DELETE request
    lo_response = HTTP_DELETE( i_request_prop = ls_request_prop ).



endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->CREATE_TRAINING_QUERY
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PROJECT_ID        TYPE STRING
* | [--->] I_TRAININGQUERY        TYPE T_TRAINING_QUERY
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_TRAINING_QUERY
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CREATE_TRAINING_QUERY.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/projects/{project_id}/training_data/queries'.
    replace all occurrences of `{project_id}` in ls_request_prop-url-path with i_PROJECT_ID ignoring case.

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
    lv_datatype = get_datatype( i_TRAININGQUERY ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_TRAININGQUERY i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'TrainingQuery' i_value = i_TRAININGQUERY ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_TRAININGQUERY to <lv_text>.
      lv_bodyparam = <lv_text>.
      concatenate lv_body lv_bodyparam into lv_body.
    endif.
    if ls_request_prop-header_content_type cp '*json*'.
      if lv_body is initial.
        lv_body = '{}'.
      elseif lv_body(1) ne '{'.
        lv_body = `{` && lv_body && `}`.
      endif.
    endif.

    if ls_request_prop-header_content_type cp '*charset=utf-8*'.
      ls_request_prop-body_bin = convert_string_to_utf8( i_string = lv_body ).
      "replace all occurrences of regex ';\s*charset=utf-8' in ls_request_prop-header_content_type with '' ignoring case.
      find_regex(
        exporting
          i_regex = ';\s*charset=utf-8'
          i_with = ''
          i_ignoring_case = 'X'
        changing
          c_in = ls_request_prop-header_content_type ).
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->GET_TRAINING_QUERY
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PROJECT_ID        TYPE STRING
* | [--->] I_QUERY_ID        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_TRAINING_QUERY
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_TRAINING_QUERY.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/projects/{project_id}/training_data/queries/{query_id}'.
    replace all occurrences of `{project_id}` in ls_request_prop-url-path with i_PROJECT_ID ignoring case.
    replace all occurrences of `{query_id}` in ls_request_prop-url-path with i_QUERY_ID ignoring case.

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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->UPDATE_TRAINING_QUERY
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PROJECT_ID        TYPE STRING
* | [--->] I_QUERY_ID        TYPE STRING
* | [--->] I_BODY        TYPE T_TRAINING_QUERY
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_TRAINING_QUERY
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method UPDATE_TRAINING_QUERY.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/projects/{project_id}/training_data/queries/{query_id}'.
    replace all occurrences of `{project_id}` in ls_request_prop-url-path with i_PROJECT_ID ignoring case.
    replace all occurrences of `{query_id}` in ls_request_prop-url-path with i_QUERY_ID ignoring case.

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
    lv_datatype = get_datatype( i_BODY ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_BODY i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'body' i_value = i_BODY ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_BODY to <lv_text>.
      lv_bodyparam = <lv_text>.
      concatenate lv_body lv_bodyparam into lv_body.
    endif.
    if ls_request_prop-header_content_type cp '*json*'.
      if lv_body is initial.
        lv_body = '{}'.
      elseif lv_body(1) ne '{'.
        lv_body = `{` && lv_body && `}`.
      endif.
    endif.

    if ls_request_prop-header_content_type cp '*charset=utf-8*'.
      ls_request_prop-body_bin = convert_string_to_utf8( i_string = lv_body ).
      "replace all occurrences of regex ';\s*charset=utf-8' in ls_request_prop-header_content_type with '' ignoring case.
      find_regex(
        exporting
          i_regex = ';\s*charset=utf-8'
          i_with = ''
          i_ignoring_case = 'X'
        changing
          c_in = ls_request_prop-header_content_type ).
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->DELETE_TRAINING_QUERY
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PROJECT_ID        TYPE STRING
* | [--->] I_QUERY_ID        TYPE STRING
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_TRAINING_QUERY.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/projects/{project_id}/training_data/queries/{query_id}'.
    replace all occurrences of `{project_id}` in ls_request_prop-url-path with i_PROJECT_ID ignoring case.
    replace all occurrences of `{query_id}` in ls_request_prop-url-path with i_QUERY_ID ignoring case.

    " standard headers
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








    " execute HTTP DELETE request
    lo_response = HTTP_DELETE( i_request_prop = ls_request_prop ).



endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->LIST_ENRICHMENTS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PROJECT_ID        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_ENRICHMENTS
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_ENRICHMENTS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/projects/{project_id}/enrichments'.
    replace all occurrences of `{project_id}` in ls_request_prop-url-path with i_PROJECT_ID ignoring case.

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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->CREATE_ENRICHMENT
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PROJECT_ID        TYPE STRING
* | [--->] I_ENRICHMENT        TYPE T_CREATE_ENRICHMENT
* | [--->] I_FILE        TYPE FILE(optional)
* | [--->] I_FILE_CT     TYPE STRING (default = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-all)
* | [--->] I_contenttype       TYPE string (default ='multipart/form-data')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_ENRICHMENT
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CREATE_ENRICHMENT.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/projects/{project_id}/enrichments'.
    replace all occurrences of `{project_id}` in ls_request_prop-url-path with i_PROJECT_ID ignoring case.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).





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


    if not i_ENRICHMENT is initial.
      clear ls_form_part.
      ls_form_part-content_disposition = 'form-data; name="enrichment"'  ##NO_TEXT.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-APPL_JSON.
      lv_formdata = abap_to_json( i_value = i_ENRICHMENT i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.



    if not i_FILE is initial.
      lv_extension = get_file_extension( I_FILE_CT ).
      lv_value = `form-data; name="file"; filename="file` && lv_index && `.` && lv_extension && `"`  ##NO_TEXT.
      lv_index = lv_index + 1.
      clear ls_form_part.
      ls_form_part-content_type = I_FILE_CT.
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->GET_ENRICHMENT
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PROJECT_ID        TYPE STRING
* | [--->] I_ENRICHMENT_ID        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_ENRICHMENT
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_ENRICHMENT.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/projects/{project_id}/enrichments/{enrichment_id}'.
    replace all occurrences of `{project_id}` in ls_request_prop-url-path with i_PROJECT_ID ignoring case.
    replace all occurrences of `{enrichment_id}` in ls_request_prop-url-path with i_ENRICHMENT_ID ignoring case.

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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->UPDATE_ENRICHMENT
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PROJECT_ID        TYPE STRING
* | [--->] I_ENRICHMENT_ID        TYPE STRING
* | [--->] I_UPDATEENRICHMENT        TYPE T_UPDATE_ENRICHMENT
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_ENRICHMENT
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method UPDATE_ENRICHMENT.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/projects/{project_id}/enrichments/{enrichment_id}'.
    replace all occurrences of `{project_id}` in ls_request_prop-url-path with i_PROJECT_ID ignoring case.
    replace all occurrences of `{enrichment_id}` in ls_request_prop-url-path with i_ENRICHMENT_ID ignoring case.

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
    lv_datatype = get_datatype( i_UPDATEENRICHMENT ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_UPDATEENRICHMENT i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'UpdateEnrichment' i_value = i_UPDATEENRICHMENT ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_UPDATEENRICHMENT to <lv_text>.
      lv_bodyparam = <lv_text>.
      concatenate lv_body lv_bodyparam into lv_body.
    endif.
    if ls_request_prop-header_content_type cp '*json*'.
      if lv_body is initial.
        lv_body = '{}'.
      elseif lv_body(1) ne '{'.
        lv_body = `{` && lv_body && `}`.
      endif.
    endif.

    if ls_request_prop-header_content_type cp '*charset=utf-8*'.
      ls_request_prop-body_bin = convert_string_to_utf8( i_string = lv_body ).
      "replace all occurrences of regex ';\s*charset=utf-8' in ls_request_prop-header_content_type with '' ignoring case.
      find_regex(
        exporting
          i_regex = ';\s*charset=utf-8'
          i_with = ''
          i_ignoring_case = 'X'
        changing
          c_in = ls_request_prop-header_content_type ).
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->DELETE_ENRICHMENT
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PROJECT_ID        TYPE STRING
* | [--->] I_ENRICHMENT_ID        TYPE STRING
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_ENRICHMENT.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/projects/{project_id}/enrichments/{enrichment_id}'.
    replace all occurrences of `{project_id}` in ls_request_prop-url-path with i_PROJECT_ID ignoring case.
    replace all occurrences of `{enrichment_id}` in ls_request_prop-url-path with i_ENRICHMENT_ID ignoring case.

    " standard headers
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








    " execute HTTP DELETE request
    lo_response = HTTP_DELETE( i_request_prop = ls_request_prop ).



endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->LIST_DOCUMENT_CLASSIFIERS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PROJECT_ID        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_DOCUMENT_CLASSIFIERS
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_DOCUMENT_CLASSIFIERS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/projects/{project_id}/document_classifiers'.
    replace all occurrences of `{project_id}` in ls_request_prop-url-path with i_PROJECT_ID ignoring case.

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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->CREATE_DOCUMENT_CLASSIFIER
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PROJECT_ID        TYPE STRING
* | [--->] I_TRAINING_DATA        TYPE FILE
* | [--->] I_CLASSIFIER        TYPE T_CREATE_DOCUMENT_CLASSIFIER
* | [--->] I_TEST_DATA        TYPE FILE(optional)
* | [--->] I_TRAINING_DATA_CT     TYPE STRING (default = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-all)
* | [--->] I_TEST_DATA_CT     TYPE STRING (default = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-all)
* | [--->] I_contenttype       TYPE string (default ='multipart/form-data')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_DOCUMENT_CLASSIFIER
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CREATE_DOCUMENT_CLASSIFIER.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/projects/{project_id}/document_classifiers'.
    replace all occurrences of `{project_id}` in ls_request_prop-url-path with i_PROJECT_ID ignoring case.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).





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


    if not i_CLASSIFIER is initial.
      clear ls_form_part.
      ls_form_part-content_disposition = 'form-data; name="classifier"'  ##NO_TEXT.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-APPL_JSON.
      lv_formdata = abap_to_json( i_value = i_CLASSIFIER i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.



    if not i_TRAINING_DATA is initial.
      lv_extension = get_file_extension( I_TRAINING_DATA_CT ).
      lv_value = `form-data; name="training_data"; filename="file` && lv_index && `.` && lv_extension && `"`  ##NO_TEXT.
      lv_index = lv_index + 1.
      clear ls_form_part.
      ls_form_part-content_type = I_TRAINING_DATA_CT.
      ls_form_part-content_disposition = lv_value.
      ls_form_part-xdata = i_TRAINING_DATA.
      append ls_form_part to lt_form_part.
    endif.

    if not i_TEST_DATA is initial.
      lv_extension = get_file_extension( I_TEST_DATA_CT ).
      lv_value = `form-data; name="test_data"; filename="file` && lv_index && `.` && lv_extension && `"`  ##NO_TEXT.
      lv_index = lv_index + 1.
      clear ls_form_part.
      ls_form_part-content_type = I_TEST_DATA_CT.
      ls_form_part-content_disposition = lv_value.
      ls_form_part-xdata = i_TEST_DATA.
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->GET_DOCUMENT_CLASSIFIER
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PROJECT_ID        TYPE STRING
* | [--->] I_CLASSIFIER_ID        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_DOCUMENT_CLASSIFIER
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_DOCUMENT_CLASSIFIER.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/projects/{project_id}/document_classifiers/{classifier_id}'.
    replace all occurrences of `{project_id}` in ls_request_prop-url-path with i_PROJECT_ID ignoring case.
    replace all occurrences of `{classifier_id}` in ls_request_prop-url-path with i_CLASSIFIER_ID ignoring case.

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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->UPDATE_DOCUMENT_CLASSIFIER
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PROJECT_ID        TYPE STRING
* | [--->] I_CLASSIFIER_ID        TYPE STRING
* | [--->] I_CLASSIFIER        TYPE T_UPDATE_DOCUMENT_CLASSIFIER
* | [--->] I_TRAINING_DATA        TYPE FILE(optional)
* | [--->] I_TEST_DATA        TYPE FILE(optional)
* | [--->] I_TRAINING_DATA_CT     TYPE STRING (default = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-all)
* | [--->] I_TEST_DATA_CT     TYPE STRING (default = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-all)
* | [--->] I_contenttype       TYPE string (default ='multipart/form-data')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_DOCUMENT_CLASSIFIER
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method UPDATE_DOCUMENT_CLASSIFIER.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/projects/{project_id}/document_classifiers/{classifier_id}'.
    replace all occurrences of `{project_id}` in ls_request_prop-url-path with i_PROJECT_ID ignoring case.
    replace all occurrences of `{classifier_id}` in ls_request_prop-url-path with i_CLASSIFIER_ID ignoring case.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).





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


    if not i_CLASSIFIER is initial.
      clear ls_form_part.
      ls_form_part-content_disposition = 'form-data; name="classifier"'  ##NO_TEXT.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-APPL_JSON.
      lv_formdata = abap_to_json( i_value = i_CLASSIFIER i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.



    if not i_TRAINING_DATA is initial.
      lv_extension = get_file_extension( I_TRAINING_DATA_CT ).
      lv_value = `form-data; name="training_data"; filename="file` && lv_index && `.` && lv_extension && `"`  ##NO_TEXT.
      lv_index = lv_index + 1.
      clear ls_form_part.
      ls_form_part-content_type = I_TRAINING_DATA_CT.
      ls_form_part-content_disposition = lv_value.
      ls_form_part-xdata = i_TRAINING_DATA.
      append ls_form_part to lt_form_part.
    endif.

    if not i_TEST_DATA is initial.
      lv_extension = get_file_extension( I_TEST_DATA_CT ).
      lv_value = `form-data; name="test_data"; filename="file` && lv_index && `.` && lv_extension && `"`  ##NO_TEXT.
      lv_index = lv_index + 1.
      clear ls_form_part.
      ls_form_part-content_type = I_TEST_DATA_CT.
      ls_form_part-content_disposition = lv_value.
      ls_form_part-xdata = i_TEST_DATA.
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->DELETE_DOCUMENT_CLASSIFIER
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PROJECT_ID        TYPE STRING
* | [--->] I_CLASSIFIER_ID        TYPE STRING
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_DOCUMENT_CLASSIFIER.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/projects/{project_id}/document_classifiers/{classifier_id}'.
    replace all occurrences of `{project_id}` in ls_request_prop-url-path with i_PROJECT_ID ignoring case.
    replace all occurrences of `{classifier_id}` in ls_request_prop-url-path with i_CLASSIFIER_ID ignoring case.

    " standard headers
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








    " execute HTTP DELETE request
    lo_response = HTTP_DELETE( i_request_prop = ls_request_prop ).



endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->LST_DOCUMENT_CLASSIFIER_MODELS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PROJECT_ID        TYPE STRING
* | [--->] I_CLASSIFIER_ID        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_DOCUMENT_CLASSIFIER_MODELS
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LST_DOCUMENT_CLASSIFIER_MODELS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/projects/{project_id}/document_classifiers/{classifier_id}/models'.
    replace all occurrences of `{project_id}` in ls_request_prop-url-path with i_PROJECT_ID ignoring case.
    replace all occurrences of `{classifier_id}` in ls_request_prop-url-path with i_CLASSIFIER_ID ignoring case.

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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->CRE_DOCUMENT_CLASSIFIER_MODEL
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PROJECT_ID        TYPE STRING
* | [--->] I_CLASSIFIER_ID        TYPE STRING
* | [--->] I_DOCUMENTCLASSIFIERMODELTRAIN        TYPE T_DOC_CLASSIFIER_MODEL_TRAIN
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_DOCUMENT_CLASSIFIER_MODEL
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CRE_DOCUMENT_CLASSIFIER_MODEL.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/projects/{project_id}/document_classifiers/{classifier_id}/models'.
    replace all occurrences of `{project_id}` in ls_request_prop-url-path with i_PROJECT_ID ignoring case.
    replace all occurrences of `{classifier_id}` in ls_request_prop-url-path with i_CLASSIFIER_ID ignoring case.

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
    lv_datatype = get_datatype( i_DOCUMENTCLASSIFIERMODELTRAIN ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_DOCUMENTCLASSIFIERMODELTRAIN i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'DocumentClassifierModelTrain' i_value = i_DOCUMENTCLASSIFIERMODELTRAIN ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_DOCUMENTCLASSIFIERMODELTRAIN to <lv_text>.
      lv_bodyparam = <lv_text>.
      concatenate lv_body lv_bodyparam into lv_body.
    endif.
    if ls_request_prop-header_content_type cp '*json*'.
      if lv_body is initial.
        lv_body = '{}'.
      elseif lv_body(1) ne '{'.
        lv_body = `{` && lv_body && `}`.
      endif.
    endif.

    if ls_request_prop-header_content_type cp '*charset=utf-8*'.
      ls_request_prop-body_bin = convert_string_to_utf8( i_string = lv_body ).
      "replace all occurrences of regex ';\s*charset=utf-8' in ls_request_prop-header_content_type with '' ignoring case.
      find_regex(
        exporting
          i_regex = ';\s*charset=utf-8'
          i_with = ''
          i_ignoring_case = 'X'
        changing
          c_in = ls_request_prop-header_content_type ).
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->GET_DOCUMENT_CLASSIFIER_MODEL
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PROJECT_ID        TYPE STRING
* | [--->] I_CLASSIFIER_ID        TYPE STRING
* | [--->] I_MODEL_ID        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_DOCUMENT_CLASSIFIER_MODEL
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_DOCUMENT_CLASSIFIER_MODEL.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/projects/{project_id}/document_classifiers/{classifier_id}/models/{model_id}'.
    replace all occurrences of `{project_id}` in ls_request_prop-url-path with i_PROJECT_ID ignoring case.
    replace all occurrences of `{classifier_id}` in ls_request_prop-url-path with i_CLASSIFIER_ID ignoring case.
    replace all occurrences of `{model_id}` in ls_request_prop-url-path with i_MODEL_ID ignoring case.

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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->UPD_DOCUMENT_CLASSIFIER_MODEL
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PROJECT_ID        TYPE STRING
* | [--->] I_CLASSIFIER_ID        TYPE STRING
* | [--->] I_MODEL_ID        TYPE STRING
* | [--->] I_UPDTDCMNTCLSSFRMDL        TYPE T_UPD_DOC_CLASSIFIER_MODEL
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_DOCUMENT_CLASSIFIER_MODEL
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method UPD_DOCUMENT_CLASSIFIER_MODEL.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/projects/{project_id}/document_classifiers/{classifier_id}/models/{model_id}'.
    replace all occurrences of `{project_id}` in ls_request_prop-url-path with i_PROJECT_ID ignoring case.
    replace all occurrences of `{classifier_id}` in ls_request_prop-url-path with i_CLASSIFIER_ID ignoring case.
    replace all occurrences of `{model_id}` in ls_request_prop-url-path with i_MODEL_ID ignoring case.

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
    lv_datatype = get_datatype( i_UPDTDCMNTCLSSFRMDL ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_UPDTDCMNTCLSSFRMDL i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'UpdateDocumentClassifierModel' i_value = i_UPDTDCMNTCLSSFRMDL ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_UPDTDCMNTCLSSFRMDL to <lv_text>.
      lv_bodyparam = <lv_text>.
      concatenate lv_body lv_bodyparam into lv_body.
    endif.
    if ls_request_prop-header_content_type cp '*json*'.
      if lv_body is initial.
        lv_body = '{}'.
      elseif lv_body(1) ne '{'.
        lv_body = `{` && lv_body && `}`.
      endif.
    endif.

    if ls_request_prop-header_content_type cp '*charset=utf-8*'.
      ls_request_prop-body_bin = convert_string_to_utf8( i_string = lv_body ).
      "replace all occurrences of regex ';\s*charset=utf-8' in ls_request_prop-header_content_type with '' ignoring case.
      find_regex(
        exporting
          i_regex = ';\s*charset=utf-8'
          i_with = ''
          i_ignoring_case = 'X'
        changing
          c_in = ls_request_prop-header_content_type ).
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->DEL_DOCUMENT_CLASSIFIER_MODEL
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PROJECT_ID        TYPE STRING
* | [--->] I_CLASSIFIER_ID        TYPE STRING
* | [--->] I_MODEL_ID        TYPE STRING
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DEL_DOCUMENT_CLASSIFIER_MODEL.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/projects/{project_id}/document_classifiers/{classifier_id}/models/{model_id}'.
    replace all occurrences of `{project_id}` in ls_request_prop-url-path with i_PROJECT_ID ignoring case.
    replace all occurrences of `{classifier_id}` in ls_request_prop-url-path with i_CLASSIFIER_ID ignoring case.
    replace all occurrences of `{model_id}` in ls_request_prop-url-path with i_MODEL_ID ignoring case.

    " standard headers
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








    " execute HTTP DELETE request
    lo_response = HTTP_DELETE( i_request_prop = ls_request_prop ).



endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->ANALYZE_DOCUMENT
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PROJECT_ID        TYPE STRING
* | [--->] I_COLLECTION_ID        TYPE STRING
* | [--->] I_FILE        TYPE FILE(optional)
* | [--->] I_FILENAME        TYPE STRING(optional)
* | [--->] I_FILE_CONTENT_TYPE        TYPE STRING(optional)
* | [--->] I_METADATA        TYPE STRING(optional)
* | [--->] I_contenttype       TYPE string (default ='multipart/form-data')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_ANALYZED_DOCUMENT
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method ANALYZE_DOCUMENT.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/projects/{project_id}/collections/{collection_id}/analyze'.
    replace all occurrences of `{project_id}` in ls_request_prop-url-path with i_PROJECT_ID ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_COLLECTION_ID ignoring case.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).





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


    if not i_METADATA is initial.
      clear ls_form_part.
      ls_form_part-content_disposition = 'form-data; name="metadata"'  ##NO_TEXT.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      lv_formdata = i_METADATA.
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.



    if not i_FILE is initial.
      if not I_filename is initial.
        lv_value = `form-data; name="file"; filename="` && I_filename && `"`  ##NO_TEXT.
      else.
      lv_extension = get_file_extension( I_file_content_type ).
      lv_value = `form-data; name="file"; filename="file` && lv_index && `.` && lv_extension && `"`  ##NO_TEXT.
      endif.
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V2->DELETE_USER_DATA
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_CUSTOMER_ID        TYPE STRING
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_USER_DATA.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/user_data'.

    " standard headers
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    lv_queryparam = escape( val = i_CUSTOMER_ID format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `customer_id`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.






    " execute HTTP DELETE request
    lo_response = HTTP_DELETE( i_request_prop = ls_request_prop ).



endmethod.


ENDCLASS.
