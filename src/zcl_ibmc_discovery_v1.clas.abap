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
"! <p class="shorttext synchronized" lang="en">Discovery</p>
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
    "! <p class="shorttext synchronized" lang="en">
    "!    An aggregation produced by  Discovery to analyze the input</p>
    "!     provided.
    begin of T_QUERY_AGGREGATION,
      "!   The type of aggregation command used. For example: term, filter, max, min, etc.
      TYPE type STRING,
      "!   Array of aggregation results.
      RESULTS type STANDARD TABLE OF DATA_REFERENCE WITH NON-UNIQUE DEFAULT KEY,
      "!   Number of matching results.
      MATCHING_RESULTS type INTEGER,
      "!   Aggregations returned by Discovery.
      AGGREGATIONS type STANDARD TABLE OF DATA_REFERENCE WITH NON-UNIQUE DEFAULT KEY,
    end of T_QUERY_AGGREGATION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Aggregation results for the specified query.</p>
    begin of T_AGGREGATION_RESULT,
      "!   Key that matched the aggregation type.
      KEY type STRING,
      "!   Number of matching results.
      MATCHING_RESULTS type INTEGER,
      "!   Aggregations returned in the case of chained aggregations.
      AGGREGATIONS type STANDARD TABLE OF T_QUERY_AGGREGATION WITH NON-UNIQUE DEFAULT KEY,
    end of T_AGGREGATION_RESULT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Training status details.</p>
    begin of T_TRAINING_STATUS,
      "!   The total number of training examples uploaded to this collection.
      TOTAL_EXAMPLES type INTEGER,
      "!   When `true`, the collection has been successfully trained.
      AVAILABLE type BOOLEAN,
      "!   When `true`, the collection is currently processing training.
      PROCESSING type BOOLEAN,
      "!   When `true`, the collection has a sufficent amount of queries added for training
      "!    to occur.
      MINIMUM_QUERIES_ADDED type BOOLEAN,
      "!   When `true`, the collection has a sufficent amount of examples added for
      "!    training to occur.
      MINIMUM_EXAMPLES_ADDED type BOOLEAN,
      "!   When `true`, the collection has a sufficent amount of diversity in labeled
      "!    results for training to occur.
      SUFFICIENT_LABEL_DIVERSITY type BOOLEAN,
      "!   The number of notices associated with this data set.
      NOTICES type INTEGER,
      "!   The timestamp of when the collection was successfully trained.
      SUCCESSFULLY_TRAINED type DATETIME,
      "!   The timestamp of when the data was uploaded.
      DATA_UPDATED type DATETIME,
    end of T_TRAINING_STATUS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Object describing the current status of the wordlist.</p>
    begin of T_TOKEN_DICT_STATUS_RESPONSE,
      "!   Current wordlist status for the specified collection.
      STATUS type STRING,
      "!   The type for this wordlist. Can be `tokenization_dictionary` or `stopwords`.
      TYPE type STRING,
    end of T_TOKEN_DICT_STATUS_RESPONSE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object that indicates the Categories enrichment will be</p>
    "!     applied to the specified field.
      T_NLU_ENRICHMENT_CATEGORIES type MAP.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object specifying the relations enrichment and related</p>
    "!     parameters.
    begin of T_NLU_ENRICHMENT_RELATIONS,
      "!   *For use with `natural_language_understanding` enrichments only.* The
      "!    enrichement model to use with relationship extraction. May be a custom model
      "!    provided by Watson Knowledge Studio, the default public model is`en-news`.
      MODEL type STRING,
    end of T_NLU_ENRICHMENT_RELATIONS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object specifying the sentiment extraction enrichment and</p>
    "!     related parameters.
    begin of T_NLU_ENRICHMENT_SENTIMENT,
      "!   When `true`, sentiment analysis is performed on the entire field.
      DOCUMENT type BOOLEAN,
      "!   A comma-separated list of target strings that will have any associated sentiment
      "!    analyzed.
      TARGETS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
    end of T_NLU_ENRICHMENT_SENTIMENT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object specifiying the semantic roles enrichment and</p>
    "!     related parameters.
    begin of T_NL_ENRICHMENT_SEMANTIC_ROLES,
      "!   When `true`, entities are extracted from the identified sentence parts.
      ENTITIES type BOOLEAN,
      "!   When `true`, keywords are extracted from the identified sentence parts.
      KEYWORDS type BOOLEAN,
      "!   The maximum number of semantic roles enrichments to extact from each instance of
      "!    the specified field.
      LIMIT type INTEGER,
    end of T_NL_ENRICHMENT_SEMANTIC_ROLES.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object speficying the Entities enrichment and related</p>
    "!     parameters.
    begin of T_NLU_ENRICHMENT_ENTITIES,
      "!   When `true`, sentiment analysis of entities will be performed on the specified
      "!    field.
      SENTIMENT type BOOLEAN,
      "!   When `true`, emotion detection of entities will be performed on the specified
      "!    field.
      EMOTION type BOOLEAN,
      "!   The maximum number of entities to extract for each instance of the specified
      "!    field.
      LIMIT type INTEGER,
      "!   When `true`, the number of mentions of each identified entity is recorded. The
      "!    default is `false`.
      MENTIONS type BOOLEAN,
      "!   When `true`, the types of mentions for each idetifieid entity is recorded. The
      "!    default is `false`.
      MENTION_TYPES type BOOLEAN,
      "!   When `true`, a list of sentence locations for each instance of each identified
      "!    entity is recorded. The default is `false`.
      SENTENCE_LOCATIONS type BOOLEAN,
      "!   The enrichement model to use with entity extraction. May be a custom model
      "!    provided by Watson Knowledge Studio, or the default public model `alchemy`.
      MODEL type STRING,
    end of T_NLU_ENRICHMENT_ENTITIES.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object specifying the emotion detection enrichment and</p>
    "!     related parameters.
    begin of T_NLU_ENRICHMENT_EMOTION,
      "!   When `true`, emotion detection is performed on the entire field.
      DOCUMENT type BOOLEAN,
      "!   A comma-separated list of target strings that will have any associated emotions
      "!    detected.
      TARGETS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
    end of T_NLU_ENRICHMENT_EMOTION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object specifiying the concepts enrichment and related</p>
    "!     parameters.
    begin of T_NLU_ENRICHMENT_CONCEPTS,
      "!   The maximum number of concepts enrichments to extact from each instance of the
      "!    specified field.
      LIMIT type INTEGER,
    end of T_NLU_ENRICHMENT_CONCEPTS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object specifying the Keyword enrichment and related</p>
    "!     parameters.
    begin of T_NLU_ENRICHMENT_KEYWORDS,
      "!   When `true`, sentiment analysis of keywords will be performed on the specified
      "!    field.
      SENTIMENT type BOOLEAN,
      "!   When `true`, emotion detection of keywords will be performed on the specified
      "!    field.
      EMOTION type BOOLEAN,
      "!   The maximum number of keywords to extract for each instance of the specified
      "!    field.
      LIMIT type INTEGER,
    end of T_NLU_ENRICHMENT_KEYWORDS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Object containing Natural Language Understanding features to</p>
    "!     be used.
    begin of T_NLU_ENRICHMENT_FEATURES,
      "!   An object specifying the Keyword enrichment and related parameters.
      KEYWORDS type T_NLU_ENRICHMENT_KEYWORDS,
      "!   An object speficying the Entities enrichment and related parameters.
      ENTITIES type T_NLU_ENRICHMENT_ENTITIES,
      "!   An object specifying the sentiment extraction enrichment and related parameters.
      "!
      SENTIMENT type T_NLU_ENRICHMENT_SENTIMENT,
      "!   An object specifying the emotion detection enrichment and related parameters.
      EMOTION type T_NLU_ENRICHMENT_EMOTION,
      "!   An object that indicates the Categories enrichment will be applied to the
      "!    specified field.
      CATEGORIES type T_NLU_ENRICHMENT_CATEGORIES,
      "!   An object specifiying the semantic roles enrichment and related parameters.
      SEMANTIC_ROLES type T_NL_ENRICHMENT_SEMANTIC_ROLES,
      "!   An object specifying the relations enrichment and related parameters.
      RELATIONS type T_NLU_ENRICHMENT_RELATIONS,
      "!   An object specifiying the concepts enrichment and related parameters.
      CONCEPTS type T_NLU_ENRICHMENT_CONCEPTS,
    end of T_NLU_ENRICHMENT_FEATURES.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object representing the configuration options to use for</p>
    "!     the `natural_language_understanding` enrichments.
    begin of T_NLU_ENRICHMENT_OPTIONS,
      "!   Object containing Natural Language Understanding features to be used.
      FEATURES type T_NLU_ENRICHMENT_FEATURES,
      "!   ISO 639-1 code indicating the language to use for the analysis. This code
      "!    overrides the automatic language detection performed by the service. Valid
      "!    codes are `ar` (Arabic), `en` (English), `fr` (French), `de` (German), `it`
      "!    (Italian), `pt` (Portuguese), `ru` (Russian), `es` (Spanish), and `sv`
      "!    (Swedish). **Note:** Not all features support all languages, automatic
      "!    detection is recommended.
      LANGUAGE type STRING,
    end of T_NLU_ENRICHMENT_OPTIONS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object defining a single tokenizaion rule.</p>
    begin of T_TOKEN_DICT_RULE,
      "!   The string to tokenize.
      TEXT type STRING,
      "!   Array of tokens that the `text` field is split into when found.
      TOKENS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   Array of tokens that represent the content of the `text` field in an alternate
      "!    character set.
      READINGS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   The part of speech that the `text` string belongs to. For example `noun`. Custom
      "!    parts of speech can be specified.
      PART_OF_SPEECH type STRING,
    end of T_TOKEN_DICT_RULE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Tokenization dictionary describing how words are tokenized</p>
    "!     during ingestion and at query time.
    begin of T_TOKEN_DICT,
      "!   An array of tokenization rules. Each rule contains, the original `text` string,
      "!    component `tokens`, any alternate character set `readings`, and which
      "!    `part_of_speech` the text is from.
      TOKENIZATION_RULES type STANDARD TABLE OF T_TOKEN_DICT_RULE WITH NON-UNIQUE DEFAULT KEY,
    end of T_TOKEN_DICT.
  types:
    "! No documentation available.
    begin of T_FILTER,
      "!   The match the aggregated results queried for.
      MATCH type STRING,
    end of T_FILTER.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Object defining which URL to crawl and how to crawl it.</p>
    begin of T_SOURCE_OPTIONS_WEB_CRAWL,
      "!   The starting URL to crawl.
      URL type STRING,
      "!   When `true`, crawls of the specified URL are limited to the host part of the
      "!    **url** field.
      LIMIT_TO_STARTING_HOSTS type BOOLEAN,
      "!   The number of concurrent URLs to fetch. `gentle` means one URL is fetched at a
      "!    time with a delay between each call. `normal` means as many as two URLs are
      "!    fectched concurrently with a short delay between fetch calls. `aggressive`
      "!    means that up to ten URLs are fetched concurrently with a short delay between
      "!    fetch calls.
      CRAWL_SPEED type STRING,
      "!   When `true`, allows the crawl to interact with HTTPS sites with SSL certificates
      "!    with untrusted signers.
      ALLOW_UNTRUSTED_CERTIFICATE type BOOLEAN,
      "!   The maximum number of hops to make from the initial URL. When a page is crawled
      "!    each link on that page will also be crawled if it is within the
      "!    **maximum_hops** from the initial URL. The first page crawled is 0 hops, each
      "!    link crawled from the first page is 1 hop, each link crawled from those pages
      "!    is 2 hops, and so on.
      MAXIMUM_HOPS type INTEGER,
      "!   The maximum milliseconds to wait for a response from the web server.
      REQUEST_TIMEOUT type INTEGER,
      "!   When `true`, the crawler will ignore any `robots.txt` encountered by the
      "!    crawler. This should only ever be done when crawling a web site the user owns.
      "!    This must be be set to `true` when a **gateway_id** is specied in the
      "!    **credentials**.
      OVERRIDE_ROBOTS_TXT type BOOLEAN,
      "!   Array of URL&apos;s to be excluded while crawling. The crawler will not follow
      "!    links which contains this string. For example, listing `https://ibm.com/watson`
      "!    also excludes `https://ibm.com/watson/discovery`.
      BLACKLIST type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
    end of T_SOURCE_OPTIONS_WEB_CRAWL.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Object containing details of the stored credentials. </p><br/>
    "!    <br/>
    "!    Obtain credentials for your source from the administrator of the source.
    begin of T_CREDENTIAL_DETAILS,
      "!   The authentication method for this credentials definition. The
      "!    **credential_type** specified must be supported by the **source_type**. The
      "!    following combinations are possible:<br/>
      "!   <br/>
      "!   -  `&quot;source_type&quot;: &quot;box&quot;` - valid `credential_type`s:
      "!    `oauth2`<br/>
      "!   -  `&quot;source_type&quot;: &quot;salesforce&quot;` - valid `credential_type`s:
      "!    `username_password`<br/>
      "!   -  `&quot;source_type&quot;: &quot;sharepoint&quot;` - valid `credential_type`s:
      "!    `saml` with **source_version** of `online`, or `ntlm_v1` with
      "!    **source_version** of `2016`<br/>
      "!   -  `&quot;source_type&quot;: &quot;web_crawl&quot;` - valid `credential_type`s:
      "!    `noauth` or `basic`<br/>
      "!   -  &quot;source_type&quot;: &quot;cloud_object_storage&quot;` - valid
      "!    `credential_type`s: `aws4_hmac`.
      CREDENTIAL_TYPE type STRING,
      "!   The **client_id** of the source that these credentials connect to. Only valid,
      "!    and required, with a **credential_type** of `oauth2`.
      CLIENT_ID type STRING,
      "!   The **enterprise_id** of the Box site that these credentials connect to. Only
      "!    valid, and required, with a **source_type** of `box`.
      ENTERPRISE_ID type STRING,
      "!   The **url** of the source that these credentials connect to. Only valid, and
      "!    required, with a **credential_type** of `username_password`, `noauth`, and
      "!    `basic`.
      URL type STRING,
      "!   The **username** of the source that these credentials connect to. Only valid,
      "!    and required, with a **credential_type** of `saml`, `username_password`,
      "!    `basic`, or `ntlm_v1`.
      USERNAME type STRING,
      "!   The **organization_url** of the source that these credentials connect to. Only
      "!    valid, and required, with a **credential_type** of `saml`.
      ORGANIZATION_URL type STRING,
      "!   The **site_collection.path** of the source that these credentials connect to.
      "!    Only valid, and required, with a **source_type** of `sharepoint`.
      SITE_COLLECTION_PATH type STRING,
      "!   The **client_secret** of the source that these credentials connect to. Only
      "!    valid, and required, with a **credential_type** of `oauth2`. This value is
      "!    never returned and is only used when creating or modifying **credentials**.
      CLIENT_SECRET type STRING,
      "!   The **public_key_id** of the source that these credentials connect to. Only
      "!    valid, and required, with a **credential_type** of `oauth2`. This value is
      "!    never returned and is only used when creating or modifying **credentials**.
      PUBLIC_KEY_ID type STRING,
      "!   The **private_key** of the source that these credentials connect to. Only valid,
      "!    and required, with a **credential_type** of `oauth2`. This value is never
      "!    returned and is only used when creating or modifying **credentials**.
      PRIVATE_KEY type STRING,
      "!   The **passphrase** of the source that these credentials connect to. Only valid,
      "!    and required, with a **credential_type** of `oauth2`. This value is never
      "!    returned and is only used when creating or modifying **credentials**.
      PASSPHRASE type STRING,
      "!   The **password** of the source that these credentials connect to. Only valid,
      "!    and required, with **credential_type**s of `saml`, `username_password`,
      "!    `basic`, or `ntlm_v1`. <br/>
      "!   <br/>
      "!   **Note:** When used with a **source_type** of `salesforce`, the password
      "!    consists of the Salesforce password and a valid Salesforce security token
      "!    concatenated. This value is never returned and is only used when creating or
      "!    modifying **credentials**.
      PASSWORD type STRING,
      "!   The ID of the **gateway** to be connected through (when connecting to intranet
      "!    sites). Only valid with a **credential_type** of `noauth`, `basic`, or
      "!    `ntlm_v1`. Gateways are created using the
      "!    `/v1/environments/&#123;environment_id&#125;/gateways` methods.
      GATEWAY_ID type STRING,
      "!   The type of Sharepoint repository to connect to. Only valid, and required, with
      "!    a **source_type** of `sharepoint`.
      SOURCE_VERSION type STRING,
      "!   SharePoint OnPrem WebApplication URL. Only valid, and required, with a
      "!    **source_version** of `2016`. If a port is not supplied, the default to port
      "!    `80` for http and port `443` for https connections are used.
      WEB_APPLICATION_URL type STRING,
      "!   The domain used to log in to your OnPrem SharePoint account. Only valid, and
      "!    required, with a **source_version** of `2016`.
      DOMAIN type STRING,
      "!   The endpoint associated with the cloud object store that your are connecting to.
      "!    Only valid, and required, with a **credential_type** of `aws4_hmac`.
      ENDPOINT type STRING,
      "!   The access key ID associated with the cloud object store. Only valid, and
      "!    required, with a **credential_type** of `aws4_hmac`. This value is never
      "!    returned and is only used when creating or modifying **credentials**. For more
      "!    infomation, see the [cloud object store
      "!    documentation](https://cloud.ibm.com/docs/services/cloud-object-storage?topic=c
      "!   loud-object-storage-using-hmac-credentials#using-hmac-credentials).
      ACCESS_KEY_ID type STRING,
      "!   The secret access key associated with the cloud object store. Only valid, and
      "!    required, with a **credential_type** of `aws4_hmac`. This value is never
      "!    returned and is only used when creating or modifying **credentials**. For more
      "!    infomation, see the [cloud object store
      "!    documentation](https://cloud.ibm.com/docs/services/cloud-object-storage?topic=c
      "!   loud-object-storage-using-hmac-credentials#using-hmac-credentials).
      SECRET_ACCESS_KEY type STRING,
    end of T_CREDENTIAL_DETAILS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Object containing credential information.</p>
    begin of T_CREDENTIALS,
      "!   Unique identifier for this set of credentials.
      CREDENTIAL_ID type STRING,
      "!   The source that this credentials object connects to.<br/>
      "!   -  `box` indicates the credentials are used to connect an instance of Enterprise
      "!    Box.<br/>
      "!   -  `salesforce` indicates the credentials are used to connect to
      "!    Salesforce.<br/>
      "!   -  `sharepoint` indicates the credentials are used to connect to Microsoft
      "!    SharePoint Online.<br/>
      "!   -  `web_crawl` indicates the credentials are used to perform a web crawl.<br/>
      "!   =  `cloud_object_storage` indicates the credentials are used to connect to an
      "!    IBM Cloud Object Store.
      SOURCE_TYPE type STRING,
      "!   Object containing details of the stored credentials. <br/>
      "!   <br/>
      "!   Obtain credentials for your source from the administrator of the source.
      CREDENTIAL_DETAILS type T_CREDENTIAL_DETAILS,
      "!   The current status of this set of credentials. `connected` indicates that the
      "!    credentials are available to use with the source configuration of a collection.
      "!    `invalid` refers to the credentials (for example, the password provided has
      "!    expired) and must be corrected before they can be used with a collection.
      STATUS type STRING,
    end of T_CREDENTIALS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Object containing array of credential definitions.</p>
    begin of T_CREDENTIALS_LIST,
      "!   An array of credential definitions that were created for this instance.
      CREDENTIALS type STANDARD TABLE OF T_CREDENTIALS WITH NON-UNIQUE DEFAULT KEY,
    end of T_CREDENTIALS_LIST.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Summary of the collection usage in the environment.</p>
    begin of T_COLLECTION_USAGE,
      "!   Number of active collections in the environment.
      AVAILABLE type INTEGER,
      "!   Total number of collections allowed in the environment.
      MAXIMUM_ALLOWED type INTEGER,
    end of T_COLLECTION_USAGE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Summary of the disk usage statistics for the environment.</p>
    begin of T_DISK_USAGE,
      "!   Number of bytes within the environment&apos;s disk capacity that are currently
      "!    used to store data.
      USED_BYTES type INTEGER,
      "!   Total number of bytes available in the environment&apos;s disk capacity.
      MAXIMUM_ALLOWED_BYTES type INTEGER,
    end of T_DISK_USAGE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Summary of the document usage statistics for the</p>
    "!     environment.
    begin of T_ENVIRONMENT_DOCUMENTS,
      "!   Number of documents indexed for the environment.
      INDEXED type INTEGER,
      "!   Total number of documents allowed in the environment&apos;s capacity.
      MAXIMUM_ALLOWED type INTEGER,
    end of T_ENVIRONMENT_DOCUMENTS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Details about the resource usage and capacity of the</p>
    "!     environment.
    begin of T_INDEX_CAPACITY,
      "!   Summary of the document usage statistics for the environment.
      DOCUMENTS type T_ENVIRONMENT_DOCUMENTS,
      "!   Summary of the disk usage statistics for the environment.
      DISK_USAGE type T_DISK_USAGE,
      "!   Summary of the collection usage in the environment.
      COLLECTIONS type T_COLLECTION_USAGE,
    end of T_INDEX_CAPACITY.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about the Continuous Relevancy Training for this</p>
    "!     environment.
    begin of T_SEARCH_STATUS,
      "!   Current scope of the training. Always returned as `environment`.
      SCOPE type STRING,
      "!   The current status of Continuous Relevancy Training for this environment.
      STATUS type STRING,
      "!   Long description of the current Continuous Relevancy Training status.
      STATUS_DESCRIPTION type STRING,
      "!   The date stamp of the most recent completed training for this environment.
      LAST_TRAINED type DATE,
    end of T_SEARCH_STATUS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Details about an environment.</p>
    begin of T_ENVIRONMENT,
      "!   Unique identifier for the environment.
      ENVIRONMENT_ID type STRING,
      "!   Name that identifies the environment.
      NAME type STRING,
      "!   Description of the environment.
      DESCRIPTION type STRING,
      "!   Creation date of the environment, in the format
      "!    `yyyy-MM-dd&apos;T&apos;HH:mm:ss.SSS&apos;Z&apos;`.
      CREATED type DATETIME,
      "!   Date of most recent environment update, in the format
      "!    `yyyy-MM-dd&apos;T&apos;HH:mm:ss.SSS&apos;Z&apos;`.
      UPDATED type DATETIME,
      "!   Current status of the environment. `resizing` is displayed when a request to
      "!    increase the environment size has been made, but is still in the process of
      "!    being completed.
      STATUS type STRING,
      "!   If `true`, the environment contains read-only collections that are maintained by
      "!    IBM.
      READ_ONLY type BOOLEAN,
      "!   Current size of the environment.
      SIZE type STRING,
      "!   The new size requested for this environment. Only returned when the environment
      "!    *status* is `resizing`.<br/>
      "!   <br/>
      "!   *Note:* Querying and indexing can still be performed during an environment
      "!    upsize.
      REQUESTED_SIZE type STRING,
      "!   Details about the resource usage and capacity of the environment.
      INDEX_CAPACITY type T_INDEX_CAPACITY,
      "!   Information about the Continuous Relevancy Training for this environment.
      SEARCH_STATUS type T_SEARCH_STATUS,
    end of T_ENVIRONMENT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Response object containing an array of configured</p>
    "!     environments.
    begin of T_LIST_ENVIRONMENTS_RESPONSE,
      "!   An array of [environments] that are available for the service instance.
      ENVIRONMENTS type STANDARD TABLE OF T_ENVIRONMENT WITH NON-UNIQUE DEFAULT KEY,
    end of T_LIST_ENVIRONMENTS_RESPONSE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Gatway deletion confirmation.</p>
    begin of T_GATEWAY_DELETE,
      "!   The gateway ID of the deleted gateway.
      GATEWAY_ID type STRING,
      "!   The status of the request.
      STATUS type STRING,
    end of T_GATEWAY_DELETE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Training example details.</p>
    begin of T_TRAINING_EXAMPLE,
      "!   The document ID associated with this training example.
      DOCUMENT_ID type STRING,
      "!   The cross reference associated with this training example.
      CROSS_REFERENCE type STRING,
      "!   The relevance of the training example.
      RELEVANCE type INTEGER,
    end of T_TRAINING_EXAMPLE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Training query details.</p>
    begin of T_TRAINING_QUERY,
      "!   The query ID associated with the training query.
      QUERY_ID type STRING,
      "!   The natural text query for the training query.
      NATURAL_LANGUAGE_QUERY type STRING,
      "!   The filter used on the collection before the **natural_language_query** is
      "!    applied.
      FILTER type STRING,
      "!   Array of training examples.
      EXAMPLES type STANDARD TABLE OF T_TRAINING_EXAMPLE WITH NON-UNIQUE DEFAULT KEY,
    end of T_TRAINING_QUERY.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A passage query result.</p>
    begin of T_QUERY_PASSAGES,
      "!   The unique identifier of the document from which the passage has been extracted.
      "!
      DOCUMENT_ID type STRING,
      "!   The confidence score of the passages&apos;s analysis. A higher score indicates
      "!    greater confidence.
      PASSAGE_SCORE type DOUBLE,
      "!   The content of the extracted passage.
      PASSAGE_TEXT type STRING,
      "!   The position of the first character of the extracted passage in the originating
      "!    field.
      START_OFFSET type INTEGER,
      "!   The position of the last character of the extracted passage in the originating
      "!    field.
      END_OFFSET type INTEGER,
      "!   The label of the field from which the passage has been extracted.
      FIELD type STRING,
    end of T_QUERY_PASSAGES.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Object containing normalization operations.</p>
    begin of T_NORMALIZATION_OPERATION,
      "!   Identifies what type of operation to perform. <br/>
      "!   <br/>
      "!   **copy** - Copies the value of the **source_field** to the **destination_field**
      "!    field. If the **destination_field** already exists, then the value of the
      "!    **source_field** overwrites the original value of the **destination_field**.
      "!    <br/>
      "!   <br/>
      "!   **move** - Renames (moves) the **source_field** to the **destination_field**. If
      "!    the **destination_field** already exists, then the value of the
      "!    **source_field** overwrites the original value of the **destination_field**.
      "!    Rename is identical to copy, except that the **source_field** is removed after
      "!    the value has been copied to the **destination_field** (it is the same as a
      "!    _copy_ followed by a _remove_). <br/>
      "!   <br/>
      "!   **merge** - Merges the value of the **source_field** with the value of the
      "!    **destination_field**. The **destination_field** is converted into an array if
      "!    it is not already an array, and the value of the **source_field** is appended
      "!    to the array. This operation removes the **source_field** after the merge. If
      "!    the **source_field** does not exist in the current document, then the
      "!    **destination_field** is still converted into an array (if it is not an array
      "!    already). This conversion ensures the type for **destination_field** is
      "!    consistent across all documents. <br/>
      "!   <br/>
      "!   **remove** - Deletes the **source_field** field. The **destination_field** is
      "!    ignored for this operation. <br/>
      "!   <br/>
      "!   **remove_nulls** - Removes all nested null (blank) field values from the
      "!    ingested document. **source_field** and **destination_field** are ignored by
      "!    this operation because _remove_nulls_ operates on the entire ingested document.
      "!    Typically, **remove_nulls** is invoked as the last normalization operation (if
      "!    it is invoked at all, it can be time-expensive).
      OPERATION type STRING,
      "!   The source field for the operation.
      SOURCE_FIELD type STRING,
      "!   The destination field for the operation.
      DESTINATION_FIELD type STRING,
    end of T_NORMALIZATION_OPERATION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Font matching configuration.</p>
    begin of T_FONT_SETTING,
      "!   The HTML heading level that any content with the matching font is converted to.
      LEVEL type INTEGER,
      "!   The minimum size of the font to match.
      MIN_SIZE type INTEGER,
      "!   The maximum size of the font to match.
      MAX_SIZE type INTEGER,
      "!   When `true`, the font is matched if it is bold.
      BOLD type BOOLEAN,
      "!   When `true`, the font is matched if it is italic.
      ITALIC type BOOLEAN,
      "!   The name of the font.
      NAME type STRING,
    end of T_FONT_SETTING.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Microsoft Word styles to convert into a specified HTML head</p>
    "!     level.
    begin of T_WORD_STYLE,
      "!   HTML head level that content matching this style is tagged with.
      LEVEL type INTEGER,
      "!   Array of word style names to convert.
      NAMES type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
    end of T_WORD_STYLE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Object containing heading detection conversion settings for</p>
    "!     Microsoft Word documents.
    begin of T_WORD_HEADING_DETECTION,
      "!   Array of font matching configurations.
      FONTS type STANDARD TABLE OF T_FONT_SETTING WITH NON-UNIQUE DEFAULT KEY,
      "!   Array of Microsoft Word styles to convert.
      STYLES type STANDARD TABLE OF T_WORD_STYLE WITH NON-UNIQUE DEFAULT KEY,
    end of T_WORD_HEADING_DETECTION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Object containing heading detection conversion settings for</p>
    "!     PDF documents.
    begin of T_PDF_HEADING_DETECTION,
      "!   Array of font matching configurations.
      FONTS type STANDARD TABLE OF T_FONT_SETTING WITH NON-UNIQUE DEFAULT KEY,
    end of T_PDF_HEADING_DETECTION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A list of PDF conversion settings.</p>
    begin of T_PDF_SETTINGS,
      "!   Object containing heading detection conversion settings for PDF documents.
      HEADING type T_PDF_HEADING_DETECTION,
    end of T_PDF_SETTINGS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Object that defines a box folder to crawl with this</p>
    "!     configuration.
    begin of T_SOURCE_OPTIONS_FOLDER,
      "!   The Box user ID of the user who owns the folder to crawl.
      OWNER_USER_ID type STRING,
      "!   The Box folder ID of the folder to crawl.
      FOLDER_ID type STRING,
      "!   The maximum number of documents to crawl for this folder. By default, all
      "!    documents in the folder are crawled.
      LIMIT type INTEGER,
    end of T_SOURCE_OPTIONS_FOLDER.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Object defining a cloud object store bucket to crawl.</p>
    begin of T_SOURCE_OPTIONS_BUCKETS,
      "!   The name of the cloud object store bucket to crawl.
      NAME type STRING,
      "!   The number of documents to crawl from this cloud object store bucket. If not
      "!    specified, all documents in the bucket are crawled.
      LIMIT type INTEGER,
    end of T_SOURCE_OPTIONS_BUCKETS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Object containing the schedule information for the source.</p>
    begin of T_SOURCE_SCHEDULE,
      "!   When `true`, the source is re-crawled based on the **frequency** field in this
      "!    object. When `false` the source is not re-crawled; When `false` and connecting
      "!    to Salesforce the source is crawled annually.
      ENABLED type BOOLEAN,
      "!   The time zone to base source crawl times on. Possible values correspond to the
      "!    IANA (Internet Assigned Numbers Authority) time zones list.
      TIME_ZONE type STRING,
      "!   The crawl schedule in the specified **time_zone**.<br/>
      "!   <br/>
      "!   -  `five_minutes`: Runs every five minutes.<br/>
      "!   -  `hourly`: Runs every hour.<br/>
      "!   -  `daily`: Runs every day between 00:00 and 06:00.<br/>
      "!   -  `weekly`: Runs every week on Sunday between 00:00 and 06:00.<br/>
      "!   -  `monthly`: Runs the on the first Sunday of every month between 00:00 and
      "!    06:00.
      FREQUENCY type STRING,
    end of T_SOURCE_SCHEDULE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Object that defines a Salesforce document object type crawl</p>
    "!     with this configuration.
    begin of T_SOURCE_OPTIONS_OBJECT,
      "!   The name of the Salesforce document object to crawl. For example, `case`.
      NAME type STRING,
      "!   The maximum number of documents to crawl for this document object. By default,
      "!    all documents in the document object are crawled.
      LIMIT type INTEGER,
    end of T_SOURCE_OPTIONS_OBJECT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Object that defines a Microsoft SharePoint site collection</p>
    "!     to crawl with this configuration.
    begin of T_SOURCE_OPTIONS_SITE_COLL,
      "!   The Microsoft SharePoint Online site collection path to crawl. The path must be
      "!    be relative to the **organization_url** that was specified in the credentials
      "!    associated with this source configuration.
      SITE_COLLECTION_PATH1 type STRING,
      "!   The maximum number of documents to crawl for this site collection. By default,
      "!    all documents in the site collection are crawled.
      LIMIT type INTEGER,
    end of T_SOURCE_OPTIONS_SITE_COLL.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The **options** object defines which items to crawl from the</p>
    "!     source system.
    begin of T_SOURCE_OPTIONS,
      "!   Array of folders to crawl from the Box source. Only valid, and required, when
      "!    the **type** field of the **source** object is set to `box`.
      FOLDERS type STANDARD TABLE OF T_SOURCE_OPTIONS_FOLDER WITH NON-UNIQUE DEFAULT KEY,
      "!   Array of Salesforce document object types to crawl from the Salesforce source.
      "!    Only valid, and required, when the **type** field of the **source** object is
      "!    set to `salesforce`.
      OBJECTS type STANDARD TABLE OF T_SOURCE_OPTIONS_OBJECT WITH NON-UNIQUE DEFAULT KEY,
      "!   Array of Microsoft SharePointoint Online site collections to crawl from the
      "!    SharePoint source. Only valid and required when the **type** field of the
      "!    **source** object is set to `sharepoint`.
      SITE_COLLECTIONS type STANDARD TABLE OF T_SOURCE_OPTIONS_SITE_COLL WITH NON-UNIQUE DEFAULT KEY,
      "!   Array of Web page URLs to begin crawling the web from. Only valid and required
      "!    when the **type** field of the **source** object is set to `web_crawl`.
      URLS type STANDARD TABLE OF T_SOURCE_OPTIONS_WEB_CRAWL WITH NON-UNIQUE DEFAULT KEY,
      "!   Array of cloud object store buckets to begin crawling. Only valid and required
      "!    when the **type** field of the **source** object is set to
      "!    `cloud_object_store`, and the **crawl_all_buckets** field is `false` or not
      "!    specified.
      BUCKETS type STANDARD TABLE OF T_SOURCE_OPTIONS_BUCKETS WITH NON-UNIQUE DEFAULT KEY,
      "!   When `true`, all buckets in the specified cloud object store are crawled. If set
      "!    to `true`, the **buckets** array must not be specified.
      CRAWL_ALL_BUCKETS type BOOLEAN,
    end of T_SOURCE_OPTIONS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Object containing source parameters for the configuration.</p>
    begin of T_SOURCE,
      "!   The type of source to connect to.<br/>
      "!   -  `box` indicates the configuration is to connect an instance of Enterprise
      "!    Box.<br/>
      "!   -  `salesforce` indicates the configuration is to connect to Salesforce.<br/>
      "!   -  `sharepoint` indicates the configuration is to connect to Microsoft
      "!    SharePoint Online.<br/>
      "!   -  `web_crawl` indicates the configuration is to perform a web page crawl.<br/>
      "!   -  `cloud_object_storage` indicates the configuration is to connect to a cloud
      "!    object store.
      TYPE type STRING,
      "!   The **credential_id** of the credentials to use to connect to the source.
      "!    Credentials are defined using the **credentials** method. The **source_type**
      "!    of the credentials used must match the **type** field specified in this object.
      "!
      CREDENTIAL_ID type STRING,
      "!   Object containing the schedule information for the source.
      SCHEDULE type T_SOURCE_SCHEDULE,
      "!   The **options** object defines which items to crawl from the source system.
      OPTIONS type T_SOURCE_OPTIONS,
    end of T_SOURCE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Object containing an array of XPaths.</p>
    begin of T_XPATH_PATTERNS,
      "!   An array to XPaths.
      XPATHS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
    end of T_XPATH_PATTERNS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Options which are specific to a particular enrichment.</p>
    begin of T_ENRICHMENT_OPTIONS,
      "!   Object containing Natural Language Understanding features to be used.
      FEATURES type T_NLU_ENRICHMENT_FEATURES,
      "!   ISO 639-1 code indicating the language to use for the analysis. This code
      "!    overrides the automatic language detection performed by the service. Valid
      "!    codes are `ar` (Arabic), `en` (English), `fr` (French), `de` (German), `it`
      "!    (Italian), `pt` (Portuguese), `ru` (Russian), `es` (Spanish), and `sv`
      "!    (Swedish). **Note:** Not all features support all languages, automatic
      "!    detection is recommended.
      LANGUAGE type STRING,
      "!   *For use with `elements` enrichments only.* The element extraction model to use.
      "!    Models available are: `contract`.
      MODEL type STRING,
    end of T_ENRICHMENT_OPTIONS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Enrichment step to perform on the document. Each enrichment</p>
    "!     is performed on the specified field in the order that they are listed in the
    "!     configuration.
    begin of T_ENRICHMENT,
      "!   Describes what the enrichment step does.
      DESCRIPTION type STRING,
      "!   Field where enrichments will be stored. This field must already exist or be at
      "!    most 1 level deeper than an existing field. For example, if `text` is a
      "!    top-level field with no sub-fields, `text.foo` is a valid destination but
      "!    `text.foo.bar` is not.
      DESTINATION_FIELD type STRING,
      "!   Field to be enriched.<br/>
      "!   <br/>
      "!   Arrays can be specified as the **source_field** if the **enrichment** service
      "!    for this enrichment is set to `natural_language_undstanding`.
      SOURCE_FIELD type STRING,
      "!   Indicates that the enrichments will overwrite the destination_field field if it
      "!    already exists.
      OVERWRITE type BOOLEAN,
      "!   Name of the enrichment service to call. Current options are
      "!    `natural_language_understanding` and `elements`.<br/>
      "!   <br/>
      "!    When using `natual_language_understanding`, the **options** object must contain
      "!    Natural Language Understanding options.<br/>
      "!   <br/>
      "!    When using `elements` the **options** object must contain Element
      "!    Classification options. Additionally, when using the `elements` enrichment the
      "!    configuration specified and files ingested must meet all the criteria specified
      "!    in [the
      "!    documentation](https://cloud.ibm.com/docs/services/discovery?topic=discovery-el
      "!   ement-classification#element-classification).
      ENRICHMENT type STRING,
      "!   If true, then most errors generated during the enrichment process will be
      "!    treated as warnings and will not cause the document to fail processing.
      IGNORE_DOWNSTREAM_ERRORS type BOOLEAN,
      "!   Options which are specific to a particular enrichment.
      OPTIONS type T_ENRICHMENT_OPTIONS,
    end of T_ENRICHMENT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A list of Document Segmentation settings.</p>
    begin of T_SEGMENT_SETTINGS,
      "!   Enables/disables the Document Segmentation feature.
      ENABLED type BOOLEAN,
      "!   Defines the heading level that splits into document segments. Valid values are
      "!    h1, h2, h3, h4, h5, h6. The content of the header field that the segmentation
      "!    splits at is used as the **title** field for that segmented result. Only valid
      "!    if used with a collection that has **enabled** set to `false` in the
      "!    **smart_document_understanding** object.
      SELECTOR_TAGS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   Defines the annotated smart document understanding fields that the document is
      "!    split on. The content of the annotated field that the segmentation splits at is
      "!    used as the **title** field for that segmented result. For example, if the
      "!    field `sub-title` is specified, when a document is uploaded each time the smart
      "!    documement understanding conversion encounters a field of type `sub-title` the
      "!    document is split at that point and the content of the field used as the title
      "!    of the remaining content. Thnis split is performed for all instances of the
      "!    listed fields in the uploaded document. Only valid if used with a collection
      "!    that has **enabled** set to `true` in the **smart_document_understanding**
      "!    object.
      ANNOTATED_FIELDS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
    end of T_SEGMENT_SETTINGS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A list of Word conversion settings.</p>
    begin of T_WORD_SETTINGS,
      "!   Object containing heading detection conversion settings for Microsoft Word
      "!    documents.
      HEADING type T_WORD_HEADING_DETECTION,
    end of T_WORD_SETTINGS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A list of HTML conversion settings.</p>
    begin of T_HTML_SETTINGS,
      "!   Array of HTML tags that are excluded completely.
      EXCLUDE_TAGS_COMPLETELY type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   Array of HTML tags which are excluded but still retain content.
      EXCLUDE_TAGS_KEEP_CONTENT type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   Object containing an array of XPaths.
      KEEP_CONTENT type T_XPATH_PATTERNS,
      "!   Object containing an array of XPaths.
      EXCLUDE_CONTENT type T_XPATH_PATTERNS,
      "!   An array of HTML tag attributes to keep in the converted document.
      KEEP_TAG_ATTRIBUTES type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   Array of HTML tag attributes to exclude.
      EXCLUDE_TAG_ATTRIBUTES type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
    end of T_HTML_SETTINGS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Document conversion settings.</p>
    begin of T_CONVERSIONS,
      "!   A list of PDF conversion settings.
      PDF type T_PDF_SETTINGS,
      "!   A list of Word conversion settings.
      WORD type T_WORD_SETTINGS,
      "!   A list of HTML conversion settings.
      HTML type T_HTML_SETTINGS,
      "!   A list of Document Segmentation settings.
      SEGMENT type T_SEGMENT_SETTINGS,
      "!   Defines operations that can be used to transform the final output JSON into a
      "!    normalized form. Operations are executed in the order that they appear in the
      "!    array.
      JSON_NORMALIZATIONS type STANDARD TABLE OF T_NORMALIZATION_OPERATION WITH NON-UNIQUE DEFAULT KEY,
      "!   When `true`, automatic text extraction from images (this includes images
      "!    embedded in supported document formats, for example PDF, and suppported image
      "!    formats, for example TIFF) is performed on documents uploaded to the
      "!    collection. This field is supported on **Advanced** and higher plans only.
      "!    **Lite** plans do not support image text recognition.
      IMAGE_TEXT_RECOGNITION type BOOLEAN,
    end of T_CONVERSIONS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A custom configuration for the environment.</p>
    begin of T_CONFIGURATION,
      "!   The unique identifier of the configuration.
      CONFIGURATION_ID type STRING,
      "!   The name of the configuration.
      NAME type STRING,
      "!   The creation date of the configuration in the format
      "!    yyyy-MM-dd&apos;T&apos;HH:mm:ss.SSS&apos;Z&apos;.
      CREATED type DATETIME,
      "!   The timestamp of when the configuration was last updated in the format
      "!    yyyy-MM-dd&apos;T&apos;HH:mm:ss.SSS&apos;Z&apos;.
      UPDATED type DATETIME,
      "!   The description of the configuration, if available.
      DESCRIPTION type STRING,
      "!   Document conversion settings.
      CONVERSIONS type T_CONVERSIONS,
      "!   An array of document enrichment settings for the configuration.
      ENRICHMENTS type STANDARD TABLE OF T_ENRICHMENT WITH NON-UNIQUE DEFAULT KEY,
      "!   Defines operations that can be used to transform the final output JSON into a
      "!    normalized form. Operations are executed in the order that they appear in the
      "!    array.
      NORMALIZATIONS type STANDARD TABLE OF T_NORMALIZATION_OPERATION WITH NON-UNIQUE DEFAULT KEY,
      "!   Object containing source parameters for the configuration.
      SOURCE type T_SOURCE,
    end of T_CONFIGURATION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Object containing an array of available configurations.</p>
    begin of T_LIST_CONFIGURATIONS_RESPONSE,
      "!   An array of configurations that are available for the service instance.
      CONFIGURATIONS type STANDARD TABLE OF T_CONFIGURATION WITH NON-UNIQUE DEFAULT KEY,
    end of T_LIST_CONFIGURATIONS_RESPONSE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Object containing source crawl status information.</p>
    begin of T_SOURCE_STATUS,
      "!   The current status of the source crawl for this collection. This field returns
      "!    `not_configured` if the default configuration for this source does not have a
      "!    **source** object defined.<br/>
      "!   <br/>
      "!   -  `running` indicates that a crawl to fetch more documents is in progress.<br/>
      "!   -  `complete` indicates that the crawl has completed with no errors.<br/>
      "!   -  `queued` indicates that the crawl has been paused by the system and will
      "!    automatically restart when possible.<br/>
      "!   -  `unknown` indicates that an unidentified error has occured in the service.
      STATUS type STRING,
      "!   Date in `RFC 3339` format indicating the time of the next crawl attempt.
      NEXT_CRAWL type DATETIME,
    end of T_SOURCE_STATUS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Object returned after credentials are deleted.</p>
    begin of T_DELETE_CREDENTIALS,
      "!   The unique identifier of the credentials that have been deleted.
      CREDENTIAL_ID type STRING,
      "!   The status of the deletion request.
      STATUS type STRING,
    end of T_DELETE_CREDENTIALS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A notice produced for the collection.</p>
    begin of T_NOTICE,
      "!   Identifies the notice. Many notices might have the same ID. This field exists so
      "!    that user applications can programmatically identify a notice and take
      "!    automatic corrective action. Typical notice IDs include: `index_failed`,
      "!    `index_failed_too_many_requests`, `index_failed_incompatible_field`,
      "!    `index_failed_cluster_unavailable`, `ingestion_timeout`, `ingestion_error`,
      "!    `bad_request`, `internal_error`, `missing_model`, `unsupported_model`,
      "!    `smart_document_understanding_failed_incompatible_field`,
      "!    `smart_document_understanding_failed_internal_error`,
      "!    `smart_document_understanding_failed_internal_error`,
      "!    `smart_document_understanding_failed_warning`,
      "!    `smart_document_understanding_page_error`,
      "!    `smart_document_understanding_page_warning`. **Note:** This is not a complete
      "!    list, other values might be returned.
      NOTICE_ID type STRING,
      "!   The creation date of the collection in the format
      "!    yyyy-MM-dd&apos;T&apos;HH:mm:ss.SSS&apos;Z&apos;.
      CREATED type DATETIME,
      "!   Unique identifier of the document.
      DOCUMENT_ID type STRING,
      "!   Unique identifier of the query used for relevance training.
      QUERY_ID type STRING,
      "!   Severity level of the notice.
      SEVERITY type STRING,
      "!   Ingestion or training step in which the notice occurred. Typical step values
      "!    include: `classify_elements`, `smartDocumentUnderstanding`, `ingestion`,
      "!    `indexing`, `convert`. **Note:** This is not a complete list, other values
      "!    might be returned.
      STEP type STRING,
      "!   The description of the notice.
      DESCRIPTION type STRING,
    end of T_NOTICE.
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
      "!   Array of notices produced by the document-ingestion process.
      NOTICES type STANDARD TABLE OF T_NOTICE WITH NON-UNIQUE DEFAULT KEY,
    end of T_DOCUMENT_ACCEPTED.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Object describing a specific gateway.</p>
    begin of T_GATEWAY,
      "!   The gateway ID of the gateway.
      GATEWAY_ID type STRING,
      "!   The user defined name of the gateway.
      NAME type STRING,
      "!   The current status of the gateway. `connected` means the gateway is connected to
      "!    the remotly installed gateway. `idle` means this gateway is not currently in
      "!    use.
      STATUS type STRING,
      "!   The generated **token** for this gateway. The value of this field is used when
      "!    configuring the remotly installed gateway.
      TOKEN type STRING,
      "!   The generated **token_id** for this gateway. The value of this field is used
      "!    when configuring the remotly installed gateway.
      TOKEN_ID type STRING,
    end of T_GATEWAY.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Aggregation result data for the requested metric.</p>
    begin of T_METRIC_AGGREGATION_RESULT,
      "!   Date in string form representing the start of this interval.
      KEY_AS_STRING type DATETIME,
      "!   Unix epoch time equivalent of the **key_as_string**, that represents the start
      "!    of this interval.
      KEY type LONG,
      "!   Number of matching results.
      MATCHING_RESULTS type INTEGER,
      "!   The number of queries with associated events divided by the total number of
      "!    queries for the interval. Only returned with **event_rate** metrics.
      EVENT_RATE type DOUBLE,
    end of T_METRIC_AGGREGATION_RESULT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An aggregation analyzing log information for queries and</p>
    "!     events.
    begin of T_METRIC_AGGREGATION,
      "!   The measurement interval for this metric. Metric intervals are always 1 day
      "!    (`1d`).
      INTERVAL type STRING,
      "!   The event type associated with this metric result. This field, when present,
      "!    will always be `click`.
      EVENT_TYPE type STRING,
      "!   Array of metric aggregation query results.
      RESULTS type STANDARD TABLE OF T_METRIC_AGGREGATION_RESULT WITH NON-UNIQUE DEFAULT KEY,
    end of T_METRIC_AGGREGATION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The response generated from a call to a **metrics** method.</p>
    begin of T_METRIC_RESPONSE,
      "!   Array of metric aggregations.
      AGGREGATIONS type STANDARD TABLE OF T_METRIC_AGGREGATION WITH NON-UNIQUE DEFAULT KEY,
    end of T_METRIC_RESPONSE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Metadata of a query result.</p>
    begin of T_QUERY_RESULT_METADATA,
      "!   An unbounded measure of the relevance of a particular result, dependent on the
      "!    query and matching document. A higher score indicates a greater match to the
      "!    query parameters.
      SCORE type DOUBLE,
      "!   The confidence score for the given result. Calculated based on how relevant the
      "!    result is estimated to be. confidence can range from `0.0` to `1.0`. The higher
      "!    the number, the more relevant the document. The `confidence` value for a result
      "!    was calculated using the model specified in the `document_retrieval_strategy`
      "!    field of the result set.
      CONFIDENCE type DOUBLE,
    end of T_QUERY_RESULT_METADATA.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Query result object.</p>
    begin of T_QUERY_NOTICES_RESULT,
      "!   The unique identifier of the document.
      ID type STRING,
      "!   Metadata of the document.
      METADATA type MAP,
      "!   The collection ID of the collection containing the document for this result.
      COLLECTION_ID type STRING,
      "!   Metadata of a query result.
      RESULT_METADATA type T_QUERY_RESULT_METADATA,
      "!   The internal status code returned by the ingestion subsystem indicating the
      "!    overall result of ingesting the source document.
      CODE type INTEGER,
      "!   Name of the original source file (if available).
      FILENAME type STRING,
      "!   The type of the original source file.
      FILE_TYPE type STRING,
      "!   The SHA-1 hash of the original source file (formatted as a hexadecimal string).
      SHA1 type STRING,
      "!   Array of notices for the document.
      NOTICES type STANDARD TABLE OF T_NOTICE WITH NON-UNIQUE DEFAULT KEY,
    end of T_QUERY_NOTICES_RESULT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Each object in the **results** array corresponds to an</p>
    "!     individual document returned by the original query.
    begin of T_LOG_QRY_RESP_RSLT_DOCS_RSLT,
      "!   The result rank of this document. A position of `1` indicates that it was the
      "!    first returned result.
      POSITION type INTEGER,
      "!   The **document_id** of the document that this result represents.
      DOCUMENT_ID type STRING,
      "!   The raw score of this result. A higher score indicates a greater match to the
      "!    query parameters.
      SCORE type DOUBLE,
      "!   The confidence score of the result&apos;s analysis. A higher score indicating
      "!    greater confidence.
      CONFIDENCE type DOUBLE,
      "!   The **collection_id** of the document represented by this result.
      COLLECTION_ID type STRING,
    end of T_LOG_QRY_RESP_RSLT_DOCS_RSLT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Object containing result information that was returned by</p>
    "!     the query used to create this log entry. Only returned with logs of type
    "!     `query`.
    begin of T_LOG_QUERY_RESP_RESULT_DOCS,
      "!   Array of log query response results.
      RESULTS type STANDARD TABLE OF T_LOG_QRY_RESP_RSLT_DOCS_RSLT WITH NON-UNIQUE DEFAULT KEY,
      "!   The number of results returned in the query associate with this log.
      COUNT type INTEGER,
    end of T_LOG_QUERY_RESP_RESULT_DOCS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Object containing field details.</p>
    begin of T_FIELD,
      "!   The name of the field.
      FIELD type STRING,
      "!   The type of the field.
      TYPE type STRING,
    end of T_FIELD.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Query event data object.</p>
    begin of T_EVENT_DATA,
      "!   The **environment_id** associated with the query that the event is associated
      "!    with.
      ENVIRONMENT_ID type STRING,
      "!   The session token that was returned as part of the query results that this event
      "!    is associated with.
      SESSION_TOKEN type STRING,
      "!   The optional timestamp for the event that was created. If not provided, the time
      "!    that the event was created in the log was used.
      CLIENT_TIMESTAMP type DATETIME,
      "!   The rank of the result item which the event is associated with.
      DISPLAY_RANK type INTEGER,
      "!   The **collection_id** of the document that this event is associated with.
      COLLECTION_ID type STRING,
      "!   The **document_id** of the document that this event is associated with.
      DOCUMENT_ID type STRING,
      "!   The query identifier stored in the log. The query and any events associated with
      "!    that query are stored with the same **query_id**.
      QUERY_ID type STRING,
    end of T_EVENT_DATA.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object defining the event being created.</p>
    begin of T_CREATE_EVENT_OBJECT,
      "!   The event type to be created.
      TYPE type STRING,
      "!   Query event data object.
      DATA type T_EVENT_DATA,
    end of T_CREATE_EVENT_OBJECT.
  types:
    "! No documentation available.
    begin of T_NESTED,
      "!   The area of the results the aggregation was restricted to.
      PATH type STRING,
    end of T_NESTED.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Object that describes a long query.</p>
    begin of T_QUERY_LARGE,
      "!   A cacheable query that excludes documents that don&apos;t mention the query
      "!    content. Filter searches are better for metadata-type searches and for
      "!    assessing the concepts in the data set.
      FILTER type STRING,
      "!   A query search returns all documents in your data set with full enrichments and
      "!    full text, but with the most relevant documents listed first. Use a query
      "!    search when you want to find the most relevant search results.
      QUERY type STRING,
      "!   A natural language query that returns relevant documents by utilizing training
      "!    data and natural language understanding.
      NATURAL_LANGUAGE_QUERY type STRING,
      "!   A passages query that returns the most relevant passages from the results.
      PASSAGES type BOOLEAN,
      "!   An aggregation search that returns an exact answer by combining query search
      "!    with filters. Useful for applications to build lists, tables, and time series.
      "!    For a full list of possible aggregations, see the Query reference.
      AGGREGATION type STRING,
      "!   Number of results to return.
      COUNT type INTEGER,
      "!   A comma-separated list of the portion of the document hierarchy to return.
      RETURN type STRING,
      "!   The number of query results to skip at the beginning. For example, if the total
      "!    number of results that are returned is 10 and the offset is 8, it returns the
      "!    last two results.
      OFFSET type INTEGER,
      "!   A comma-separated list of fields in the document to sort on. You can optionally
      "!    specify a sort direction by prefixing the field with `-` for descending or `+`
      "!    for ascending. Ascending is the default sort direction if no prefix is
      "!    specified. This parameter cannot be used in the same query as the **bias**
      "!    parameter.
      SORT type STRING,
      "!   When true, a highlight field is returned for each result which contains the
      "!    fields which match the query with `&lt;em&gt;&lt;/em&gt;` tags around the
      "!    matching query terms.
      HIGHLIGHT type BOOLEAN,
      "!   A comma-separated list of fields that passages are drawn from. If this parameter
      "!    not specified, then all top-level fields are included.
      PASSAGES_FIELDS type STRING,
      "!   The maximum number of passages to return. The search returns fewer passages if
      "!    the requested total is not found. The default is `10`. The maximum is `100`.
      PASSAGES_COUNT type INTEGER,
      "!   The approximate number of characters that any one passage will have.
      PASSAGES_CHARACTERS type INTEGER,
      "!   When `true`, and used with a Watson Discovery News collection, duplicate results
      "!    (based on the contents of the **title** field) are removed. Duplicate
      "!    comparison is limited to the current query only; **offset** is not considered.
      "!    This parameter is currently Beta functionality.
      DEDUPLICATE type BOOLEAN,
      "!   When specified, duplicate results based on the field specified are removed from
      "!    the returned results. Duplicate comparison is limited to the current query
      "!    only, **offset** is not considered. This parameter is currently Beta
      "!    functionality.
      DEDUPLICATE_FIELD type STRING,
      "!   When `true`, results are returned based on their similarity to the document IDs
      "!    specified in the **similar.document_ids** parameter.
      SIMILAR type BOOLEAN,
      "!   A comma-separated list of document IDs to find similar documents.<br/>
      "!   <br/>
      "!   **Tip:** Include the **natural_language_query** parameter to expand the scope of
      "!    the document similarity search with the natural language query. Other query
      "!    parameters, such as **filter** and **query**, are subsequently applied and
      "!    reduce the scope.
      SIMILAR_DOCUMENT_IDS type STRING,
      "!   A comma-separated list of field names that are used as a basis for comparison to
      "!    identify similar documents. If not specified, the entire document is used for
      "!    comparison.
      SIMILAR_FIELDS type STRING,
      "!   Field which the returned results will be biased against. The specified field
      "!    must be either a **date** or **number** format. When a **date** type field is
      "!    specified returned results are biased towards field values closer to the
      "!    current date. When a **number** type field is specified, returned results are
      "!    biased towards higher field values. This parameter cannot be used in the same
      "!    query as the **sort** parameter.
      BIAS type STRING,
    end of T_QUERY_LARGE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Object containing user-defined name.</p>
    begin of T_GATEWAY_NAME,
      "!   User-defined name.
      NAME type STRING,
    end of T_GATEWAY_NAME.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Object containing collection document count information.</p>
    begin of T_DOCUMENT_COUNTS,
      "!   The total number of available documents in the collection.
      AVAILABLE type LONG,
      "!   The number of documents in the collection that are currently being processed.
      PROCESSING type LONG,
      "!   The number of documents in the collection that failed to be ingested.
      FAILED type LONG,
      "!   The number of documents that have been uploaded to the collection, but have not
      "!    yet started processing.
      PENDING type LONG,
    end of T_DOCUMENT_COUNTS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about custom smart document understanding fields</p>
    "!     that exist in this collection.
    begin of T_SDU_STATUS_CUSTOM_FIELDS,
      "!   The number of custom fields defined for this collection.
      DEFINED type LONG,
      "!   The maximum number of custom fields that are allowed in this collection.
      MAXIMUM_ALLOWED type LONG,
    end of T_SDU_STATUS_CUSTOM_FIELDS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Object containing smart document understanding information</p>
    "!     for this collection.
    begin of T_SDU_STATUS,
      "!   When `true`, smart document understanding conversion is enabled for this
      "!    collection. All collections created with a version date after `2019-04-30` have
      "!    smart document understanding enabled. If `false`, documents added to the
      "!    collection are converted using the **conversion** settings specified in the
      "!    configuration associated with the collection.
      ENABLED type BOOLEAN,
      "!   The total number of pages annotated using smart document understanding in this
      "!    collection.
      TOTAL_ANNOTATED_PAGES type LONG,
      "!   The current number of pages that can be used for training smart document
      "!    understanding. The `total_pages` number is calculated as the total number of
      "!    pages identified from the documents listed in the **total_documents** field.
      TOTAL_PAGES type LONG,
      "!   The total number of documents in this collection that can be used to train smart
      "!    document understanding. For **lite** plan collections, the maximum is the first
      "!    20 uploaded documents (not including HTML or JSON documents). For other plans,
      "!    the maximum is the first 40 uploaded documents (not including HTML or JSON
      "!    documents). When the maximum is reached, additional documents uploaded to the
      "!    collection are not considered for training smart document understanding.
      TOTAL_DOCUMENTS type LONG,
      "!   Information about custom smart document understanding fields that exist in this
      "!    collection.
      CUSTOM_FIELDS type T_SDU_STATUS_CUSTOM_FIELDS,
    end of T_SDU_STATUS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Object containing information about the crawl status of this</p>
    "!     collection.
    begin of T_COLLECTION_CRAWL_STATUS,
      "!   Object containing source crawl status information.
      SOURCE_CRAWL type T_SOURCE_STATUS,
    end of T_COLLECTION_CRAWL_STATUS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Summary of the disk usage statistics for this collection.</p>
    begin of T_COLLECTION_DISK_USAGE,
      "!   Number of bytes used by the collection.
      USED_BYTES type INTEGER,
    end of T_COLLECTION_DISK_USAGE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A collection for storing documents.</p>
    begin of T_COLLECTION,
      "!   The unique identifier of the collection.
      COLLECTION_ID type STRING,
      "!   The name of the collection.
      NAME type STRING,
      "!   The description of the collection.
      DESCRIPTION type STRING,
      "!   The creation date of the collection in the format
      "!    yyyy-MM-dd&apos;T&apos;HH:mmcon:ss.SSS&apos;Z&apos;.
      CREATED type DATETIME,
      "!   The timestamp of when the collection was last updated in the format
      "!    yyyy-MM-dd&apos;T&apos;HH:mm:ss.SSS&apos;Z&apos;.
      UPDATED type DATETIME,
      "!   The status of the collection.
      STATUS type STRING,
      "!   The unique identifier of the collection&apos;s configuration.
      CONFIGURATION_ID type STRING,
      "!   The language of the documents stored in the collection. Permitted values include
      "!    `en` (English), `de` (German), and `es` (Spanish).
      LANGUAGE type STRING,
      "!   Object containing collection document count information.
      DOCUMENT_COUNTS type T_DOCUMENT_COUNTS,
      "!   Summary of the disk usage statistics for this collection.
      DISK_USAGE type T_COLLECTION_DISK_USAGE,
      "!   Training status details.
      TRAINING_STATUS type T_TRAINING_STATUS,
      "!   Object containing information about the crawl status of this collection.
      CRAWL_STATUS type T_COLLECTION_CRAWL_STATUS,
      "!   Object containing smart document understanding information for this collection.
      SMART_DOCUMENT_UNDERSTANDING type T_SDU_STATUS,
    end of T_COLLECTION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Array of Microsoft Word styles to convert.</p>
      T_WORD_STYLES type STANDARD TABLE OF T_WORD_STYLE WITH NON-UNIQUE DEFAULT KEY.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object representing the configuration options to use for</p>
    "!     the `elements` enrichment.
    begin of T_ELEMENTS_ENRICHMENT_OPTIONS,
      "!   *For use with `elements` enrichments only.* The element extraction model to use.
      "!    Models available are: `contract`.
      MODEL type STRING,
    end of T_ELEMENTS_ENRICHMENT_OPTIONS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Object containing information about a new environment.</p>
    begin of T_CREATE_ENVIRONMENT_REQUEST,
      "!   Name that identifies the environment.
      NAME type STRING,
      "!   Description of the environment.
      DESCRIPTION type STRING,
      "!   Size of the environment. In the Lite plan the default and only accepted value is
      "!    `LT`, in all other plans the default is `S`.
      SIZE type STRING,
    end of T_CREATE_ENVIRONMENT_REQUEST.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Object containing specification for a new collection.</p>
    begin of T_CREATE_COLLECTION_REQUEST,
      "!   The name of the collection to be created.
      NAME type STRING,
      "!   A description of the collection.
      DESCRIPTION type STRING,
      "!   The ID of the configuration in which the collection is to be created.
      CONFIGURATION_ID type STRING,
      "!   The language of the documents stored in the collection, in the form of an ISO
      "!    639-1 language code.
      LANGUAGE type STRING,
    end of T_CREATE_COLLECTION_REQUEST.
  types:
    "! No documentation available.
    begin of T_INLINE_OBJECT,
      "!   The content of the stopword list to ingest.
      STOPWORD_FILE type FILE,
    end of T_INLINE_OBJECT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Query result object.</p>
    begin of T_QUERY_RESULT,
      "!   The unique identifier of the document.
      ID type STRING,
      "!   Metadata of the document.
      METADATA type MAP,
      "!   The collection ID of the collection containing the document for this result.
      COLLECTION_ID type STRING,
      "!   Metadata of a query result.
      RESULT_METADATA type T_QUERY_RESULT_METADATA,
    end of T_QUERY_RESULT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Top hit information for this query.</p>
    begin of T_TOP_HITS_RESULTS,
      "!   Number of matching results.
      MATCHING_RESULTS type INTEGER,
      "!   Top results returned by the aggregation.
      HITS type STANDARD TABLE OF T_QUERY_RESULT WITH NON-UNIQUE DEFAULT KEY,
    end of T_TOP_HITS_RESULTS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Response object returned when deleting a colleciton.</p>
    begin of T_DELETE_COLLECTION_RESPONSE,
      "!   The unique identifier of the collection that is being deleted.
      COLLECTION_ID type STRING,
      "!   The status of the collection. The status of a successful deletion operation is
      "!    `deleted`.
      STATUS type STRING,
    end of T_DELETE_COLLECTION_RESPONSE.
  types:
    "! No documentation available.
    begin of T_TERM,
      "!   The field where the aggregation is located in the document.
      FIELD type STRING,
      "!   The number of terms identified.
      COUNT type INTEGER,
    end of T_TERM.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object containing an array of autocompletion suggestions.</p>
    begin of T_COMPLETIONS,
      "!   Array of autcomplete suggestion based on the provided prefix.
      COMPLETIONS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
    end of T_COMPLETIONS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object contain retrieval type information.</p>
    begin of T_RETRIEVAL_DETAILS,
      "!   Indentifies the document retrieval strategy used for this query.
      "!    `relevancy_training` indicates that the results were returned using a relevancy
      "!    trained model. `continuous_relevancy_training` indicates that the results were
      "!    returned using the continuous relevancy training model created by result
      "!    feedback analysis. `untrained` means the results were returned using the
      "!    standard untrained model.<br/>
      "!   <br/>
      "!    **Note**: In the event of trained collections being queried, but the trained
      "!    model is not used to return results, the **document_retrieval_strategy** will
      "!    be listed as `untrained`.
      DOCUMENT_RETRIEVAL_STRATEGY type STRING,
    end of T_RETRIEVAL_DETAILS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Response object returned when deleting an environment.</p>
    begin of T_DELETE_ENVIRONMENT_RESPONSE,
      "!   The unique identifier for the environment.
      ENVIRONMENT_ID type STRING,
      "!   Status of the environment.
      STATUS type STRING,
    end of T_DELETE_ENVIRONMENT_RESPONSE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The list of fetched fields.</p><br/>
    "!    <br/>
    "!    The fields are returned using a fully qualified name format, however, the format
    "!     differs slightly from that used by the query operations.<br/>
    "!    <br/>
    "!      * Fields which contain nested JSON objects are assigned a type of
    "!     &quot;nested&quot;.<br/>
    "!    <br/>
    "!      * Fields which belong to a nested object are prefixed with `.properties` (for
    "!     example, `warnings.properties.severity` means that the `warnings` object has a
    "!     property called `severity`).<br/>
    "!    <br/>
    "!      * Fields returned from the News collection are prefixed with
    "!     `v&#123;N&#125;-fullnews-t3-&#123;YEAR&#125;.mappings` (for example,
    "!     `v5-fullnews-t3-2016.mappings.text.properties.author`).
    begin of T_LST_COLLECTION_FIELDS_RESP,
      "!   An array containing information about each field in the collections.
      FIELDS type STANDARD TABLE OF T_FIELD WITH NON-UNIQUE DEFAULT KEY,
    end of T_LST_COLLECTION_FIELDS_RESP.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Object containing collection update information.</p>
    begin of T_UPDATE_COLLECTION_REQUEST,
      "!   The name of the collection.
      NAME type STRING,
      "!   A description of the collection.
      DESCRIPTION type STRING,
      "!   The ID of the configuration in which the collection is to be updated.
      CONFIGURATION_ID type STRING,
    end of T_UPDATE_COLLECTION_REQUEST.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Object containing gateways array.</p>
    begin of T_GATEWAY_LIST,
      "!   Array of configured gateway connections.
      GATEWAYS type STANDARD TABLE OF T_GATEWAY WITH NON-UNIQUE DEFAULT KEY,
    end of T_GATEWAY_LIST.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Aggregation result data for the requested metric.</p>
    begin of T_METRIC_TOKEN_AGGR_RESULT,
      "!   The content of the **natural_language_query** parameter used in the query that
      "!    this result represents.
      KEY type STRING,
      "!   Number of matching results.
      MATCHING_RESULTS type INTEGER,
      "!   The number of queries with associated events divided by the total number of
      "!    queries currently stored (queries and events are stored in the log for 30
      "!    days).
      EVENT_RATE type DOUBLE,
    end of T_METRIC_TOKEN_AGGR_RESULT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An aggregation analyzing log information for queries and</p>
    "!     events.
    begin of T_METRIC_TOKEN_AGGREGATION,
      "!   The event type associated with this metric result. This field, when present,
      "!    will always be `click`.
      EVENT_TYPE type STRING,
      "!   Array of results for the metric token aggregation.
      RESULTS type STANDARD TABLE OF T_METRIC_TOKEN_AGGR_RESULT WITH NON-UNIQUE DEFAULT KEY,
    end of T_METRIC_TOKEN_AGGREGATION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Object that describes a long query.</p>
    begin of T_COLL_QUERY_LARGE,
      "!   A cacheable query that excludes documents that don&apos;t mention the query
      "!    content. Filter searches are better for metadata-type searches and for
      "!    assessing the concepts in the data set.
      FILTER type STRING,
      "!   A query search returns all documents in your data set with full enrichments and
      "!    full text, but with the most relevant documents listed first. Use a query
      "!    search when you want to find the most relevant search results.
      QUERY type STRING,
      "!   A natural language query that returns relevant documents by utilizing training
      "!    data and natural language understanding.
      NATURAL_LANGUAGE_QUERY type STRING,
      "!   A passages query that returns the most relevant passages from the results.
      PASSAGES type BOOLEAN,
      "!   An aggregation search that returns an exact answer by combining query search
      "!    with filters. Useful for applications to build lists, tables, and time series.
      "!    For a full list of possible aggregations, see the Query reference.
      AGGREGATION type STRING,
      "!   Number of results to return.
      COUNT type INTEGER,
      "!   A comma-separated list of the portion of the document hierarchy to return.
      RETURN type STRING,
      "!   The number of query results to skip at the beginning. For example, if the total
      "!    number of results that are returned is 10 and the offset is 8, it returns the
      "!    last two results.
      OFFSET type INTEGER,
      "!   A comma-separated list of fields in the document to sort on. You can optionally
      "!    specify a sort direction by prefixing the field with `-` for descending or `+`
      "!    for ascending. Ascending is the default sort direction if no prefix is
      "!    specified. This parameter cannot be used in the same query as the **bias**
      "!    parameter.
      SORT type STRING,
      "!   When true, a highlight field is returned for each result which contains the
      "!    fields which match the query with `&lt;em&gt;&lt;/em&gt;` tags around the
      "!    matching query terms.
      HIGHLIGHT type BOOLEAN,
      "!   A comma-separated list of fields that passages are drawn from. If this parameter
      "!    not specified, then all top-level fields are included.
      PASSAGES_FIELDS type STRING,
      "!   The maximum number of passages to return. The search returns fewer passages if
      "!    the requested total is not found. The default is `10`. The maximum is `100`.
      PASSAGES_COUNT type INTEGER,
      "!   The approximate number of characters that any one passage will have.
      PASSAGES_CHARACTERS type INTEGER,
      "!   When `true`, and used with a Watson Discovery News collection, duplicate results
      "!    (based on the contents of the **title** field) are removed. Duplicate
      "!    comparison is limited to the current query only; **offset** is not considered.
      "!    This parameter is currently Beta functionality.
      DEDUPLICATE type BOOLEAN,
      "!   When specified, duplicate results based on the field specified are removed from
      "!    the returned results. Duplicate comparison is limited to the current query
      "!    only, **offset** is not considered. This parameter is currently Beta
      "!    functionality.
      DEDUPLICATE_FIELD type STRING,
      "!   When `true`, results are returned based on their similarity to the document IDs
      "!    specified in the **similar.document_ids** parameter.
      SIMILAR type BOOLEAN,
      "!   A comma-separated list of document IDs to find similar documents.<br/>
      "!   <br/>
      "!   **Tip:** Include the **natural_language_query** parameter to expand the scope of
      "!    the document similarity search with the natural language query. Other query
      "!    parameters, such as **filter** and **query**, are subsequently applied and
      "!    reduce the scope.
      SIMILAR_DOCUMENT_IDS type STRING,
      "!   A comma-separated list of field names that are used as a basis for comparison to
      "!    identify similar documents. If not specified, the entire document is used for
      "!    comparison.
      SIMILAR_FIELDS type STRING,
      "!   Field which the returned results will be biased against. The specified field
      "!    must be either a **date** or **number** format. When a **date** type field is
      "!    specified returned results are biased towards field values closer to the
      "!    current date. When a **number** type field is specified, returned results are
      "!    biased towards higher field values. This parameter cannot be used in the same
      "!    query as the **sort** parameter.
      BIAS type STRING,
      "!   When `true` and the **natural_language_query** parameter is used, the
      "!    **natural_languge_query** parameter is spell checked. The most likely
      "!    correction is retunred in the **suggested_query** field of the response (if one
      "!    exists). <br/>
      "!   <br/>
      "!   **Important:** this parameter is only valid when using the Cloud Pak version of
      "!    Discovery.
      SPELLING_SUGGESTIONS type BOOLEAN,
    end of T_COLL_QUERY_LARGE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Object containing environment update information.</p>
    begin of T_UPDATE_ENVIRONMENT_REQUEST,
      "!   Name that identifies the environment.
      NAME type STRING,
      "!   Description of the environment.
      DESCRIPTION type STRING,
      "!   Size that the environment should be increased to. Environment size cannot be
      "!    modified when using a Lite plan. Environment size can only increased and not
      "!    decreased.
      SIZE type STRING,
    end of T_UPDATE_ENVIRONMENT_REQUEST.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information returned when a configuration is deleted.</p>
    begin of T_DEL_CONFIGURATION_RESPONSE,
      "!   The unique identifier for the configuration.
      CONFIGURATION_ID type STRING,
      "!   Status of the configuration. A deleted configuration has the status deleted.
      STATUS type STRING,
      "!   An array of notice messages, if any.
      NOTICES type STANDARD TABLE OF T_NOTICE WITH NON-UNIQUE DEFAULT KEY,
    end of T_DEL_CONFIGURATION_RESPONSE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A response containing the documents and aggregations for the</p>
    "!     query.
    begin of T_QUERY_RESPONSE,
      "!   The number of matching results for the query.
      MATCHING_RESULTS type INTEGER,
      "!   Array of document results for the query.
      RESULTS type STANDARD TABLE OF T_QUERY_RESULT WITH NON-UNIQUE DEFAULT KEY,
      "!   Array of aggregation results for the query.
      AGGREGATIONS type STANDARD TABLE OF T_QUERY_AGGREGATION WITH NON-UNIQUE DEFAULT KEY,
      "!   Array of passage results for the query.
      PASSAGES type STANDARD TABLE OF T_QUERY_PASSAGES WITH NON-UNIQUE DEFAULT KEY,
      "!   The number of duplicate results removed.
      DUPLICATES_REMOVED type INTEGER,
      "!   The session token for this query. The session token can be used to add events
      "!    associated with this query to the query and event log.<br/>
      "!   <br/>
      "!   **Important:** Session tokens are case sensitive.
      SESSION_TOKEN type STRING,
      "!   An object contain retrieval type information.
      RETRIEVAL_DETAILS type T_RETRIEVAL_DETAILS,
      "!   The suggestions for a misspelled natural language query.
      SUGGESTED_QUERY type STRING,
    end of T_QUERY_RESPONSE.
  types:
    "! No documentation available.
    begin of T_TIMESLICE,
      "!   The field where the aggregation is located in the document.
      FIELD type STRING,
      "!   Interval of the aggregation. Valid date interval values are second/seconds
      "!    minute/minutes, hour/hours, day/days, week/weeks, month/months, and year/years.
      "!
      INTERVAL type STRING,
      "!   Used to indicate that anomaly detection should be performed. Anomaly detection
      "!    is used to locate unusual datapoints within a time series.
      ANOMALY type BOOLEAN,
    end of T_TIMESLICE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Training query to add.</p>
    begin of T_NEW_TRAINING_QUERY,
      "!   The natural text query for the new training query.
      NATURAL_LANGUAGE_QUERY type STRING,
      "!   The filter used on the collection before the **natural_language_query** is
      "!    applied.
      FILTER type STRING,
      "!   Array of training examples.
      EXAMPLES type STANDARD TABLE OF T_TRAINING_EXAMPLE WITH NON-UNIQUE DEFAULT KEY,
    end of T_NEW_TRAINING_QUERY.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Status information about a submitted document.</p>
    begin of T_DOCUMENT_STATUS,
      "!   The unique identifier of the document.
      DOCUMENT_ID type STRING,
      "!   The unique identifier for the configuration.
      CONFIGURATION_ID type STRING,
      "!   Status of the document in the ingestion process.
      STATUS type STRING,
      "!   Description of the document status.
      STATUS_DESCRIPTION type STRING,
      "!   Name of the original source file (if available).
      FILENAME type STRING,
      "!   The type of the original source file.
      FILE_TYPE type STRING,
      "!   The SHA-1 hash of the original source file (formatted as a hexadecimal string).
      SHA1 type STRING,
      "!   Array of notices produced by the document-ingestion process.
      NOTICES type STANDARD TABLE OF T_NOTICE WITH NON-UNIQUE DEFAULT KEY,
    end of T_DOCUMENT_STATUS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Object that describes a long query.</p>
    begin of T_FED_QUERY_LARGE,
      "!   A cacheable query that excludes documents that don&apos;t mention the query
      "!    content. Filter searches are better for metadata-type searches and for
      "!    assessing the concepts in the data set.
      FILTER type STRING,
      "!   A query search returns all documents in your data set with full enrichments and
      "!    full text, but with the most relevant documents listed first. Use a query
      "!    search when you want to find the most relevant search results.
      QUERY type STRING,
      "!   A natural language query that returns relevant documents by utilizing training
      "!    data and natural language understanding.
      NATURAL_LANGUAGE_QUERY type STRING,
      "!   A passages query that returns the most relevant passages from the results.
      PASSAGES type BOOLEAN,
      "!   An aggregation search that returns an exact answer by combining query search
      "!    with filters. Useful for applications to build lists, tables, and time series.
      "!    For a full list of possible aggregations, see the Query reference.
      AGGREGATION type STRING,
      "!   Number of results to return.
      COUNT type INTEGER,
      "!   A comma-separated list of the portion of the document hierarchy to return.
      RETURN type STRING,
      "!   The number of query results to skip at the beginning. For example, if the total
      "!    number of results that are returned is 10 and the offset is 8, it returns the
      "!    last two results.
      OFFSET type INTEGER,
      "!   A comma-separated list of fields in the document to sort on. You can optionally
      "!    specify a sort direction by prefixing the field with `-` for descending or `+`
      "!    for ascending. Ascending is the default sort direction if no prefix is
      "!    specified. This parameter cannot be used in the same query as the **bias**
      "!    parameter.
      SORT type STRING,
      "!   When true, a highlight field is returned for each result which contains the
      "!    fields which match the query with `&lt;em&gt;&lt;/em&gt;` tags around the
      "!    matching query terms.
      HIGHLIGHT type BOOLEAN,
      "!   A comma-separated list of fields that passages are drawn from. If this parameter
      "!    not specified, then all top-level fields are included.
      PASSAGES_FIELDS type STRING,
      "!   The maximum number of passages to return. The search returns fewer passages if
      "!    the requested total is not found. The default is `10`. The maximum is `100`.
      PASSAGES_COUNT type INTEGER,
      "!   The approximate number of characters that any one passage will have.
      PASSAGES_CHARACTERS type INTEGER,
      "!   When `true`, and used with a Watson Discovery News collection, duplicate results
      "!    (based on the contents of the **title** field) are removed. Duplicate
      "!    comparison is limited to the current query only; **offset** is not considered.
      "!    This parameter is currently Beta functionality.
      DEDUPLICATE type BOOLEAN,
      "!   When specified, duplicate results based on the field specified are removed from
      "!    the returned results. Duplicate comparison is limited to the current query
      "!    only, **offset** is not considered. This parameter is currently Beta
      "!    functionality.
      DEDUPLICATE_FIELD type STRING,
      "!   When `true`, results are returned based on their similarity to the document IDs
      "!    specified in the **similar.document_ids** parameter.
      SIMILAR type BOOLEAN,
      "!   A comma-separated list of document IDs to find similar documents.<br/>
      "!   <br/>
      "!   **Tip:** Include the **natural_language_query** parameter to expand the scope of
      "!    the document similarity search with the natural language query. Other query
      "!    parameters, such as **filter** and **query**, are subsequently applied and
      "!    reduce the scope.
      SIMILAR_DOCUMENT_IDS type STRING,
      "!   A comma-separated list of field names that are used as a basis for comparison to
      "!    identify similar documents. If not specified, the entire document is used for
      "!    comparison.
      SIMILAR_FIELDS type STRING,
      "!   Field which the returned results will be biased against. The specified field
      "!    must be either a **date** or **number** format. When a **date** type field is
      "!    specified returned results are biased towards field values closer to the
      "!    current date. When a **number** type field is specified, returned results are
      "!    biased towards higher field values. This parameter cannot be used in the same
      "!    query as the **sort** parameter.
      BIAS type STRING,
      "!   A comma-separated list of collection IDs to be queried against.
      COLLECTION_IDS type STRING,
    end of T_FED_QUERY_LARGE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An error response object.</p>
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
    "!     in one object, and expansions for the word `cold` in another.
    begin of T_EXPANSION,
      "!   A list of terms that will be expanded for this expansion. If specified, only the
      "!    items in this list are expanded.
      INPUT_TERMS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   A list of terms that this expansion will be expanded to. If specified without
      "!    **input_terms**, it also functions as the input term list.
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
      "!    bidirectional or unidirectional. Bidirectional means that all terms are
      "!    expanded to all other terms in the object. Unidirectional means that a set list
      "!    of terms can be expanded into a second list of terms.<br/>
      "!   <br/>
      "!    To create a bi-directional expansion specify an **expanded_terms** array. When
      "!    found in a query, all items in the **expanded_terms** array are then expanded
      "!    to the other items in the same array.<br/>
      "!   <br/>
      "!    To create a uni-directional expansion, specify both an array of **input_terms**
      "!    and an array of **expanded_terms**. When items in the **input_terms** array are
      "!    present in a query, they are expanded using the items listed in the
      "!    **expanded_terms** array.
      EXPANSIONS type STANDARD TABLE OF T_EXPANSION WITH NON-UNIQUE DEFAULT KEY,
    end of T_EXPANSIONS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object defining the event being created.</p>
    begin of T_CREATE_EVENT_RESPONSE,
      "!   The event type that was created.
      TYPE type STRING,
      "!   Query event data object.
      DATA type T_EVENT_DATA,
    end of T_CREATE_EVENT_RESPONSE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An array of document enrichment settings for the</p>
    "!     configuration.
      T_ENRICHMENTS type STANDARD TABLE OF T_ENRICHMENT WITH NON-UNIQUE DEFAULT KEY.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The response generated from a call to a **metrics** method</p>
    "!     that evaluates tokens.
    begin of T_METRIC_TOKEN_RESPONSE,
      "!   Array of metric token aggregations.
      AGGREGATIONS type STANDARD TABLE OF T_METRIC_TOKEN_AGGREGATION WITH NON-UNIQUE DEFAULT KEY,
    end of T_METRIC_TOKEN_RESPONSE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Object containing an array of training examples.</p>
    begin of T_TRAINING_EXAMPLE_LIST,
      "!   Array of training examples.
      EXAMPLES type STANDARD TABLE OF T_TRAINING_EXAMPLE WITH NON-UNIQUE DEFAULT KEY,
    end of T_TRAINING_EXAMPLE_LIST.
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
    "! No documentation available.
    begin of T_TOP_HITS,
      "!   Number of top hits returned by the aggregation.
      SIZE type INTEGER,
      "!   No documentation available.
      HITS type T_TOP_HITS_RESULTS,
    end of T_TOP_HITS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Individual result object for a **logs** query. Each object</p>
    "!     represents either a query to a Discovery collection or an event that is
    "!     associated with a query.
    begin of T_LOG_QUERY_RESPONSE_RESULT,
      "!   The environment ID that is associated with this log entry.
      ENVIRONMENT_ID type STRING,
      "!   The **customer_id** label that was specified in the header of the query or event
      "!    API call that corresponds to this log entry.
      CUSTOMER_ID type STRING,
      "!   The type of log entry returned.<br/>
      "!   <br/>
      "!    **query** indicates that the log represents the results of a call to the single
      "!    collection **query** method.<br/>
      "!   <br/>
      "!    **event** indicates that the log represents  a call to the **events** API.
      DOCUMENT_TYPE type STRING,
      "!   The value of the **natural_language_query** query parameter that was used to
      "!    create these results. Only returned with logs of type **query**.<br/>
      "!   <br/>
      "!   **Note:** Other query parameters (such as **filter** or **deduplicate**) might
      "!    have been used with this query, but are not recorded.
      NATURAL_LANGUAGE_QUERY type STRING,
      "!   Object containing result information that was returned by the query used to
      "!    create this log entry. Only returned with logs of type `query`.
      DOCUMENT_RESULTS type T_LOG_QUERY_RESP_RESULT_DOCS,
      "!   Date that the log result was created. Returned in `YYYY-MM-DDThh:mm:ssZ` format.
      "!
      CREATED_TIMESTAMP type DATETIME,
      "!   Date specified by the user when recording an event. Returned in
      "!    `YYYY-MM-DDThh:mm:ssZ` format. Only returned with logs of type **event**.
      CLIENT_TIMESTAMP type DATETIME,
      "!   Identifier that corresponds to the **natural_language_query** string used in the
      "!    original or associated query. All **event** and **query** log entries that have
      "!    the same original **natural_language_query** string also have them same
      "!    **query_id**. This field can be used to recall all **event** and **query** log
      "!    results that have the same original query (**event** logs do not contain the
      "!    original **natural_language_query** field).
      QUERY_ID type STRING,
      "!   Unique identifier (within a 24-hour period) that identifies a single `query` log
      "!    and any `event` logs that were created for it.<br/>
      "!   <br/>
      "!   **Note:** If the exact same query is run at the exact same time on different
      "!    days, the **session_token** for those queries might be identical. However, the
      "!    **created_timestamp** differs. <br/>
      "!   <br/>
      "!   **Note:** Session tokens are case sensitive. To avoid matching on session tokens
      "!    that are identical except for case, use the exact match operator (`::`) when
      "!    you query for a specific session token.
      SESSION_TOKEN type STRING,
      "!   The collection ID of the document associated with this event. Only returned with
      "!    logs of type `event`.
      COLLECTION_ID type STRING,
      "!   The original display rank of the document associated with this event. Only
      "!    returned with logs of type `event`.
      DISPLAY_RANK type INTEGER,
      "!   The document ID of the document associated with this event. Only returned with
      "!    logs of type `event`.
      DOCUMENT_ID type STRING,
      "!   The type of event that this object respresents. Possible values are<br/>
      "!   <br/>
      "!    -  `query` the log of a query to a collection<br/>
      "!   <br/>
      "!    -  `click` the result of a call to the **events** endpoint.
      EVENT_TYPE type STRING,
      "!   The type of result that this **event** is associated with. Only returned with
      "!    logs of type `event`.
      RESULT_TYPE type STRING,
    end of T_LOG_QUERY_RESPONSE_RESULT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Object containing results that match the requested **logs**</p>
    "!     query.
    begin of T_LOG_QUERY_RESPONSE,
      "!   Number of matching results.
      MATCHING_RESULTS type INTEGER,
      "!   Array of log query response results.
      RESULTS type STANDARD TABLE OF T_LOG_QUERY_RESPONSE_RESULT WITH NON-UNIQUE DEFAULT KEY,
    end of T_LOG_QUERY_RESPONSE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Defines operations that can be used to transform the final</p>
    "!     output JSON into a normalized form. Operations are executed in the order that
    "!     they appear in the array.
      T_NORMALIZATIONS type STANDARD TABLE OF T_NORMALIZATION_OPERATION WITH NON-UNIQUE DEFAULT KEY.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Training example to add.</p>
    begin of T_TRAINING_EXAMPLE_PATCH,
      "!   The example to add.
      CROSS_REFERENCE type STRING,
      "!   The relevance value for this example.
      RELEVANCE type INTEGER,
    end of T_TRAINING_EXAMPLE_PATCH.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Response object containing an array of collection details.</p>
    begin of T_LIST_COLLECTIONS_RESPONSE,
      "!   An array containing information about each collection in the environment.
      COLLECTIONS type STANDARD TABLE OF T_COLLECTION WITH NON-UNIQUE DEFAULT KEY,
    end of T_LIST_COLLECTIONS_RESPONSE.
  types:
    "! No documentation available.
    begin of T_CALCULATION,
      "!   The field where the aggregation is located in the document.
      FIELD type STRING,
      "!   Value of the aggregation.
      VALUE type DOUBLE,
    end of T_CALCULATION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Training information for a specific collection.</p>
    begin of T_TRAINING_DATA_SET,
      "!   The environment id associated with this training data set.
      ENVIRONMENT_ID type STRING,
      "!   The collection id associated with this training data set.
      COLLECTION_ID type STRING,
      "!   Array of training queries.
      QUERIES type STANDARD TABLE OF T_TRAINING_QUERY WITH NON-UNIQUE DEFAULT KEY,
    end of T_TRAINING_DATA_SET.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Array of font matching configurations.</p>
      T_FONT_SETTINGS type STANDARD TABLE OF T_FONT_SETTING WITH NON-UNIQUE DEFAULT KEY.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Object containing notice query results.</p>
    begin of T_QUERY_NOTICES_RESPONSE,
      "!   The number of matching results.
      MATCHING_RESULTS type INTEGER,
      "!   Array of document results that match the query.
      RESULTS type STANDARD TABLE OF T_QUERY_NOTICES_RESULT WITH NON-UNIQUE DEFAULT KEY,
      "!   Array of aggregation results that match the query.
      AGGREGATIONS type STANDARD TABLE OF T_QUERY_AGGREGATION WITH NON-UNIQUE DEFAULT KEY,
      "!   Array of passage results that match the query.
      PASSAGES type STANDARD TABLE OF T_QUERY_PASSAGES WITH NON-UNIQUE DEFAULT KEY,
      "!   The number of duplicates removed from this notices query.
      DUPLICATES_REMOVED type INTEGER,
    end of T_QUERY_NOTICES_RESPONSE.
  types:
    "! No documentation available.
    begin of T_HISTOGRAM,
      "!   The field where the aggregation is located in the document.
      FIELD type STRING,
      "!   Interval of the aggregation. (For &apos;histogram&apos; type).
      INTERVAL type INTEGER,
    end of T_HISTOGRAM.

constants:
  "! <p class="shorttext synchronized" lang="en">List of required fields per type.</p>
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
  "! <p class="shorttext synchronized" lang="en">Map ABAP identifiers to service identifiers.</p>
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
     SUGGESTED_QUERY type string value 'suggested_query',
     ID type string value 'id',
     METADATA type string value 'metadata',
     INNER type string value 'inner',
     RESULT_METADATA type string value 'result_metadata',
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


    "! <p class="shorttext synchronized" lang="en">Create an environment</p>
    "!   Creates a new environment for private data. An environment must be created
    "!    before collections can be created. <br/>
    "!   <br/>
    "!   **Note**: You can create only one environment for private data per service
    "!    instance. An attempt to create another environment results in an error.
    "!
    "! @parameter I_BODY |
    "!   An object that defines an environment name and optional description. The fields
    "!    in this object are not approved for personal information and cannot be deleted
    "!    based on customer ID.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_ENVIRONMENT
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods CREATE_ENVIRONMENT
    importing
      !I_BODY type T_CREATE_ENVIRONMENT_REQUEST
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_ENVIRONMENT
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">List environments</p>
    "!   List existing environments for the service instance.
    "!
    "! @parameter I_NAME |
    "!   Show only the environment with the given name.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_LIST_ENVIRONMENTS_RESPONSE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_ENVIRONMENTS
    importing
      !I_NAME type STRING optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_LIST_ENVIRONMENTS_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Get environment info</p>
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_ENVIRONMENT
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_ENVIRONMENT
    importing
      !I_ENVIRONMENT_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_ENVIRONMENT
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Update an environment</p>
    "!   Updates an environment. The environment&apos;s **name** and  **description**
    "!    parameters can be changed. You must specify a **name** for the environment.
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter I_BODY |
    "!   An object that defines the environment&apos;s name and, optionally, description.
    "!
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_ENVIRONMENT
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods UPDATE_ENVIRONMENT
    importing
      !I_ENVIRONMENT_ID type STRING
      !I_BODY type T_UPDATE_ENVIRONMENT_REQUEST
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_ENVIRONMENT
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Delete environment</p>
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_DELETE_ENVIRONMENT_RESPONSE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_ENVIRONMENT
    importing
      !I_ENVIRONMENT_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_DELETE_ENVIRONMENT_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">List fields across collections</p>
    "!   Gets a list of the unique fields (and their types) stored in the indexes of the
    "!    specified collections.
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter I_COLLECTION_IDS |
    "!   A comma-separated list of collection IDs to be queried against.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_LST_COLLECTION_FIELDS_RESP
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_FIELDS
    importing
      !I_ENVIRONMENT_ID type STRING
      !I_COLLECTION_IDS type TT_STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_LST_COLLECTION_FIELDS_RESP
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">Add configuration</p>
    "!   Creates a new configuration.<br/>
    "!   <br/>
    "!   If the input configuration contains the **configuration_id**, **created**, or
    "!    **updated** properties, then they are ignored and overridden by the system, and
    "!    an error is not returned so that the overridden fields do not need to be
    "!    removed when copying a configuration.<br/>
    "!   <br/>
    "!   The configuration can contain unrecognized JSON fields. Any such fields are
    "!    ignored and do not generate an error. This makes it easier to use newer
    "!    configuration files with older versions of the API and the service. It also
    "!    makes it possible for the tooling to add additional metadata and information to
    "!    the configuration.
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter I_CONFIGURATION |
    "!   Input an object that enables you to customize how your content is ingested and
    "!    what enrichments are added to your data. <br/>
    "!   <br/>
    "!   **name** is required and must be unique within the current **environment**. All
    "!    other properties are optional.<br/>
    "!   <br/>
    "!   If the input configuration contains the **configuration_id**, **created**, or
    "!    **updated** properties, then they will be ignored and overridden by the system
    "!    (an error is not returned so that the overridden fields do not need to be
    "!    removed when copying a configuration). <br/>
    "!   <br/>
    "!   The configuration can contain unrecognized JSON fields. Any such fields will be
    "!    ignored and will not generate an error. This makes it easier to use newer
    "!    configuration files with older versions of the API and the service. It also
    "!    makes it possible for the tooling to add additional metadata and information to
    "!    the configuration.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_CONFIGURATION
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods CREATE_CONFIGURATION
    importing
      !I_ENVIRONMENT_ID type STRING
      !I_CONFIGURATION type T_CONFIGURATION
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_CONFIGURATION
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">List configurations</p>
    "!   Lists existing configurations for the service instance.
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter I_NAME |
    "!   Find configurations with the given name.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_LIST_CONFIGURATIONS_RESPONSE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_CONFIGURATIONS
    importing
      !I_ENVIRONMENT_ID type STRING
      !I_NAME type STRING optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_LIST_CONFIGURATIONS_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Get configuration details</p>
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter I_CONFIGURATION_ID |
    "!   The ID of the configuration.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_CONFIGURATION
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_CONFIGURATION
    importing
      !I_ENVIRONMENT_ID type STRING
      !I_CONFIGURATION_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_CONFIGURATION
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Update a configuration</p>
    "!   Replaces an existing configuration.<br/>
    "!     * Completely replaces the original configuration.<br/>
    "!     * The **configuration_id**, **updated**, and **created** fields are accepted
    "!    in the request, but they are ignored, and an error is not generated. It is also
    "!    acceptable for users to submit an updated configuration with none of the three
    "!    properties.<br/>
    "!     * Documents are processed with a snapshot of the configuration as it was at
    "!    the time the document was submitted to be ingested. This means that already
    "!    submitted documents will not see any updates made to the configuration.
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter I_CONFIGURATION_ID |
    "!   The ID of the configuration.
    "! @parameter I_CONFIGURATION |
    "!   Input an object that enables you to update and customize how your data is
    "!    ingested and what enrichments are added to your data.  The **name** parameter
    "!    is required and must be unique within the current **environment**. All other
    "!    properties are optional, but if they are omitted  the default values replace
    "!    the current value of each omitted property.<br/>
    "!   <br/>
    "!   If the input configuration contains the **configuration_id**, **created**, or
    "!    **updated** properties, they are ignored and overridden by the system, and an
    "!    error is not returned so that the overridden fields do not need to be removed
    "!    when updating a configuration. <br/>
    "!   <br/>
    "!   The configuration can contain unrecognized JSON fields. Any such fields are
    "!    ignored and do not generate an error. This makes it easier to use newer
    "!    configuration files with older versions of the API and the service. It also
    "!    makes it possible for the tooling to add additional metadata and information to
    "!    the configuration.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_CONFIGURATION
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods UPDATE_CONFIGURATION
    importing
      !I_ENVIRONMENT_ID type STRING
      !I_CONFIGURATION_ID type STRING
      !I_CONFIGURATION type T_CONFIGURATION
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_CONFIGURATION
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Delete a configuration</p>
    "!   The deletion is performed unconditionally. A configuration deletion request
    "!    succeeds even if the configuration is referenced by a collection or document
    "!    ingestion. However, documents that have already been submitted for processing
    "!    continue to use the deleted configuration. Documents are always processed with
    "!    a snapshot of the configuration as it existed at the time the document was
    "!    submitted.
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter I_CONFIGURATION_ID |
    "!   The ID of the configuration.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_DEL_CONFIGURATION_RESPONSE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_CONFIGURATION
    importing
      !I_ENVIRONMENT_ID type STRING
      !I_CONFIGURATION_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_DEL_CONFIGURATION_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">Create a collection</p>
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter I_BODY |
    "!   Input an object that allows you to add a collection.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_COLLECTION
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods CREATE_COLLECTION
    importing
      !I_ENVIRONMENT_ID type STRING
      !I_BODY type T_CREATE_COLLECTION_REQUEST
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_COLLECTION
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">List collections</p>
    "!   Lists existing collections for the service instance.
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter I_NAME |
    "!   Find collections with the given name.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_LIST_COLLECTIONS_RESPONSE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_COLLECTIONS
    importing
      !I_ENVIRONMENT_ID type STRING
      !I_NAME type STRING optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_LIST_COLLECTIONS_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Get collection details</p>
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter I_COLLECTION_ID |
    "!   The ID of the collection.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_COLLECTION
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_COLLECTION
    importing
      !I_ENVIRONMENT_ID type STRING
      !I_COLLECTION_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_COLLECTION
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Update a collection</p>
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter I_COLLECTION_ID |
    "!   The ID of the collection.
    "! @parameter I_BODY |
    "!   Input an object that allows you to update a collection.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_COLLECTION
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods UPDATE_COLLECTION
    importing
      !I_ENVIRONMENT_ID type STRING
      !I_COLLECTION_ID type STRING
      !I_BODY type T_UPDATE_COLLECTION_REQUEST
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_COLLECTION
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Delete a collection</p>
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter I_COLLECTION_ID |
    "!   The ID of the collection.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_DELETE_COLLECTION_RESPONSE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_COLLECTION
    importing
      !I_ENVIRONMENT_ID type STRING
      !I_COLLECTION_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_DELETE_COLLECTION_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">List collection fields</p>
    "!   Gets a list of the unique fields (and their types) stored in the index.
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter I_COLLECTION_ID |
    "!   The ID of the collection.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_LST_COLLECTION_FIELDS_RESP
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_COLLECTION_FIELDS
    importing
      !I_ENVIRONMENT_ID type STRING
      !I_COLLECTION_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_LST_COLLECTION_FIELDS_RESP
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">Get the expansion list</p>
    "!   Returns the current expansion list for the specified collection. If an expansion
    "!    list is not specified, an object with empty expansion arrays is returned.
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter I_COLLECTION_ID |
    "!   The ID of the collection.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_EXPANSIONS
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_EXPANSIONS
    importing
      !I_ENVIRONMENT_ID type STRING
      !I_COLLECTION_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_EXPANSIONS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Create or update expansion list</p>
    "!   Create or replace the Expansion list for this collection. The maximum number of
    "!    expanded terms per collection is `500`.<br/>
    "!   The current expansion list is replaced with the uploaded content.
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
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
      !I_ENVIRONMENT_ID type STRING
      !I_COLLECTION_ID type STRING
      !I_BODY type T_EXPANSIONS
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_EXPANSIONS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Delete the expansion list</p>
    "!   Remove the expansion information for this collection. The expansion list must be
    "!    deleted to disable query expansion for a collection.
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter I_COLLECTION_ID |
    "!   The ID of the collection.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_EXPANSIONS
    importing
      !I_ENVIRONMENT_ID type STRING
      !I_COLLECTION_ID type STRING
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Get tokenization dictionary status</p>
    "!   Returns the current status of the tokenization dictionary for the specified
    "!    collection.
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter I_COLLECTION_ID |
    "!   The ID of the collection.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_TOKEN_DICT_STATUS_RESPONSE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_TOKENIZATION_DICT_STATUS
    importing
      !I_ENVIRONMENT_ID type STRING
      !I_COLLECTION_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_TOKEN_DICT_STATUS_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Create tokenization dictionary</p>
    "!   Upload a custom tokenization dictionary to use with the specified collection.
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter I_COLLECTION_ID |
    "!   The ID of the collection.
    "! @parameter I_TOKENIZATION_DICTIONARY |
    "!   An object that represents the tokenization dictionary to be uploaded.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_TOKEN_DICT_STATUS_RESPONSE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods CREATE_TOKENIZATION_DICTIONARY
    importing
      !I_ENVIRONMENT_ID type STRING
      !I_COLLECTION_ID type STRING
      !I_TOKENIZATION_DICTIONARY type T_TOKEN_DICT optional
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_TOKEN_DICT_STATUS_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Delete tokenization dictionary</p>
    "!   Delete the tokenization dictionary from the collection.
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter I_COLLECTION_ID |
    "!   The ID of the collection.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_TOKENIZATION_DICTIONARY
    importing
      !I_ENVIRONMENT_ID type STRING
      !I_COLLECTION_ID type STRING
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Get stopword list status</p>
    "!   Returns the current status of the stopword list for the specified collection.
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter I_COLLECTION_ID |
    "!   The ID of the collection.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_TOKEN_DICT_STATUS_RESPONSE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_STOPWORD_LIST_STATUS
    importing
      !I_ENVIRONMENT_ID type STRING
      !I_COLLECTION_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_TOKEN_DICT_STATUS_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Create stopword list</p>
    "!   Upload a custom stopword list to use with the specified collection.
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter I_COLLECTION_ID |
    "!   The ID of the collection.
    "! @parameter I_STOPWORD_FILE |
    "!   The content of the stopword list to ingest.
    "! @parameter I_STOPWORD_FILENAME |
    "!   The filename for stopwordFile.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_TOKEN_DICT_STATUS_RESPONSE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods CREATE_STOPWORD_LIST
    importing
      !I_ENVIRONMENT_ID type STRING
      !I_COLLECTION_ID type STRING
      !I_STOPWORD_FILE type FILE
      !I_STOPWORD_FILENAME type STRING
      !I_STOPWORD_FILE_CT type STRING default ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-ALL
      !I_contenttype type string default 'multipart/form-data'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_TOKEN_DICT_STATUS_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Delete a custom stopword list</p>
    "!   Delete a custom stopword list from the collection. After a custom stopword list
    "!    is deleted, the default list is used for the collection.
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter I_COLLECTION_ID |
    "!   The ID of the collection.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_STOPWORD_LIST
    importing
      !I_ENVIRONMENT_ID type STRING
      !I_COLLECTION_ID type STRING
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">Add a document</p>
    "!   Add a document to a collection with optional metadata.<br/>
    "!   <br/>
    "!     * The **version** query parameter is still required.<br/>
    "!   <br/>
    "!     * Returns immediately after the system has accepted the document for
    "!    processing.<br/>
    "!   <br/>
    "!     * The user must provide document content, metadata, or both. If the request is
    "!    missing both document content and metadata, it is rejected.<br/>
    "!   <br/>
    "!     * The user can set the **Content-Type** parameter on the **file** part to
    "!    indicate the media type of the document. If the **Content-Type** parameter is
    "!    missing or is one of the generic media types (for example,
    "!    `application/octet-stream`), then the service attempts to automatically detect
    "!    the document&apos;s media type.<br/>
    "!   <br/>
    "!     * The following field names are reserved and will be filtered out if present
    "!    after normalization: `id`, `score`, `highlight`, and any field with the prefix
    "!    of: `_`, `+`, or `-`<br/>
    "!   <br/>
    "!     * Fields with empty name values after normalization are filtered out before
    "!    indexing.<br/>
    "!   <br/>
    "!     * Fields containing the following characters after normalization are filtered
    "!    out before indexing: `#` and `,`<br/>
    "!   <br/>
    "!    **Note:** Documents can be added with a specific **document_id** by using the
    "!    **/v1/environments/&#123;environment_id&#125;/collections/&#123;collection_id&#
    "!   125;/documents** method.
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter I_COLLECTION_ID |
    "!   The ID of the collection.
    "! @parameter I_FILE |
    "!   The content of the document to ingest. The maximum supported file size when
    "!    adding a file to a collection is 50 megabytes, the maximum supported file size
    "!    when testing a configuration is 1 megabyte. Files larger than the supported
    "!    size are rejected.
    "! @parameter I_FILENAME |
    "!   The filename for file.
    "! @parameter I_FILE_CONTENT_TYPE |
    "!   The content type of file.
    "! @parameter I_METADATA |
    "!   The maximum supported metadata file size is 1 MB. Metadata parts larger than 1
    "!    MB are rejected. Example:  ``` &#123;<br/>
    "!     &quot;Creator&quot;: &quot;Johnny Appleseed&quot;,<br/>
    "!     &quot;Subject&quot;: &quot;Apples&quot;<br/>
    "!   &#125; ```.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_DOCUMENT_ACCEPTED
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods ADD_DOCUMENT
    importing
      !I_ENVIRONMENT_ID type STRING
      !I_COLLECTION_ID type STRING
      !I_FILE type FILE optional
      !I_FILENAME type STRING optional
      !I_FILE_CONTENT_TYPE type STRING optional
      !I_METADATA type STRING optional
      !I_contenttype type string default 'multipart/form-data'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_DOCUMENT_ACCEPTED
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Get document details</p>
    "!   Fetch status details about a submitted document. **Note:** this operation does
    "!    not return the document itself. Instead, it returns only the document&apos;s
    "!    processing status and any notices (warnings or errors) that were generated when
    "!    the document was ingested. Use the query API to retrieve the actual document
    "!    content.
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter I_COLLECTION_ID |
    "!   The ID of the collection.
    "! @parameter I_DOCUMENT_ID |
    "!   The ID of the document.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_DOCUMENT_STATUS
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_DOCUMENT_STATUS
    importing
      !I_ENVIRONMENT_ID type STRING
      !I_COLLECTION_ID type STRING
      !I_DOCUMENT_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_DOCUMENT_STATUS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Update a document</p>
    "!   Replace an existing document or add a document with a specified **document_id**.
    "!    Starts ingesting a document with optional metadata.<br/>
    "!   <br/>
    "!   **Note:** When uploading a new document with this method it automatically
    "!    replaces any document stored with the same **document_id** if it exists.
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter I_COLLECTION_ID |
    "!   The ID of the collection.
    "! @parameter I_DOCUMENT_ID |
    "!   The ID of the document.
    "! @parameter I_FILE |
    "!   The content of the document to ingest. The maximum supported file size when
    "!    adding a file to a collection is 50 megabytes, the maximum supported file size
    "!    when testing a configuration is 1 megabyte. Files larger than the supported
    "!    size are rejected.
    "! @parameter I_FILENAME |
    "!   The filename for file.
    "! @parameter I_FILE_CONTENT_TYPE |
    "!   The content type of file.
    "! @parameter I_METADATA |
    "!   The maximum supported metadata file size is 1 MB. Metadata parts larger than 1
    "!    MB are rejected. Example:  ``` &#123;<br/>
    "!     &quot;Creator&quot;: &quot;Johnny Appleseed&quot;,<br/>
    "!     &quot;Subject&quot;: &quot;Apples&quot;<br/>
    "!   &#125; ```.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_DOCUMENT_ACCEPTED
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods UPDATE_DOCUMENT
    importing
      !I_ENVIRONMENT_ID type STRING
      !I_COLLECTION_ID type STRING
      !I_DOCUMENT_ID type STRING
      !I_FILE type FILE optional
      !I_FILENAME type STRING optional
      !I_FILE_CONTENT_TYPE type STRING optional
      !I_METADATA type STRING optional
      !I_contenttype type string default 'multipart/form-data'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_DOCUMENT_ACCEPTED
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Delete a document</p>
    "!   If the given document ID is invalid, or if the document is not found, then the a
    "!    success response is returned (HTTP status code `200`) with the status set to
    "!    &apos;deleted&apos;.
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter I_COLLECTION_ID |
    "!   The ID of the collection.
    "! @parameter I_DOCUMENT_ID |
    "!   The ID of the document.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_DELETE_DOCUMENT_RESPONSE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_DOCUMENT
    importing
      !I_ENVIRONMENT_ID type STRING
      !I_COLLECTION_ID type STRING
      !I_DOCUMENT_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_DELETE_DOCUMENT_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">Query a collection</p>
    "!   By using this method, you can construct long queries. For details, see the
    "!    [Discovery
    "!    documentation](https://cloud.ibm.com/docs/services/discovery?topic=discovery-qu
    "!   ery-concepts#query-concepts).
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter I_COLLECTION_ID |
    "!   The ID of the collection.
    "! @parameter I_QUERY_LONG |
    "!   An object that represents the query to be submitted.
    "! @parameter I_X_WATSON_LOGGING_OPT_OUT |
    "!   If `true`, queries are not stored in the Discovery **Logs** endpoint.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_QUERY_RESPONSE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods QUERY
    importing
      !I_ENVIRONMENT_ID type STRING
      !I_COLLECTION_ID type STRING
      !I_QUERY_LONG type T_COLL_QUERY_LARGE optional
      !I_X_WATSON_LOGGING_OPT_OUT type BOOLEAN default c_boolean_false
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_QUERY_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Query system notices</p>
    "!   Queries for notices (errors or warnings) that might have been generated by the
    "!    system. Notices are generated when ingesting documents and performing relevance
    "!    training. See the [Discovery
    "!    documentation](https://cloud.ibm.com/docs/services/discovery?topic=discovery-qu
    "!   ery-concepts#query-concepts) for more details on the query language.
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter I_COLLECTION_ID |
    "!   The ID of the collection.
    "! @parameter I_FILTER |
    "!   A cacheable query that excludes documents that don&apos;t mention the query
    "!    content. Filter searches are better for metadata-type searches and for
    "!    assessing the concepts in the data set.
    "! @parameter I_QUERY |
    "!   A query search returns all documents in your data set with full enrichments and
    "!    full text, but with the most relevant documents listed first.
    "! @parameter I_NATURAL_LANGUAGE_QUERY |
    "!   A natural language query that returns relevant documents by utilizing training
    "!    data and natural language understanding.
    "! @parameter I_PASSAGES |
    "!   A passages query that returns the most relevant passages from the results.
    "! @parameter I_AGGREGATION |
    "!   An aggregation search that returns an exact answer by combining query search
    "!    with filters. Useful for applications to build lists, tables, and time series.
    "!    For a full list of possible aggregations, see the Query reference.
    "! @parameter I_COUNT |
    "!   Number of results to return. The maximum for the **count** and **offset** values
    "!    together in any one query is **10000**.
    "! @parameter I_RETURN |
    "!   A comma-separated list of the portion of the document hierarchy to return.
    "! @parameter I_OFFSET |
    "!   The number of query results to skip at the beginning. For example, if the total
    "!    number of results that are returned is 10 and the offset is 8, it returns the
    "!    last two results. The maximum for the **count** and **offset** values together
    "!    in any one query is **10000**.
    "! @parameter I_SORT |
    "!   A comma-separated list of fields in the document to sort on. You can optionally
    "!    specify a sort direction by prefixing the field with `-` for descending or `+`
    "!    for ascending. Ascending is the default sort direction if no prefix is
    "!    specified.
    "! @parameter I_HIGHLIGHT |
    "!   When true, a highlight field is returned for each result which contains the
    "!    fields which match the query with `&lt;em&gt;&lt;/em&gt;` tags around the
    "!    matching query terms.
    "! @parameter I_PASSAGES_FIELDS |
    "!   A comma-separated list of fields that passages are drawn from. If this parameter
    "!    not specified, then all top-level fields are included.
    "! @parameter I_PASSAGES_COUNT |
    "!   The maximum number of passages to return. The search returns fewer passages if
    "!    the requested total is not found.
    "! @parameter I_PASSAGES_CHARACTERS |
    "!   The approximate number of characters that any one passage will have.
    "! @parameter I_DEDUPLICATE_FIELD |
    "!   When specified, duplicate results based on the field specified are removed from
    "!    the returned results. Duplicate comparison is limited to the current query
    "!    only, **offset** is not considered. This parameter is currently Beta
    "!    functionality.
    "! @parameter I_SIMILAR |
    "!   When `true`, results are returned based on their similarity to the document IDs
    "!    specified in the **similar.document_ids** parameter.
    "! @parameter I_SIMILAR_DOCUMENT_IDS |
    "!   A comma-separated list of document IDs to find similar documents.<br/>
    "!   <br/>
    "!   **Tip:** Include the **natural_language_query** parameter to expand the scope of
    "!    the document similarity search with the natural language query. Other query
    "!    parameters, such as **filter** and **query**, are subsequently applied and
    "!    reduce the scope.
    "! @parameter I_SIMILAR_FIELDS |
    "!   A comma-separated list of field names that are used as a basis for comparison to
    "!    identify similar documents. If not specified, the entire document is used for
    "!    comparison.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_QUERY_NOTICES_RESPONSE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods QUERY_NOTICES
    importing
      !I_ENVIRONMENT_ID type STRING
      !I_COLLECTION_ID type STRING
      !I_FILTER type STRING optional
      !I_QUERY type STRING optional
      !I_NATURAL_LANGUAGE_QUERY type STRING optional
      !I_PASSAGES type BOOLEAN optional
      !I_AGGREGATION type STRING optional
      !I_COUNT type INTEGER optional
      !I_RETURN type TT_STRING optional
      !I_OFFSET type INTEGER optional
      !I_SORT type TT_STRING optional
      !I_HIGHLIGHT type BOOLEAN default c_boolean_false
      !I_PASSAGES_FIELDS type TT_STRING optional
      !I_PASSAGES_COUNT type INTEGER optional
      !I_PASSAGES_CHARACTERS type INTEGER optional
      !I_DEDUPLICATE_FIELD type STRING optional
      !I_SIMILAR type BOOLEAN default c_boolean_false
      !I_SIMILAR_DOCUMENT_IDS type TT_STRING optional
      !I_SIMILAR_FIELDS type TT_STRING optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_QUERY_NOTICES_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Query multiple collections</p>
    "!   By using this method, you can construct long queries that search multiple
    "!    collection. For details, see the [Discovery
    "!    documentation](https://cloud.ibm.com/docs/services/discovery?topic=discovery-qu
    "!   ery-concepts#query-concepts).
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter I_QUERY_LONG |
    "!   No documentation available.
    "! @parameter I_X_WATSON_LOGGING_OPT_OUT |
    "!   If `true`, queries are not stored in the Discovery **Logs** endpoint.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_QUERY_RESPONSE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods FEDERATED_QUERY
    importing
      !I_ENVIRONMENT_ID type STRING
      !I_QUERY_LONG type T_FED_QUERY_LARGE
      !I_X_WATSON_LOGGING_OPT_OUT type BOOLEAN default c_boolean_false
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_QUERY_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Query multiple collection system notices</p>
    "!   Queries for notices (errors or warnings) that might have been generated by the
    "!    system. Notices are generated when ingesting documents and performing relevance
    "!    training. See the [Discovery
    "!    documentation](https://cloud.ibm.com/docs/services/discovery?topic=discovery-qu
    "!   ery-concepts#query-concepts) for more details on the query language.
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter I_COLLECTION_IDS |
    "!   A comma-separated list of collection IDs to be queried against.
    "! @parameter I_FILTER |
    "!   A cacheable query that excludes documents that don&apos;t mention the query
    "!    content. Filter searches are better for metadata-type searches and for
    "!    assessing the concepts in the data set.
    "! @parameter I_QUERY |
    "!   A query search returns all documents in your data set with full enrichments and
    "!    full text, but with the most relevant documents listed first.
    "! @parameter I_NATURAL_LANGUAGE_QUERY |
    "!   A natural language query that returns relevant documents by utilizing training
    "!    data and natural language understanding.
    "! @parameter I_AGGREGATION |
    "!   An aggregation search that returns an exact answer by combining query search
    "!    with filters. Useful for applications to build lists, tables, and time series.
    "!    For a full list of possible aggregations, see the Query reference.
    "! @parameter I_COUNT |
    "!   Number of results to return. The maximum for the **count** and **offset** values
    "!    together in any one query is **10000**.
    "! @parameter I_RETURN |
    "!   A comma-separated list of the portion of the document hierarchy to return.
    "! @parameter I_OFFSET |
    "!   The number of query results to skip at the beginning. For example, if the total
    "!    number of results that are returned is 10 and the offset is 8, it returns the
    "!    last two results. The maximum for the **count** and **offset** values together
    "!    in any one query is **10000**.
    "! @parameter I_SORT |
    "!   A comma-separated list of fields in the document to sort on. You can optionally
    "!    specify a sort direction by prefixing the field with `-` for descending or `+`
    "!    for ascending. Ascending is the default sort direction if no prefix is
    "!    specified.
    "! @parameter I_HIGHLIGHT |
    "!   When true, a highlight field is returned for each result which contains the
    "!    fields which match the query with `&lt;em&gt;&lt;/em&gt;` tags around the
    "!    matching query terms.
    "! @parameter I_DEDUPLICATE_FIELD |
    "!   When specified, duplicate results based on the field specified are removed from
    "!    the returned results. Duplicate comparison is limited to the current query
    "!    only, **offset** is not considered. This parameter is currently Beta
    "!    functionality.
    "! @parameter I_SIMILAR |
    "!   When `true`, results are returned based on their similarity to the document IDs
    "!    specified in the **similar.document_ids** parameter.
    "! @parameter I_SIMILAR_DOCUMENT_IDS |
    "!   A comma-separated list of document IDs to find similar documents.<br/>
    "!   <br/>
    "!   **Tip:** Include the **natural_language_query** parameter to expand the scope of
    "!    the document similarity search with the natural language query. Other query
    "!    parameters, such as **filter** and **query**, are subsequently applied and
    "!    reduce the scope.
    "! @parameter I_SIMILAR_FIELDS |
    "!   A comma-separated list of field names that are used as a basis for comparison to
    "!    identify similar documents. If not specified, the entire document is used for
    "!    comparison.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_QUERY_NOTICES_RESPONSE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods FEDERATED_QUERY_NOTICES
    importing
      !I_ENVIRONMENT_ID type STRING
      !I_COLLECTION_IDS type TT_STRING
      !I_FILTER type STRING optional
      !I_QUERY type STRING optional
      !I_NATURAL_LANGUAGE_QUERY type STRING optional
      !I_AGGREGATION type STRING optional
      !I_COUNT type INTEGER optional
      !I_RETURN type TT_STRING optional
      !I_OFFSET type INTEGER optional
      !I_SORT type TT_STRING optional
      !I_HIGHLIGHT type BOOLEAN default c_boolean_false
      !I_DEDUPLICATE_FIELD type STRING optional
      !I_SIMILAR type BOOLEAN default c_boolean_false
      !I_SIMILAR_DOCUMENT_IDS type TT_STRING optional
      !I_SIMILAR_FIELDS type TT_STRING optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_QUERY_NOTICES_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Get Autocomplete Suggestions</p>
    "!   Returns completion query suggestions for the specified prefix.  /n/n
    "!    **Important:** this method is only valid when using the Cloud Pak version of
    "!    Discovery.
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter I_COLLECTION_ID |
    "!   The ID of the collection.
    "! @parameter I_PREFIX |
    "!   The prefix to use for autocompletion. For example, the prefix `Ho` could
    "!    autocomplete to `Hot`, `Housing`, or `How do I upgrade`. Possible completions
    "!    are.
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
      !I_ENVIRONMENT_ID type STRING
      !I_COLLECTION_ID type STRING
      !I_PREFIX type STRING
      !I_FIELD type STRING optional
      !I_COUNT type INTEGER optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_COMPLETIONS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">List training data</p>
    "!   Lists the training data for the specified collection.
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter I_COLLECTION_ID |
    "!   The ID of the collection.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_TRAINING_DATA_SET
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_TRAINING_DATA
    importing
      !I_ENVIRONMENT_ID type STRING
      !I_COLLECTION_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_TRAINING_DATA_SET
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Add query to training data</p>
    "!   Adds a query to the training data for this collection. The query can contain a
    "!    filter and natural language query.
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter I_COLLECTION_ID |
    "!   The ID of the collection.
    "! @parameter I_BODY |
    "!   The body of the training data query that is to be added to the collection&apos;s
    "!    training data.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_TRAINING_QUERY
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods ADD_TRAINING_DATA
    importing
      !I_ENVIRONMENT_ID type STRING
      !I_COLLECTION_ID type STRING
      !I_BODY type T_NEW_TRAINING_QUERY
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_TRAINING_QUERY
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Delete all training data</p>
    "!   Deletes all training data from a collection.
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter I_COLLECTION_ID |
    "!   The ID of the collection.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_ALL_TRAINING_DATA
    importing
      !I_ENVIRONMENT_ID type STRING
      !I_COLLECTION_ID type STRING
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Get details about a query</p>
    "!   Gets details for a specific training data query, including the query string and
    "!    all examples.
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter I_COLLECTION_ID |
    "!   The ID of the collection.
    "! @parameter I_QUERY_ID |
    "!   The ID of the query used for training.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_TRAINING_QUERY
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_TRAINING_DATA
    importing
      !I_ENVIRONMENT_ID type STRING
      !I_COLLECTION_ID type STRING
      !I_QUERY_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_TRAINING_QUERY
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Delete a training data query</p>
    "!   Removes the training data query and all associated examples from the training
    "!    data set.
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter I_COLLECTION_ID |
    "!   The ID of the collection.
    "! @parameter I_QUERY_ID |
    "!   The ID of the query used for training.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_TRAINING_DATA
    importing
      !I_ENVIRONMENT_ID type STRING
      !I_COLLECTION_ID type STRING
      !I_QUERY_ID type STRING
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">List examples for a training data query</p>
    "!   List all examples for this training data query.
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter I_COLLECTION_ID |
    "!   The ID of the collection.
    "! @parameter I_QUERY_ID |
    "!   The ID of the query used for training.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_TRAINING_EXAMPLE_LIST
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_TRAINING_EXAMPLES
    importing
      !I_ENVIRONMENT_ID type STRING
      !I_COLLECTION_ID type STRING
      !I_QUERY_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_TRAINING_EXAMPLE_LIST
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Add example to training data query</p>
    "!   Adds a example to this training data query.
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter I_COLLECTION_ID |
    "!   The ID of the collection.
    "! @parameter I_QUERY_ID |
    "!   The ID of the query used for training.
    "! @parameter I_BODY |
    "!   The body of the example that is to be added to the specified query.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_TRAINING_EXAMPLE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods CREATE_TRAINING_EXAMPLE
    importing
      !I_ENVIRONMENT_ID type STRING
      !I_COLLECTION_ID type STRING
      !I_QUERY_ID type STRING
      !I_BODY type T_TRAINING_EXAMPLE
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_TRAINING_EXAMPLE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Delete example for training data query</p>
    "!   Deletes the example document with the given ID from the training data query.
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter I_COLLECTION_ID |
    "!   The ID of the collection.
    "! @parameter I_QUERY_ID |
    "!   The ID of the query used for training.
    "! @parameter I_EXAMPLE_ID |
    "!   The ID of the document as it is indexed.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_TRAINING_EXAMPLE
    importing
      !I_ENVIRONMENT_ID type STRING
      !I_COLLECTION_ID type STRING
      !I_QUERY_ID type STRING
      !I_EXAMPLE_ID type STRING
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Change label or cross reference for example</p>
    "!   Changes the label or cross reference query for this training data example.
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter I_COLLECTION_ID |
    "!   The ID of the collection.
    "! @parameter I_QUERY_ID |
    "!   The ID of the query used for training.
    "! @parameter I_EXAMPLE_ID |
    "!   The ID of the document as it is indexed.
    "! @parameter I_BODY |
    "!   The body of the example that is to be added to the specified query.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_TRAINING_EXAMPLE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods UPDATE_TRAINING_EXAMPLE
    importing
      !I_ENVIRONMENT_ID type STRING
      !I_COLLECTION_ID type STRING
      !I_QUERY_ID type STRING
      !I_EXAMPLE_ID type STRING
      !I_BODY type T_TRAINING_EXAMPLE_PATCH
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_TRAINING_EXAMPLE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Get details for training data example</p>
    "!   Gets the details for this training example.
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter I_COLLECTION_ID |
    "!   The ID of the collection.
    "! @parameter I_QUERY_ID |
    "!   The ID of the query used for training.
    "! @parameter I_EXAMPLE_ID |
    "!   The ID of the document as it is indexed.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_TRAINING_EXAMPLE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_TRAINING_EXAMPLE
    importing
      !I_ENVIRONMENT_ID type STRING
      !I_COLLECTION_ID type STRING
      !I_QUERY_ID type STRING
      !I_EXAMPLE_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_TRAINING_EXAMPLE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">Delete labeled data</p>
    "!   Deletes all data associated with a specified customer ID. The method has no
    "!    effect if no data is associated with the customer ID. <br/>
    "!   <br/>
    "!   You associate a customer ID with data by passing the **X-Watson-Metadata**
    "!    header with a request that passes data. For more information about personal
    "!    data and customer IDs, see [Information
    "!    security](https://cloud.ibm.com/docs/services/discovery?topic=discovery-informa
    "!   tion-security#information-security).
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

    "! <p class="shorttext synchronized" lang="en">Create event</p>
    "!   The **Events** API can be used to create log entries that are associated with
    "!    specific queries. For example, you can record which documents in the results
    "!    set were &quot;clicked&quot; by a user and when that click occurred.
    "!
    "! @parameter I_QUERY_EVENT |
    "!   An object that defines a query event to be added to the log.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_CREATE_EVENT_RESPONSE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods CREATE_EVENT
    importing
      !I_QUERY_EVENT type T_CREATE_EVENT_OBJECT
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_CREATE_EVENT_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Search the query and event log</p>
    "!   Searches the query and event log to find query sessions that match the specified
    "!    criteria. Searching the **logs** endpoint uses the standard Discovery query
    "!    syntax for the parameters that are supported.
    "!
    "! @parameter I_FILTER |
    "!   A cacheable query that excludes documents that don&apos;t mention the query
    "!    content. Filter searches are better for metadata-type searches and for
    "!    assessing the concepts in the data set.
    "! @parameter I_QUERY |
    "!   A query search returns all documents in your data set with full enrichments and
    "!    full text, but with the most relevant documents listed first.
    "! @parameter I_COUNT |
    "!   Number of results to return. The maximum for the **count** and **offset** values
    "!    together in any one query is **10000**.
    "! @parameter I_OFFSET |
    "!   The number of query results to skip at the beginning. For example, if the total
    "!    number of results that are returned is 10 and the offset is 8, it returns the
    "!    last two results. The maximum for the **count** and **offset** values together
    "!    in any one query is **10000**.
    "! @parameter I_SORT |
    "!   A comma-separated list of fields in the document to sort on. You can optionally
    "!    specify a sort direction by prefixing the field with `-` for descending or `+`
    "!    for ascending. Ascending is the default sort direction if no prefix is
    "!    specified.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_LOG_QUERY_RESPONSE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods QUERY_LOG
    importing
      !I_FILTER type STRING optional
      !I_QUERY type STRING optional
      !I_COUNT type INTEGER optional
      !I_OFFSET type INTEGER optional
      !I_SORT type TT_STRING optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_LOG_QUERY_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Number of queries over time</p>
    "!   Total number of queries using the **natural_language_query** parameter over a
    "!    specific time window.
    "!
    "! @parameter I_START_TIME |
    "!   Metric is computed from data recorded after this timestamp; must be in
    "!    `YYYY-MM-DDThh:mm:ssZ` format.
    "! @parameter I_END_TIME |
    "!   Metric is computed from data recorded before this timestamp; must be in
    "!    `YYYY-MM-DDThh:mm:ssZ` format.
    "! @parameter I_RESULT_TYPE |
    "!   The type of result to consider when calculating the metric.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_METRIC_RESPONSE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_METRICS_QUERY
    importing
      !I_START_TIME type DATETIME optional
      !I_END_TIME type DATETIME optional
      !I_RESULT_TYPE type STRING optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_METRIC_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Number of queries with an event over time</p>
    "!   Total number of queries using the **natural_language_query** parameter that have
    "!    a corresponding &quot;click&quot; event over a specified time window. This
    "!    metric requires having integrated event tracking in your application using the
    "!    **Events** API.
    "!
    "! @parameter I_START_TIME |
    "!   Metric is computed from data recorded after this timestamp; must be in
    "!    `YYYY-MM-DDThh:mm:ssZ` format.
    "! @parameter I_END_TIME |
    "!   Metric is computed from data recorded before this timestamp; must be in
    "!    `YYYY-MM-DDThh:mm:ssZ` format.
    "! @parameter I_RESULT_TYPE |
    "!   The type of result to consider when calculating the metric.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_METRIC_RESPONSE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_METRICS_QUERY_EVENT
    importing
      !I_START_TIME type DATETIME optional
      !I_END_TIME type DATETIME optional
      !I_RESULT_TYPE type STRING optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_METRIC_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Number of queries with no search results over time</p>
    "!   Total number of queries using the **natural_language_query** parameter that have
    "!    no results returned over a specified time window.
    "!
    "! @parameter I_START_TIME |
    "!   Metric is computed from data recorded after this timestamp; must be in
    "!    `YYYY-MM-DDThh:mm:ssZ` format.
    "! @parameter I_END_TIME |
    "!   Metric is computed from data recorded before this timestamp; must be in
    "!    `YYYY-MM-DDThh:mm:ssZ` format.
    "! @parameter I_RESULT_TYPE |
    "!   The type of result to consider when calculating the metric.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_METRIC_RESPONSE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_METRICS_QUERY_NO_RESULTS
    importing
      !I_START_TIME type DATETIME optional
      !I_END_TIME type DATETIME optional
      !I_RESULT_TYPE type STRING optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_METRIC_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Percentage of queries with an associated event</p>
    "!   The percentage of queries using the **natural_language_query** parameter that
    "!    have a corresponding &quot;click&quot; event over a specified time window.
    "!    This metric requires having integrated event tracking in your application using
    "!    the **Events** API.
    "!
    "! @parameter I_START_TIME |
    "!   Metric is computed from data recorded after this timestamp; must be in
    "!    `YYYY-MM-DDThh:mm:ssZ` format.
    "! @parameter I_END_TIME |
    "!   Metric is computed from data recorded before this timestamp; must be in
    "!    `YYYY-MM-DDThh:mm:ssZ` format.
    "! @parameter I_RESULT_TYPE |
    "!   The type of result to consider when calculating the metric.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_METRIC_RESPONSE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_METRICS_EVENT_RATE
    importing
      !I_START_TIME type DATETIME optional
      !I_END_TIME type DATETIME optional
      !I_RESULT_TYPE type STRING optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_METRIC_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Most frequent query tokens with an event</p>
    "!   The most frequent query tokens parsed from the **natural_language_query**
    "!    parameter and their corresponding &quot;click&quot; event rate within the
    "!    recording period (queries and events are stored for 30 days). A query token is
    "!    an individual word or unigram within the query string.
    "!
    "! @parameter I_COUNT |
    "!   Number of results to return. The maximum for the **count** and **offset** values
    "!    together in any one query is **10000**.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_METRIC_TOKEN_RESPONSE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_METRICS_QUERY_TOKEN_EVENT
    importing
      !I_COUNT type INTEGER optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_METRIC_TOKEN_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">List credentials</p>
    "!   List all the source credentials that have been created for this service
    "!    instance.<br/>
    "!   <br/>
    "!    **Note:**  All credentials are sent over an encrypted connection and encrypted
    "!    at rest.
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_CREDENTIALS_LIST
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_CREDENTIALS
    importing
      !I_ENVIRONMENT_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_CREDENTIALS_LIST
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Create credentials</p>
    "!   Creates a set of credentials to connect to a remote source. Created credentials
    "!    are used in a configuration to associate a collection with the remote
    "!    source.<br/>
    "!   <br/>
    "!   **Note:** All credentials are sent over an encrypted connection and encrypted at
    "!    rest.
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter I_CREDENTIALS_PARAMETER |
    "!   An object that defines an individual set of source credentials.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_CREDENTIALS
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods CREATE_CREDENTIALS
    importing
      !I_ENVIRONMENT_ID type STRING
      !I_CREDENTIALS_PARAMETER type T_CREDENTIALS
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_CREDENTIALS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">View Credentials</p>
    "!   Returns details about the specified credentials.<br/>
    "!   <br/>
    "!    **Note:** Secure credential information such as a password or SSH key is never
    "!    returned and must be obtained from the source system.
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter I_CREDENTIAL_ID |
    "!   The unique identifier for a set of source credentials.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_CREDENTIALS
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_CREDENTIALS
    importing
      !I_ENVIRONMENT_ID type STRING
      !I_CREDENTIAL_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_CREDENTIALS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Update credentials</p>
    "!   Updates an existing set of source credentials.<br/>
    "!   <br/>
    "!   **Note:** All credentials are sent over an encrypted connection and encrypted at
    "!    rest.
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter I_CREDENTIAL_ID |
    "!   The unique identifier for a set of source credentials.
    "! @parameter I_CREDENTIALS_PARAMETER |
    "!   An object that defines an individual set of source credentials.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_CREDENTIALS
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods UPDATE_CREDENTIALS
    importing
      !I_ENVIRONMENT_ID type STRING
      !I_CREDENTIAL_ID type STRING
      !I_CREDENTIALS_PARAMETER type T_CREDENTIALS
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_CREDENTIALS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Delete credentials</p>
    "!   Deletes a set of stored credentials from your Discovery instance.
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter I_CREDENTIAL_ID |
    "!   The unique identifier for a set of source credentials.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_DELETE_CREDENTIALS
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_CREDENTIALS
    importing
      !I_ENVIRONMENT_ID type STRING
      !I_CREDENTIAL_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_DELETE_CREDENTIALS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">List Gateways</p>
    "!   List the currently configured gateways.
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_GATEWAY_LIST
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_GATEWAYS
    importing
      !I_ENVIRONMENT_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_GATEWAY_LIST
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Create Gateway</p>
    "!   Create a gateway configuration to use with a remotely installed gateway.
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter I_GATEWAY_NAME |
    "!   The name of the gateway to created.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_GATEWAY
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods CREATE_GATEWAY
    importing
      !I_ENVIRONMENT_ID type STRING
      !I_GATEWAY_NAME type T_GATEWAY_NAME optional
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_GATEWAY
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">List Gateway Details</p>
    "!   List information about the specified gateway.
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter I_GATEWAY_ID |
    "!   The requested gateway ID.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_GATEWAY
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_GATEWAY
    importing
      !I_ENVIRONMENT_ID type STRING
      !I_GATEWAY_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_GATEWAY
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Delete Gateway</p>
    "!   Delete the specified gateway configuration.
    "!
    "! @parameter I_ENVIRONMENT_ID |
    "!   The ID of the environment.
    "! @parameter I_GATEWAY_ID |
    "!   The requested gateway ID.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_GATEWAY_DELETE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_GATEWAY
    importing
      !I_ENVIRONMENT_ID type STRING
      !I_GATEWAY_ID type STRING
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
  e_request_prop-url-path_base   = '/discovery/api'.

endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->GET_SDK_VERSION_DATE
* +-------------------------------------------------------------------------------------------------+
* | [<-()] E_SDK_VERSION_DATE             TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method get_sdk_version_date.

    e_sdk_version_date = '20200310173426'.

  endmethod.



* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->CREATE_ENVIRONMENT
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_BODY        TYPE T_CREATE_ENVIRONMENT_REQUEST
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
* | [--->] I_NAME        TYPE STRING(optional)
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

    if i_NAME is supplied.
    lv_queryparam = escape( val = i_NAME format = cl_abap_format=>e_uri_full ).
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
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
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
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.

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
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
* | [--->] I_BODY        TYPE T_UPDATE_ENVIRONMENT_REQUEST
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
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.

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
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
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
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.

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
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
* | [--->] I_COLLECTION_IDS        TYPE TT_STRING
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
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

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
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
* | [--->] I_CONFIGURATION        TYPE T_CONFIGURATION
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
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.

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
    lv_datatype = get_datatype( i_CONFIGURATION ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_CONFIGURATION i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'configuration' i_value = i_CONFIGURATION ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_CONFIGURATION to <lv_text>.
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
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
* | [--->] I_NAME        TYPE STRING(optional)
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
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_NAME is supplied.
    lv_queryparam = escape( val = i_NAME format = cl_abap_format=>e_uri_full ).
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
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
* | [--->] I_CONFIGURATION_ID        TYPE STRING
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
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.
    replace all occurrences of `{configuration_id}` in ls_request_prop-url-path with i_CONFIGURATION_ID ignoring case.

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
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
* | [--->] I_CONFIGURATION_ID        TYPE STRING
* | [--->] I_CONFIGURATION        TYPE T_CONFIGURATION
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
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.
    replace all occurrences of `{configuration_id}` in ls_request_prop-url-path with i_CONFIGURATION_ID ignoring case.

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
    lv_datatype = get_datatype( i_CONFIGURATION ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_CONFIGURATION i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'configuration' i_value = i_CONFIGURATION ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_CONFIGURATION to <lv_text>.
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
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
* | [--->] I_CONFIGURATION_ID        TYPE STRING
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
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.
    replace all occurrences of `{configuration_id}` in ls_request_prop-url-path with i_CONFIGURATION_ID ignoring case.

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
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
* | [--->] I_BODY        TYPE T_CREATE_COLLECTION_REQUEST
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
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.

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
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
* | [--->] I_NAME        TYPE STRING(optional)
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
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_NAME is supplied.
    lv_queryparam = escape( val = i_NAME format = cl_abap_format=>e_uri_full ).
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
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
* | [--->] I_COLLECTION_ID        TYPE STRING
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
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->UPDATE_COLLECTION
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
* | [--->] I_COLLECTION_ID        TYPE STRING
* | [--->] I_BODY        TYPE T_UPDATE_COLLECTION_REQUEST
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
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.
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
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
* | [--->] I_COLLECTION_ID        TYPE STRING
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
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_COLLECTION_ID ignoring case.

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
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
* | [--->] I_COLLECTION_ID        TYPE STRING
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
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->LIST_EXPANSIONS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
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

    ls_request_prop-url-path = '/v1/environments/{environment_id}/collections/{collection_id}/expansions'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->CREATE_EXPANSIONS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
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

    ls_request_prop-url-path = '/v1/environments/{environment_id}/collections/{collection_id}/expansions'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.
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
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
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

    ls_request_prop-url-path = '/v1/environments/{environment_id}/collections/{collection_id}/expansions'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_COLLECTION_ID ignoring case.

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
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
* | [--->] I_COLLECTION_ID        TYPE STRING
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
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->CREATE_TOKENIZATION_DICTIONARY
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
* | [--->] I_COLLECTION_ID        TYPE STRING
* | [--->] I_TOKENIZATION_DICTIONARY        TYPE T_TOKEN_DICT(optional)
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
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.
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
    if not i_TOKENIZATION_DICTIONARY is initial.
    lv_datatype = get_datatype( i_TOKENIZATION_DICTIONARY ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_TOKENIZATION_DICTIONARY i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'tokenization_dictionary' i_value = i_TOKENIZATION_DICTIONARY ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_TOKENIZATION_DICTIONARY to <lv_text>.
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
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
* | [--->] I_COLLECTION_ID        TYPE STRING
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
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_COLLECTION_ID ignoring case.

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
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
* | [--->] I_COLLECTION_ID        TYPE STRING
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
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->CREATE_STOPWORD_LIST
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
* | [--->] I_COLLECTION_ID        TYPE STRING
* | [--->] I_STOPWORD_FILE        TYPE FILE
* | [--->] I_STOPWORD_FILENAME        TYPE STRING
* | [--->] I_STOPWORD_FILE_CT     TYPE STRING (default = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-all)
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
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.
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




    if not i_STOPWORD_FILE is initial.
      if not I_stopword_filename is initial.
        lv_value = `form-data; name="stopword_file"; filename="` && I_stopword_filename && `"`  ##NO_TEXT.
      else.
      lv_extension = get_file_extension( I_STOPWORD_FILE_CT ).
      lv_value = `form-data; name="stopword_file"; filename="file` && lv_index && `.` && lv_extension && `"`  ##NO_TEXT.
      endif.
      lv_index = lv_index + 1.
      clear ls_form_part.
      ls_form_part-content_type = I_STOPWORD_FILE_CT.
      ls_form_part-content_disposition = lv_value.
      ls_form_part-xdata = i_STOPWORD_FILE.
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
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
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

    ls_request_prop-url-path = '/v1/environments/{environment_id}/collections/{collection_id}/word_lists/stopwords'.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_COLLECTION_ID ignoring case.

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
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
* | [--->] I_COLLECTION_ID        TYPE STRING
* | [--->] I_FILE        TYPE FILE(optional)
* | [--->] I_FILENAME        TYPE STRING(optional)
* | [--->] I_FILE_CONTENT_TYPE        TYPE STRING(optional)
* | [--->] I_METADATA        TYPE STRING(optional)
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
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.
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
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      ls_form_part-content_disposition = 'form-data; name="metadata"'  ##NO_TEXT.
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->GET_DOCUMENT_STATUS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
* | [--->] I_COLLECTION_ID        TYPE STRING
* | [--->] I_DOCUMENT_ID        TYPE STRING
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
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->UPDATE_DOCUMENT
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
* | [--->] I_COLLECTION_ID        TYPE STRING
* | [--->] I_DOCUMENT_ID        TYPE STRING
* | [--->] I_FILE        TYPE FILE(optional)
* | [--->] I_FILENAME        TYPE STRING(optional)
* | [--->] I_FILE_CONTENT_TYPE        TYPE STRING(optional)
* | [--->] I_METADATA        TYPE STRING(optional)
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
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_COLLECTION_ID ignoring case.
    replace all occurrences of `{document_id}` in ls_request_prop-url-path with i_DOCUMENT_ID ignoring case.

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
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      ls_form_part-content_disposition = 'form-data; name="metadata"'  ##NO_TEXT.
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->DELETE_DOCUMENT
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
* | [--->] I_COLLECTION_ID        TYPE STRING
* | [--->] I_DOCUMENT_ID        TYPE STRING
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
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_COLLECTION_ID ignoring case.
    replace all occurrences of `{document_id}` in ls_request_prop-url-path with i_DOCUMENT_ID ignoring case.

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
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
* | [--->] I_COLLECTION_ID        TYPE STRING
* | [--->] I_QUERY_LONG        TYPE T_COLL_QUERY_LARGE(optional)
* | [--->] I_X_WATSON_LOGGING_OPT_OUT        TYPE BOOLEAN (default =c_boolean_false)
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
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.
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

    if i_X_WATSON_LOGGING_OPT_OUT is supplied.
    lv_headerparam = I_X_WATSON_LOGGING_OPT_OUT.
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
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
* | [--->] I_COLLECTION_ID        TYPE STRING
* | [--->] I_FILTER        TYPE STRING(optional)
* | [--->] I_QUERY        TYPE STRING(optional)
* | [--->] I_NATURAL_LANGUAGE_QUERY        TYPE STRING(optional)
* | [--->] I_PASSAGES        TYPE BOOLEAN(optional)
* | [--->] I_AGGREGATION        TYPE STRING(optional)
* | [--->] I_COUNT        TYPE INTEGER(optional)
* | [--->] I_RETURN        TYPE TT_STRING(optional)
* | [--->] I_OFFSET        TYPE INTEGER(optional)
* | [--->] I_SORT        TYPE TT_STRING(optional)
* | [--->] I_HIGHLIGHT        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_PASSAGES_FIELDS        TYPE TT_STRING(optional)
* | [--->] I_PASSAGES_COUNT        TYPE INTEGER(optional)
* | [--->] I_PASSAGES_CHARACTERS        TYPE INTEGER(optional)
* | [--->] I_DEDUPLICATE_FIELD        TYPE STRING(optional)
* | [--->] I_SIMILAR        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_SIMILAR_DOCUMENT_IDS        TYPE TT_STRING(optional)
* | [--->] I_SIMILAR_FIELDS        TYPE TT_STRING(optional)
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
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.
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

    if i_PASSAGES is supplied.
    lv_queryparam = i_PASSAGES.
    add_query_parameter(
      exporting
        i_parameter  = `passages`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_AGGREGATION is supplied.
    lv_queryparam = escape( val = i_AGGREGATION format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `aggregation`
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

    if i_RETURN is supplied.
    data:
      lv_item_RETURN type STRING.
    clear: lv_queryparam, lv_sep.
    loop at i_RETURN into lv_item_RETURN.
      lv_queryparam = lv_queryparam && lv_sep && lv_item_RETURN.
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

    if i_OFFSET is supplied.
    lv_queryparam = i_OFFSET.
    add_query_parameter(
      exporting
        i_parameter  = `offset`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_SORT is supplied.
    data:
      lv_item_SORT type STRING.
    clear: lv_queryparam, lv_sep.
    loop at i_SORT into lv_item_SORT.
      lv_queryparam = lv_queryparam && lv_sep && lv_item_SORT.
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

    if i_HIGHLIGHT is supplied.
    lv_queryparam = i_HIGHLIGHT.
    add_query_parameter(
      exporting
        i_parameter  = `highlight`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_PASSAGES_FIELDS is supplied.
    data:
      lv_item_PASSAGES_FIELDS type STRING.
    clear: lv_queryparam, lv_sep.
    loop at i_PASSAGES_FIELDS into lv_item_PASSAGES_FIELDS.
      lv_queryparam = lv_queryparam && lv_sep && lv_item_PASSAGES_FIELDS.
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

    if i_PASSAGES_COUNT is supplied.
    lv_queryparam = i_PASSAGES_COUNT.
    add_query_parameter(
      exporting
        i_parameter  = `passages.count`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_PASSAGES_CHARACTERS is supplied.
    lv_queryparam = i_PASSAGES_CHARACTERS.
    add_query_parameter(
      exporting
        i_parameter  = `passages.characters`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_DEDUPLICATE_FIELD is supplied.
    lv_queryparam = escape( val = i_DEDUPLICATE_FIELD format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `deduplicate.field`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_SIMILAR is supplied.
    lv_queryparam = i_SIMILAR.
    add_query_parameter(
      exporting
        i_parameter  = `similar`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_SIMILAR_DOCUMENT_IDS is supplied.
    data:
      lv_item_SIMILAR_DOCUMENT_IDS type STRING.
    clear: lv_queryparam, lv_sep.
    loop at i_SIMILAR_DOCUMENT_IDS into lv_item_SIMILAR_DOCUMENT_IDS.
      lv_queryparam = lv_queryparam && lv_sep && lv_item_SIMILAR_DOCUMENT_IDS.
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

    if i_SIMILAR_FIELDS is supplied.
    data:
      lv_item_SIMILAR_FIELDS type STRING.
    clear: lv_queryparam, lv_sep.
    loop at i_SIMILAR_FIELDS into lv_item_SIMILAR_FIELDS.
      lv_queryparam = lv_queryparam && lv_sep && lv_item_SIMILAR_FIELDS.
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
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
* | [--->] I_QUERY_LONG        TYPE T_FED_QUERY_LARGE
* | [--->] I_X_WATSON_LOGGING_OPT_OUT        TYPE BOOLEAN (default =c_boolean_false)
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
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).



    " process header parameters
    data:
      lv_headerparam type string  ##NEEDED.

    if i_X_WATSON_LOGGING_OPT_OUT is supplied.
    lv_headerparam = I_X_WATSON_LOGGING_OPT_OUT.
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
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
* | [--->] I_COLLECTION_IDS        TYPE TT_STRING
* | [--->] I_FILTER        TYPE STRING(optional)
* | [--->] I_QUERY        TYPE STRING(optional)
* | [--->] I_NATURAL_LANGUAGE_QUERY        TYPE STRING(optional)
* | [--->] I_AGGREGATION        TYPE STRING(optional)
* | [--->] I_COUNT        TYPE INTEGER(optional)
* | [--->] I_RETURN        TYPE TT_STRING(optional)
* | [--->] I_OFFSET        TYPE INTEGER(optional)
* | [--->] I_SORT        TYPE TT_STRING(optional)
* | [--->] I_HIGHLIGHT        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_DEDUPLICATE_FIELD        TYPE STRING(optional)
* | [--->] I_SIMILAR        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_SIMILAR_DOCUMENT_IDS        TYPE TT_STRING(optional)
* | [--->] I_SIMILAR_FIELDS        TYPE TT_STRING(optional)
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
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

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

    if i_AGGREGATION is supplied.
    lv_queryparam = escape( val = i_AGGREGATION format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `aggregation`
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

    if i_RETURN is supplied.
    data:
      lv_item_RETURN type STRING.
    clear: lv_queryparam, lv_sep.
    loop at i_RETURN into lv_item_RETURN.
      lv_queryparam = lv_queryparam && lv_sep && lv_item_RETURN.
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

    if i_OFFSET is supplied.
    lv_queryparam = i_OFFSET.
    add_query_parameter(
      exporting
        i_parameter  = `offset`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_SORT is supplied.
    data:
      lv_item_SORT type STRING.
    clear: lv_queryparam, lv_sep.
    loop at i_SORT into lv_item_SORT.
      lv_queryparam = lv_queryparam && lv_sep && lv_item_SORT.
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

    if i_HIGHLIGHT is supplied.
    lv_queryparam = i_HIGHLIGHT.
    add_query_parameter(
      exporting
        i_parameter  = `highlight`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_DEDUPLICATE_FIELD is supplied.
    lv_queryparam = escape( val = i_DEDUPLICATE_FIELD format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `deduplicate.field`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_SIMILAR is supplied.
    lv_queryparam = i_SIMILAR.
    add_query_parameter(
      exporting
        i_parameter  = `similar`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_SIMILAR_DOCUMENT_IDS is supplied.
    data:
      lv_item_SIMILAR_DOCUMENT_IDS type STRING.
    clear: lv_queryparam, lv_sep.
    loop at i_SIMILAR_DOCUMENT_IDS into lv_item_SIMILAR_DOCUMENT_IDS.
      lv_queryparam = lv_queryparam && lv_sep && lv_item_SIMILAR_DOCUMENT_IDS.
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

    if i_SIMILAR_FIELDS is supplied.
    data:
      lv_item_SIMILAR_FIELDS type STRING.
    clear: lv_queryparam, lv_sep.
    loop at i_SIMILAR_FIELDS into lv_item_SIMILAR_FIELDS.
      lv_queryparam = lv_queryparam && lv_sep && lv_item_SIMILAR_FIELDS.
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
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
* | [--->] I_COLLECTION_ID        TYPE STRING
* | [--->] I_PREFIX        TYPE STRING
* | [--->] I_FIELD        TYPE STRING(optional)
* | [--->] I_COUNT        TYPE INTEGER(optional)
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
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_COLLECTION_ID ignoring case.

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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->LIST_TRAINING_DATA
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
* | [--->] I_COLLECTION_ID        TYPE STRING
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
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->ADD_TRAINING_DATA
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
* | [--->] I_COLLECTION_ID        TYPE STRING
* | [--->] I_BODY        TYPE T_NEW_TRAINING_QUERY
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
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.
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
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
* | [--->] I_COLLECTION_ID        TYPE STRING
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
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_COLLECTION_ID ignoring case.

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
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
* | [--->] I_COLLECTION_ID        TYPE STRING
* | [--->] I_QUERY_ID        TYPE STRING
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
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_COLLECTION_ID ignoring case.
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->DELETE_TRAINING_DATA
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
* | [--->] I_COLLECTION_ID        TYPE STRING
* | [--->] I_QUERY_ID        TYPE STRING
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
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_COLLECTION_ID ignoring case.
    replace all occurrences of `{query_id}` in ls_request_prop-url-path with i_QUERY_ID ignoring case.

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
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
* | [--->] I_COLLECTION_ID        TYPE STRING
* | [--->] I_QUERY_ID        TYPE STRING
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
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_COLLECTION_ID ignoring case.
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->CREATE_TRAINING_EXAMPLE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
* | [--->] I_COLLECTION_ID        TYPE STRING
* | [--->] I_QUERY_ID        TYPE STRING
* | [--->] I_BODY        TYPE T_TRAINING_EXAMPLE
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
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_COLLECTION_ID ignoring case.
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
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
* | [--->] I_COLLECTION_ID        TYPE STRING
* | [--->] I_QUERY_ID        TYPE STRING
* | [--->] I_EXAMPLE_ID        TYPE STRING
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
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_COLLECTION_ID ignoring case.
    replace all occurrences of `{query_id}` in ls_request_prop-url-path with i_QUERY_ID ignoring case.
    replace all occurrences of `{example_id}` in ls_request_prop-url-path with i_EXAMPLE_ID ignoring case.

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
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
* | [--->] I_COLLECTION_ID        TYPE STRING
* | [--->] I_QUERY_ID        TYPE STRING
* | [--->] I_EXAMPLE_ID        TYPE STRING
* | [--->] I_BODY        TYPE T_TRAINING_EXAMPLE_PATCH
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
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_COLLECTION_ID ignoring case.
    replace all occurrences of `{query_id}` in ls_request_prop-url-path with i_QUERY_ID ignoring case.
    replace all occurrences of `{example_id}` in ls_request_prop-url-path with i_EXAMPLE_ID ignoring case.

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
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
* | [--->] I_COLLECTION_ID        TYPE STRING
* | [--->] I_QUERY_ID        TYPE STRING
* | [--->] I_EXAMPLE_ID        TYPE STRING
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
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_COLLECTION_ID ignoring case.
    replace all occurrences of `{query_id}` in ls_request_prop-url-path with i_QUERY_ID ignoring case.
    replace all occurrences of `{example_id}` in ls_request_prop-url-path with i_EXAMPLE_ID ignoring case.

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

    ls_request_prop-url-path = '/v1/user_data'.

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


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->CREATE_EVENT
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_QUERY_EVENT        TYPE T_CREATE_EVENT_OBJECT
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
    lv_datatype = get_datatype( i_QUERY_EVENT ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_QUERY_EVENT i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'query_event' i_value = i_QUERY_EVENT ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_QUERY_EVENT to <lv_text>.
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
* | [--->] I_FILTER        TYPE STRING(optional)
* | [--->] I_QUERY        TYPE STRING(optional)
* | [--->] I_COUNT        TYPE INTEGER(optional)
* | [--->] I_OFFSET        TYPE INTEGER(optional)
* | [--->] I_SORT        TYPE TT_STRING(optional)
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

    if i_SORT is supplied.
    data:
      lv_item_SORT type STRING.
    clear: lv_queryparam, lv_sep.
    loop at i_SORT into lv_item_SORT.
      lv_queryparam = lv_queryparam && lv_sep && lv_item_SORT.
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
* | [--->] I_START_TIME        TYPE DATETIME(optional)
* | [--->] I_END_TIME        TYPE DATETIME(optional)
* | [--->] I_RESULT_TYPE        TYPE STRING(optional)
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

    if i_START_TIME is supplied.
    lv_queryparam = i_START_TIME.
    add_query_parameter(
      exporting
        i_parameter  = `start_time`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_END_TIME is supplied.
    lv_queryparam = i_END_TIME.
    add_query_parameter(
      exporting
        i_parameter  = `end_time`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_RESULT_TYPE is supplied.
    lv_queryparam = escape( val = i_RESULT_TYPE format = cl_abap_format=>e_uri_full ).
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
* | [--->] I_START_TIME        TYPE DATETIME(optional)
* | [--->] I_END_TIME        TYPE DATETIME(optional)
* | [--->] I_RESULT_TYPE        TYPE STRING(optional)
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

    if i_START_TIME is supplied.
    lv_queryparam = i_START_TIME.
    add_query_parameter(
      exporting
        i_parameter  = `start_time`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_END_TIME is supplied.
    lv_queryparam = i_END_TIME.
    add_query_parameter(
      exporting
        i_parameter  = `end_time`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_RESULT_TYPE is supplied.
    lv_queryparam = escape( val = i_RESULT_TYPE format = cl_abap_format=>e_uri_full ).
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
* | [--->] I_START_TIME        TYPE DATETIME(optional)
* | [--->] I_END_TIME        TYPE DATETIME(optional)
* | [--->] I_RESULT_TYPE        TYPE STRING(optional)
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

    if i_START_TIME is supplied.
    lv_queryparam = i_START_TIME.
    add_query_parameter(
      exporting
        i_parameter  = `start_time`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_END_TIME is supplied.
    lv_queryparam = i_END_TIME.
    add_query_parameter(
      exporting
        i_parameter  = `end_time`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_RESULT_TYPE is supplied.
    lv_queryparam = escape( val = i_RESULT_TYPE format = cl_abap_format=>e_uri_full ).
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
* | [--->] I_START_TIME        TYPE DATETIME(optional)
* | [--->] I_END_TIME        TYPE DATETIME(optional)
* | [--->] I_RESULT_TYPE        TYPE STRING(optional)
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

    if i_START_TIME is supplied.
    lv_queryparam = i_START_TIME.
    add_query_parameter(
      exporting
        i_parameter  = `start_time`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_END_TIME is supplied.
    lv_queryparam = i_END_TIME.
    add_query_parameter(
      exporting
        i_parameter  = `end_time`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_RESULT_TYPE is supplied.
    lv_queryparam = escape( val = i_RESULT_TYPE format = cl_abap_format=>e_uri_full ).
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
* | [--->] I_COUNT        TYPE INTEGER(optional)
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
* | Instance Public Method ZCL_IBMC_DISCOVERY_V1->LIST_CREDENTIALS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
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
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.

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
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
* | [--->] I_CREDENTIALS_PARAMETER        TYPE T_CREDENTIALS
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
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.

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
    lv_datatype = get_datatype( i_CREDENTIALS_PARAMETER ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_CREDENTIALS_PARAMETER i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'credentials_parameter' i_value = i_CREDENTIALS_PARAMETER ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_CREDENTIALS_PARAMETER to <lv_text>.
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
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
* | [--->] I_CREDENTIAL_ID        TYPE STRING
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
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.
    replace all occurrences of `{credential_id}` in ls_request_prop-url-path with i_CREDENTIAL_ID ignoring case.

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
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
* | [--->] I_CREDENTIAL_ID        TYPE STRING
* | [--->] I_CREDENTIALS_PARAMETER        TYPE T_CREDENTIALS
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
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.
    replace all occurrences of `{credential_id}` in ls_request_prop-url-path with i_CREDENTIAL_ID ignoring case.

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
    lv_datatype = get_datatype( i_CREDENTIALS_PARAMETER ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_CREDENTIALS_PARAMETER i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'credentials_parameter' i_value = i_CREDENTIALS_PARAMETER ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_CREDENTIALS_PARAMETER to <lv_text>.
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
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
* | [--->] I_CREDENTIAL_ID        TYPE STRING
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
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.
    replace all occurrences of `{credential_id}` in ls_request_prop-url-path with i_CREDENTIAL_ID ignoring case.

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
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
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
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.

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
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
* | [--->] I_GATEWAY_NAME        TYPE T_GATEWAY_NAME(optional)
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
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.

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
    if not i_GATEWAY_NAME is initial.
    lv_datatype = get_datatype( i_GATEWAY_NAME ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_GATEWAY_NAME i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'gateway_name' i_value = i_GATEWAY_NAME ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_GATEWAY_NAME to <lv_text>.
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
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
* | [--->] I_GATEWAY_ID        TYPE STRING
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
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.
    replace all occurrences of `{gateway_id}` in ls_request_prop-url-path with i_GATEWAY_ID ignoring case.

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
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
* | [--->] I_GATEWAY_ID        TYPE STRING
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
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.
    replace all occurrences of `{gateway_id}` in ls_request_prop-url-path with i_GATEWAY_ID ignoring case.

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
