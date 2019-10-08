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
"! <h1>Discovery</h1>
"! IBM Watson&trade; Discovery is a cognitive search and content analytics engine
"!  that you can add to applications to identify patterns, trends and actionable
"!  insights to drive better decision-making. Securely unify structured and
"!  unstructured data with pre-enriched content, and use a simplified query
"!  language to eliminate the need for manual filtering of results. <br/>
class ZCL_IBMC_DISCOVERY_V1 DEFINITION
  public
  inheriting from ZCL_IBMC_SERVICE_EXT
  create public .

public section.
  types:
    "!   An aggregation produced by  Discovery to analyze the input provided.
    begin of T_QUERY_AGGREGATION,
      TYPE type STRING,
      RESULTS type STANDARD TABLE OF DATA_REFERENCE WITH NON-UNIQUE DEFAULT KEY,
      MATCHING_RESULTS type INTEGER,
      AGGREGATIONS type STANDARD TABLE OF DATA_REFERENCE WITH NON-UNIQUE DEFAULT KEY,
    end of T_QUERY_AGGREGATION.
  types:
    "!   Aggregation results for the specified query.
    begin of T_AGGREGATION_RESULT,
      KEY type STRING,
      MATCHING_RESULTS type INTEGER,
      AGGREGATIONS type STANDARD TABLE OF T_QUERY_AGGREGATION WITH NON-UNIQUE DEFAULT KEY,
    end of T_AGGREGATION_RESULT.
  types:
    "!   Training status details.
    begin of T_TRAINING_STATUS,
      TOTAL_EXAMPLES type INTEGER,
      AVAILABLE type BOOLEAN,
      PROCESSING type BOOLEAN,
      MINIMUM_QUERIES_ADDED type BOOLEAN,
      MINIMUM_EXAMPLES_ADDED type BOOLEAN,
      SUFFICIENT_LABEL_DIVERSITY type BOOLEAN,
      NOTICES type INTEGER,
      SUCCESSFULLY_TRAINED type DATETIME,
      DATA_UPDATED type DATETIME,
    end of T_TRAINING_STATUS.
  types:
    "!   Object describing the current status of the wordlist.
    begin of T_TOKEN_DICT_STATUS_RESPONSE,
      STATUS type STRING,
      TYPE type STRING,
    end of T_TOKEN_DICT_STATUS_RESPONSE.
  types:
    "!   An object that indicates the Categories enrichment will be applied to the
    "!    specified field.
      T_NLU_ENRICHMENT_CATEGORIES type MAP.
  types:
    "!   An object specifying the relations enrichment and related parameters.
    begin of T_NLU_ENRICHMENT_RELATIONS,
      MODEL type STRING,
    end of T_NLU_ENRICHMENT_RELATIONS.
  types:
    "!   An object specifying the sentiment extraction enrichment and related parameters.
    "!
    begin of T_NLU_ENRICHMENT_SENTIMENT,
      DOCUMENT type BOOLEAN,
      TARGETS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
    end of T_NLU_ENRICHMENT_SENTIMENT.
  types:
    "!   An object specifiying the semantic roles enrichment and related parameters.
    begin of T_NL_ENRICHMENT_SEMANTIC_ROLES,
      ENTITIES type BOOLEAN,
      KEYWORDS type BOOLEAN,
      LIMIT type INTEGER,
    end of T_NL_ENRICHMENT_SEMANTIC_ROLES.
  types:
    "!   An object speficying the Entities enrichment and related parameters.
    begin of T_NLU_ENRICHMENT_ENTITIES,
      SENTIMENT type BOOLEAN,
      EMOTION type BOOLEAN,
      LIMIT type INTEGER,
      MENTIONS type BOOLEAN,
      MENTION_TYPES type BOOLEAN,
      SENTENCE_LOCATIONS type BOOLEAN,
      MODEL type STRING,
    end of T_NLU_ENRICHMENT_ENTITIES.
  types:
    "!   An object specifying the emotion detection enrichment and related parameters.
    begin of T_NLU_ENRICHMENT_EMOTION,
      DOCUMENT type BOOLEAN,
      TARGETS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
    end of T_NLU_ENRICHMENT_EMOTION.
  types:
    "!   An object specifiying the concepts enrichment and related parameters.
    begin of T_NLU_ENRICHMENT_CONCEPTS,
      LIMIT type INTEGER,
    end of T_NLU_ENRICHMENT_CONCEPTS.
  types:
    "!   An object specifying the Keyword enrichment and related parameters.
    begin of T_NLU_ENRICHMENT_KEYWORDS,
      SENTIMENT type BOOLEAN,
      EMOTION type BOOLEAN,
      LIMIT type INTEGER,
    end of T_NLU_ENRICHMENT_KEYWORDS.
  types:
    "!   Object containing Natural Language Understanding features to be used.
    begin of T_NLU_ENRICHMENT_FEATURES,
      KEYWORDS type T_NLU_ENRICHMENT_KEYWORDS,
      ENTITIES type T_NLU_ENRICHMENT_ENTITIES,
      SENTIMENT type T_NLU_ENRICHMENT_SENTIMENT,
      EMOTION type T_NLU_ENRICHMENT_EMOTION,
      CATEGORIES type T_NLU_ENRICHMENT_CATEGORIES,
      SEMANTIC_ROLES type T_NL_ENRICHMENT_SEMANTIC_ROLES,
      RELATIONS type T_NLU_ENRICHMENT_RELATIONS,
      CONCEPTS type T_NLU_ENRICHMENT_CONCEPTS,
    end of T_NLU_ENRICHMENT_FEATURES.
  types:
    "!   An object representing the configuration options to use for the
    "!    `natural_language_understanding` enrichments.
    begin of T_NLU_ENRICHMENT_OPTIONS,
      FEATURES type T_NLU_ENRICHMENT_FEATURES,
      LANGUAGE type STRING,
    end of T_NLU_ENRICHMENT_OPTIONS.
  types:
    "!   An object defining a single tokenizaion rule.
    begin of T_TOKEN_DICT_RULE,
      TEXT type STRING,
      TOKENS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      READINGS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      PART_OF_SPEECH type STRING,
    end of T_TOKEN_DICT_RULE.
  types:
    "!   Tokenization dictionary describing how words are tokenized during ingestion and
    "!    at query time.
    begin of T_TOKEN_DICT,
      TOKENIZATION_RULES type STANDARD TABLE OF T_TOKEN_DICT_RULE WITH NON-UNIQUE DEFAULT KEY,
    end of T_TOKEN_DICT.
  types:
    "!
    begin of T_FILTER,
      MATCH type STRING,
    end of T_FILTER.
  types:
    "!   Object defining which URL to crawl and how to crawl it.
    begin of T_SOURCE_OPTIONS_WEB_CRAWL,
      URL type STRING,
      LIMIT_TO_STARTING_HOSTS type BOOLEAN,
      CRAWL_SPEED type STRING,
      ALLOW_UNTRUSTED_CERTIFICATE type BOOLEAN,
      MAXIMUM_HOPS type INTEGER,
      REQUEST_TIMEOUT type INTEGER,
      OVERRIDE_ROBOTS_TXT type BOOLEAN,
      BLACKLIST type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
    end of T_SOURCE_OPTIONS_WEB_CRAWL.
  types:
    "!   Object containing details of the stored credentials.
    "!
    "!   Obtain credentials for your source from the administrator of the source.
    begin of T_CREDENTIAL_DETAILS,
      CREDENTIAL_TYPE type STRING,
      CLIENT_ID type STRING,
      ENTERPRISE_ID type STRING,
      URL type STRING,
      USERNAME type STRING,
      ORGANIZATION_URL type STRING,
      SITE_COLLECTION_PATH type STRING,
      CLIENT_SECRET type STRING,
      PUBLIC_KEY_ID type STRING,
      PRIVATE_KEY type STRING,
      PASSPHRASE type STRING,
      PASSWORD type STRING,
      GATEWAY_ID type STRING,
      SOURCE_VERSION type STRING,
      WEB_APPLICATION_URL type STRING,
      DOMAIN type STRING,
      ENDPOINT type STRING,
      ACCESS_KEY_ID type STRING,
      SECRET_ACCESS_KEY type STRING,
    end of T_CREDENTIAL_DETAILS.
  types:
    "!   Object containing credential information.
    begin of T_CREDENTIALS,
      CREDENTIAL_ID type STRING,
      SOURCE_TYPE type STRING,
      CREDENTIAL_DETAILS type T_CREDENTIAL_DETAILS,
      STATUS type STRING,
    end of T_CREDENTIALS.
  types:
    "!   Object containing array of credential definitions.
    begin of T_CREDENTIALS_LIST,
      CREDENTIALS type STANDARD TABLE OF T_CREDENTIALS WITH NON-UNIQUE DEFAULT KEY,
    end of T_CREDENTIALS_LIST.
  types:
    "!   Summary of the collection usage in the environment.
    begin of T_COLLECTION_USAGE,
      AVAILABLE type INTEGER,
      MAXIMUM_ALLOWED type INTEGER,
    end of T_COLLECTION_USAGE.
  types:
    "!   Summary of the disk usage statistics for the environment.
    begin of T_DISK_USAGE,
      USED_BYTES type INTEGER,
      MAXIMUM_ALLOWED_BYTES type INTEGER,
    end of T_DISK_USAGE.
  types:
    "!   Summary of the document usage statistics for the environment.
    begin of T_ENVIRONMENT_DOCUMENTS,
      INDEXED type INTEGER,
      MAXIMUM_ALLOWED type INTEGER,
    end of T_ENVIRONMENT_DOCUMENTS.
  types:
    "!   Details about the resource usage and capacity of the environment.
    begin of T_INDEX_CAPACITY,
      DOCUMENTS type T_ENVIRONMENT_DOCUMENTS,
      DISK_USAGE type T_DISK_USAGE,
      COLLECTIONS type T_COLLECTION_USAGE,
    end of T_INDEX_CAPACITY.
  types:
    "!   Information about the Continuous Relevancy Training for this environment.
    begin of T_SEARCH_STATUS,
      SCOPE type STRING,
      STATUS type STRING,
      STATUS_DESCRIPTION type STRING,
      LAST_TRAINED type DATE,
    end of T_SEARCH_STATUS.
  types:
    "!   Details about an environment.
    begin of T_ENVIRONMENT,
      ENVIRONMENT_ID type STRING,
      NAME type STRING,
      DESCRIPTION type STRING,
      CREATED type DATETIME,
      UPDATED type DATETIME,
      STATUS type STRING,
      READ_ONLY type BOOLEAN,
      SIZE type STRING,
      REQUESTED_SIZE type STRING,
      INDEX_CAPACITY type T_INDEX_CAPACITY,
      SEARCH_STATUS type T_SEARCH_STATUS,
    end of T_ENVIRONMENT.
  types:
    "!   Response object containing an array of configured environments.
    begin of T_LIST_ENVIRONMENTS_RESPONSE,
      ENVIRONMENTS type STANDARD TABLE OF T_ENVIRONMENT WITH NON-UNIQUE DEFAULT KEY,
    end of T_LIST_ENVIRONMENTS_RESPONSE.
  types:
    "!   Gatway deletion confirmation.
    begin of T_GATEWAY_DELETE,
      GATEWAY_ID type STRING,
      STATUS type STRING,
    end of T_GATEWAY_DELETE.
  types:
    "!   Training example details.
    begin of T_TRAINING_EXAMPLE,
      DOCUMENT_ID type STRING,
      CROSS_REFERENCE type STRING,
      RELEVANCE type INTEGER,
    end of T_TRAINING_EXAMPLE.
  types:
    "!   Training query details.
    begin of T_TRAINING_QUERY,
      QUERY_ID type STRING,
      NATURAL_LANGUAGE_QUERY type STRING,
      FILTER type STRING,
      EXAMPLES type STANDARD TABLE OF T_TRAINING_EXAMPLE WITH NON-UNIQUE DEFAULT KEY,
    end of T_TRAINING_QUERY.
  types:
    "!   A passage query result.
    begin of T_QUERY_PASSAGES,
      DOCUMENT_ID type STRING,
      PASSAGE_SCORE type DOUBLE,
      PASSAGE_TEXT type STRING,
      START_OFFSET type INTEGER,
      END_OFFSET type INTEGER,
      FIELD type STRING,
    end of T_QUERY_PASSAGES.
  types:
    "!   Object containing normalization operations.
    begin of T_NORMALIZATION_OPERATION,
      OPERATION type STRING,
      SOURCE_FIELD type STRING,
      DESTINATION_FIELD type STRING,
    end of T_NORMALIZATION_OPERATION.
  types:
    "!   Font matching configuration.
    begin of T_FONT_SETTING,
      LEVEL type INTEGER,
      MIN_SIZE type INTEGER,
      MAX_SIZE type INTEGER,
      BOLD type BOOLEAN,
      ITALIC type BOOLEAN,
      NAME type STRING,
    end of T_FONT_SETTING.
  types:
    "!   Microsoft Word styles to convert into a specified HTML head level.
    begin of T_WORD_STYLE,
      LEVEL type INTEGER,
      NAMES type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
    end of T_WORD_STYLE.
  types:
    "!   Object containing heading detection conversion settings for Microsoft Word
    "!    documents.
    begin of T_WORD_HEADING_DETECTION,
      FONTS type STANDARD TABLE OF T_FONT_SETTING WITH NON-UNIQUE DEFAULT KEY,
      STYLES type STANDARD TABLE OF T_WORD_STYLE WITH NON-UNIQUE DEFAULT KEY,
    end of T_WORD_HEADING_DETECTION.
  types:
    "!   Object containing heading detection conversion settings for PDF documents.
    begin of T_PDF_HEADING_DETECTION,
      FONTS type STANDARD TABLE OF T_FONT_SETTING WITH NON-UNIQUE DEFAULT KEY,
    end of T_PDF_HEADING_DETECTION.
  types:
    "!   A list of PDF conversion settings.
    begin of T_PDF_SETTINGS,
      HEADING type T_PDF_HEADING_DETECTION,
    end of T_PDF_SETTINGS.
  types:
    "!   Object that defines a box folder to crawl with this configuration.
    begin of T_SOURCE_OPTIONS_FOLDER,
      OWNER_USER_ID type STRING,
      FOLDER_ID type STRING,
      LIMIT type INTEGER,
    end of T_SOURCE_OPTIONS_FOLDER.
  types:
    "!   Object defining a cloud object store bucket to crawl.
    begin of T_SOURCE_OPTIONS_BUCKETS,
      NAME type STRING,
      LIMIT type INTEGER,
    end of T_SOURCE_OPTIONS_BUCKETS.
  types:
    "!   Object containing the schedule information for the source.
    begin of T_SOURCE_SCHEDULE,
      ENABLED type BOOLEAN,
      TIME_ZONE type STRING,
      FREQUENCY type STRING,
    end of T_SOURCE_SCHEDULE.
  types:
    "!   Object that defines a Salesforce document object type crawl with this
    "!    configuration.
    begin of T_SOURCE_OPTIONS_OBJECT,
      NAME type STRING,
      LIMIT type INTEGER,
    end of T_SOURCE_OPTIONS_OBJECT.
  types:
    "!   Object that defines a Microsoft SharePoint site collection to crawl with this
    "!    configuration.
    begin of T_SOURCE_OPTIONS_SITE_COLL,
      SITE_COLLECTION_PATH1 type STRING,
      LIMIT type INTEGER,
    end of T_SOURCE_OPTIONS_SITE_COLL.
  types:
    "!   The **options** object defines which items to crawl from the source system.
    begin of T_SOURCE_OPTIONS,
      FOLDERS type STANDARD TABLE OF T_SOURCE_OPTIONS_FOLDER WITH NON-UNIQUE DEFAULT KEY,
      OBJECTS type STANDARD TABLE OF T_SOURCE_OPTIONS_OBJECT WITH NON-UNIQUE DEFAULT KEY,
      SITE_COLLECTIONS type STANDARD TABLE OF T_SOURCE_OPTIONS_SITE_COLL WITH NON-UNIQUE DEFAULT KEY,
      URLS type STANDARD TABLE OF T_SOURCE_OPTIONS_WEB_CRAWL WITH NON-UNIQUE DEFAULT KEY,
      BUCKETS type STANDARD TABLE OF T_SOURCE_OPTIONS_BUCKETS WITH NON-UNIQUE DEFAULT KEY,
      CRAWL_ALL_BUCKETS type BOOLEAN,
    end of T_SOURCE_OPTIONS.
  types:
    "!   Object containing source parameters for the configuration.
    begin of T_SOURCE,
      TYPE type STRING,
      CREDENTIAL_ID type STRING,
      SCHEDULE type T_SOURCE_SCHEDULE,
      OPTIONS type T_SOURCE_OPTIONS,
    end of T_SOURCE.
  types:
    "!   Object containing an array of XPaths.
    begin of T_XPATH_PATTERNS,
      XPATHS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
    end of T_XPATH_PATTERNS.
  types:
    "!   Options which are specific to a particular enrichment.
    begin of T_ENRICHMENT_OPTIONS,
      FEATURES type T_NLU_ENRICHMENT_FEATURES,
      LANGUAGE type STRING,
      MODEL type STRING,
    end of T_ENRICHMENT_OPTIONS.
  types:
    "!   Enrichment step to perform on the document. Each enrichment is performed on the
    "!    specified field in the order that they are listed in the configuration.
    begin of T_ENRICHMENT,
      DESCRIPTION type STRING,
      DESTINATION_FIELD type STRING,
      SOURCE_FIELD type STRING,
      OVERWRITE type BOOLEAN,
      ENRICHMENT type STRING,
      IGNORE_DOWNSTREAM_ERRORS type BOOLEAN,
      OPTIONS type T_ENRICHMENT_OPTIONS,
    end of T_ENRICHMENT.
  types:
    "!   A list of Document Segmentation settings.
    begin of T_SEGMENT_SETTINGS,
      ENABLED type BOOLEAN,
      SELECTOR_TAGS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      ANNOTATED_FIELDS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
    end of T_SEGMENT_SETTINGS.
  types:
    "!   A list of Word conversion settings.
    begin of T_WORD_SETTINGS,
      HEADING type T_WORD_HEADING_DETECTION,
    end of T_WORD_SETTINGS.
  types:
    "!   A list of HTML conversion settings.
    begin of T_HTML_SETTINGS,
      EXCLUDE_TAGS_COMPLETELY type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      EXCLUDE_TAGS_KEEP_CONTENT type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      KEEP_CONTENT type T_XPATH_PATTERNS,
      EXCLUDE_CONTENT type T_XPATH_PATTERNS,
      KEEP_TAG_ATTRIBUTES type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      EXCLUDE_TAG_ATTRIBUTES type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
    end of T_HTML_SETTINGS.
  types:
    "!   Document conversion settings.
    begin of T_CONVERSIONS,
      PDF type T_PDF_SETTINGS,
      WORD type T_WORD_SETTINGS,
      HTML type T_HTML_SETTINGS,
      SEGMENT type T_SEGMENT_SETTINGS,
      JSON_NORMALIZATIONS type STANDARD TABLE OF T_NORMALIZATION_OPERATION WITH NON-UNIQUE DEFAULT KEY,
      IMAGE_TEXT_RECOGNITION type BOOLEAN,
    end of T_CONVERSIONS.
  types:
    "!   A custom configuration for the environment.
    begin of T_CONFIGURATION,
      CONFIGURATION_ID type STRING,
      NAME type STRING,
      CREATED type DATETIME,
      UPDATED type DATETIME,
      DESCRIPTION type STRING,
      CONVERSIONS type T_CONVERSIONS,
      ENRICHMENTS type STANDARD TABLE OF T_ENRICHMENT WITH NON-UNIQUE DEFAULT KEY,
      NORMALIZATIONS type STANDARD TABLE OF T_NORMALIZATION_OPERATION WITH NON-UNIQUE DEFAULT KEY,
      SOURCE type T_SOURCE,
    end of T_CONFIGURATION.
  types:
    "!   Object containing an array of available configurations.
    begin of T_LIST_CONFIGURATIONS_RESPONSE,
      CONFIGURATIONS type STANDARD TABLE OF T_CONFIGURATION WITH NON-UNIQUE DEFAULT KEY,
    end of T_LIST_CONFIGURATIONS_RESPONSE.
  types:
    "!   Object containing source crawl status information.
    begin of T_SOURCE_STATUS,
      STATUS type STRING,
      NEXT_CRAWL type DATETIME,
    end of T_SOURCE_STATUS.
  types:
    "!   Object returned after credentials are deleted.
    begin of T_DELETE_CREDENTIALS,
      CREDENTIAL_ID type STRING,
      STATUS type STRING,
    end of T_DELETE_CREDENTIALS.
  types:
    "!   A notice produced for the collection.
    begin of T_NOTICE,
      NOTICE_ID type STRING,
      CREATED type DATETIME,
      DOCUMENT_ID type STRING,
      QUERY_ID type STRING,
      SEVERITY type STRING,
      STEP type STRING,
      DESCRIPTION type STRING,
    end of T_NOTICE.
  types:
    "!   Information returned after an uploaded document is accepted.
    begin of T_DOCUMENT_ACCEPTED,
      DOCUMENT_ID type STRING,
      STATUS type STRING,
      NOTICES type STANDARD TABLE OF T_NOTICE WITH NON-UNIQUE DEFAULT KEY,
    end of T_DOCUMENT_ACCEPTED.
  types:
    "!   Object describing a specific gateway.
    begin of T_GATEWAY,
      GATEWAY_ID type STRING,
      NAME type STRING,
      STATUS type STRING,
      TOKEN type STRING,
      TOKEN_ID type STRING,
    end of T_GATEWAY.
  types:
    "!   Aggregation result data for the requested metric.
    begin of T_METRIC_AGGREGATION_RESULT,
      KEY_AS_STRING type DATETIME,
      KEY type LONG,
      MATCHING_RESULTS type INTEGER,
      EVENT_RATE type DOUBLE,
    end of T_METRIC_AGGREGATION_RESULT.
  types:
    "!   An aggregation analyzing log information for queries and events.
    begin of T_METRIC_AGGREGATION,
      INTERVAL type STRING,
      EVENT_TYPE type STRING,
      RESULTS type STANDARD TABLE OF T_METRIC_AGGREGATION_RESULT WITH NON-UNIQUE DEFAULT KEY,
    end of T_METRIC_AGGREGATION.
  types:
    "!   The response generated from a call to a **metrics** method.
    begin of T_METRIC_RESPONSE,
      AGGREGATIONS type STANDARD TABLE OF T_METRIC_AGGREGATION WITH NON-UNIQUE DEFAULT KEY,
    end of T_METRIC_RESPONSE.
  types:
    "!   Metadata of a query result.
    begin of T_QUERY_RESULT_METADATA,
      SCORE type DOUBLE,
      CONFIDENCE type DOUBLE,
    end of T_QUERY_RESULT_METADATA.
  types:
    "!   Query result object.
    begin of T_QUERY_NOTICES_RESULT,
      ID type STRING,
      METADATA type MAP,
      COLLECTION_ID type STRING,
      RESULT_METADATA type T_QUERY_RESULT_METADATA,
      TITLE type STRING,
      CODE type INTEGER,
      FILENAME type STRING,
      FILE_TYPE type STRING,
      SHA1 type STRING,
      NOTICES type STANDARD TABLE OF T_NOTICE WITH NON-UNIQUE DEFAULT KEY,
    end of T_QUERY_NOTICES_RESULT.
  types:
    "!   Each object in the **results** array corresponds to an individual document
    "!    returned by the original query.
    begin of T_LOG_QRY_RESP_RSLT_DOCS_RSLT,
      POSITION type INTEGER,
      DOCUMENT_ID type STRING,
      SCORE type DOUBLE,
      CONFIDENCE type DOUBLE,
      COLLECTION_ID type STRING,
    end of T_LOG_QRY_RESP_RSLT_DOCS_RSLT.
  types:
    "!   Object containing result information that was returned by the query used to
    "!    create this log entry. Only returned with logs of type `query`.
    begin of T_LOG_QUERY_RESP_RESULT_DOCS,
      RESULTS type STANDARD TABLE OF T_LOG_QRY_RESP_RSLT_DOCS_RSLT WITH NON-UNIQUE DEFAULT KEY,
      COUNT type INTEGER,
    end of T_LOG_QUERY_RESP_RESULT_DOCS.
  types:
    "!   Object containing field details.
    begin of T_FIELD,
      FIELD type STRING,
      TYPE type STRING,
    end of T_FIELD.
  types:
    "!   Query event data object.
    begin of T_EVENT_DATA,
      ENVIRONMENT_ID type STRING,
      SESSION_TOKEN type STRING,
      CLIENT_TIMESTAMP type DATETIME,
      DISPLAY_RANK type INTEGER,
      COLLECTION_ID type STRING,
      DOCUMENT_ID type STRING,
      QUERY_ID type STRING,
    end of T_EVENT_DATA.
  types:
    "!   An object defining the event being created.
    begin of T_CREATE_EVENT_OBJECT,
      TYPE type STRING,
      DATA type T_EVENT_DATA,
    end of T_CREATE_EVENT_OBJECT.
  types:
    "!
    begin of T_NESTED,
      PATH type STRING,
    end of T_NESTED.
  types:
    "!   Object that describes a long query.
    begin of T_QUERY_LARGE,
      FILTER type STRING,
      QUERY type STRING,
      NATURAL_LANGUAGE_QUERY type STRING,
      PASSAGES type BOOLEAN,
      AGGREGATION type STRING,
      COUNT type INTEGER,
      RETURN type STRING,
      OFFSET type INTEGER,
      SORT type STRING,
      HIGHLIGHT type BOOLEAN,
      PASSAGES_FIELDS type STRING,
      PASSAGES_COUNT type INTEGER,
      PASSAGES_CHARACTERS type INTEGER,
      DEDUPLICATE type BOOLEAN,
      DEDUPLICATE_FIELD type STRING,
      SIMILAR type BOOLEAN,
      SIMILAR_DOCUMENT_IDS type STRING,
      SIMILAR_FIELDS type STRING,
      BIAS type STRING,
    end of T_QUERY_LARGE.
  types:
    "!   Object containing user-defined name.
    begin of T_GATEWAY_NAME,
      NAME type STRING,
    end of T_GATEWAY_NAME.
  types:
    "!   Object containing collection document count information.
    begin of T_DOCUMENT_COUNTS,
      AVAILABLE type LONG,
      PROCESSING type LONG,
      FAILED type LONG,
      PENDING type LONG,
    end of T_DOCUMENT_COUNTS.
  types:
    "!   Information about custom smart document understanding fields that exist in this
    "!    collection.
    begin of T_SDU_STATUS_CUSTOM_FIELDS,
      DEFINED type LONG,
      MAXIMUM_ALLOWED type LONG,
    end of T_SDU_STATUS_CUSTOM_FIELDS.
  types:
    "!   Object containing smart document understanding information for this collection.
    begin of T_SDU_STATUS,
      ENABLED type BOOLEAN,
      TOTAL_ANNOTATED_PAGES type LONG,
      TOTAL_PAGES type LONG,
      TOTAL_DOCUMENTS type LONG,
      CUSTOM_FIELDS type T_SDU_STATUS_CUSTOM_FIELDS,
    end of T_SDU_STATUS.
  types:
    "!   Object containing information about the crawl status of this collection.
    begin of T_COLLECTION_CRAWL_STATUS,
      SOURCE_CRAWL type T_SOURCE_STATUS,
    end of T_COLLECTION_CRAWL_STATUS.
  types:
    "!   Summary of the disk usage statistics for this collection.
    begin of T_COLLECTION_DISK_USAGE,
      USED_BYTES type INTEGER,
    end of T_COLLECTION_DISK_USAGE.
  types:
    "!   A collection for storing documents.
    begin of T_COLLECTION,
      COLLECTION_ID type STRING,
      NAME type STRING,
      DESCRIPTION type STRING,
      CREATED type DATETIME,
      UPDATED type DATETIME,
      STATUS type STRING,
      CONFIGURATION_ID type STRING,
      LANGUAGE type STRING,
      DOCUMENT_COUNTS type T_DOCUMENT_COUNTS,
      DISK_USAGE type T_COLLECTION_DISK_USAGE,
      TRAINING_STATUS type T_TRAINING_STATUS,
      CRAWL_STATUS type T_COLLECTION_CRAWL_STATUS,
      SMART_DOCUMENT_UNDERSTANDING type T_SDU_STATUS,
    end of T_COLLECTION.
  types:
    "!   Array of Microsoft Word styles to convert.
      T_WORD_STYLES type STANDARD TABLE OF T_WORD_STYLE WITH NON-UNIQUE DEFAULT KEY.
  types:
    "!   An object representing the configuration options to use for the `elements`
    "!    enrichment.
    begin of T_ELEMENTS_ENRICHMENT_OPTIONS,
      MODEL type STRING,
    end of T_ELEMENTS_ENRICHMENT_OPTIONS.
  types:
    "!   Object containing information about a new environment.
    begin of T_CREATE_ENVIRONMENT_REQUEST,
      NAME type STRING,
      DESCRIPTION type STRING,
      SIZE type STRING,
    end of T_CREATE_ENVIRONMENT_REQUEST.
  types:
    "!   Object containing specification for a new collection.
    begin of T_CREATE_COLLECTION_REQUEST,
      NAME type STRING,
      DESCRIPTION type STRING,
      CONFIGURATION_ID type STRING,
      LANGUAGE type STRING,
    end of T_CREATE_COLLECTION_REQUEST.
  types:
    "!
    begin of T_INLINE_OBJECT,
      STOPWORD_FILE type FILE,
    end of T_INLINE_OBJECT.
  types:
    "!   Query result object.
    begin of T_QUERY_RESULT,
      ID type STRING,
      METADATA type MAP,
      COLLECTION_ID type STRING,
      RESULT_METADATA type T_QUERY_RESULT_METADATA,
      TITLE type STRING,
    end of T_QUERY_RESULT.
  types:
    "!   Top hit information for this query.
    begin of T_TOP_HITS_RESULTS,
      MATCHING_RESULTS type INTEGER,
      HITS type STANDARD TABLE OF T_QUERY_RESULT WITH NON-UNIQUE DEFAULT KEY,
    end of T_TOP_HITS_RESULTS.
  types:
    "!   Response object returned when deleting a colleciton.
    begin of T_DELETE_COLLECTION_RESPONSE,
      COLLECTION_ID type STRING,
      STATUS type STRING,
    end of T_DELETE_COLLECTION_RESPONSE.
  types:
    "!
    begin of T_TERM,
      FIELD type STRING,
      COUNT type INTEGER,
    end of T_TERM.
  types:
    "!   An object containing an array of autocompletion suggestions.
    begin of T_COMPLETIONS,
      COMPLETIONS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
    end of T_COMPLETIONS.
  types:
    "!   An object contain retrieval type information.
    begin of T_RETRIEVAL_DETAILS,
      DOCUMENT_RETRIEVAL_STRATEGY type STRING,
    end of T_RETRIEVAL_DETAILS.
  types:
    "!   Response object returned when deleting an environment.
    begin of T_DELETE_ENVIRONMENT_RESPONSE,
      ENVIRONMENT_ID type STRING,
      STATUS type STRING,
    end of T_DELETE_ENVIRONMENT_RESPONSE.
  types:
    "!   The list of fetched fields.
    "!
    "!   The fields are returned using a fully qualified name format, however, the format
    "!    differs slightly from that used by the query operations.
    "!
    "!     * Fields which contain nested JSON objects are assigned a type of "nested".
    "!
    "!     * Fields which belong to a nested object are prefixed with `.properties` (for
    "!    example, `warnings.properties.severity` means that the `warnings` object has a
    "!    property called `severity`).
    "!
    "!     * Fields returned from the News collection are prefixed with
    "!    `v&#123;N&#125;-fullnews-t3-&#123;YEAR&#125;.mappings` (for example,
    "!    `v5-fullnews-t3-2016.mappings.text.properties.author`).
    begin of T_LST_COLLECTION_FIELDS_RESP,
      FIELDS type STANDARD TABLE OF T_FIELD WITH NON-UNIQUE DEFAULT KEY,
    end of T_LST_COLLECTION_FIELDS_RESP.
  types:
    "!   Object containing collection update information.
    begin of T_UPDATE_COLLECTION_REQUEST,
      NAME type STRING,
      DESCRIPTION type STRING,
      CONFIGURATION_ID type STRING,
    end of T_UPDATE_COLLECTION_REQUEST.
  types:
    "!   Object containing gateways array.
    begin of T_GATEWAY_LIST,
      GATEWAYS type STANDARD TABLE OF T_GATEWAY WITH NON-UNIQUE DEFAULT KEY,
    end of T_GATEWAY_LIST.
  types:
    "!   Aggregation result data for the requested metric.
    begin of T_METRIC_TOKEN_AGGR_RESULT,
      KEY type STRING,
      MATCHING_RESULTS type INTEGER,
      EVENT_RATE type DOUBLE,
    end of T_METRIC_TOKEN_AGGR_RESULT.
  types:
    "!   An aggregation analyzing log information for queries and events.
    begin of T_METRIC_TOKEN_AGGREGATION,
      EVENT_TYPE type STRING,
      RESULTS type STANDARD TABLE OF T_METRIC_TOKEN_AGGR_RESULT WITH NON-UNIQUE DEFAULT KEY,
    end of T_METRIC_TOKEN_AGGREGATION.
  types:
    "!   Object that describes a long query.
    begin of T_COLL_QUERY_LARGE,
      FILTER type STRING,
      QUERY type STRING,
      NATURAL_LANGUAGE_QUERY type STRING,
      PASSAGES type BOOLEAN,
      AGGREGATION type STRING,
      COUNT type INTEGER,
      RETURN type STRING,
      OFFSET type INTEGER,
      SORT type STRING,
      HIGHLIGHT type BOOLEAN,
      PASSAGES_FIELDS type STRING,
      PASSAGES_COUNT type INTEGER,
      PASSAGES_CHARACTERS type INTEGER,
      DEDUPLICATE type BOOLEAN,
      DEDUPLICATE_FIELD type STRING,
      SIMILAR type BOOLEAN,
      SIMILAR_DOCUMENT_IDS type STRING,
      SIMILAR_FIELDS type STRING,
      BIAS type STRING,
      SPELLING_SUGGESTIONS type BOOLEAN,
    end of T_COLL_QUERY_LARGE.
  types:
    "!   Object containing environment update information.
    begin of T_UPDATE_ENVIRONMENT_REQUEST,
      NAME type STRING,
      DESCRIPTION type STRING,
      SIZE type STRING,
    end of T_UPDATE_ENVIRONMENT_REQUEST.
  types:
    "!   Information returned when a configuration is deleted.
    begin of T_DEL_CONFIGURATION_RESPONSE,
      CONFIGURATION_ID type STRING,
      STATUS type STRING,
      NOTICES type STANDARD TABLE OF T_NOTICE WITH NON-UNIQUE DEFAULT KEY,
    end of T_DEL_CONFIGURATION_RESPONSE.
  types:
    "!   A response containing the documents and aggregations for the query.
    begin of T_QUERY_RESPONSE,
      MATCHING_RESULTS type INTEGER,
      RESULTS type STANDARD TABLE OF T_QUERY_RESULT WITH NON-UNIQUE DEFAULT KEY,
      AGGREGATIONS type STANDARD TABLE OF T_QUERY_AGGREGATION WITH NON-UNIQUE DEFAULT KEY,
      PASSAGES type STANDARD TABLE OF T_QUERY_PASSAGES WITH NON-UNIQUE DEFAULT KEY,
      DUPLICATES_REMOVED type INTEGER,
      SESSION_TOKEN type STRING,
      RETRIEVAL_DETAILS type T_RETRIEVAL_DETAILS,
    end of T_QUERY_RESPONSE.
  types:
    "!
    begin of T_TIMESLICE,
      FIELD type STRING,
      INTERVAL type STRING,
      ANOMALY type BOOLEAN,
    end of T_TIMESLICE.
  types:
    "!   Training query to add.
    begin of T_NEW_TRAINING_QUERY,
      NATURAL_LANGUAGE_QUERY type STRING,
      FILTER type STRING,
      EXAMPLES type STANDARD TABLE OF T_TRAINING_EXAMPLE WITH NON-UNIQUE DEFAULT KEY,
    end of T_NEW_TRAINING_QUERY.
  types:
    "!   Status information about a submitted document.
    begin of T_DOCUMENT_STATUS,
      DOCUMENT_ID type STRING,
      CONFIGURATION_ID type STRING,
      STATUS type STRING,
      STATUS_DESCRIPTION type STRING,
      FILENAME type STRING,
      FILE_TYPE type STRING,
      SHA1 type STRING,
      NOTICES type STANDARD TABLE OF T_NOTICE WITH NON-UNIQUE DEFAULT KEY,
    end of T_DOCUMENT_STATUS.
  types:
    "!   Object that describes a long query.
    begin of T_FED_QUERY_LARGE,
      FILTER type STRING,
      QUERY type STRING,
      NATURAL_LANGUAGE_QUERY type STRING,
      PASSAGES type BOOLEAN,
      AGGREGATION type STRING,
      COUNT type INTEGER,
      RETURN type STRING,
      OFFSET type INTEGER,
      SORT type STRING,
      HIGHLIGHT type BOOLEAN,
      PASSAGES_FIELDS type STRING,
      PASSAGES_COUNT type INTEGER,
      PASSAGES_CHARACTERS type INTEGER,
      DEDUPLICATE type BOOLEAN,
      DEDUPLICATE_FIELD type STRING,
      SIMILAR type BOOLEAN,
      SIMILAR_DOCUMENT_IDS type STRING,
      SIMILAR_FIELDS type STRING,
      BIAS type STRING,
      COLLECTION_IDS type STRING,
    end of T_FED_QUERY_LARGE.
  types:
    "!   An error response object.
    begin of T_ERROR_RESPONSE,
      CODE type INTEGER,
      ERROR type STRING,
    end of T_ERROR_RESPONSE.
  types:
    "!   An expansion definition. Each object respresents one set of expandable strings.
    "!    For example, you could have expansions for the word `hot` in one object, and
    "!    expansions for the word `cold` in another.
    begin of T_EXPANSION,
      INPUT_TERMS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      EXPANDED_TERMS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
    end of T_EXPANSION.
  types:
    "!   The query expansion definitions for the specified collection.
    begin of T_EXPANSIONS,
      EXPANSIONS type STANDARD TABLE OF T_EXPANSION WITH NON-UNIQUE DEFAULT KEY,
    end of T_EXPANSIONS.
  types:
    "!   An object defining the event being created.
    begin of T_CREATE_EVENT_RESPONSE,
      TYPE type STRING,
      DATA type T_EVENT_DATA,
    end of T_CREATE_EVENT_RESPONSE.
  types:
    "!   An array of document enrichment settings for the configuration.
      T_ENRICHMENTS type STANDARD TABLE OF T_ENRICHMENT WITH NON-UNIQUE DEFAULT KEY.
  types:
    "!   The response generated from a call to a **metrics** method that evaluates
    "!    tokens.
    begin of T_METRIC_TOKEN_RESPONSE,
      AGGREGATIONS type STANDARD TABLE OF T_METRIC_TOKEN_AGGREGATION WITH NON-UNIQUE DEFAULT KEY,
    end of T_METRIC_TOKEN_RESPONSE.
  types:
    "!   Object containing an array of training examples.
    begin of T_TRAINING_EXAMPLE_LIST,
      EXAMPLES type STANDARD TABLE OF T_TRAINING_EXAMPLE WITH NON-UNIQUE DEFAULT KEY,
    end of T_TRAINING_EXAMPLE_LIST.
  types:
    "!   Information returned when a document is deleted.
    begin of T_DELETE_DOCUMENT_RESPONSE,
      DOCUMENT_ID type STRING,
      STATUS type STRING,
    end of T_DELETE_DOCUMENT_RESPONSE.
  types:
    "!
    begin of T_TOP_HITS,
      SIZE type INTEGER,
      HITS type T_TOP_HITS_RESULTS,
    end of T_TOP_HITS.
  types:
    "!   Individual result object for a **logs** query. Each object represents either a
    "!    query to a Discovery collection or an event that is associated with a query.
    begin of T_LOG_QUERY_RESPONSE_RESULT,
      ENVIRONMENT_ID type STRING,
      CUSTOMER_ID type STRING,
      DOCUMENT_TYPE type STRING,
      NATURAL_LANGUAGE_QUERY type STRING,
      DOCUMENT_RESULTS type T_LOG_QUERY_RESP_RESULT_DOCS,
      CREATED_TIMESTAMP type DATETIME,
      CLIENT_TIMESTAMP type DATETIME,
      QUERY_ID type STRING,
      SESSION_TOKEN type STRING,
      COLLECTION_ID type STRING,
      DISPLAY_RANK type INTEGER,
      DOCUMENT_ID type STRING,
      EVENT_TYPE type STRING,
      RESULT_TYPE type STRING,
    end of T_LOG_QUERY_RESPONSE_RESULT.
  types:
    "!   Object containing results that match the requested **logs** query.
    begin of T_LOG_QUERY_RESPONSE,
      MATCHING_RESULTS type INTEGER,
      RESULTS type STANDARD TABLE OF T_LOG_QUERY_RESPONSE_RESULT WITH NON-UNIQUE DEFAULT KEY,
    end of T_LOG_QUERY_RESPONSE.
  types:
    "!   Defines operations that can be used to transform the final output JSON into a
    "!    normalized form. Operations are executed in the order that they appear in the
    "!    array.
      T_NORMALIZATIONS type STANDARD TABLE OF T_NORMALIZATION_OPERATION WITH NON-UNIQUE DEFAULT KEY.
  types:
    "!   Training example to add.
    begin of T_TRAINING_EXAMPLE_PATCH,
      CROSS_REFERENCE type STRING,
      RELEVANCE type INTEGER,
    end of T_TRAINING_EXAMPLE_PATCH.
  types:
    "!   Response object containing an array of collection details.
    begin of T_LIST_COLLECTIONS_RESPONSE,
      COLLECTIONS type STANDARD TABLE OF T_COLLECTION WITH NON-UNIQUE DEFAULT KEY,
    end of T_LIST_COLLECTIONS_RESPONSE.
  types:
    "!
    begin of T_CALCULATION,
      FIELD type STRING,
      VALUE type DOUBLE,
    end of T_CALCULATION.
  types:
    "!   Training information for a specific collection.
    begin of T_TRAINING_DATA_SET,
      ENVIRONMENT_ID type STRING,
      COLLECTION_ID type STRING,
      QUERIES type STANDARD TABLE OF T_TRAINING_QUERY WITH NON-UNIQUE DEFAULT KEY,
    end of T_TRAINING_DATA_SET.
  types:
    "!   Array of font matching configurations.
      T_FONT_SETTINGS type STANDARD TABLE OF T_FONT_SETTING WITH NON-UNIQUE DEFAULT KEY.
  types:
    "!   Object containing notice query results.
    begin of T_QUERY_NOTICES_RESPONSE,
      MATCHING_RESULTS type INTEGER,
      RESULTS type STANDARD TABLE OF T_QUERY_NOTICES_RESULT WITH NON-UNIQUE DEFAULT KEY,
      AGGREGATIONS type STANDARD TABLE OF T_QUERY_AGGREGATION WITH NON-UNIQUE DEFAULT KEY,
      PASSAGES type STANDARD TABLE OF T_QUERY_PASSAGES WITH NON-UNIQUE DEFAULT KEY,
      DUPLICATES_REMOVED type INTEGER,
    end of T_QUERY_NOTICES_RESPONSE.
  types:
    "!
    begin of T_HISTOGRAM,
      FIELD type STRING,
      INTERVAL type INTEGER,
    end of T_HISTOGRAM.

constants:
  begin of C_REQUIRED_FIELDS,
    T_QUERY_AGGREGATION type string value '|',
    T_AGGREGATION_RESULT type string value '|',
    T_TRAINING_STATUS type string value '|',
    T_TOKEN_DICT_STATUS_RESPONSE type string value '|',
    T_NLU_ENRICHMENT_RELATIONS type string value '|',
    T_NLU_ENRICHMENT_SENTIMENT type string value '|',
    T_NL_ENRICHMENT_SEMANTIC_ROLES type string value '|',
    T_NLU_ENRICHMENT_ENTITIES type string value '|',
    T_NLU_ENRICHMENT_EMOTION type string value '|',
    T_NLU_ENRICHMENT_CONCEPTS type string value '|',
    T_NLU_ENRICHMENT_KEYWORDS type string value '|',
    T_NLU_ENRICHMENT_FEATURES type string value '|',
    T_NLU_ENRICHMENT_OPTIONS type string value '|',
    T_TOKEN_DICT_RULE type string value '|TEXT|TOKENS|PART_OF_SPEECH|',
    T_TOKEN_DICT type string value '|',
    T_FILTER type string value '|',
    T_SOURCE_OPTIONS_WEB_CRAWL type string value '|URL|',
    T_CREDENTIAL_DETAILS type string value '|',
    T_CREDENTIALS type string value '|',
    T_CREDENTIALS_LIST type string value '|',
    T_COLLECTION_USAGE type string value '|',
    T_DISK_USAGE type string value '|',
    T_ENVIRONMENT_DOCUMENTS type string value '|',
    T_INDEX_CAPACITY type string value '|',
    T_SEARCH_STATUS type string value '|',
    T_ENVIRONMENT type string value '|',
    T_LIST_ENVIRONMENTS_RESPONSE type string value '|',
    T_GATEWAY_DELETE type string value '|',
    T_TRAINING_EXAMPLE type string value '|',
    T_TRAINING_QUERY type string value '|',
    T_QUERY_PASSAGES type string value '|',
    T_NORMALIZATION_OPERATION type string value '|',
    T_FONT_SETTING type string value '|',
    T_WORD_STYLE type string value '|',
    T_WORD_HEADING_DETECTION type string value '|',
    T_PDF_HEADING_DETECTION type string value '|',
    T_PDF_SETTINGS type string value '|',
    T_SOURCE_OPTIONS_FOLDER type string value '|OWNER_USER_ID|FOLDER_ID|',
    T_SOURCE_OPTIONS_BUCKETS type string value '|NAME|',
    T_SOURCE_SCHEDULE type string value '|',
    T_SOURCE_OPTIONS_OBJECT type string value '|NAME|',
    T_SOURCE_OPTIONS_SITE_COLL type string value '|SITE_COLLECTION_PATH1|',
    T_SOURCE_OPTIONS type string value '|',
    T_SOURCE type string value '|',
    T_XPATH_PATTERNS type string value '|',
    T_ENRICHMENT_OPTIONS type string value '|',
    T_ENRICHMENT type string value '|DESTINATION_FIELD|SOURCE_FIELD|ENRICHMENT|',
    T_SEGMENT_SETTINGS type string value '|',
    T_WORD_SETTINGS type string value '|',
    T_HTML_SETTINGS type string value '|',
    T_CONVERSIONS type string value '|',
    T_CONFIGURATION type string value '|NAME|',
    T_LIST_CONFIGURATIONS_RESPONSE type string value '|',
    T_SOURCE_STATUS type string value '|',
    T_DELETE_CREDENTIALS type string value '|',
    T_NOTICE type string value '|',
    T_DOCUMENT_ACCEPTED type string value '|',
    T_GATEWAY type string value '|',
    T_METRIC_AGGREGATION_RESULT type string value '|',
    T_METRIC_AGGREGATION type string value '|',
    T_METRIC_RESPONSE type string value '|',
    T_QUERY_RESULT_METADATA type string value '|SCORE|',
    T_QUERY_NOTICES_RESULT type string value '|',
    T_LOG_QRY_RESP_RSLT_DOCS_RSLT type string value '|',
    T_LOG_QUERY_RESP_RESULT_DOCS type string value '|',
    T_FIELD type string value '|',
    T_EVENT_DATA type string value '|ENVIRONMENT_ID|SESSION_TOKEN|COLLECTION_ID|DOCUMENT_ID|',
    T_CREATE_EVENT_OBJECT type string value '|TYPE|DATA|',
    T_NESTED type string value '|',
    T_QUERY_LARGE type string value '|',
    T_GATEWAY_NAME type string value '|',
    T_DOCUMENT_COUNTS type string value '|',
    T_SDU_STATUS_CUSTOM_FIELDS type string value '|',
    T_SDU_STATUS type string value '|',
    T_COLLECTION_CRAWL_STATUS type string value '|',
    T_COLLECTION_DISK_USAGE type string value '|',
    T_COLLECTION type string value '|',
    T_ELEMENTS_ENRICHMENT_OPTIONS type string value '|',
    T_CREATE_ENVIRONMENT_REQUEST type string value '|NAME|',
    T_CREATE_COLLECTION_REQUEST type string value '|NAME|',
    T_INLINE_OBJECT type string value '|STOPWORD_FILE|',
    T_QUERY_RESULT type string value '|',
    T_TOP_HITS_RESULTS type string value '|',
    T_DELETE_COLLECTION_RESPONSE type string value '|COLLECTION_ID|STATUS|',
    T_TERM type string value '|',
    T_COMPLETIONS type string value '|',
    T_RETRIEVAL_DETAILS type string value '|',
    T_DELETE_ENVIRONMENT_RESPONSE type string value '|ENVIRONMENT_ID|STATUS|',
    T_LST_COLLECTION_FIELDS_RESP type string value '|',
    T_UPDATE_COLLECTION_REQUEST type string value '|NAME|',
    T_GATEWAY_LIST type string value '|',
    T_METRIC_TOKEN_AGGR_RESULT type string value '|',
    T_METRIC_TOKEN_AGGREGATION type string value '|',
    T_COLL_QUERY_LARGE type string value '|',
    T_UPDATE_ENVIRONMENT_REQUEST type string value '|',
    T_DEL_CONFIGURATION_RESPONSE type string value '|CONFIGURATION_ID|STATUS|',
    T_QUERY_RESPONSE type string value '|',
    T_TIMESLICE type string value '|',
    T_NEW_TRAINING_QUERY type string value '|',
    T_DOCUMENT_STATUS type string value '|DOCUMENT_ID|STATUS|STATUS_DESCRIPTION|NOTICES|',
    T_FED_QUERY_LARGE type string value '|COLLECTION_IDS|',
    T_ERROR_RESPONSE type string value '|CODE|ERROR|',
    T_EXPANSION type string value '|EXPANDED_TERMS|',
    T_EXPANSIONS type string value '|EXPANSIONS|',
    T_CREATE_EVENT_RESPONSE type string value '|',
    T_METRIC_TOKEN_RESPONSE type string value '|',
    T_TRAINING_EXAMPLE_LIST type string value '|',
    T_DELETE_DOCUMENT_RESPONSE type string value '|',
    T_TOP_HITS type string value '|',
    T_LOG_QUERY_RESPONSE_RESULT type string value '|',
    T_LOG_QUERY_RESPONSE type string value '|',
    T_TRAINING_EXAMPLE_PATCH type string value '|',
    T_LIST_COLLECTIONS_RESPONSE type string value '|',
    T_CALCULATION type string value '|',
    T_TRAINING_DATA_SET type string value '|',
    T_QUERY_NOTICES_RESPONSE type string value '|',
    T_HISTOGRAM type string value '|',
    __DUMMY type string value SPACE,
  end of C_REQUIRED_FIELDS .

constants:
  begin of C_ABAPNAME_DICTIONARY,
     ENVIRONMENT_ID type string value 'environment_id',
     NAME type string value 'name',
     DESCRIPTION type string value 'description',
     CREATED type string value 'created',
     UPDATED type string value 'updated',
     STATUS type string value 'status',
     READ_ONLY type string value 'read_only',
     SIZE type string value 'size',
     REQUESTED_SIZE type string value 'requested_size',
     INDEX_CAPACITY type string value 'index_capacity',
     SEARCH_STATUS type string value 'search_status',
     DOCUMENTS type string value 'documents',
     DISK_USAGE type string value 'disk_usage',
     COLLECTIONS type string value 'collections',
     USED_BYTES type string value 'used_bytes',
     MAXIMUM_ALLOWED_BYTES type string value 'maximum_allowed_bytes',
     AVAILABLE type string value 'available',
     MAXIMUM_ALLOWED type string value 'maximum_allowed',
     INDEXED type string value 'indexed',
     ENVIRONMENTS type string value 'environments',
     CONFIGURATION_ID type string value 'configuration_id',
     LANGUAGE type string value 'language',
     COLLECTION_ID type string value 'collection_id',
     DOCUMENT_COUNTS type string value 'document_counts',
     TRAINING_STATUS type string value 'training_status',
     CRAWL_STATUS type string value 'crawl_status',
     SMART_DOCUMENT_UNDERSTANDING type string value 'smart_document_understanding',
     PROCESSING type string value 'processing',
     FAILED type string value 'failed',
     PENDING type string value 'pending',
     CONVERSIONS type string value 'conversions',
     ENRICHMENTS type string value 'enrichments',
     ENRICHMENT type string value 'enrichment',
     NORMALIZATIONS type string value 'normalizations',
     NORMALIZATION type string value 'normalization',
     SOURCE type string value 'source',
     PDF type string value 'pdf',
     WORD type string value 'word',
     HTML type string value 'html',
     SEGMENT type string value 'segment',
     JSON_NORMALIZATIONS type string value 'json_normalizations',
     IMAGE_TEXT_RECOGNITION type string value 'image_text_recognition',
     HEADING type string value 'heading',
     FONTS type string value 'fonts',
     FONTSETTING type string value 'fontSetting',
     STYLES type string value 'styles',
     WORDSTYLE type string value 'wordStyle',
     LEVEL type string value 'level',
     NAMES type string value 'names',
     EXCLUDE_TAGS_COMPLETELY type string value 'exclude_tags_completely',
     EXCLUDETAGSCOMPLETELY type string value 'excludeTagsCompletely',
     EXCLUDE_TAGS_KEEP_CONTENT type string value 'exclude_tags_keep_content',
     EXCLUDETAGSKEEPCONTENT type string value 'excludeTagsKeepContent',
     KEEP_CONTENT type string value 'keep_content',
     EXCLUDE_CONTENT type string value 'exclude_content',
     KEEP_TAG_ATTRIBUTES type string value 'keep_tag_attributes',
     KEEPTAGATTRIBUTES type string value 'keepTagAttributes',
     EXCLUDE_TAG_ATTRIBUTES type string value 'exclude_tag_attributes',
     EXCLUDETAGATTRIBUTES type string value 'excludeTagAttributes',
     ENABLED type string value 'enabled',
     SELECTOR_TAGS type string value 'selector_tags',
     SELECTORTAGS type string value 'selectorTags',
     ANNOTATED_FIELDS type string value 'annotated_fields',
     ANNOTATEDFIELDS type string value 'annotatedFields',
     XPATHS type string value 'xpaths',
     MIN_SIZE type string value 'min_size',
     MAX_SIZE type string value 'max_size',
     BOLD type string value 'bold',
     ITALIC type string value 'italic',
     DESTINATION_FIELD type string value 'destination_field',
     SOURCE_FIELD type string value 'source_field',
     OVERWRITE type string value 'overwrite',
     IGNORE_DOWNSTREAM_ERRORS type string value 'ignore_downstream_errors',
     OPTIONS type string value 'options',
     FEATURES type string value 'features',
     MODEL type string value 'model',
     OPERATION type string value 'operation',
     CONFIGURATIONS type string value 'configurations',
     NOTICES type string value 'notices',
     DOCUMENT_ID type string value 'document_id',
     STATUS_DESCRIPTION type string value 'status_description',
     FILENAME type string value 'filename',
     FILE_TYPE type string value 'file_type',
     SHA1 type string value 'sha1',
     FIELDS type string value 'fields',
     FIELD type string value 'field',
     TYPE type string value 'type',
     MATCHING_RESULTS type string value 'matching_results',
     RESULTS type string value 'results',
     AGGREGATIONS type string value 'aggregations',
     PASSAGES type string value 'passages',
     DUPLICATES_REMOVED type string value 'duplicates_removed',
     SESSION_TOKEN type string value 'session_token',
     RETRIEVAL_DETAILS type string value 'retrieval_details',
     ID type string value 'id',
     METADATA type string value 'metadata',
     INNER type string value 'inner',
     RESULT_METADATA type string value 'result_metadata',
     TITLE type string value 'title',
     SCORE type string value 'score',
     CONFIDENCE type string value 'confidence',
     CODE type string value 'code',
     KEY type string value 'key',
     INTERVAL type string value 'interval',
     VALUE type string value 'value',
     COUNT type string value 'count',
     MATCH type string value 'match',
     PATH type string value 'path',
     ANOMALY type string value 'anomaly',
     HITS type string value 'hits',
     TOTAL_EXAMPLES type string value 'total_examples',
     MINIMUM_QUERIES_ADDED type string value 'minimum_queries_added',
     MINIMUM_EXAMPLES_ADDED type string value 'minimum_examples_added',
     SUFFICIENT_LABEL_DIVERSITY type string value 'sufficient_label_diversity',
     SUCCESSFULLY_TRAINED type string value 'successfully_trained',
     DATA_UPDATED type string value 'data_updated',
     QUERIES type string value 'queries',
     QUERY_ID type string value 'query_id',
     NATURAL_LANGUAGE_QUERY type string value 'natural_language_query',
     FILTER type string value 'filter',
     EXAMPLES type string value 'examples',
     CROSS_REFERENCE type string value 'cross_reference',
     RELEVANCE type string value 'relevance',
     NOTICE_ID type string value 'notice_id',
     SEVERITY type string value 'severity',
     STEP type string value 'step',
     ERROR type string value 'error',
     PASSAGE_SCORE type string value 'passage_score',
     PASSAGE_TEXT type string value 'passage_text',
     START_OFFSET type string value 'start_offset',
     END_OFFSET type string value 'end_offset',
     KEYWORDS type string value 'keywords',
     ENTITIES type string value 'entities',
     SENTIMENT type string value 'sentiment',
     EMOTION type string value 'emotion',
     CATEGORIES type string value 'categories',
     SEMANTIC_ROLES type string value 'semantic_roles',
     RELATIONS type string value 'relations',
     CONCEPTS type string value 'concepts',
     LIMIT type string value 'limit',
     MENTIONS type string value 'mentions',
     MENTION_TYPES type string value 'mention_types',
     SENTENCE_LOCATIONS type string value 'sentence_locations',
     DOCUMENT type string value 'document',
     TARGETS type string value 'targets',
     TARGET type string value 'target',
     EXPANSIONS type string value 'expansions',
     INPUT_TERMS type string value 'input_terms',
     INPUTTERMS type string value 'inputTerms',
     EXPANDED_TERMS type string value 'expanded_terms',
     EXPANDEDTERMS type string value 'expandedTerms',
     DATA type string value 'data',
     CLIENT_TIMESTAMP type string value 'client_timestamp',
     DISPLAY_RANK type string value 'display_rank',
     EVENT_TYPE type string value 'event_type',
     KEY_AS_STRING type string value 'key_as_string',
     EVENT_RATE type string value 'event_rate',
     CUSTOMER_ID type string value 'customer_id',
     DOCUMENT_TYPE type string value 'document_type',
     DOCUMENT_RESULTS type string value 'document_results',
     CREATED_TIMESTAMP type string value 'created_timestamp',
     RESULT_TYPE type string value 'result_type',
     POSITION type string value 'position',
     CREDENTIALS type string value 'credentials',
     CREDENTIAL_ID type string value 'credential_id',
     SOURCE_TYPE type string value 'source_type',
     CREDENTIAL_DETAILS type string value 'credential_details',
     CREDENTIAL_TYPE type string value 'credential_type',
     CLIENT_ID type string value 'client_id',
     ENTERPRISE_ID type string value 'enterprise_id',
     URL type string value 'url',
     USERNAME type string value 'username',
     ORGANIZATION_URL type string value 'organization_url',
     SITE_COLLECTION_PATH type string value 'site_collection.path',
     CLIENT_SECRET type string value 'client_secret',
     PUBLIC_KEY_ID type string value 'public_key_id',
     PRIVATE_KEY type string value 'private_key',
     PASSPHRASE type string value 'passphrase',
     PASSWORD type string value 'password',
     GATEWAY_ID type string value 'gateway_id',
     SOURCE_VERSION type string value 'source_version',
     WEB_APPLICATION_URL type string value 'web_application_url',
     DOMAIN type string value 'domain',
     ENDPOINT type string value 'endpoint',
     ACCESS_KEY_ID type string value 'access_key_id',
     SECRET_ACCESS_KEY type string value 'secret_access_key',
     NEXT_CRAWL type string value 'next_crawl',
     SCHEDULE type string value 'schedule',
     TIME_ZONE type string value 'time_zone',
     FREQUENCY type string value 'frequency',
     FOLDERS type string value 'folders',
     OBJECTS type string value 'objects',
     SITE_COLLECTIONS type string value 'site_collections',
     SITECOLLECTIONS type string value 'siteCollections',
     URLS type string value 'urls',
     BUCKETS type string value 'buckets',
     CRAWL_ALL_BUCKETS type string value 'crawl_all_buckets',
     OWNER_USER_ID type string value 'owner_user_id',
     FOLDER_ID type string value 'folder_id',
     SITE_COLLECTION_PATH1 type string value 'site_collection_path',
     SCOPE type string value 'scope',
     LAST_TRAINED type string value 'last_trained',
     QUERY type string value 'query',
     AGGREGATION type string value 'aggregation',
     RETURN type string value 'return',
     OFFSET type string value 'offset',
     SORT type string value 'sort',
     HIGHLIGHT type string value 'highlight',
     PASSAGES_FIELDS type string value 'passages.fields',
     PASSAGES_COUNT type string value 'passages.count',
     PASSAGES_CHARACTERS type string value 'passages.characters',
     DEDUPLICATE type string value 'deduplicate',
     DEDUPLICATE_FIELD type string value 'deduplicate.field',
     SIMILAR type string value 'similar',
     SIMILAR_DOCUMENT_IDS type string value 'similar.document_ids',
     SIMILAR_FIELDS type string value 'similar.fields',
     BIAS type string value 'bias',
     TOKENIZATION_RULES type string value 'tokenization_rules',
     TOKENIZATIONRULES type string value 'tokenizationRules',
     TEXT type string value 'text',
     TOKENS type string value 'tokens',
     READINGS type string value 'readings',
     PART_OF_SPEECH type string value 'part_of_speech',
     DOCUMENT_RETRIEVAL_STRATEGY type string value 'document_retrieval_strategy',
     LIMIT_TO_STARTING_HOSTS type string value 'limit_to_starting_hosts',
     CRAWL_SPEED type string value 'crawl_speed',
     ALLOW_UNTRUSTED_CERTIFICATE type string value 'allow_untrusted_certificate',
     MAXIMUM_HOPS type string value 'maximum_hops',
     REQUEST_TIMEOUT type string value 'request_timeout',
     OVERRIDE_ROBOTS_TXT type string value 'override_robots_txt',
     BLACKLIST type string value 'blacklist',
     GATEWAYS type string value 'gateways',
     TOKEN type string value 'token',
     TOKEN_ID type string value 'token_id',
     TOTAL_ANNOTATED_PAGES type string value 'total_annotated_pages',
     TOTAL_PAGES type string value 'total_pages',
     TOTAL_DOCUMENTS type string value 'total_documents',
     CUSTOM_FIELDS type string value 'custom_fields',
     COMPLETIONS type string value 'completions',
     COLLECTION_IDS type string value 'collection_ids',
     SPELLING_SUGGESTIONS type string value 'spelling_suggestions',
     SOURCE_CRAWL type string value 'source_crawl',
     DEFINED type string value 'defined',
     STOPWORD_FILE type string value 'stopword_file',
  end of C_ABAPNAME_DICTIONARY .


  methods GET_APPNAME
    redefinition .
  methods GET_REQUEST_PROP
    redefinition .
  methods GET_SDK_VERSION_DATE
    redefinition .


    "! Create an environment.
    "!
    "! @parameter I_body |
    "!   An object that defines an environment name and optional description. The fields
    "!    in this object are not approved for personal information and cannot be deleted
    "!    based on customer ID.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_ENVIRONMENT
    "!
  methods CREATE_ENVIRONMENT
    importing
      !I_body type T_CREATE_ENVIRONMENT_REQUEST
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_ENVIRONMENT
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! List environments.
    "!
    "! @parameter I_name |
    "!   Show only the environment with the given name.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_LIST_ENVIRONMENTS_RESPONSE
    "!
  methods LIST_ENVIRONMENTS
    importing
      !I_name type STRING optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_LIST_ENVIRONMENTS_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Get environment info.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_ENVIRONMENT
    "!
  methods GET_ENVIRONMENT
    importing
      !I_environment_id type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_ENVIRONMENT
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Update an environment.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter I_body |
    "!   An object that defines the environment's name and, optionally, description.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_ENVIRONMENT
    "!
  methods UPDATE_ENVIRONMENT
    importing
      !I_environment_id type STRING
      !I_body type T_UPDATE_ENVIRONMENT_REQUEST
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_ENVIRONMENT
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Delete environment.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_DELETE_ENVIRONMENT_RESPONSE
    "!
  methods DELETE_ENVIRONMENT
    importing
      !I_environment_id type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_DELETE_ENVIRONMENT_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! List fields across collections.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter I_collection_ids |
    "!   A comma-separated list of collection IDs to be queried against.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_LST_COLLECTION_FIELDS_RESP
    "!
  methods LIST_FIELDS
    importing
      !I_environment_id type STRING
      !I_collection_ids type TT_STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_LST_COLLECTION_FIELDS_RESP
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! Add configuration.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter I_configuration |
    "!   Input an object that enables you to customize how your content is ingested and
    "!    what enrichments are added to your data.
    "!
    "!   **name** is required and must be unique within the current **environment**. All
    "!    other properties are optional.
    "!
    "!   If the input configuration contains the **configuration_id**, **created**, or
    "!    **updated** properties, then they will be ignored and overridden by the system
    "!    (an error is not returned so that the overridden fields do not need to be
    "!    removed when copying a configuration).
    "!
    "!   The configuration can contain unrecognized JSON fields. Any such fields will be
    "!    ignored and will not generate an error. This makes it easier to use newer
    "!    configuration files with older versions of the API and the service. It also
    "!    makes it possible for the tooling to add additional metadata and information to
    "!    the configuration.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_CONFIGURATION
    "!
  methods CREATE_CONFIGURATION
    importing
      !I_environment_id type STRING
      !I_configuration type T_CONFIGURATION
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_CONFIGURATION
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! List configurations.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter I_name |
    "!   Find configurations with the given name.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_LIST_CONFIGURATIONS_RESPONSE
    "!
  methods LIST_CONFIGURATIONS
    importing
      !I_environment_id type STRING
      !I_name type STRING optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_LIST_CONFIGURATIONS_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Get configuration details.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter I_configuration_id |
    "!   The ID of the configuration.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_CONFIGURATION
    "!
  methods GET_CONFIGURATION
    importing
      !I_environment_id type STRING
      !I_configuration_id type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_CONFIGURATION
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Update a configuration.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter I_configuration_id |
    "!   The ID of the configuration.
    "! @parameter I_configuration |
    "!   Input an object that enables you to update and customize how your data is
    "!    ingested and what enrichments are added to your data.  The **name** parameter
    "!    is required and must be unique within the current **environment**. All other
    "!    properties are optional, but if they are omitted  the default values replace
    "!    the current value of each omitted property.
    "!
    "!   If the input configuration contains the **configuration_id**, **created**, or
    "!    **updated** properties, they are ignored and overridden by the system, and an
    "!    error is not returned so that the overridden fields do not need to be removed
    "!    when updating a configuration.
    "!
    "!   The configuration can contain unrecognized JSON fields. Any such fields are
    "!    ignored and do not generate an error. This makes it easier to use newer
    "!    configuration files with older versions of the API and the service. It also
    "!    makes it possible for the tooling to add additional metadata and information to
    "!    the configuration.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_CONFIGURATION
    "!
  methods UPDATE_CONFIGURATION
    importing
      !I_environment_id type STRING
      !I_configuration_id type STRING
      !I_configuration type T_CONFIGURATION
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_CONFIGURATION
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Delete a configuration.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter I_configuration_id |
    "!   The ID of the configuration.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_DEL_CONFIGURATION_RESPONSE
    "!
  methods DELETE_CONFIGURATION
    importing
      !I_environment_id type STRING
      !I_configuration_id type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_DEL_CONFIGURATION_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! Create a collection.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter I_body |
    "!   Input an object that allows you to add a collection.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_COLLECTION
    "!
  methods CREATE_COLLECTION
    importing
      !I_environment_id type STRING
      !I_body type T_CREATE_COLLECTION_REQUEST
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_COLLECTION
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! List collections.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter I_name |
    "!   Find collections with the given name.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_LIST_COLLECTIONS_RESPONSE
    "!
  methods LIST_COLLECTIONS
    importing
      !I_environment_id type STRING
      !I_name type STRING optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_LIST_COLLECTIONS_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Get collection details.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter I_collection_id |
    "!   The ID of the collection.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_COLLECTION
    "!
  methods GET_COLLECTION
    importing
      !I_environment_id type STRING
      !I_collection_id type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_COLLECTION
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Update a collection.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter I_collection_id |
    "!   The ID of the collection.
    "! @parameter I_body |
    "!   Input an object that allows you to update a collection.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_COLLECTION
    "!
  methods UPDATE_COLLECTION
    importing
      !I_environment_id type STRING
      !I_collection_id type STRING
      !I_body type T_UPDATE_COLLECTION_REQUEST optional
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_COLLECTION
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Delete a collection.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter I_collection_id |
    "!   The ID of the collection.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_DELETE_COLLECTION_RESPONSE
    "!
  methods DELETE_COLLECTION
    importing
      !I_environment_id type STRING
      !I_collection_id type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_DELETE_COLLECTION_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! List collection fields.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter I_collection_id |
    "!   The ID of the collection.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_LST_COLLECTION_FIELDS_RESP
    "!
  methods LIST_COLLECTION_FIELDS
    importing
      !I_environment_id type STRING
      !I_collection_id type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_LST_COLLECTION_FIELDS_RESP
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! Get the expansion list.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter I_collection_id |
    "!   The ID of the collection.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_EXPANSIONS
    "!
  methods LIST_EXPANSIONS
    importing
      !I_environment_id type STRING
      !I_collection_id type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_EXPANSIONS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Create or update expansion list.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter I_collection_id |
    "!   The ID of the collection.
    "! @parameter I_body |
    "!   An object that defines the expansion list.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_EXPANSIONS
    "!
  methods CREATE_EXPANSIONS
    importing
      !I_environment_id type STRING
      !I_collection_id type STRING
      !I_body type T_EXPANSIONS
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_EXPANSIONS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Delete the expansion list.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter I_collection_id |
    "!   The ID of the collection.
    "!
  methods DELETE_EXPANSIONS
    importing
      !I_environment_id type STRING
      !I_collection_id type STRING
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Get tokenization dictionary status.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter I_collection_id |
    "!   The ID of the collection.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_TOKEN_DICT_STATUS_RESPONSE
    "!
  methods GET_TOKENIZATION_DICT_STATUS
    importing
      !I_environment_id type STRING
      !I_collection_id type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_TOKEN_DICT_STATUS_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Create tokenization dictionary.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter I_collection_id |
    "!   The ID of the collection.
    "! @parameter I_tokenization_dictionary |
    "!   An object that represents the tokenization dictionary to be uploaded.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_TOKEN_DICT_STATUS_RESPONSE
    "!
  methods CREATE_TOKENIZATION_DICTIONARY
    importing
      !I_environment_id type STRING
      !I_collection_id type STRING
      !I_tokenization_dictionary type T_TOKEN_DICT optional
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_TOKEN_DICT_STATUS_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Delete tokenization dictionary.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter I_collection_id |
    "!   The ID of the collection.
    "!
  methods DELETE_TOKENIZATION_DICTIONARY
    importing
      !I_environment_id type STRING
      !I_collection_id type STRING
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Get stopword list status.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter I_collection_id |
    "!   The ID of the collection.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_TOKEN_DICT_STATUS_RESPONSE
    "!
  methods GET_STOPWORD_LIST_STATUS
    importing
      !I_environment_id type STRING
      !I_collection_id type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_TOKEN_DICT_STATUS_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Create stopword list.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter I_collection_id |
    "!   The ID of the collection.
    "! @parameter I_stopword_file |
    "!   The content of the stopword list to ingest.
    "! @parameter I_stopword_filename |
    "!   The filename for stopwordFile.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_TOKEN_DICT_STATUS_RESPONSE
    "!
  methods CREATE_STOPWORD_LIST
    importing
      !I_environment_id type STRING
      !I_collection_id type STRING
      !I_stopword_file type FILE
      !I_stopword_filename type STRING
      !I_stopword_file_CT type STRING default ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-ALL
      !I_contenttype type string default 'multipart/form-data'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_TOKEN_DICT_STATUS_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Delete a custom stopword list.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter I_collection_id |
    "!   The ID of the collection.
    "!
  methods DELETE_STOPWORD_LIST
    importing
      !I_environment_id type STRING
      !I_collection_id type STRING
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! Add a document.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter I_collection_id |
    "!   The ID of the collection.
    "! @parameter I_file |
    "!   The content of the document to ingest. The maximum supported file size when
    "!    adding a file to a collection is 50 megabytes, the maximum supported file size
    "!    when testing a confiruration is 1 megabyte. Files larger than the supported
    "!    size are rejected.
    "! @parameter I_filename |
    "!   The filename for file.
    "! @parameter I_file_content_type |
    "!   The content type of file.
    "! @parameter I_metadata |
    "!   The maximum supported metadata file size is 1 MB. Metadata parts larger than 1
    "!    MB are rejected. Example:  ``` &#123;
    "!     "Creator": "Johnny Appleseed",
    "!     "Subject": "Apples"
    "!   &#125; ```.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_DOCUMENT_ACCEPTED
    "!
  methods ADD_DOCUMENT
    importing
      !I_environment_id type STRING
      !I_collection_id type STRING
      !I_file type FILE optional
      !I_filename type STRING optional
      !I_file_content_type type STRING optional
      !I_metadata type STRING optional
      !I_contenttype type string default 'multipart/form-data'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_DOCUMENT_ACCEPTED
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Get document details.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter I_collection_id |
    "!   The ID of the collection.
    "! @parameter I_document_id |
    "!   The ID of the document.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_DOCUMENT_STATUS
    "!
  methods GET_DOCUMENT_STATUS
    importing
      !I_environment_id type STRING
      !I_collection_id type STRING
      !I_document_id type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_DOCUMENT_STATUS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Update a document.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter I_collection_id |
    "!   The ID of the collection.
    "! @parameter I_document_id |
    "!   The ID of the document.
    "! @parameter I_file |
    "!   The content of the document to ingest. The maximum supported file size when
    "!    adding a file to a collection is 50 megabytes, the maximum supported file size
    "!    when testing a confiruration is 1 megabyte. Files larger than the supported
    "!    size are rejected.
    "! @parameter I_filename |
    "!   The filename for file.
    "! @parameter I_file_content_type |
    "!   The content type of file.
    "! @parameter I_metadata |
    "!   The maximum supported metadata file size is 1 MB. Metadata parts larger than 1
    "!    MB are rejected. Example:  ``` &#123;
    "!     "Creator": "Johnny Appleseed",
    "!     "Subject": "Apples"
    "!   &#125; ```.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_DOCUMENT_ACCEPTED
    "!
  methods UPDATE_DOCUMENT
    importing
      !I_environment_id type STRING
      !I_collection_id type STRING
      !I_document_id type STRING
      !I_file type FILE optional
      !I_filename type STRING optional
      !I_file_content_type type STRING optional
      !I_metadata type STRING optional
      !I_contenttype type string default 'multipart/form-data'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_DOCUMENT_ACCEPTED
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Delete a document.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter I_collection_id |
    "!   The ID of the collection.
    "! @parameter I_document_id |
    "!   The ID of the document.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_DELETE_DOCUMENT_RESPONSE
    "!
  methods DELETE_DOCUMENT
    importing
      !I_environment_id type STRING
      !I_collection_id type STRING
      !I_document_id type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_DELETE_DOCUMENT_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! Query a collection.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter I_collection_id |
    "!   The ID of the collection.
    "! @parameter I_query_long |
    "!   An object that represents the query to be submitted.
    "! @parameter I_X_Watson_Logging_Opt_Out |
    "!   If `true`, queries are not stored in the Discovery **Logs** endpoint.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_QUERY_RESPONSE
    "!
  methods QUERY
    importing
      !I_environment_id type STRING
      !I_collection_id type STRING
      !I_query_long type T_COLL_QUERY_LARGE optional
      !I_X_Watson_Logging_Opt_Out type BOOLEAN default c_boolean_false
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_QUERY_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Query system notices.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter I_collection_id |
    "!   The ID of the collection.
    "! @parameter I_filter |
    "!   A cacheable query that excludes documents that don't mention the query content.
    "!    Filter searches are better for metadata-type searches and for assessing the
    "!    concepts in the data set.
    "! @parameter I_query |
    "!   A query search returns all documents in your data set with full enrichments and
    "!    full text, but with the most relevant documents listed first.
    "! @parameter I_natural_language_query |
    "!   A natural language query that returns relevant documents by utilizing training
    "!    data and natural language understanding.
    "! @parameter I_passages |
    "!   A passages query that returns the most relevant passages from the results.
    "! @parameter I_aggregation |
    "!   An aggregation search that returns an exact answer by combining query search
    "!    with filters. Useful for applications to build lists, tables, and time series.
    "!    For a full list of possible aggregations, see the Query reference.
    "! @parameter I_count |
    "!   Number of results to return. The maximum for the **count** and **offset** values
    "!    together in any one query is **10000**.
    "! @parameter I_return |
    "!   A comma-separated list of the portion of the document hierarchy to return.
    "! @parameter I_offset |
    "!   The number of query results to skip at the beginning. For example, if the total
    "!    number of results that are returned is 10 and the offset is 8, it returns the
    "!    last two results. The maximum for the **count** and **offset** values together
    "!    in any one query is **10000**.
    "! @parameter I_sort |
    "!   A comma-separated list of fields in the document to sort on. You can optionally
    "!    specify a sort direction by prefixing the field with `-` for descending or `+`
    "!    for ascending. Ascending is the default sort direction if no prefix is
    "!    specified.
    "! @parameter I_highlight |
    "!   When true, a highlight field is returned for each result which contains the
    "!    fields which match the query with `<em></em>` tags around the matching query
    "!    terms.
    "! @parameter I_passages_fields |
    "!   A comma-separated list of fields that passages are drawn from. If this parameter
    "!    not specified, then all top-level fields are included.
    "! @parameter I_passages_count |
    "!   The maximum number of passages to return. The search returns fewer passages if
    "!    the requested total is not found.
    "! @parameter I_passages_characters |
    "!   The approximate number of characters that any one passage will have.
    "! @parameter I_deduplicate_field |
    "!   When specified, duplicate results based on the field specified are removed from
    "!    the returned results. Duplicate comparison is limited to the current query
    "!    only, **offset** is not considered. This parameter is currently Beta
    "!    functionality.
    "! @parameter I_similar |
    "!   When `true`, results are returned based on their similarity to the document IDs
    "!    specified in the **similar.document_ids** parameter.
    "! @parameter I_similar_document_ids |
    "!   A comma-separated list of document IDs to find similar documents.
    "!
    "!   **Tip:** Include the **natural_language_query** parameter to expand the scope of
    "!    the document similarity search with the natural language query. Other query
    "!    parameters, such as **filter** and **query**, are subsequently applied and
    "!    reduce the scope.
    "! @parameter I_similar_fields |
    "!   A comma-separated list of field names that are used as a basis for comparison to
    "!    identify similar documents. If not specified, the entire document is used for
    "!    comparison.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_QUERY_NOTICES_RESPONSE
    "!
  methods QUERY_NOTICES
    importing
      !I_environment_id type STRING
      !I_collection_id type STRING
      !I_filter type STRING optional
      !I_query type STRING optional
      !I_natural_language_query type STRING optional
      !I_passages type BOOLEAN optional
      !I_aggregation type STRING optional
      !I_count type INTEGER optional
      !I_return type TT_STRING optional
      !I_offset type INTEGER optional
      !I_sort type TT_STRING optional
      !I_highlight type BOOLEAN default c_boolean_false
      !I_passages_fields type TT_STRING optional
      !I_passages_count type INTEGER optional
      !I_passages_characters type INTEGER optional
      !I_deduplicate_field type STRING optional
      !I_similar type BOOLEAN default c_boolean_false
      !I_similar_document_ids type TT_STRING optional
      !I_similar_fields type TT_STRING optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_QUERY_NOTICES_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Query multiple collections.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter I_query_long |
    "!
    "! @parameter I_X_Watson_Logging_Opt_Out |
    "!   If `true`, queries are not stored in the Discovery **Logs** endpoint.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_QUERY_RESPONSE
    "!
  methods FEDERATED_QUERY
    importing
      !I_environment_id type STRING
      !I_query_long type T_FED_QUERY_LARGE optional
      !I_X_Watson_Logging_Opt_Out type BOOLEAN default c_boolean_false
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_QUERY_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Query multiple collection system notices.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter I_collection_ids |
    "!   A comma-separated list of collection IDs to be queried against.
    "! @parameter I_filter |
    "!   A cacheable query that excludes documents that don't mention the query content.
    "!    Filter searches are better for metadata-type searches and for assessing the
    "!    concepts in the data set.
    "! @parameter I_query |
    "!   A query search returns all documents in your data set with full enrichments and
    "!    full text, but with the most relevant documents listed first.
    "! @parameter I_natural_language_query |
    "!   A natural language query that returns relevant documents by utilizing training
    "!    data and natural language understanding.
    "! @parameter I_aggregation |
    "!   An aggregation search that returns an exact answer by combining query search
    "!    with filters. Useful for applications to build lists, tables, and time series.
    "!    For a full list of possible aggregations, see the Query reference.
    "! @parameter I_count |
    "!   Number of results to return. The maximum for the **count** and **offset** values
    "!    together in any one query is **10000**.
    "! @parameter I_return |
    "!   A comma-separated list of the portion of the document hierarchy to return.
    "! @parameter I_offset |
    "!   The number of query results to skip at the beginning. For example, if the total
    "!    number of results that are returned is 10 and the offset is 8, it returns the
    "!    last two results. The maximum for the **count** and **offset** values together
    "!    in any one query is **10000**.
    "! @parameter I_sort |
    "!   A comma-separated list of fields in the document to sort on. You can optionally
    "!    specify a sort direction by prefixing the field with `-` for descending or `+`
    "!    for ascending. Ascending is the default sort direction if no prefix is
    "!    specified.
    "! @parameter I_highlight |
    "!   When true, a highlight field is returned for each result which contains the
    "!    fields which match the query with `<em></em>` tags around the matching query
    "!    terms.
    "! @parameter I_deduplicate_field |
    "!   When specified, duplicate results based on the field specified are removed from
    "!    the returned results. Duplicate comparison is limited to the current query
    "!    only, **offset** is not considered. This parameter is currently Beta
    "!    functionality.
    "! @parameter I_similar |
    "!   When `true`, results are returned based on their similarity to the document IDs
    "!    specified in the **similar.document_ids** parameter.
    "! @parameter I_similar_document_ids |
    "!   A comma-separated list of document IDs to find similar documents.
    "!
    "!   **Tip:** Include the **natural_language_query** parameter to expand the scope of
    "!    the document similarity search with the natural language query. Other query
    "!    parameters, such as **filter** and **query**, are subsequently applied and
    "!    reduce the scope.
    "! @parameter I_similar_fields |
    "!   A comma-separated list of field names that are used as a basis for comparison to
    "!    identify similar documents. If not specified, the entire document is used for
    "!    comparison.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_QUERY_NOTICES_RESPONSE
    "!
  methods FEDERATED_QUERY_NOTICES
    importing
      !I_environment_id type STRING
      !I_collection_ids type TT_STRING
      !I_filter type STRING optional
      !I_query type STRING optional
      !I_natural_language_query type STRING optional
      !I_aggregation type STRING optional
      !I_count type INTEGER optional
      !I_return type TT_STRING optional
      !I_offset type INTEGER optional
      !I_sort type TT_STRING optional
      !I_highlight type BOOLEAN default c_boolean_false
      !I_deduplicate_field type STRING optional
      !I_similar type BOOLEAN default c_boolean_false
      !I_similar_document_ids type TT_STRING optional
      !I_similar_fields type TT_STRING optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_QUERY_NOTICES_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Get Autocomplete Suggestions.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter I_collection_id |
    "!   The ID of the collection.
    "! @parameter I_field |
    "!   The field in the result documents that autocompletion suggestions are identified
    "!    from.
    "! @parameter I_prefix |
    "!   The prefix to use for autocompletion. For example, the prefix `Ho` could
    "!    autocomplete to `Hot`, `Housing`, or `How do I upgrade`. Possible completions
    "!    are.
    "! @parameter I_count |
    "!   The number of autocompletion suggestions to return.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_COMPLETIONS
    "!
  methods GET_AUTOCOMPLETION
    importing
      !I_environment_id type STRING
      !I_collection_id type STRING
      !I_field type STRING optional
      !I_prefix type STRING optional
      !I_count type INTEGER optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_COMPLETIONS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! List training data.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter I_collection_id |
    "!   The ID of the collection.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_TRAINING_DATA_SET
    "!
  methods LIST_TRAINING_DATA
    importing
      !I_environment_id type STRING
      !I_collection_id type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_TRAINING_DATA_SET
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Add query to training data.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter I_collection_id |
    "!   The ID of the collection.
    "! @parameter I_body |
    "!   The body of the training data query that is to be added to the collection's
    "!    training data.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_TRAINING_QUERY
    "!
  methods ADD_TRAINING_DATA
    importing
      !I_environment_id type STRING
      !I_collection_id type STRING
      !I_body type T_NEW_TRAINING_QUERY
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_TRAINING_QUERY
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Delete all training data.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter I_collection_id |
    "!   The ID of the collection.
    "!
  methods DELETE_ALL_TRAINING_DATA
    importing
      !I_environment_id type STRING
      !I_collection_id type STRING
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Get details about a query.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter I_collection_id |
    "!   The ID of the collection.
    "! @parameter I_query_id |
    "!   The ID of the query used for training.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_TRAINING_QUERY
    "!
  methods GET_TRAINING_DATA
    importing
      !I_environment_id type STRING
      !I_collection_id type STRING
      !I_query_id type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_TRAINING_QUERY
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Delete a training data query.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter I_collection_id |
    "!   The ID of the collection.
    "! @parameter I_query_id |
    "!   The ID of the query used for training.
    "!
  methods DELETE_TRAINING_DATA
    importing
      !I_environment_id type STRING
      !I_collection_id type STRING
      !I_query_id type STRING
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! List examples for a training data query.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter I_collection_id |
    "!   The ID of the collection.
    "! @parameter I_query_id |
    "!   The ID of the query used for training.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_TRAINING_EXAMPLE_LIST
    "!
  methods LIST_TRAINING_EXAMPLES
    importing
      !I_environment_id type STRING
      !I_collection_id type STRING
      !I_query_id type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_TRAINING_EXAMPLE_LIST
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Add example to training data query.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter I_collection_id |
    "!   The ID of the collection.
    "! @parameter I_query_id |
    "!   The ID of the query used for training.
    "! @parameter I_body |
    "!   The body of the example that is to be added to the specified query.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_TRAINING_EXAMPLE
    "!
  methods CREATE_TRAINING_EXAMPLE
    importing
      !I_environment_id type STRING
      !I_collection_id type STRING
      !I_query_id type STRING
      !I_body type T_TRAINING_EXAMPLE
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_TRAINING_EXAMPLE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Delete example for training data query.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter I_collection_id |
    "!   The ID of the collection.
    "! @parameter I_query_id |
    "!   The ID of the query used for training.
    "! @parameter I_example_id |
    "!   The ID of the document as it is indexed.
    "!
  methods DELETE_TRAINING_EXAMPLE
    importing
      !I_environment_id type STRING
      !I_collection_id type STRING
      !I_query_id type STRING
      !I_example_id type STRING
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Change label or cross reference for example.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter I_collection_id |
    "!   The ID of the collection.
    "! @parameter I_query_id |
    "!   The ID of the query used for training.
    "! @parameter I_example_id |
    "!   The ID of the document as it is indexed.
    "! @parameter I_body |
    "!   The body of the example that is to be added to the specified query.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_TRAINING_EXAMPLE
    "!
  methods UPDATE_TRAINING_EXAMPLE
    importing
      !I_environment_id type STRING
      !I_collection_id type STRING
      !I_query_id type STRING
      !I_example_id type STRING
      !I_body type T_TRAINING_EXAMPLE_PATCH
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_TRAINING_EXAMPLE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Get details for training data example.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter I_collection_id |
    "!   The ID of the collection.
    "! @parameter I_query_id |
    "!   The ID of the query used for training.
    "! @parameter I_example_id |
    "!   The ID of the document as it is indexed.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_TRAINING_EXAMPLE
    "!
  methods GET_TRAINING_EXAMPLE
    importing
      !I_environment_id type STRING
      !I_collection_id type STRING
      !I_query_id type STRING
      !I_example_id type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_TRAINING_EXAMPLE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! Delete labeled data.
    "!
    "! @parameter I_customer_id |
    "!   The customer ID for which all data is to be deleted.
    "!
  methods DELETE_USER_DATA
    importing
      !I_customer_id type STRING
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! Create event.
    "!
    "! @parameter I_query_event |
    "!   An object that defines a query event to be added to the log.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_CREATE_EVENT_RESPONSE
    "!
  methods CREATE_EVENT
    importing
      !I_query_event type T_CREATE_EVENT_OBJECT
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_CREATE_EVENT_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Search the query and event log.
    "!
    "! @parameter I_filter |
    "!   A cacheable query that excludes documents that don't mention the query content.
    "!    Filter searches are better for metadata-type searches and for assessing the
    "!    concepts in the data set.
    "! @parameter I_query |
    "!   A query search returns all documents in your data set with full enrichments and
    "!    full text, but with the most relevant documents listed first.
    "! @parameter I_count |
    "!   Number of results to return. The maximum for the **count** and **offset** values
    "!    together in any one query is **10000**.
    "! @parameter I_offset |
    "!   The number of query results to skip at the beginning. For example, if the total
    "!    number of results that are returned is 10 and the offset is 8, it returns the
    "!    last two results. The maximum for the **count** and **offset** values together
    "!    in any one query is **10000**.
    "! @parameter I_sort |
    "!   A comma-separated list of fields in the document to sort on. You can optionally
    "!    specify a sort direction by prefixing the field with `-` for descending or `+`
    "!    for ascending. Ascending is the default sort direction if no prefix is
    "!    specified.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_LOG_QUERY_RESPONSE
    "!
  methods QUERY_LOG
    importing
      !I_filter type STRING optional
      !I_query type STRING optional
      !I_count type INTEGER optional
      !I_offset type INTEGER optional
      !I_sort type TT_STRING optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_LOG_QUERY_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Number of queries over time.
    "!
    "! @parameter I_start_time |
    "!   Metric is computed from data recorded after this timestamp; must be in
    "!    `YYYY-MM-DDThh:mm:ssZ` format.
    "! @parameter I_end_time |
    "!   Metric is computed from data recorded before this timestamp; must be in
    "!    `YYYY-MM-DDThh:mm:ssZ` format.
    "! @parameter I_result_type |
    "!   The type of result to consider when calculating the metric.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_METRIC_RESPONSE
    "!
  methods GET_METRICS_QUERY
    importing
      !I_start_time type DATETIME optional
      !I_end_time type DATETIME optional
      !I_result_type type STRING optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_METRIC_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Number of queries with an event over time.
    "!
    "! @parameter I_start_time |
    "!   Metric is computed from data recorded after this timestamp; must be in
    "!    `YYYY-MM-DDThh:mm:ssZ` format.
    "! @parameter I_end_time |
    "!   Metric is computed from data recorded before this timestamp; must be in
    "!    `YYYY-MM-DDThh:mm:ssZ` format.
    "! @parameter I_result_type |
    "!   The type of result to consider when calculating the metric.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_METRIC_RESPONSE
    "!
  methods GET_METRICS_QUERY_EVENT
    importing
      !I_start_time type DATETIME optional
      !I_end_time type DATETIME optional
      !I_result_type type STRING optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_METRIC_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Number of queries with no search results over time.
    "!
    "! @parameter I_start_time |
    "!   Metric is computed from data recorded after this timestamp; must be in
    "!    `YYYY-MM-DDThh:mm:ssZ` format.
    "! @parameter I_end_time |
    "!   Metric is computed from data recorded before this timestamp; must be in
    "!    `YYYY-MM-DDThh:mm:ssZ` format.
    "! @parameter I_result_type |
    "!   The type of result to consider when calculating the metric.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_METRIC_RESPONSE
    "!
  methods GET_METRICS_QUERY_NO_RESULTS
    importing
      !I_start_time type DATETIME optional
      !I_end_time type DATETIME optional
      !I_result_type type STRING optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_METRIC_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Percentage of queries with an associated event.
    "!
    "! @parameter I_start_time |
    "!   Metric is computed from data recorded after this timestamp; must be in
    "!    `YYYY-MM-DDThh:mm:ssZ` format.
    "! @parameter I_end_time |
    "!   Metric is computed from data recorded before this timestamp; must be in
    "!    `YYYY-MM-DDThh:mm:ssZ` format.
    "! @parameter I_result_type |
    "!   The type of result to consider when calculating the metric.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_METRIC_RESPONSE
    "!
  methods GET_METRICS_EVENT_RATE
    importing
      !I_start_time type DATETIME optional
      !I_end_time type DATETIME optional
      !I_result_type type STRING optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_METRIC_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Most frequent query tokens with an event.
    "!
    "! @parameter I_count |
    "!   Number of results to return. The maximum for the **count** and **offset** values
    "!    together in any one query is **10000**.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_METRIC_TOKEN_RESPONSE
    "!
  methods GET_METRICS_QUERY_TOKEN_EVENT
    importing
      !I_count type INTEGER optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_METRIC_TOKEN_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! List credentials.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_CREDENTIALS_LIST
    "!
  methods LIST_CREDENTIALS
    importing
      !I_environment_id type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_CREDENTIALS_LIST
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Create credentials.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter I_credentials_parameter |
    "!   An object that defines an individual set of source credentials.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_CREDENTIALS
    "!
  methods CREATE_CREDENTIALS
    importing
      !I_environment_id type STRING
      !I_credentials_parameter type T_CREDENTIALS
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_CREDENTIALS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! View Credentials.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter I_credential_id |
    "!   The unique identifier for a set of source credentials.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_CREDENTIALS
    "!
  methods GET_CREDENTIALS
    importing
      !I_environment_id type STRING
      !I_credential_id type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_CREDENTIALS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Update credentials.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter I_credential_id |
    "!   The unique identifier for a set of source credentials.
    "! @parameter I_credentials_parameter |
    "!   An object that defines an individual set of source credentials.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_CREDENTIALS
    "!
  methods UPDATE_CREDENTIALS
    importing
      !I_environment_id type STRING
      !I_credential_id type STRING
      !I_credentials_parameter type T_CREDENTIALS
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_CREDENTIALS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Delete credentials.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter I_credential_id |
    "!   The unique identifier for a set of source credentials.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_DELETE_CREDENTIALS
    "!
  methods DELETE_CREDENTIALS
    importing
      !I_environment_id type STRING
      !I_credential_id type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_DELETE_CREDENTIALS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! List Gateways.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_GATEWAY_LIST
    "!
  methods LIST_GATEWAYS
    importing
      !I_environment_id type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_GATEWAY_LIST
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Create Gateway.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter I_gateway_name |
    "!   The name of the gateway to created.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_GATEWAY
    "!
  methods CREATE_GATEWAY
    importing
      !I_environment_id type STRING
      !I_gateway_name type T_GATEWAY_NAME optional
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_GATEWAY
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! List Gateway Details.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter I_gateway_id |
    "!   The requested gateway ID.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_GATEWAY
    "!
  methods GET_GATEWAY
    importing
      !I_environment_id type STRING
      !I_gateway_id type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_GATEWAY
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Delete Gateway.
    "!
    "! @parameter I_environment_id |
    "!   The ID of the environment.
    "! @parameter I_gateway_id |
    "!   The requested gateway ID.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_GATEWAY_DELETE
    "!
  methods DELETE_GATEWAY
    importing
      !I_environment_id type STRING
      !I_gateway_id type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_GATEWAY_DELETE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .


protected section.

private section.

  methods SET_DEFAULT_QUERY_PARAMETERS
    changing
      !C_URL type TS_URL .

ENDCLASS.

class ZCL_IBMC_DISCOVERY_V1 IMPLEMENTATION.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->GET_APPNAME
* +-------------------------------------------------------------------------------------------------+
* | [<-()] E_APPNAME                      TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method GET_APPNAME.

    e_appname = 'Discovery'.

  endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Protected Method ZCL_IBMC_DISCOVERY_V1->GET_REQUEST_PROP
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
  e_request_prop-url-path_base   = '/discovery/api'.

endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->GET_SDK_VERSION_DATE
* +-------------------------------------------------------------------------------------------------+
* | [<-()] E_SDK_VERSION_DATE             TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method get_sdk_version_date.

    e_sdk_version_date = '20191002122840'.

  endmethod.



* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->CREATE_ENVIRONMENT
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_body        TYPE T_CREATE_ENVIRONMENT_REQUEST
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_ENVIRONMENT
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CREATE_ENVIRONMENT.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/environments'.

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
    lv_datatype = get_datatype( i_body ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_body i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'body' i_value = i_body ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_body to <lv_text>.
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->LIST_ENVIRONMENTS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_name        TYPE STRING(optional)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_LIST_ENVIRONMENTS_RESPONSE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_ENVIRONMENTS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/environments'.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_name is supplied.
    lv_queryparam = escape( val = i_name format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `name`
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->GET_ENVIRONMENT
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_ENVIRONMENT
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_ENVIRONMENT.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/environments/{environment_id}'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.

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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->UPDATE_ENVIRONMENT
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_body        TYPE T_UPDATE_ENVIRONMENT_REQUEST
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_ENVIRONMENT
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method UPDATE_ENVIRONMENT.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/environments/{environment_id}'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.

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
    lv_datatype = get_datatype( i_body ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_body i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'body' i_value = i_body ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_body to <lv_text>.
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->DELETE_ENVIRONMENT
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_DELETE_ENVIRONMENT_RESPONSE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_ENVIRONMENT.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/environments/{environment_id}'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->LIST_FIELDS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_collection_ids        TYPE TT_STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_LST_COLLECTION_FIELDS_RESP
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_FIELDS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/environments/{environment_id}/fields'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    data:
      lv_item_collection_ids type STRING.
    clear: lv_queryparam, lv_sep.
    loop at i_collection_ids into lv_item_collection_ids.
      lv_queryparam = lv_queryparam && lv_sep && lv_item_collection_ids.
      lv_sep = ','.
    endloop.
    lv_queryparam = escape( val = lv_queryparam format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `collection_ids`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.






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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->CREATE_CONFIGURATION
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_configuration        TYPE T_CONFIGURATION
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_CONFIGURATION
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CREATE_CONFIGURATION.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/environments/{environment_id}/configurations'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.

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
    lv_datatype = get_datatype( i_configuration ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_configuration i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'configuration' i_value = i_configuration ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_configuration to <lv_text>.
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->LIST_CONFIGURATIONS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_name        TYPE STRING(optional)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_LIST_CONFIGURATIONS_RESPONSE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_CONFIGURATIONS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/environments/{environment_id}/configurations'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_name is supplied.
    lv_queryparam = escape( val = i_name format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `name`
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->GET_CONFIGURATION
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_configuration_id        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_CONFIGURATION
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_CONFIGURATION.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/environments/{environment_id}/configurations/{configuration_id}'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.
    replace all occurrences of `{configuration_id}` in ls_request_prop-url-path with i_configuration_id ignoring case.

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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->UPDATE_CONFIGURATION
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_configuration_id        TYPE STRING
* | [--->] I_configuration        TYPE T_CONFIGURATION
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_CONFIGURATION
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method UPDATE_CONFIGURATION.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/environments/{environment_id}/configurations/{configuration_id}'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.
    replace all occurrences of `{configuration_id}` in ls_request_prop-url-path with i_configuration_id ignoring case.

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
    lv_datatype = get_datatype( i_configuration ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_configuration i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'configuration' i_value = i_configuration ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_configuration to <lv_text>.
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->DELETE_CONFIGURATION
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_configuration_id        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_DEL_CONFIGURATION_RESPONSE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_CONFIGURATION.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/environments/{environment_id}/configurations/{configuration_id}'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.
    replace all occurrences of `{configuration_id}` in ls_request_prop-url-path with i_configuration_id ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->CREATE_COLLECTION
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_body        TYPE T_CREATE_COLLECTION_REQUEST
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_COLLECTION
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CREATE_COLLECTION.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/environments/{environment_id}/collections'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.

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
    lv_datatype = get_datatype( i_body ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_body i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'body' i_value = i_body ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_body to <lv_text>.
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->LIST_COLLECTIONS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_name        TYPE STRING(optional)
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

    ls_request_prop-url-path = '/v1/environments/{environment_id}/collections'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_name is supplied.
    lv_queryparam = escape( val = i_name format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `name`
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->GET_COLLECTION
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_collection_id        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_COLLECTION
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_COLLECTION.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/environments/{environment_id}/collections/{collection_id}'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_collection_id ignoring case.

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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->UPDATE_COLLECTION
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_collection_id        TYPE STRING
* | [--->] I_body        TYPE T_UPDATE_COLLECTION_REQUEST(optional)
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_COLLECTION
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method UPDATE_COLLECTION.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/environments/{environment_id}/collections/{collection_id}'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_collection_id ignoring case.

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
    if not i_body is initial.
    lv_datatype = get_datatype( i_body ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_body i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'body' i_value = i_body ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_body to <lv_text>.
      lv_bodyparam = <lv_text>.
      concatenate lv_body lv_bodyparam into lv_body.
    endif.
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->DELETE_COLLECTION
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_collection_id        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_DELETE_COLLECTION_RESPONSE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_COLLECTION.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/environments/{environment_id}/collections/{collection_id}'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_collection_id ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->LIST_COLLECTION_FIELDS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_collection_id        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_LST_COLLECTION_FIELDS_RESP
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_COLLECTION_FIELDS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/environments/{environment_id}/collections/{collection_id}/fields'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_collection_id ignoring case.

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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->LIST_EXPANSIONS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_collection_id        TYPE STRING
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

    ls_request_prop-url-path = '/v1/environments/{environment_id}/collections/{collection_id}/expansions'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_collection_id ignoring case.

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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->CREATE_EXPANSIONS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_collection_id        TYPE STRING
* | [--->] I_body        TYPE T_EXPANSIONS
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

    ls_request_prop-url-path = '/v1/environments/{environment_id}/collections/{collection_id}/expansions'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_collection_id ignoring case.

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
    lv_datatype = get_datatype( i_body ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_body i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'body' i_value = i_body ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_body to <lv_text>.
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->DELETE_EXPANSIONS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_collection_id        TYPE STRING
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_EXPANSIONS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/environments/{environment_id}/collections/{collection_id}/expansions'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_collection_id ignoring case.

    " standard headers
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








    " execute HTTP DELETE request
    lo_response = HTTP_DELETE( i_request_prop = ls_request_prop ).



endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->GET_TOKENIZATION_DICT_STATUS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_collection_id        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_TOKEN_DICT_STATUS_RESPONSE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_TOKENIZATION_DICT_STATUS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/environments/{environment_id}/collections/{collection_id}/word_lists/tokenization_dictionary'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_collection_id ignoring case.

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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->CREATE_TOKENIZATION_DICTIONARY
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_collection_id        TYPE STRING
* | [--->] I_tokenization_dictionary        TYPE T_TOKEN_DICT(optional)
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_TOKEN_DICT_STATUS_RESPONSE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CREATE_TOKENIZATION_DICTIONARY.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/environments/{environment_id}/collections/{collection_id}/word_lists/tokenization_dictionary'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_collection_id ignoring case.

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
    if not i_tokenization_dictionary is initial.
    lv_datatype = get_datatype( i_tokenization_dictionary ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_tokenization_dictionary i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'tokenization_dictionary' i_value = i_tokenization_dictionary ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_tokenization_dictionary to <lv_text>.
      lv_bodyparam = <lv_text>.
      concatenate lv_body lv_bodyparam into lv_body.
    endif.
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->DELETE_TOKENIZATION_DICTIONARY
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_collection_id        TYPE STRING
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_TOKENIZATION_DICTIONARY.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/environments/{environment_id}/collections/{collection_id}/word_lists/tokenization_dictionary'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_collection_id ignoring case.

    " standard headers
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








    " execute HTTP DELETE request
    lo_response = HTTP_DELETE( i_request_prop = ls_request_prop ).



endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->GET_STOPWORD_LIST_STATUS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_collection_id        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_TOKEN_DICT_STATUS_RESPONSE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_STOPWORD_LIST_STATUS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/environments/{environment_id}/collections/{collection_id}/word_lists/stopwords'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_collection_id ignoring case.

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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->CREATE_STOPWORD_LIST
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_collection_id        TYPE STRING
* | [--->] I_stopword_file        TYPE FILE
* | [--->] I_stopword_filename        TYPE STRING
* | [--->] I_stopword_file_CT     TYPE STRING (default = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-all)
* | [--->] I_contenttype       TYPE string (default ='multipart/form-data')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_TOKEN_DICT_STATUS_RESPONSE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CREATE_STOPWORD_LIST.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/environments/{environment_id}/collections/{collection_id}/word_lists/stopwords'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_collection_id ignoring case.

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




    if not i_stopword_file is initial.
      if not I_stopword_filename is initial.
        lv_value = `form-data; name="stopword_file"; filename="` && I_stopword_filename && `"`  ##NO_TEXT.
      else.
      lv_extension = get_file_extension( I_stopword_file_CT ).
      lv_value = `form-data; name="stopword_file"; filename="file` && lv_index && `.` && lv_extension && `"`  ##NO_TEXT.
      endif.
      lv_index = lv_index + 1.
      clear ls_form_part.
      ls_form_part-content_type = I_stopword_file_CT.
      ls_form_part-content_disposition = lv_value.
      ls_form_part-xdata = i_stopword_file.
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->DELETE_STOPWORD_LIST
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_collection_id        TYPE STRING
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_STOPWORD_LIST.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/environments/{environment_id}/collections/{collection_id}/word_lists/stopwords'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_collection_id ignoring case.

    " standard headers
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








    " execute HTTP DELETE request
    lo_response = HTTP_DELETE( i_request_prop = ls_request_prop ).



endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->ADD_DOCUMENT
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_collection_id        TYPE STRING
* | [--->] I_file        TYPE FILE(optional)
* | [--->] I_filename        TYPE STRING(optional)
* | [--->] I_file_content_type        TYPE STRING(optional)
* | [--->] I_metadata        TYPE STRING(optional)
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

    ls_request_prop-url-path = '/v1/environments/{environment_id}/collections/{collection_id}/documents'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_collection_id ignoring case.

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


    if not i_metadata is initial.
      clear ls_form_part.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      ls_form_part-content_disposition = 'form-data; name="metadata"'  ##NO_TEXT.
      lv_formdata = i_metadata.
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.



    if not i_file is initial.
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->GET_DOCUMENT_STATUS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_collection_id        TYPE STRING
* | [--->] I_document_id        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_DOCUMENT_STATUS
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_DOCUMENT_STATUS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/environments/{environment_id}/collections/{collection_id}/documents/{document_id}'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_collection_id ignoring case.
    replace all occurrences of `{document_id}` in ls_request_prop-url-path with i_document_id ignoring case.

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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->UPDATE_DOCUMENT
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_collection_id        TYPE STRING
* | [--->] I_document_id        TYPE STRING
* | [--->] I_file        TYPE FILE(optional)
* | [--->] I_filename        TYPE STRING(optional)
* | [--->] I_file_content_type        TYPE STRING(optional)
* | [--->] I_metadata        TYPE STRING(optional)
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

    ls_request_prop-url-path = '/v1/environments/{environment_id}/collections/{collection_id}/documents/{document_id}'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_collection_id ignoring case.
    replace all occurrences of `{document_id}` in ls_request_prop-url-path with i_document_id ignoring case.

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


    if not i_metadata is initial.
      clear ls_form_part.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      ls_form_part-content_disposition = 'form-data; name="metadata"'  ##NO_TEXT.
      lv_formdata = i_metadata.
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.



    if not i_file is initial.
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->DELETE_DOCUMENT
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_collection_id        TYPE STRING
* | [--->] I_document_id        TYPE STRING
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

    ls_request_prop-url-path = '/v1/environments/{environment_id}/collections/{collection_id}/documents/{document_id}'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_collection_id ignoring case.
    replace all occurrences of `{document_id}` in ls_request_prop-url-path with i_document_id ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->QUERY
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_collection_id        TYPE STRING
* | [--->] I_query_long        TYPE T_COLL_QUERY_LARGE(optional)
* | [--->] I_X_Watson_Logging_Opt_Out        TYPE BOOLEAN (default =c_boolean_false)
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

    ls_request_prop-url-path = '/v1/environments/{environment_id}/collections/{collection_id}/query'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_collection_id ignoring case.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).



    " process header parameters
    data:
      lv_headerparam type string  ##NEEDED.

    if i_X_Watson_Logging_Opt_Out is supplied.
    lv_headerparam = I_X_Watson_Logging_Opt_Out.
    add_header_parameter(
      exporting
        i_parameter  = 'X-Watson-Logging-Opt-Out'
        i_value      = lv_headerparam
        i_is_boolean = c_boolean_true
      changing
        c_headers    = ls_request_prop-headers )  ##NO_TEXT.
    endif.



    " process body parameters
    data:
      lv_body      type string,
      lv_bodyparam type string,
      lv_datatype  type char.
    field-symbols:
      <lv_text> type any.
    lv_separator = ''.
    if not i_query_long is initial.
    lv_datatype = get_datatype( i_query_long ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_query_long i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'query_long' i_value = i_query_long ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_query_long to <lv_text>.
      lv_bodyparam = <lv_text>.
      concatenate lv_body lv_bodyparam into lv_body.
    endif.
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->QUERY_NOTICES
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_collection_id        TYPE STRING
* | [--->] I_filter        TYPE STRING(optional)
* | [--->] I_query        TYPE STRING(optional)
* | [--->] I_natural_language_query        TYPE STRING(optional)
* | [--->] I_passages        TYPE BOOLEAN(optional)
* | [--->] I_aggregation        TYPE STRING(optional)
* | [--->] I_count        TYPE INTEGER(optional)
* | [--->] I_return        TYPE TT_STRING(optional)
* | [--->] I_offset        TYPE INTEGER(optional)
* | [--->] I_sort        TYPE TT_STRING(optional)
* | [--->] I_highlight        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_passages_fields        TYPE TT_STRING(optional)
* | [--->] I_passages_count        TYPE INTEGER(optional)
* | [--->] I_passages_characters        TYPE INTEGER(optional)
* | [--->] I_deduplicate_field        TYPE STRING(optional)
* | [--->] I_similar        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_similar_document_ids        TYPE TT_STRING(optional)
* | [--->] I_similar_fields        TYPE TT_STRING(optional)
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

    ls_request_prop-url-path = '/v1/environments/{environment_id}/collections/{collection_id}/notices'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_collection_id ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_filter is supplied.
    lv_queryparam = escape( val = i_filter format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `filter`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_query is supplied.
    lv_queryparam = escape( val = i_query format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `query`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_natural_language_query is supplied.
    lv_queryparam = escape( val = i_natural_language_query format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `natural_language_query`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_passages is supplied.
    lv_queryparam = i_passages.
    add_query_parameter(
      exporting
        i_parameter  = `passages`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_aggregation is supplied.
    lv_queryparam = escape( val = i_aggregation format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `aggregation`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_count is supplied.
    lv_queryparam = i_count.
    add_query_parameter(
      exporting
        i_parameter  = `count`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_return is supplied.
    data:
      lv_item_return type STRING.
    clear: lv_queryparam, lv_sep.
    loop at i_return into lv_item_return.
      lv_queryparam = lv_queryparam && lv_sep && lv_item_return.
      lv_sep = ','.
    endloop.
    lv_queryparam = escape( val = lv_queryparam format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `return`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_offset is supplied.
    lv_queryparam = i_offset.
    add_query_parameter(
      exporting
        i_parameter  = `offset`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_sort is supplied.
    data:
      lv_item_sort type STRING.
    clear: lv_queryparam, lv_sep.
    loop at i_sort into lv_item_sort.
      lv_queryparam = lv_queryparam && lv_sep && lv_item_sort.
      lv_sep = ','.
    endloop.
    lv_queryparam = escape( val = lv_queryparam format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `sort`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_highlight is supplied.
    lv_queryparam = i_highlight.
    add_query_parameter(
      exporting
        i_parameter  = `highlight`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_passages_fields is supplied.
    data:
      lv_item_passages_fields type STRING.
    clear: lv_queryparam, lv_sep.
    loop at i_passages_fields into lv_item_passages_fields.
      lv_queryparam = lv_queryparam && lv_sep && lv_item_passages_fields.
      lv_sep = ','.
    endloop.
    lv_queryparam = escape( val = lv_queryparam format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `passages.fields`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_passages_count is supplied.
    lv_queryparam = i_passages_count.
    add_query_parameter(
      exporting
        i_parameter  = `passages.count`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_passages_characters is supplied.
    lv_queryparam = i_passages_characters.
    add_query_parameter(
      exporting
        i_parameter  = `passages.characters`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_deduplicate_field is supplied.
    lv_queryparam = escape( val = i_deduplicate_field format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `deduplicate.field`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_similar is supplied.
    lv_queryparam = i_similar.
    add_query_parameter(
      exporting
        i_parameter  = `similar`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_similar_document_ids is supplied.
    data:
      lv_item_similar_document_ids type STRING.
    clear: lv_queryparam, lv_sep.
    loop at i_similar_document_ids into lv_item_similar_document_ids.
      lv_queryparam = lv_queryparam && lv_sep && lv_item_similar_document_ids.
      lv_sep = ','.
    endloop.
    lv_queryparam = escape( val = lv_queryparam format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `similar.document_ids`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_similar_fields is supplied.
    data:
      lv_item_similar_fields type STRING.
    clear: lv_queryparam, lv_sep.
    loop at i_similar_fields into lv_item_similar_fields.
      lv_queryparam = lv_queryparam && lv_sep && lv_item_similar_fields.
      lv_sep = ','.
    endloop.
    lv_queryparam = escape( val = lv_queryparam format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `similar.fields`
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->FEDERATED_QUERY
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_query_long        TYPE T_FED_QUERY_LARGE(optional)
* | [--->] I_X_Watson_Logging_Opt_Out        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_QUERY_RESPONSE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method FEDERATED_QUERY.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/environments/{environment_id}/query'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).



    " process header parameters
    data:
      lv_headerparam type string  ##NEEDED.

    if i_X_Watson_Logging_Opt_Out is supplied.
    lv_headerparam = I_X_Watson_Logging_Opt_Out.
    add_header_parameter(
      exporting
        i_parameter  = 'X-Watson-Logging-Opt-Out'
        i_value      = lv_headerparam
        i_is_boolean = c_boolean_true
      changing
        c_headers    = ls_request_prop-headers )  ##NO_TEXT.
    endif.



    " process body parameters
    data:
      lv_body      type string,
      lv_bodyparam type string,
      lv_datatype  type char.
    field-symbols:
      <lv_text> type any.
    lv_separator = ''.
    if not i_query_long is initial.
    lv_datatype = get_datatype( i_query_long ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_query_long i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'query_long' i_value = i_query_long ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_query_long to <lv_text>.
      lv_bodyparam = <lv_text>.
      concatenate lv_body lv_bodyparam into lv_body.
    endif.
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->FEDERATED_QUERY_NOTICES
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_collection_ids        TYPE TT_STRING
* | [--->] I_filter        TYPE STRING(optional)
* | [--->] I_query        TYPE STRING(optional)
* | [--->] I_natural_language_query        TYPE STRING(optional)
* | [--->] I_aggregation        TYPE STRING(optional)
* | [--->] I_count        TYPE INTEGER(optional)
* | [--->] I_return        TYPE TT_STRING(optional)
* | [--->] I_offset        TYPE INTEGER(optional)
* | [--->] I_sort        TYPE TT_STRING(optional)
* | [--->] I_highlight        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_deduplicate_field        TYPE STRING(optional)
* | [--->] I_similar        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_similar_document_ids        TYPE TT_STRING(optional)
* | [--->] I_similar_fields        TYPE TT_STRING(optional)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_QUERY_NOTICES_RESPONSE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method FEDERATED_QUERY_NOTICES.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/environments/{environment_id}/notices'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    data:
      lv_item_collection_ids type STRING.
    clear: lv_queryparam, lv_sep.
    loop at i_collection_ids into lv_item_collection_ids.
      lv_queryparam = lv_queryparam && lv_sep && lv_item_collection_ids.
      lv_sep = ','.
    endloop.
    lv_queryparam = escape( val = lv_queryparam format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `collection_ids`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.

    if i_filter is supplied.
    lv_queryparam = escape( val = i_filter format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `filter`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_query is supplied.
    lv_queryparam = escape( val = i_query format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `query`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_natural_language_query is supplied.
    lv_queryparam = escape( val = i_natural_language_query format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `natural_language_query`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_aggregation is supplied.
    lv_queryparam = escape( val = i_aggregation format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `aggregation`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_count is supplied.
    lv_queryparam = i_count.
    add_query_parameter(
      exporting
        i_parameter  = `count`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_return is supplied.
    data:
      lv_item_return type STRING.
    clear: lv_queryparam, lv_sep.
    loop at i_return into lv_item_return.
      lv_queryparam = lv_queryparam && lv_sep && lv_item_return.
      lv_sep = ','.
    endloop.
    lv_queryparam = escape( val = lv_queryparam format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `return`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_offset is supplied.
    lv_queryparam = i_offset.
    add_query_parameter(
      exporting
        i_parameter  = `offset`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_sort is supplied.
    data:
      lv_item_sort type STRING.
    clear: lv_queryparam, lv_sep.
    loop at i_sort into lv_item_sort.
      lv_queryparam = lv_queryparam && lv_sep && lv_item_sort.
      lv_sep = ','.
    endloop.
    lv_queryparam = escape( val = lv_queryparam format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `sort`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_highlight is supplied.
    lv_queryparam = i_highlight.
    add_query_parameter(
      exporting
        i_parameter  = `highlight`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_deduplicate_field is supplied.
    lv_queryparam = escape( val = i_deduplicate_field format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `deduplicate.field`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_similar is supplied.
    lv_queryparam = i_similar.
    add_query_parameter(
      exporting
        i_parameter  = `similar`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_similar_document_ids is supplied.
    data:
      lv_item_similar_document_ids type STRING.
    clear: lv_queryparam, lv_sep.
    loop at i_similar_document_ids into lv_item_similar_document_ids.
      lv_queryparam = lv_queryparam && lv_sep && lv_item_similar_document_ids.
      lv_sep = ','.
    endloop.
    lv_queryparam = escape( val = lv_queryparam format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `similar.document_ids`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_similar_fields is supplied.
    data:
      lv_item_similar_fields type STRING.
    clear: lv_queryparam, lv_sep.
    loop at i_similar_fields into lv_item_similar_fields.
      lv_queryparam = lv_queryparam && lv_sep && lv_item_similar_fields.
      lv_sep = ','.
    endloop.
    lv_queryparam = escape( val = lv_queryparam format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `similar.fields`
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->GET_AUTOCOMPLETION
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_collection_id        TYPE STRING
* | [--->] I_field        TYPE STRING(optional)
* | [--->] I_prefix        TYPE STRING(optional)
* | [--->] I_count        TYPE INTEGER(optional)
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

    ls_request_prop-url-path = '/v1/environments/{environment_id}/collections/{collection_id}/autocompletion'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_collection_id ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_field is supplied.
    lv_queryparam = escape( val = i_field format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `field`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_prefix is supplied.
    lv_queryparam = escape( val = i_prefix format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `prefix`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_count is supplied.
    lv_queryparam = i_count.
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->LIST_TRAINING_DATA
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_collection_id        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_TRAINING_DATA_SET
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_TRAINING_DATA.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/environments/{environment_id}/collections/{collection_id}/training_data'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_collection_id ignoring case.

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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->ADD_TRAINING_DATA
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_collection_id        TYPE STRING
* | [--->] I_body        TYPE T_NEW_TRAINING_QUERY
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_TRAINING_QUERY
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method ADD_TRAINING_DATA.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/environments/{environment_id}/collections/{collection_id}/training_data'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_collection_id ignoring case.

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
    lv_datatype = get_datatype( i_body ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_body i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'body' i_value = i_body ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_body to <lv_text>.
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->DELETE_ALL_TRAINING_DATA
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_collection_id        TYPE STRING
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_ALL_TRAINING_DATA.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/environments/{environment_id}/collections/{collection_id}/training_data'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_collection_id ignoring case.

    " standard headers
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








    " execute HTTP DELETE request
    lo_response = HTTP_DELETE( i_request_prop = ls_request_prop ).



endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->GET_TRAINING_DATA
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_collection_id        TYPE STRING
* | [--->] I_query_id        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_TRAINING_QUERY
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_TRAINING_DATA.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/environments/{environment_id}/collections/{collection_id}/training_data/{query_id}'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_collection_id ignoring case.
    replace all occurrences of `{query_id}` in ls_request_prop-url-path with i_query_id ignoring case.

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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->DELETE_TRAINING_DATA
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_collection_id        TYPE STRING
* | [--->] I_query_id        TYPE STRING
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_TRAINING_DATA.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/environments/{environment_id}/collections/{collection_id}/training_data/{query_id}'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_collection_id ignoring case.
    replace all occurrences of `{query_id}` in ls_request_prop-url-path with i_query_id ignoring case.

    " standard headers
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








    " execute HTTP DELETE request
    lo_response = HTTP_DELETE( i_request_prop = ls_request_prop ).



endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->LIST_TRAINING_EXAMPLES
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_collection_id        TYPE STRING
* | [--->] I_query_id        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_TRAINING_EXAMPLE_LIST
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_TRAINING_EXAMPLES.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/environments/{environment_id}/collections/{collection_id}/training_data/{query_id}/examples'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_collection_id ignoring case.
    replace all occurrences of `{query_id}` in ls_request_prop-url-path with i_query_id ignoring case.

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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->CREATE_TRAINING_EXAMPLE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_collection_id        TYPE STRING
* | [--->] I_query_id        TYPE STRING
* | [--->] I_body        TYPE T_TRAINING_EXAMPLE
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_TRAINING_EXAMPLE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CREATE_TRAINING_EXAMPLE.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/environments/{environment_id}/collections/{collection_id}/training_data/{query_id}/examples'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_collection_id ignoring case.
    replace all occurrences of `{query_id}` in ls_request_prop-url-path with i_query_id ignoring case.

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
    lv_datatype = get_datatype( i_body ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_body i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'body' i_value = i_body ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_body to <lv_text>.
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->DELETE_TRAINING_EXAMPLE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_collection_id        TYPE STRING
* | [--->] I_query_id        TYPE STRING
* | [--->] I_example_id        TYPE STRING
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_TRAINING_EXAMPLE.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/environments/{environment_id}/collections/{collection_id}/training_data/{query_id}/examples/{example_id}'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_collection_id ignoring case.
    replace all occurrences of `{query_id}` in ls_request_prop-url-path with i_query_id ignoring case.
    replace all occurrences of `{example_id}` in ls_request_prop-url-path with i_example_id ignoring case.

    " standard headers
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








    " execute HTTP DELETE request
    lo_response = HTTP_DELETE( i_request_prop = ls_request_prop ).



endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->UPDATE_TRAINING_EXAMPLE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_collection_id        TYPE STRING
* | [--->] I_query_id        TYPE STRING
* | [--->] I_example_id        TYPE STRING
* | [--->] I_body        TYPE T_TRAINING_EXAMPLE_PATCH
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_TRAINING_EXAMPLE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method UPDATE_TRAINING_EXAMPLE.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/environments/{environment_id}/collections/{collection_id}/training_data/{query_id}/examples/{example_id}'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_collection_id ignoring case.
    replace all occurrences of `{query_id}` in ls_request_prop-url-path with i_query_id ignoring case.
    replace all occurrences of `{example_id}` in ls_request_prop-url-path with i_example_id ignoring case.

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
    lv_datatype = get_datatype( i_body ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_body i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'body' i_value = i_body ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_body to <lv_text>.
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->GET_TRAINING_EXAMPLE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_collection_id        TYPE STRING
* | [--->] I_query_id        TYPE STRING
* | [--->] I_example_id        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_TRAINING_EXAMPLE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_TRAINING_EXAMPLE.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/environments/{environment_id}/collections/{collection_id}/training_data/{query_id}/examples/{example_id}'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_collection_id ignoring case.
    replace all occurrences of `{query_id}` in ls_request_prop-url-path with i_query_id ignoring case.
    replace all occurrences of `{example_id}` in ls_request_prop-url-path with i_example_id ignoring case.

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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->DELETE_USER_DATA
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_customer_id        TYPE STRING
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_USER_DATA.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/user_data'.

    " standard headers
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    lv_queryparam = escape( val = i_customer_id format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `customer_id`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.






    " execute HTTP DELETE request
    lo_response = HTTP_DELETE( i_request_prop = ls_request_prop ).



endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->CREATE_EVENT
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_query_event        TYPE T_CREATE_EVENT_OBJECT
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_CREATE_EVENT_RESPONSE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CREATE_EVENT.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/events'.

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
    lv_datatype = get_datatype( i_query_event ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_query_event i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'query_event' i_value = i_query_event ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_query_event to <lv_text>.
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->QUERY_LOG
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_filter        TYPE STRING(optional)
* | [--->] I_query        TYPE STRING(optional)
* | [--->] I_count        TYPE INTEGER(optional)
* | [--->] I_offset        TYPE INTEGER(optional)
* | [--->] I_sort        TYPE TT_STRING(optional)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_LOG_QUERY_RESPONSE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method QUERY_LOG.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/logs'.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_filter is supplied.
    lv_queryparam = escape( val = i_filter format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `filter`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_query is supplied.
    lv_queryparam = escape( val = i_query format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `query`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_count is supplied.
    lv_queryparam = i_count.
    add_query_parameter(
      exporting
        i_parameter  = `count`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_offset is supplied.
    lv_queryparam = i_offset.
    add_query_parameter(
      exporting
        i_parameter  = `offset`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_sort is supplied.
    data:
      lv_item_sort type STRING.
    clear: lv_queryparam, lv_sep.
    loop at i_sort into lv_item_sort.
      lv_queryparam = lv_queryparam && lv_sep && lv_item_sort.
      lv_sep = ','.
    endloop.
    lv_queryparam = escape( val = lv_queryparam format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `sort`
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->GET_METRICS_QUERY
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_start_time        TYPE DATETIME(optional)
* | [--->] I_end_time        TYPE DATETIME(optional)
* | [--->] I_result_type        TYPE STRING(optional)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_METRIC_RESPONSE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_METRICS_QUERY.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/metrics/number_of_queries'.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_start_time is supplied.
    lv_queryparam = i_start_time.
    add_query_parameter(
      exporting
        i_parameter  = `start_time`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_end_time is supplied.
    lv_queryparam = i_end_time.
    add_query_parameter(
      exporting
        i_parameter  = `end_time`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_result_type is supplied.
    lv_queryparam = escape( val = i_result_type format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `result_type`
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->GET_METRICS_QUERY_EVENT
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_start_time        TYPE DATETIME(optional)
* | [--->] I_end_time        TYPE DATETIME(optional)
* | [--->] I_result_type        TYPE STRING(optional)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_METRIC_RESPONSE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_METRICS_QUERY_EVENT.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/metrics/number_of_queries_with_event'.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_start_time is supplied.
    lv_queryparam = i_start_time.
    add_query_parameter(
      exporting
        i_parameter  = `start_time`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_end_time is supplied.
    lv_queryparam = i_end_time.
    add_query_parameter(
      exporting
        i_parameter  = `end_time`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_result_type is supplied.
    lv_queryparam = escape( val = i_result_type format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `result_type`
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->GET_METRICS_QUERY_NO_RESULTS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_start_time        TYPE DATETIME(optional)
* | [--->] I_end_time        TYPE DATETIME(optional)
* | [--->] I_result_type        TYPE STRING(optional)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_METRIC_RESPONSE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_METRICS_QUERY_NO_RESULTS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/metrics/number_of_queries_with_no_search_results'.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_start_time is supplied.
    lv_queryparam = i_start_time.
    add_query_parameter(
      exporting
        i_parameter  = `start_time`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_end_time is supplied.
    lv_queryparam = i_end_time.
    add_query_parameter(
      exporting
        i_parameter  = `end_time`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_result_type is supplied.
    lv_queryparam = escape( val = i_result_type format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `result_type`
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->GET_METRICS_EVENT_RATE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_start_time        TYPE DATETIME(optional)
* | [--->] I_end_time        TYPE DATETIME(optional)
* | [--->] I_result_type        TYPE STRING(optional)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_METRIC_RESPONSE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_METRICS_EVENT_RATE.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/metrics/event_rate'.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_start_time is supplied.
    lv_queryparam = i_start_time.
    add_query_parameter(
      exporting
        i_parameter  = `start_time`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_end_time is supplied.
    lv_queryparam = i_end_time.
    add_query_parameter(
      exporting
        i_parameter  = `end_time`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_result_type is supplied.
    lv_queryparam = escape( val = i_result_type format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `result_type`
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->GET_METRICS_QUERY_TOKEN_EVENT
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_count        TYPE INTEGER(optional)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_METRIC_TOKEN_RESPONSE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_METRICS_QUERY_TOKEN_EVENT.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/metrics/top_query_tokens_with_event_rate'.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_count is supplied.
    lv_queryparam = i_count.
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->LIST_CREDENTIALS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_CREDENTIALS_LIST
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_CREDENTIALS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/environments/{environment_id}/credentials'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.

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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->CREATE_CREDENTIALS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_credentials_parameter        TYPE T_CREDENTIALS
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_CREDENTIALS
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CREATE_CREDENTIALS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/environments/{environment_id}/credentials'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.

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
    lv_datatype = get_datatype( i_credentials_parameter ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_credentials_parameter i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'credentials_parameter' i_value = i_credentials_parameter ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_credentials_parameter to <lv_text>.
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->GET_CREDENTIALS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_credential_id        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_CREDENTIALS
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_CREDENTIALS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/environments/{environment_id}/credentials/{credential_id}'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.
    replace all occurrences of `{credential_id}` in ls_request_prop-url-path with i_credential_id ignoring case.

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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->UPDATE_CREDENTIALS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_credential_id        TYPE STRING
* | [--->] I_credentials_parameter        TYPE T_CREDENTIALS
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_CREDENTIALS
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method UPDATE_CREDENTIALS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/environments/{environment_id}/credentials/{credential_id}'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.
    replace all occurrences of `{credential_id}` in ls_request_prop-url-path with i_credential_id ignoring case.

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
    lv_datatype = get_datatype( i_credentials_parameter ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_credentials_parameter i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'credentials_parameter' i_value = i_credentials_parameter ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_credentials_parameter to <lv_text>.
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->DELETE_CREDENTIALS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_credential_id        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_DELETE_CREDENTIALS
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_CREDENTIALS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/environments/{environment_id}/credentials/{credential_id}'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.
    replace all occurrences of `{credential_id}` in ls_request_prop-url-path with i_credential_id ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->LIST_GATEWAYS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_GATEWAY_LIST
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_GATEWAYS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/environments/{environment_id}/gateways'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.

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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->CREATE_GATEWAY
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_gateway_name        TYPE T_GATEWAY_NAME(optional)
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_GATEWAY
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CREATE_GATEWAY.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/environments/{environment_id}/gateways'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.

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
    if not i_gateway_name is initial.
    lv_datatype = get_datatype( i_gateway_name ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_gateway_name i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'gateway_name' i_value = i_gateway_name ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_gateway_name to <lv_text>.
      lv_bodyparam = <lv_text>.
      concatenate lv_body lv_bodyparam into lv_body.
    endif.
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->GET_GATEWAY
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_gateway_id        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_GATEWAY
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_GATEWAY.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/environments/{environment_id}/gateways/{gateway_id}'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.
    replace all occurrences of `{gateway_id}` in ls_request_prop-url-path with i_gateway_id ignoring case.

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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->DELETE_GATEWAY
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_environment_id        TYPE STRING
* | [--->] I_gateway_id        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_GATEWAY_DELETE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_GATEWAY.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/environments/{environment_id}/gateways/{gateway_id}'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_environment_id ignoring case.
    replace all occurrences of `{gateway_id}` in ls_request_prop-url-path with i_gateway_id ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








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
* | Instance Private Method ZCL_IBMC_DISCOVERY_V1->SET_DEFAULT_QUERY_PARAMETERS
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
