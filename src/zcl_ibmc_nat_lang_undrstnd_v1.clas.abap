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
"! <p class="shorttext synchronized" lang="en">Natural Language Understanding</p>
"! Analyze various features of text content at scale. Provide text, raw HTML, or a
"!  public URL and IBM Watson Natural Language Understanding will give you results
"!  for the features you request. The service cleans HTML content before analysis
"!  by default, so the results can ignore most advertisements and other unwanted
"!  content.<br/>
"! <br/>
"! You can create [custom
"!  models](https://cloud.ibm.com/docs/natural-language-understanding?topic=natural
"! -language-understanding-customizing) with Watson Knowledge Studio to detect
"!  custom entities and relations in Natural Language Understanding. <br/>
"! <br/>
"! IBM is sunsetting Watson Natural Language Understanding Custom Sentiment (BETA).
"!  From **June 1, 2023** onward, you will no longer be able to use the Custom
"!  Sentiment feature.&lt;br /&gt;&lt;br /&gt;To ensure we continue providing our
"!  clients with robust and powerful text classification capabilities, IBM recently
"!  announced the general availability of a new [single-label text classification
"!  capability](https://cloud.ibm.com/docs/natural-language-understanding?topic=nat
"! ural-language-understanding-classifications). This new feature includes extended
"!  language support and training data customizations suited for building a custom
"!  sentiment classifier.&lt;br /&gt;&lt;br /&gt;If you would like more information
"!  or further guidance, please contact IBM Cloud Support.&#123;: deprecated&#125; <br/>
class ZCL_IBMC_NAT_LANG_UNDRSTND_V1 DEFINITION
  public
  inheriting from ZCL_IBMC_SERVICE_EXT
  create public .

public section.
  types:
    "! No documentation available.
    begin of T_SEMANTIC_ROLES_ENTITY,
      "!   Entity type.
      TYPE type STRING,
      "!   The entity text.
      TEXT type STRING,
    end of T_SEMANTIC_ROLES_ENTITY.
  types:
    "! No documentation available.
    begin of T_SEMANTIC_ROLES_KEYWORD,
      "!   The keyword text.
      TEXT type STRING,
    end of T_SEMANTIC_ROLES_KEYWORD.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The extracted subject from the sentence.</p>
    begin of T_SMNTC_ROLES_RESULT_SUBJECT,
      "!   Text that corresponds to the subject role.
      TEXT type STRING,
      "!   An array of extracted entities.
      ENTITIES type STANDARD TABLE OF T_SEMANTIC_ROLES_ENTITY WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of extracted keywords.
      KEYWORDS type STANDARD TABLE OF T_SEMANTIC_ROLES_KEYWORD WITH NON-UNIQUE DEFAULT KEY,
    end of T_SMNTC_ROLES_RESULT_SUBJECT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The extracted object from the sentence.</p>
    begin of T_SEMANTIC_ROLES_RESULT_OBJECT,
      "!   Object text.
      TEXT type STRING,
      "!   An array of extracted keywords.
      KEYWORDS type STANDARD TABLE OF T_SEMANTIC_ROLES_KEYWORD WITH NON-UNIQUE DEFAULT KEY,
    end of T_SEMANTIC_ROLES_RESULT_OBJECT.
  types:
    "! No documentation available.
    begin of T_SEMANTIC_ROLES_VERB,
      "!   The keyword text.
      TEXT type STRING,
      "!   Verb tense.
      TENSE type STRING,
    end of T_SEMANTIC_ROLES_VERB.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The extracted action from the sentence.</p>
    begin of T_SEMANTIC_ROLES_RESULT_ACTION,
      "!   Analyzed text that corresponds to the action.
      TEXT type STRING,
      "!   normalized version of the action.
      NORMALIZED type STRING,
      "!   No documentation available.
      VERB type T_SEMANTIC_ROLES_VERB,
    end of T_SEMANTIC_ROLES_RESULT_ACTION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The object containing the actions and the objects the</p>
    "!     actions act upon.
    begin of T_SEMANTIC_ROLES_RESULT,
      "!   Sentence from the source that contains the subject, action, and object.
      SENTENCE type STRING,
      "!   The extracted subject from the sentence.
      SUBJECT type T_SMNTC_ROLES_RESULT_SUBJECT,
      "!   The extracted action from the sentence.
      ACTION type T_SEMANTIC_ROLES_RESULT_ACTION,
      "!   The extracted object from the sentence.
      OBJECT type T_SEMANTIC_ROLES_RESULT_OBJECT,
    end of T_SEMANTIC_ROLES_RESULT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Parses sentences into subject, action, and object form.</p><br/>
    "!    <br/>
    "!    Supported languages: English, German, Japanese, Korean, Spanish.
    begin of T_SEMANTIC_ROLES_OPTIONS,
      "!   Maximum number of semantic_roles results to return.
      LIMIT type INTEGER,
      "!   Set this to `true` to return keyword information for subjects and objects.
      KEYWORDS type BOOLEAN,
      "!   Set this to `true` to return entity information for subjects and objects.
      ENTITIES type BOOLEAN,
    end of T_SEMANTIC_ROLES_OPTIONS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Metadata associated with this custom model.</p>
    begin of T_MODEL_METADATA,
      "!   An optional name for the model.
      NAME type STRING,
      "!   An optional map of metadata key-value pairs to store with this model.
      USER_METADATA type JSONOBJECT,
      "!   The 2-letter language code of this model.
      LANGUAGE type STRING,
      "!   An optional description of the model.
      DESCRIPTION type STRING,
      "!   An optional version string.
      MODEL_VERSION type STRING,
      "!   ID of the Watson Knowledge Studio workspace that deployed this model to Natural
      "!    Language Understanding.
      WORKSPACE_ID type STRING,
      "!   The description of the version.
      VERSION_DESCRIPTION type STRING,
    end of T_MODEL_METADATA.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A list of messages describing model training issues when</p>
    "!     model status is `error`.
    begin of T_NOTICE,
      "!   Describes deficiencies or inconsistencies in training data.
      MESSAGE type STRING,
    end of T_NOTICE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Classifications model.</p>
    begin of T_CLASSIFICATIONS_MODEL,
      "!   An optional name for the model.
      NAME type STRING,
      "!   An optional map of metadata key-value pairs to store with this model.
      USER_METADATA type JSONOBJECT,
      "!   The 2-letter language code of this model.
      LANGUAGE type STRING,
      "!   An optional description of the model.
      DESCRIPTION type STRING,
      "!   An optional version string.
      MODEL_VERSION type STRING,
      "!   ID of the Watson Knowledge Studio workspace that deployed this model to Natural
      "!    Language Understanding.
      WORKSPACE_ID type STRING,
      "!   The description of the version.
      VERSION_DESCRIPTION type STRING,
      "!   The service features that are supported by the custom model.
      FEATURES type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   When the status is `available`, the model is ready to use.
      STATUS type STRING,
      "!   Unique model ID.
      MODEL_ID type STRING,
      "!   dateTime indicating when the model was created.
      CREATED type DATETIME,
      "!   No documentation available.
      NOTICES type STANDARD TABLE OF T_NOTICE WITH NON-UNIQUE DEFAULT KEY,
      "!   dateTime of last successful model training.
      LAST_TRAINED type DATETIME,
      "!   dateTime of last successful model deployment.
      LAST_DEPLOYED type DATETIME,
    end of T_CLASSIFICATIONS_MODEL.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    List of classifications models.</p>
    begin of T_CLASSIFICATIONS_MODEL_LIST,
      "!   The classifications models.
      MODELS type STANDARD TABLE OF T_CLASSIFICATIONS_MODEL WITH NON-UNIQUE DEFAULT KEY,
    end of T_CLASSIFICATIONS_MODEL_LIST.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An entity that corresponds with an argument in a relation.</p>
    begin of T_RELATION_ENTITY,
      "!   Text that corresponds to the entity.
      TEXT type STRING,
      "!   Entity type.
      TYPE type STRING,
    end of T_RELATION_ENTITY.
  types:
    "! No documentation available.
    begin of T_RELATION_ARGUMENT,
      "!   An array of extracted entities.
      ENTITIES type STANDARD TABLE OF T_RELATION_ENTITY WITH NON-UNIQUE DEFAULT KEY,
      "!   Character offsets indicating the beginning and end of the mention in the
      "!    analyzed text.
      LOCATION type STANDARD TABLE OF INTEGER WITH NON-UNIQUE DEFAULT KEY,
      "!   Text that corresponds to the argument.
      TEXT type STRING,
    end of T_RELATION_ARGUMENT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The relations between entities found in the content.</p>
    begin of T_RELATIONS_RESULT,
      "!   Confidence score for the relation. Higher values indicate greater confidence.
      SCORE type DOUBLE,
      "!   The sentence that contains the relation.
      SENTENCE type STRING,
      "!   The type of the relation.
      TYPE type STRING,
      "!   Entity mentions that are involved in the relation.
      ARGUMENTS type STANDARD TABLE OF T_RELATION_ARGUMENT WITH NON-UNIQUE DEFAULT KEY,
    end of T_RELATIONS_RESULT.
  types:
    "! No documentation available.
    begin of T_MODEL,
      "!   When the status is `available`, the model is ready to use.
      STATUS type STRING,
      "!   Unique model ID.
      MODEL_ID type STRING,
      "!   ISO 639-1 code that indicates the language of the model.
      LANGUAGE type STRING,
      "!   Model description.
      DESCRIPTION type STRING,
      "!   ID of the Watson Knowledge Studio workspace that deployed this model to Natural
      "!    Language Understanding.
      WORKSPACE_ID type STRING,
      "!   The model version, if it was manually provided in Watson Knowledge Studio.
      MODEL_VERSION type STRING,
      "!   Deprecated — use `model_version`.
      VERSION type STRING,
      "!   The description of the version, if it was manually provided in Watson Knowledge
      "!    Studio.
      VERSION_DESCRIPTION type STRING,
      "!   A dateTime indicating when the model was created.
      CREATED type DATETIME,
    end of T_MODEL.
  types:
    "! No documentation available.
    begin of T_FEATURE_SENTIMENT_RESULTS,
      "!   Sentiment score from -1 (negative) to 1 (positive).
      SCORE type DOUBLE,
    end of T_FEATURE_SENTIMENT_RESULTS.
  types:
    "! No documentation available.
    begin of T_EMOTION_SCORES,
      "!   Anger score from 0 to 1. A higher score means that the text is more likely to
      "!    convey anger.
      ANGER type DOUBLE,
      "!   Disgust score from 0 to 1. A higher score means that the text is more likely to
      "!    convey disgust.
      DISGUST type DOUBLE,
      "!   Fear score from 0 to 1. A higher score means that the text is more likely to
      "!    convey fear.
      FEAR type DOUBLE,
      "!   Joy score from 0 to 1. A higher score means that the text is more likely to
      "!    convey joy.
      JOY type DOUBLE,
      "!   Sadness score from 0 to 1. A higher score means that the text is more likely to
      "!    convey sadness.
      SADNESS type DOUBLE,
    end of T_EMOTION_SCORES.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The author of the analyzed content.</p>
    begin of T_AUTHOR,
      "!   Name of the author.
      NAME type STRING,
    end of T_AUTHOR.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    RSS or ATOM feed found on the webpage.</p>
    begin of T_FEED,
      "!   URL of the RSS or ATOM feed.
      LINK type STRING,
    end of T_FEED.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Webpage metadata, such as the author and the title of the</p>
    "!     page.
    begin of T_FEATURES_RESULTS_METADATA,
      "!   The authors of the document.
      AUTHORS type STANDARD TABLE OF T_AUTHOR WITH NON-UNIQUE DEFAULT KEY,
      "!   The publication date in the format ISO 8601.
      PUBLICATION_DATE type STRING,
      "!   The title of the document.
      TITLE type STRING,
      "!   URL of a prominent image on the webpage.
      IMAGE type STRING,
      "!   RSS/ATOM feeds found on the webpage.
      FEEDS type STANDARD TABLE OF T_FEED WITH NON-UNIQUE DEFAULT KEY,
    end of T_FEATURES_RESULTS_METADATA.
  types:
    "! No documentation available.
    begin of T_ENTITY_MENTION,
      "!   Entity mention text.
      TEXT type STRING,
      "!   Character offsets indicating the beginning and end of the mention in the
      "!    analyzed text.
      LOCATION type STANDARD TABLE OF INTEGER WITH NON-UNIQUE DEFAULT KEY,
      "!   Confidence in the entity identification from 0 to 1. Higher values indicate
      "!    higher confidence. In standard entities requests, confidence is returned only
      "!    for English text. All entities requests that use custom models return the
      "!    confidence score.
      CONFIDENCE type DOUBLE,
    end of T_ENTITY_MENTION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Disambiguation information for the entity.</p>
    begin of T_DISAMBIGUATION_RESULT,
      "!   Common entity name.
      NAME type STRING,
      "!   Link to the corresponding DBpedia resource.
      DBPEDIA_RESOURCE type STRING,
      "!   Entity subtype information.
      SUBTYPE type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
    end of T_DISAMBIGUATION_RESULT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The important people, places, geopolitical entities and</p>
    "!     other types of entities in your content.
    begin of T_ENTITIES_RESULT,
      "!   Entity type.
      TYPE type STRING,
      "!   The name of the entity.
      TEXT type STRING,
      "!   Relevance score from 0 to 1. Higher values indicate greater relevance.
      RELEVANCE type DOUBLE,
      "!   Confidence in the entity identification from 0 to 1. Higher values indicate
      "!    higher confidence. In standard entities requests, confidence is returned only
      "!    for English text. All entities requests that use custom models return the
      "!    confidence score.
      CONFIDENCE type DOUBLE,
      "!   Entity mentions and locations.
      MENTIONS type STANDARD TABLE OF T_ENTITY_MENTION WITH NON-UNIQUE DEFAULT KEY,
      "!   How many times the entity was mentioned in the text.
      COUNT type INTEGER,
      "!   Emotion analysis results for the entity, enabled with the `emotion` option.
      EMOTION type T_EMOTION_SCORES,
      "!   Sentiment analysis results for the entity, enabled with the `sentiment` option.
      SENTIMENT type T_FEATURE_SENTIMENT_RESULTS,
      "!   Disambiguation information for the entity.
      DISAMBIGUATION type T_DISAMBIGUATION_RESULT,
    end of T_ENTITIES_RESULT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Emotion results for a specified target.</p>
    begin of T_TARGETED_EMOTION_RESULTS,
      "!   Targeted text.
      TEXT type STRING,
      "!   The emotion results for the target.
      EMOTION type T_EMOTION_SCORES,
    end of T_TARGETED_EMOTION_RESULTS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The important keywords in the content, organized by</p>
    "!     relevance.
    begin of T_KEYWORDS_RESULT,
      "!   Number of times the keyword appears in the analyzed text.
      COUNT type INTEGER,
      "!   Relevance score from 0 to 1. Higher values indicate greater relevance.
      RELEVANCE type DOUBLE,
      "!   The keyword text.
      TEXT type STRING,
      "!   Emotion analysis results for the keyword, enabled with the `emotion` option.
      EMOTION type T_EMOTION_SCORES,
      "!   Sentiment analysis results for the keyword, enabled with the `sentiment` option.
      "!
      SENTIMENT type T_FEATURE_SENTIMENT_RESULTS,
    end of T_KEYWORDS_RESULT.
  types:
    "! No documentation available.
    begin of T_TARGETED_SENTIMENT_RESULTS,
      "!   Targeted text.
      TEXT type STRING,
      "!   Sentiment score from -1 (negative) to 1 (positive).
      SCORE type DOUBLE,
    end of T_TARGETED_SENTIMENT_RESULTS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Relevant text that contributed to the categorization.</p>
    begin of T_CATEGORIES_RELEVANT_TEXT,
      "!   Text from the analyzed source that supports the categorization.
      TEXT type STRING,
    end of T_CATEGORIES_RELEVANT_TEXT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Emotion results for the document as a whole.</p>
    begin of T_DOCUMENT_EMOTION_RESULTS,
      "!   Emotion results for the document as a whole.
      EMOTION type T_EMOTION_SCORES,
    end of T_DOCUMENT_EMOTION_RESULTS.
  types:
    "! No documentation available.
    begin of T_DOCUMENT_SENTIMENT_RESULTS,
      "!   Indicates whether the sentiment is positive, neutral, or negative.
      LABEL type STRING,
      "!   Sentiment score from -1 (negative) to 1 (positive).
      SCORE type DOUBLE,
    end of T_DOCUMENT_SENTIMENT_RESULTS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The sentiment of the content.</p>
    begin of T_SENTIMENT_RESULT,
      "!   The document level sentiment.
      DOCUMENT type T_DOCUMENT_SENTIMENT_RESULTS,
      "!   The targeted sentiment to analyze.
      TARGETS type STANDARD TABLE OF T_TARGETED_SENTIMENT_RESULTS WITH NON-UNIQUE DEFAULT KEY,
    end of T_SENTIMENT_RESULT.
  types:
    "! No documentation available.
    begin of T_TOKEN_RESULT,
      "!   The token as it appears in the analyzed text.
      TEXT type STRING,
      "!   The part of speech of the token. For more information about the values, see
      "!    [Universal Dependencies POS tags](https://universaldependencies.org/u/pos/).
      PART_OF_SPEECH type STRING,
      "!   Character offsets indicating the beginning and end of the token in the analyzed
      "!    text.
      LOCATION type STANDARD TABLE OF INTEGER WITH NON-UNIQUE DEFAULT KEY,
      "!   The [lemma](https://wikipedia.org/wiki/Lemma_%28morphology%29) of the token.
      LEMMA type STRING,
    end of T_TOKEN_RESULT.
  types:
    "! No documentation available.
    begin of T_SENTENCE_RESULT,
      "!   The sentence.
      TEXT type STRING,
      "!   Character offsets indicating the beginning and end of the sentence in the
      "!    analyzed text.
      LOCATION type STANDARD TABLE OF INTEGER WITH NON-UNIQUE DEFAULT KEY,
    end of T_SENTENCE_RESULT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Tokens and sentences returned from syntax analysis.</p>
    begin of T_SYNTAX_RESULT,
      "!   No documentation available.
      TOKENS type STANDARD TABLE OF T_TOKEN_RESULT WITH NON-UNIQUE DEFAULT KEY,
      "!   No documentation available.
      SENTENCES type STANDARD TABLE OF T_SENTENCE_RESULT WITH NON-UNIQUE DEFAULT KEY,
    end of T_SYNTAX_RESULT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A classification of the analyzed text.</p>
    begin of T_CLASSIFICATIONS_RESULT,
      "!   Classification assigned to the text.
      CLASS_NAME type STRING,
      "!   Confidence score for the classification. Higher values indicate greater
      "!    confidence.
      CONFIDENCE type DOUBLE,
    end of T_CLASSIFICATIONS_RESULT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The general concepts referenced or alluded to in the</p>
    "!     analyzed text.
    begin of T_CONCEPTS_RESULT,
      "!   Name of the concept.
      TEXT type STRING,
      "!   Relevance score between 0 and 1. Higher scores indicate greater relevance.
      RELEVANCE type DOUBLE,
      "!   Link to the corresponding DBpedia resource.
      DBPEDIA_RESOURCE type STRING,
    end of T_CONCEPTS_RESULT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information that helps to explain what contributed to the</p>
    "!     categories result.
    begin of T_CTGRS_RESULT_EXPLANATION,
      "!   An array of relevant text from the source that contributed to the
      "!    categorization. The sorted array begins with the phrase that contributed most
      "!    significantly to the result, followed by phrases that were less and less
      "!    impactful.
      RELEVANT_TEXT type STANDARD TABLE OF T_CATEGORIES_RELEVANT_TEXT WITH NON-UNIQUE DEFAULT KEY,
    end of T_CTGRS_RESULT_EXPLANATION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A categorization of the analyzed text.</p>
    begin of T_CATEGORIES_RESULT,
      "!   The path to the category through the multi-level taxonomy hierarchy. For more
      "!    information about the categories, see [Categories
      "!    hierarchy](https://cloud.ibm.com/docs/natural-language-understanding?topic=natu
      "!   ral-language-understanding-categories#categories-hierarchy).
      LABEL type STRING,
      "!   Confidence score for the category classification. Higher values indicate greater
      "!    confidence.
      SCORE type DOUBLE,
      "!   Information that helps to explain what contributed to the categories result.
      EXPLANATION type T_CTGRS_RESULT_EXPLANATION,
    end of T_CATEGORIES_RESULT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The detected anger, disgust, fear, joy, or sadness that is</p>
    "!     conveyed by the content. Emotion information can be returned for detected
    "!     entities, keywords, or user-specified target phrases found in the text.
    begin of T_EMOTION_RESULT,
      "!   Emotion results for the document as a whole.
      DOCUMENT type T_DOCUMENT_EMOTION_RESULTS,
      "!   Emotion results for specified targets.
      TARGETS type STANDARD TABLE OF T_TARGETED_EMOTION_RESULTS WITH NON-UNIQUE DEFAULT KEY,
    end of T_EMOTION_RESULT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Analysis results for each requested feature.</p>
    begin of T_FEATURES_RESULTS,
      "!   The general concepts referenced or alluded to in the analyzed text.
      CONCEPTS type STANDARD TABLE OF T_CONCEPTS_RESULT WITH NON-UNIQUE DEFAULT KEY,
      "!   The entities detected in the analyzed text.
      ENTITIES type STANDARD TABLE OF T_ENTITIES_RESULT WITH NON-UNIQUE DEFAULT KEY,
      "!   The keywords from the analyzed text.
      KEYWORDS type STANDARD TABLE OF T_KEYWORDS_RESULT WITH NON-UNIQUE DEFAULT KEY,
      "!   The categories that the service assigned to the analyzed text.
      CATEGORIES type STANDARD TABLE OF T_CATEGORIES_RESULT WITH NON-UNIQUE DEFAULT KEY,
      "!   The classifications assigned to the analyzed text.
      CLASSIFICATIONS type STANDARD TABLE OF T_CLASSIFICATIONS_RESULT WITH NON-UNIQUE DEFAULT KEY,
      "!   The anger, disgust, fear, joy, or sadness conveyed by the content.
      EMOTION type T_EMOTION_RESULT,
      "!   Webpage metadata, such as the author and the title of the page.
      METADATA type T_FEATURES_RESULTS_METADATA,
      "!   The relationships between entities in the content.
      RELATIONS type STANDARD TABLE OF T_RELATIONS_RESULT WITH NON-UNIQUE DEFAULT KEY,
      "!   Sentences parsed into `subject`, `action`, and `object` form.
      SEMANTIC_ROLES type STANDARD TABLE OF T_SEMANTIC_ROLES_RESULT WITH NON-UNIQUE DEFAULT KEY,
      "!   The sentiment of the content.
      SENTIMENT type T_SENTIMENT_RESULT,
      "!   Tokens and sentences returned from syntax analysis.
      SYNTAX type T_SYNTAX_RESULT,
    end of T_FEATURES_RESULTS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The authors, publication date, title, prominent page image,</p>
    "!     and RSS/ATOM feeds of the webpage. Supports URL and HTML input types.
    begin of T_METADATA_RESULT,
      "!   The authors of the document.
      AUTHORS type STANDARD TABLE OF T_AUTHOR WITH NON-UNIQUE DEFAULT KEY,
      "!   The publication date in the format ISO 8601.
      PUBLICATION_DATE type STRING,
      "!   The title of the document.
      TITLE type STRING,
      "!   URL of a prominent image on the webpage.
      IMAGE type STRING,
      "!   RSS/ATOM feeds found on the webpage.
      FEEDS type STANDARD TABLE OF T_FEED WITH NON-UNIQUE DEFAULT KEY,
    end of T_METADATA_RESULT.
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
    "!    Detects anger, disgust, fear, joy, or sadness that is</p>
    "!     conveyed in the content or by the context around target phrases specified in
    "!     the targets parameter. You can analyze emotion for detected entities with
    "!     `entities.emotion` and for keywords with `keywords.emotion`.<br/>
    "!    <br/>
    "!    Supported languages: English.
    begin of T_EMOTION_OPTIONS,
      "!   Set this to `false` to hide document-level emotion results.
      DOCUMENT type BOOLEAN,
      "!   Emotion results will be returned for each target string that is found in the
      "!    document.
      TARGETS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
    end of T_EMOTION_OPTIONS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Usage information.</p>
    begin of T_USAGE,
      "!   Number of features used in the API call.
      FEATURES type INTEGER,
      "!   Number of text characters processed.
      TEXT_CHARACTERS type INTEGER,
      "!   Number of 10,000-character units processed.
      TEXT_UNITS type INTEGER,
    end of T_USAGE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Analyzes the general sentiment of your content or the</p>
    "!     sentiment toward specific target phrases. You can analyze sentiment for
    "!     detected entities with `entities.sentiment` and for keywords with
    "!     `keywords.sentiment`.<br/>
    "!    <br/>
    "!     Supported languages: Arabic, English, French, German, Italian, Japanese,
    "!     Korean, Portuguese, Russian, Spanish.
    begin of T_SENTIMENT_OPTIONS,
      "!   Set this to `false` to hide document-level sentiment results.
      DOCUMENT type BOOLEAN,
      "!   Sentiment results will be returned for each target string that is found in the
      "!    document.
      TARGETS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
    end of T_SENTIMENT_OPTIONS.
  types:
    "! No documentation available.
    begin of T_SEMANTIC_ROLES_ACTION,
      "!   Analyzed text that corresponds to the action.
      TEXT type STRING,
      "!   normalized version of the action.
      NORMALIZED type STRING,
      "!   No documentation available.
      VERB type T_SEMANTIC_ROLES_VERB,
    end of T_SEMANTIC_ROLES_ACTION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Tokenization options.</p>
    begin of T_SYNTAX_OPTIONS_TOKENS,
      "!   Set this to `true` to return the lemma for each token.
      LEMMA type BOOLEAN,
      "!   Set this to `true` to return the part of speech for each token.
      PART_OF_SPEECH type BOOLEAN,
    end of T_SYNTAX_OPTIONS_TOKENS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Metadata associated with this custom model.</p>
    begin of T_FILE_AND_METADATA,
      "!   An optional name for the model.
      NAME type STRING,
      "!   An optional map of metadata key-value pairs to store with this model.
      USER_METADATA type JSONOBJECT,
      "!   The 2-letter language code of this model.
      LANGUAGE type STRING,
      "!   An optional description of the model.
      DESCRIPTION type STRING,
      "!   An optional version string.
      MODEL_VERSION type STRING,
      "!   ID of the Watson Knowledge Studio workspace that deployed this model to Natural
      "!    Language Understanding.
      WORKSPACE_ID type STRING,
      "!   The description of the version.
      VERSION_DESCRIPTION type STRING,
      "!   The advanced rules feature is deprecated. Existing models are supported until 24
      "!    June 2021, but after 10 June 2021, you will not be able to deploy advanced
      "!    rules models to Natural Language Understanding. After 24 June 2021, advanced
      "!    rules models will not run in Natural Language Understanding.<br/>
      "!   <br/>
      "!   Model file exported from the advanced rules editor in Watson Knowledge Studio.
      "!    For more information, see [Creating an advanced rules
      "!    model](https://cloud.ibm.com/docs/watson-knowledge-studio?topic=watson-knowledg
      "!   e-studio-create-advanced-rules-model#create-advanced-rules-model-procedure).
      MODEL type FILE,
    end of T_FILE_AND_METADATA.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    (Experimental) Returns a summary of content. </p><br/>
    "!    <br/>
    "!    Supported languages: English only. <br/>
    "!    <br/>
    "!    Supported regions: Dallas region only.
    begin of T_SUMMARIZATION_OPTIONS,
      "!   Maximum number of summary sentences to return.
      LIMIT type INTEGER,
    end of T_SUMMARIZATION_OPTIONS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Returns important keywords in the content.</p><br/>
    "!    <br/>
    "!    Supported languages: English, French, German, Italian, Japanese, Korean,
    "!     Portuguese, Russian, Spanish, Swedish.
    begin of T_KEYWORDS_OPTIONS,
      "!   Maximum number of keywords to return.
      LIMIT type INTEGER,
      "!   Set this to `true` to return sentiment information for detected keywords.
      SENTIMENT type BOOLEAN,
      "!   Set this to `true` to analyze emotion for detected keywords.
      EMOTION type BOOLEAN,
    end of T_KEYWORDS_OPTIONS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Recognizes when two entities are related and identifies the</p>
    "!     type of relation. For example, an `awardedTo` relation might connect the
    "!     entities &quot;Nobel Prize&quot; and &quot;Albert Einstein&quot;. For more
    "!     information, see [Relation
    "!     types](https://cloud.ibm.com/docs/natural-language-understanding?topic=natural-
    "!    language-understanding-relations).<br/>
    "!    <br/>
    "!    Supported languages: Arabic, English, German, Japanese, Korean, Spanish.
    "!     Chinese, Dutch, French, Italian, and Portuguese custom models are also
    "!     supported.
    begin of T_RELATIONS_OPTIONS,
      "!   Enter a [custom
      "!    model](https://cloud.ibm.com/docs/natural-language-understanding?topic=natural-
      "!   language-understanding-customizing) ID to override the default model.
      MODEL type STRING,
    end of T_RELATIONS_OPTIONS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Identifies people, cities, organizations, and other entities</p>
    "!     in the content. For more information, see [Entity types and
    "!     subtypes](https://cloud.ibm.com/docs/natural-language-understanding?topic=natur
    "!    al-language-understanding-entity-types).<br/>
    "!    <br/>
    "!    Supported languages: English, French, German, Italian, Japanese, Korean,
    "!     Portuguese, Russian, Spanish, Swedish. Arabic, Chinese, and Dutch are supported
    "!     only through custom models.
    begin of T_ENTITIES_OPTIONS,
      "!   Maximum number of entities to return.
      LIMIT type INTEGER,
      "!   Set this to `true` to return locations of entity mentions.
      MENTIONS type BOOLEAN,
      "!   Enter a [custom
      "!    model](https://cloud.ibm.com/docs/natural-language-understanding?topic=natural-
      "!   language-understanding-customizing) ID to override the standard entity detection
      "!    model.
      MODEL type STRING,
      "!   Set this to `true` to return sentiment information for detected entities.
      SENTIMENT type BOOLEAN,
      "!   Set this to `true` to analyze emotion for detected keywords.
      EMOTION type BOOLEAN,
    end of T_ENTITIES_OPTIONS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Returns high-level concepts in the content. For example, a</p>
    "!     research paper about deep learning might return the concept, &quot;Artificial
    "!     Intelligence&quot; although the term is not mentioned.<br/>
    "!    <br/>
    "!    Supported languages: English, French, German, Italian, Japanese, Korean,
    "!     Portuguese, Spanish.
    begin of T_CONCEPTS_OPTIONS,
      "!   Maximum number of concepts to return.
      LIMIT type INTEGER,
    end of T_CONCEPTS_OPTIONS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Returns tokens and sentences from the input text.</p>
    begin of T_SYNTAX_OPTIONS,
      "!   Tokenization options.
      TOKENS type T_SYNTAX_OPTIONS_TOKENS,
      "!   Set this to `true` to return sentence information.
      SENTENCES type BOOLEAN,
    end of T_SYNTAX_OPTIONS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Returns text classifications for the content.</p>
    begin of T_CLASSIFICATIONS_OPTIONS,
      "!   Enter a [custom
      "!    model](https://cloud.ibm.com/docs/natural-language-understanding?topic=natural-
      "!   language-understanding-customizing) ID of the classifications model to be used.
      "!    <br/>
      "!   <br/>
      "!   You can analyze tone by using a language-specific model ID. See [Tone analytics
      "!    (Classifications)](https://cloud.ibm.com/docs/natural-language-understanding?to
      "!   pic=natural-language-understanding-tone_analytics) for more information.
      MODEL type STRING,
    end of T_CLASSIFICATIONS_OPTIONS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Returns a hierarchical taxonomy of the content. The top</p>
    "!     three categories are returned by default. <br/>
    "!    <br/>
    "!    Supported languages: Arabic, English, French, German, Italian, Japanese, Korean,
    "!     Portuguese, Spanish.
    begin of T_CATEGORIES_OPTIONS,
      "!   Set this to `true` to return explanations for each categorization. **This is
      "!    available only for English categories.**.
      EXPLANATION type BOOLEAN,
      "!   Maximum number of categories to return.
      LIMIT type INTEGER,
      "!   (Beta) Enter a [custom
      "!    model](https://cloud.ibm.com/docs/natural-language-understanding?topic=natural-
      "!   language-understanding-customizing) ID to override the standard categories
      "!    model. **This is available only for English categories.**.
      MODEL type STRING,
    end of T_CATEGORIES_OPTIONS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Analysis features and options.</p>
    begin of T_FEATURES,
      "!   Returns text classifications for the content.
      CLASSIFICATIONS type T_CLASSIFICATIONS_OPTIONS,
      "!   Returns high-level concepts in the content. For example, a research paper about
      "!    deep learning might return the concept, &quot;Artificial Intelligence&quot;
      "!    although the term is not mentioned.<br/>
      "!   <br/>
      "!   Supported languages: English, French, German, Italian, Japanese, Korean,
      "!    Portuguese, Spanish.
      CONCEPTS type T_CONCEPTS_OPTIONS,
      "!   Detects anger, disgust, fear, joy, or sadness that is conveyed in the content or
      "!    by the context around target phrases specified in the targets parameter. You
      "!    can analyze emotion for detected entities with `entities.emotion` and for
      "!    keywords with `keywords.emotion`.<br/>
      "!   <br/>
      "!   Supported languages: English.
      EMOTION type T_EMOTION_OPTIONS,
      "!   Identifies people, cities, organizations, and other entities in the content. For
      "!    more information, see [Entity types and
      "!    subtypes](https://cloud.ibm.com/docs/natural-language-understanding?topic=natur
      "!   al-language-understanding-entity-types).<br/>
      "!   <br/>
      "!   Supported languages: English, French, German, Italian, Japanese, Korean,
      "!    Portuguese, Russian, Spanish, Swedish. Arabic, Chinese, and Dutch are supported
      "!    only through custom models.
      ENTITIES type T_ENTITIES_OPTIONS,
      "!   Returns important keywords in the content.<br/>
      "!   <br/>
      "!   Supported languages: English, French, German, Italian, Japanese, Korean,
      "!    Portuguese, Russian, Spanish, Swedish.
      KEYWORDS type T_KEYWORDS_OPTIONS,
      "!   Returns information from the document, including author name, title, RSS/ATOM
      "!    feeds, prominent page image, and publication date. Supports URL and HTML input
      "!    types only.
      METADATA type JSONOBJECT,
      "!   Recognizes when two entities are related and identifies the type of relation.
      "!    For example, an `awardedTo` relation might connect the entities &quot;Nobel
      "!    Prize&quot; and &quot;Albert Einstein&quot;. For more information, see
      "!    [Relation
      "!    types](https://cloud.ibm.com/docs/natural-language-understanding?topic=natural-
      "!   language-understanding-relations).<br/>
      "!   <br/>
      "!   Supported languages: Arabic, English, German, Japanese, Korean, Spanish.
      "!    Chinese, Dutch, French, Italian, and Portuguese custom models are also
      "!    supported.
      RELATIONS type T_RELATIONS_OPTIONS,
      "!   Parses sentences into subject, action, and object form.<br/>
      "!   <br/>
      "!   Supported languages: English, German, Japanese, Korean, Spanish.
      SEMANTIC_ROLES type T_SEMANTIC_ROLES_OPTIONS,
      "!   Analyzes the general sentiment of your content or the sentiment toward specific
      "!    target phrases. You can analyze sentiment for detected entities with
      "!    `entities.sentiment` and for keywords with `keywords.sentiment`.<br/>
      "!   <br/>
      "!    Supported languages: Arabic, English, French, German, Italian, Japanese,
      "!    Korean, Portuguese, Russian, Spanish.
      SENTIMENT type T_SENTIMENT_OPTIONS,
      "!   (Experimental) Returns a summary of content. <br/>
      "!   <br/>
      "!   Supported languages: English only. <br/>
      "!   <br/>
      "!   Supported regions: Dallas region only.
      SUMMARIZATION type T_SUMMARIZATION_OPTIONS,
      "!   Returns a hierarchical taxonomy of the content. The top three categories are
      "!    returned by default. <br/>
      "!   <br/>
      "!   Supported languages: Arabic, English, French, German, Italian, Japanese, Korean,
      "!    Portuguese, Spanish.
      CATEGORIES type T_CATEGORIES_OPTIONS,
      "!   Returns tokens and sentences from the input text.
      SYNTAX type T_SYNTAX_OPTIONS,
    end of T_FEATURES.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Metadata associated with this custom model.</p>
    begin of T_CLSSFCTNS_MDL_FL_AND_MTDT,
      "!   An optional name for the model.
      NAME type STRING,
      "!   An optional map of metadata key-value pairs to store with this model.
      USER_METADATA type JSONOBJECT,
      "!   The 2-letter language code of this model.
      LANGUAGE type STRING,
      "!   An optional description of the model.
      DESCRIPTION type STRING,
      "!   An optional version string.
      MODEL_VERSION type STRING,
      "!   ID of the Watson Knowledge Studio workspace that deployed this model to Natural
      "!    Language Understanding.
      WORKSPACE_ID type STRING,
      "!   The description of the version.
      VERSION_DESCRIPTION type STRING,
      "!   Training data in JSON format. For more information, see [Classifications
      "!    training data
      "!    requirements](https://cloud.ibm.com/docs/natural-language-understanding?topic=n
      "!   atural-language-understanding-classifications#classification-training-data-requi
      "!   rements).
      TRAINING_DATA type FILE,
    end of T_CLSSFCTNS_MDL_FL_AND_MTDT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The advanced rules feature is deprecated. Existing models</p>
    "!     are supported until 24 June 2021, but after 10 June 2021, you will not be able
    "!     to deploy advanced rules models to Natural Language Understanding. After 24
    "!     June 2021, advanced rules models will not run in Natural Language
    "!     Understanding.<br/>
    "!    <br/>
    "!    Advanced rules model.
    begin of T_BASE_ADVANCED_RULES_MODEL,
      "!   An optional name for the model.
      NAME type STRING,
      "!   An optional map of metadata key-value pairs to store with this model.
      USER_METADATA type JSONOBJECT,
      "!   The 2-letter language code of this model.
      LANGUAGE type STRING,
      "!   An optional description of the model.
      DESCRIPTION type STRING,
      "!   An optional version string.
      MODEL_VERSION type STRING,
      "!   ID of the Watson Knowledge Studio workspace that deployed this model to Natural
      "!    Language Understanding.
      WORKSPACE_ID type STRING,
      "!   The description of the version.
      VERSION_DESCRIPTION type STRING,
      "!   The service features that are supported by the custom model.
      FEATURES type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   When the status is `available`, the model is ready to use.
      STATUS type STRING,
      "!   Unique model ID.
      MODEL_ID type STRING,
      "!   dateTime indicating when the model was created.
      CREATED type DATETIME,
      "!   No documentation available.
      NOTICES type STANDARD TABLE OF T_NOTICE WITH NON-UNIQUE DEFAULT KEY,
      "!   dateTime of last successful model training.
      LAST_TRAINED type DATETIME,
      "!   dateTime of last successful model deployment.
      LAST_DEPLOYED type DATETIME,
    end of T_BASE_ADVANCED_RULES_MODEL.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    API usage information for the request.</p>
    begin of T_ANALYSIS_RESULTS_USAGE,
      "!   Number of features used in the API call.
      FEATURES type INTEGER,
      "!   Number of text characters processed.
      TEXT_CHARACTERS type INTEGER,
      "!   Number of 10,000-character units processed.
      TEXT_UNITS type INTEGER,
    end of T_ANALYSIS_RESULTS_USAGE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Results of the analysis, organized by feature.</p>
    begin of T_ANALYSIS_RESULTS,
      "!   Language used to analyze the text.
      LANGUAGE type STRING,
      "!   Text that was used in the analysis.
      ANALYZED_TEXT type STRING,
      "!   URL of the webpage that was analyzed.
      RETRIEVED_URL type STRING,
      "!   API usage information for the request.
      USAGE type T_ANALYSIS_RESULTS_USAGE,
      "!   The general concepts referenced or alluded to in the analyzed text.
      CONCEPTS type STANDARD TABLE OF T_CONCEPTS_RESULT WITH NON-UNIQUE DEFAULT KEY,
      "!   The entities detected in the analyzed text.
      ENTITIES type STANDARD TABLE OF T_ENTITIES_RESULT WITH NON-UNIQUE DEFAULT KEY,
      "!   The keywords from the analyzed text.
      KEYWORDS type STANDARD TABLE OF T_KEYWORDS_RESULT WITH NON-UNIQUE DEFAULT KEY,
      "!   The categories that the service assigned to the analyzed text.
      CATEGORIES type STANDARD TABLE OF T_CATEGORIES_RESULT WITH NON-UNIQUE DEFAULT KEY,
      "!   The classifications assigned to the analyzed text.
      CLASSIFICATIONS type STANDARD TABLE OF T_CLASSIFICATIONS_RESULT WITH NON-UNIQUE DEFAULT KEY,
      "!   The anger, disgust, fear, joy, or sadness conveyed by the content.
      EMOTION type T_EMOTION_RESULT,
      "!   Webpage metadata, such as the author and the title of the page.
      METADATA type T_FEATURES_RESULTS_METADATA,
      "!   The relationships between entities in the content.
      RELATIONS type STANDARD TABLE OF T_RELATIONS_RESULT WITH NON-UNIQUE DEFAULT KEY,
      "!   Sentences parsed into `subject`, `action`, and `object` form.
      SEMANTIC_ROLES type STANDARD TABLE OF T_SEMANTIC_ROLES_RESULT WITH NON-UNIQUE DEFAULT KEY,
      "!   The sentiment of the content.
      SENTIMENT type T_SENTIMENT_RESULT,
      "!   Tokens and sentences returned from syntax analysis.
      SYNTAX type T_SYNTAX_RESULT,
    end of T_ANALYSIS_RESULTS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Categories model.</p>
    begin of T_CATEGORIES_MODEL,
      "!   An optional name for the model.
      NAME type STRING,
      "!   An optional map of metadata key-value pairs to store with this model.
      USER_METADATA type JSONOBJECT,
      "!   The 2-letter language code of this model.
      LANGUAGE type STRING,
      "!   An optional description of the model.
      DESCRIPTION type STRING,
      "!   An optional version string.
      MODEL_VERSION type STRING,
      "!   ID of the Watson Knowledge Studio workspace that deployed this model to Natural
      "!    Language Understanding.
      WORKSPACE_ID type STRING,
      "!   The description of the version.
      VERSION_DESCRIPTION type STRING,
      "!   The service features that are supported by the custom model.
      FEATURES type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   When the status is `available`, the model is ready to use.
      STATUS type STRING,
      "!   Unique model ID.
      MODEL_ID type STRING,
      "!   dateTime indicating when the model was created.
      CREATED type DATETIME,
      "!   No documentation available.
      NOTICES type STANDARD TABLE OF T_NOTICE WITH NON-UNIQUE DEFAULT KEY,
      "!   dateTime of last successful model training.
      LAST_TRAINED type DATETIME,
      "!   dateTime of last successful model deployment.
      LAST_DEPLOYED type DATETIME,
    end of T_CATEGORIES_MODEL.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    List of categories models.</p>
    begin of T_CATEGORIES_MODEL_LIST,
      "!   The categories models.
      MODELS type STANDARD TABLE OF T_CATEGORIES_MODEL WITH NON-UNIQUE DEFAULT KEY,
    end of T_CATEGORIES_MODEL_LIST.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Optional classifications training parameters along with</p>
    "!     model train requests.
    begin of T_CLSSFCTNS_TRNNG_PARAMETERS,
      "!   Model type selector to train either a single_label or a multi_label classifier.
      MODEL_TYPE type STRING,
    end of T_CLSSFCTNS_TRNNG_PARAMETERS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Metadata associated with this custom model.</p>
    begin of T_CLSSFCTNS_MDL_FL_MTDT_AND_T1,
      "!   An optional name for the model.
      NAME type STRING,
      "!   An optional map of metadata key-value pairs to store with this model.
      USER_METADATA type JSONOBJECT,
      "!   The 2-letter language code of this model.
      LANGUAGE type STRING,
      "!   An optional description of the model.
      DESCRIPTION type STRING,
      "!   An optional version string.
      MODEL_VERSION type STRING,
      "!   ID of the Watson Knowledge Studio workspace that deployed this model to Natural
      "!    Language Understanding.
      WORKSPACE_ID type STRING,
      "!   The description of the version.
      VERSION_DESCRIPTION type STRING,
      "!   Training data in JSON format. For more information, see [Classifications
      "!    training data
      "!    requirements](https://cloud.ibm.com/docs/natural-language-understanding?topic=n
      "!   atural-language-understanding-classifications#classification-training-data-requi
      "!   rements).
      TRAINING_DATA type FILE,
      "!   Optional classifications training parameters along with model train requests.
      TRAINING_PARAMETERS type T_CLSSFCTNS_TRNNG_PARAMETERS,
    end of T_CLSSFCTNS_MDL_FL_MTDT_AND_T1.
  types:
    "! No documentation available.
    begin of T_SEMANTIC_ROLES_SUBJECT,
      "!   Text that corresponds to the subject role.
      TEXT type STRING,
      "!   An array of extracted entities.
      ENTITIES type STANDARD TABLE OF T_SEMANTIC_ROLES_ENTITY WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of extracted keywords.
      KEYWORDS type STANDARD TABLE OF T_SEMANTIC_ROLES_KEYWORD WITH NON-UNIQUE DEFAULT KEY,
    end of T_SEMANTIC_ROLES_SUBJECT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    (Experimental) Summary of content.</p>
    begin of T_SUMMARIZATION_RESULT,
      "!   Summary sentences of input source.
      TEXT type STRING,
    end of T_SUMMARIZATION_RESULT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The advanced rules feature is deprecated. Existing models</p>
    "!     are supported until 24 June 2021, but after 10 June 2021, you will not be able
    "!     to deploy advanced rules models to Natural Language Understanding. After 24
    "!     June 2021, advanced rules models will not run in Natural Language
    "!     Understanding.<br/>
    "!    <br/>
    "!    Advanced rules model.
    begin of T_ADVANCED_RULES_MODEL,
      "!   An optional name for the model.
      NAME type STRING,
      "!   An optional map of metadata key-value pairs to store with this model.
      USER_METADATA type JSONOBJECT,
      "!   The 2-letter language code of this model.
      LANGUAGE type STRING,
      "!   An optional description of the model.
      DESCRIPTION type STRING,
      "!   An optional version string.
      MODEL_VERSION type STRING,
      "!   ID of the Watson Knowledge Studio workspace that deployed this model to Natural
      "!    Language Understanding.
      WORKSPACE_ID type STRING,
      "!   The description of the version.
      VERSION_DESCRIPTION type STRING,
      "!   The service features that are supported by the custom model.
      FEATURES type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   When the status is `available`, the model is ready to use.
      STATUS type STRING,
      "!   Unique model ID.
      MODEL_ID type STRING,
      "!   dateTime indicating when the model was created.
      CREATED type DATETIME,
      "!   No documentation available.
      NOTICES type STANDARD TABLE OF T_NOTICE WITH NON-UNIQUE DEFAULT KEY,
      "!   dateTime of last successful model training.
      LAST_TRAINED type DATETIME,
      "!   dateTime of last successful model deployment.
      LAST_DEPLOYED type DATETIME,
    end of T_ADVANCED_RULES_MODEL.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The advanced rules feature is deprecated. Existing models</p>
    "!     are supported until 24 June 2021, but after 10 June 2021, you will not be able
    "!     to deploy advanced rules models to Natural Language Understanding. After 24
    "!     June 2021, advanced rules models will not run in Natural Language
    "!     Understanding.<br/>
    "!    <br/>
    "!    List of advanced rules models.
    begin of T_ADVANCED_RULES_MODEL_LIST,
      "!   The advanced rules models.
      MODELS type STANDARD TABLE OF T_ADVANCED_RULES_MODEL WITH NON-UNIQUE DEFAULT KEY,
    end of T_ADVANCED_RULES_MODEL_LIST.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Custom models that are available for entities and relations.</p>
    begin of T_LIST_MODELS_RESULTS,
      "!   An array of available models.
      MODELS type STANDARD TABLE OF T_MODEL WITH NON-UNIQUE DEFAULT KEY,
    end of T_LIST_MODELS_RESULTS.
  types:
    "! No documentation available.
    begin of T_SEMANTIC_ROLES_OBJECT,
      "!   Object text.
      TEXT type STRING,
      "!   An array of extracted keywords.
      KEYWORDS type STANDARD TABLE OF T_SEMANTIC_ROLES_KEYWORD WITH NON-UNIQUE DEFAULT KEY,
    end of T_SEMANTIC_ROLES_OBJECT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Returns information from the document, including author</p>
    "!     name, title, RSS/ATOM feeds, prominent page image, and publication date.
    "!     Supports URL and HTML input types only.
      T_METADATA_OPTIONS type JSONOBJECT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object containing request parameters.</p>
    begin of T_PARAMETERS,
      "!   The plain text to analyze. One of the `text`, `html`, or `url` parameters is
      "!    required.
      TEXT type STRING,
      "!   The HTML file to analyze. One of the `text`, `html`, or `url` parameters is
      "!    required.
      HTML type STRING,
      "!   The webpage to analyze. One of the `text`, `html`, or `url` parameters is
      "!    required.
      URL type STRING,
      "!   Specific features to analyze the document for.
      FEATURES type T_FEATURES,
      "!   Set this to `false` to disable webpage cleaning. For more information about
      "!    webpage cleaning, see [Analyzing
      "!    webpages](https://cloud.ibm.com/docs/natural-language-understanding?topic=natur
      "!   al-language-understanding-analyzing-webpages).
      CLEAN type BOOLEAN,
      "!   An [XPath
      "!    query](https://cloud.ibm.com/docs/natural-language-understanding?topic=natural-
      "!   language-understanding-analyzing-webpages#xpath) to perform on `html` or `url`
      "!    input. Results of the query will be appended to the cleaned webpage text before
      "!    it is analyzed. To analyze only the results of the XPath query, set the `clean`
      "!    parameter to `false`.
      XPATH type STRING,
      "!   Whether to use raw HTML content if text cleaning fails.
      FALLBACK_TO_RAW type BOOLEAN,
      "!   Whether or not to return the analyzed text.
      RETURN_ANALYZED_TEXT type BOOLEAN,
      "!   ISO 639-1 code that specifies the language of your text. This overrides
      "!    automatic language detection. Language support differs depending on the
      "!    features you include in your analysis. For more information, see [Language
      "!    support](https://cloud.ibm.com/docs/natural-language-understanding?topic=natura
      "!   l-language-understanding-language-support).
      LANGUAGE type STRING,
      "!   Sets the maximum number of characters that are processed by the service.
      LIMIT_TEXT_CHARACTERS type INTEGER,
    end of T_PARAMETERS.
  types:
    "! No documentation available.
    begin of T_SENTIMENT_MODEL,
      "!   The service features that are supported by the custom model.
      FEATURES type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   When the status is `available`, the model is ready to use.
      STATUS type STRING,
      "!   Unique model ID.
      MODEL_ID type STRING,
      "!   dateTime indicating when the model was created.
      CREATED type DATETIME,
      "!   dateTime of last successful model training.
      LAST_TRAINED type DATETIME,
      "!   dateTime of last successful model deployment.
      LAST_DEPLOYED type DATETIME,
      "!   A name for the model.
      NAME type STRING,
      "!   An optional map of metadata key-value pairs to store with this model.
      USER_METADATA type JSONOBJECT,
      "!   The 2-letter language code of this model.
      LANGUAGE type STRING,
      "!   An optional description of the model.
      DESCRIPTION type STRING,
      "!   An optional version string.
      MODEL_VERSION type STRING,
      "!   No documentation available.
      NOTICES type STANDARD TABLE OF T_NOTICE WITH NON-UNIQUE DEFAULT KEY,
      "!   ID of the Watson Knowledge Studio workspace that deployed this model to Natural
      "!    Language Understanding.
      WORKSPACE_ID type STRING,
      "!   The description of the version.
      VERSION_DESCRIPTION type STRING,
    end of T_SENTIMENT_MODEL.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Metadata associated with this custom model.</p>
    begin of T_CTGRS_MDL_FILE_AND_METADATA,
      "!   An optional name for the model.
      NAME type STRING,
      "!   An optional map of metadata key-value pairs to store with this model.
      USER_METADATA type JSONOBJECT,
      "!   The 2-letter language code of this model.
      LANGUAGE type STRING,
      "!   An optional description of the model.
      DESCRIPTION type STRING,
      "!   An optional version string.
      MODEL_VERSION type STRING,
      "!   ID of the Watson Knowledge Studio workspace that deployed this model to Natural
      "!    Language Understanding.
      WORKSPACE_ID type STRING,
      "!   The description of the version.
      VERSION_DESCRIPTION type STRING,
      "!   Training data in JSON format. For more information, see [Categories training
      "!    data
      "!    requirements](https://cloud.ibm.com/docs/natural-language-understanding?topic=n
      "!   atural-language-understanding-categories##categories-training-data-requirements)
      "!   .
      TRAINING_DATA type FILE,
    end of T_CTGRS_MDL_FILE_AND_METADATA.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Link to the corresponding DBpedia resource.</p>
      T_DBPEDIA_RESOURCE type String.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Metadata associated with this custom model.</p>
    begin of T_SNTMNT_MDL_FILE_AND_METADATA,
      "!   An optional name for the model.
      NAME type STRING,
      "!   An optional map of metadata key-value pairs to store with this model.
      USER_METADATA type JSONOBJECT,
      "!   The 2-letter language code of this model.
      LANGUAGE type STRING,
      "!   An optional description of the model.
      DESCRIPTION type STRING,
      "!   An optional version string.
      MODEL_VERSION type STRING,
      "!   ID of the Watson Knowledge Studio workspace that deployed this model to Natural
      "!    Language Understanding.
      WORKSPACE_ID type STRING,
      "!   The description of the version.
      VERSION_DESCRIPTION type STRING,
      "!   Training data in CSV format. For more information, see [Sentiment training data
      "!    requirements](https://cloud.ibm.com/docs/natural-language-understanding?topic=n
      "!   atural-language-understanding-custom-sentiment#sentiment-training-data-requireme
      "!   nts).
      TRAINING_DATA type FILE,
    end of T_SNTMNT_MDL_FILE_AND_METADATA.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Metadata associated with this custom model.</p>
    begin of T_MODEL_FILE_AND_METADATA,
      "!   An optional name for the model.
      NAME type STRING,
      "!   An optional map of metadata key-value pairs to store with this model.
      USER_METADATA type JSONOBJECT,
      "!   The 2-letter language code of this model.
      LANGUAGE type STRING,
      "!   An optional description of the model.
      DESCRIPTION type STRING,
      "!   An optional version string.
      MODEL_VERSION type STRING,
      "!   ID of the Watson Knowledge Studio workspace that deployed this model to Natural
      "!    Language Understanding.
      WORKSPACE_ID type STRING,
      "!   The description of the version.
      VERSION_DESCRIPTION type STRING,
      "!   No documentation available.
      FILE type FILE,
    end of T_MODEL_FILE_AND_METADATA.
  types:
    "! No documentation available.
      T_ADVNCD_RLS_ANALYSIS_RESULTS type JSONOBJECT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Delete model results.</p>
    begin of T_DELETE_MODEL_RESULTS,
      "!   model_id of the deleted model.
      DELETED type STRING,
    end of T_DELETE_MODEL_RESULTS.

constants:
  "! <p class="shorttext synchronized" lang="en">List of required fields per type.</p>
  begin of C_REQUIRED_FIELDS,
    T_SEMANTIC_ROLES_ENTITY type string value '|',
    T_SEMANTIC_ROLES_KEYWORD type string value '|',
    T_SMNTC_ROLES_RESULT_SUBJECT type string value '|',
    T_SEMANTIC_ROLES_RESULT_OBJECT type string value '|',
    T_SEMANTIC_ROLES_VERB type string value '|',
    T_SEMANTIC_ROLES_RESULT_ACTION type string value '|',
    T_SEMANTIC_ROLES_RESULT type string value '|',
    T_SEMANTIC_ROLES_OPTIONS type string value '|',
    T_MODEL_METADATA type string value '|LANGUAGE|',
    T_NOTICE type string value '|',
    T_CLASSIFICATIONS_MODEL type string value '|LANGUAGE|STATUS|MODEL_ID|CREATED|',
    T_CLASSIFICATIONS_MODEL_LIST type string value '|',
    T_RELATION_ENTITY type string value '|',
    T_RELATION_ARGUMENT type string value '|',
    T_RELATIONS_RESULT type string value '|',
    T_MODEL type string value '|',
    T_FEATURE_SENTIMENT_RESULTS type string value '|',
    T_EMOTION_SCORES type string value '|',
    T_AUTHOR type string value '|',
    T_FEED type string value '|',
    T_FEATURES_RESULTS_METADATA type string value '|',
    T_ENTITY_MENTION type string value '|',
    T_DISAMBIGUATION_RESULT type string value '|',
    T_ENTITIES_RESULT type string value '|',
    T_TARGETED_EMOTION_RESULTS type string value '|',
    T_KEYWORDS_RESULT type string value '|',
    T_TARGETED_SENTIMENT_RESULTS type string value '|',
    T_CATEGORIES_RELEVANT_TEXT type string value '|',
    T_DOCUMENT_EMOTION_RESULTS type string value '|',
    T_DOCUMENT_SENTIMENT_RESULTS type string value '|',
    T_SENTIMENT_RESULT type string value '|',
    T_TOKEN_RESULT type string value '|',
    T_SENTENCE_RESULT type string value '|',
    T_SYNTAX_RESULT type string value '|',
    T_CLASSIFICATIONS_RESULT type string value '|',
    T_CONCEPTS_RESULT type string value '|',
    T_CTGRS_RESULT_EXPLANATION type string value '|',
    T_CATEGORIES_RESULT type string value '|',
    T_EMOTION_RESULT type string value '|',
    T_FEATURES_RESULTS type string value '|',
    T_METADATA_RESULT type string value '|',
    T_ERROR_RESPONSE type string value '|CODE|ERROR|',
    T_EMOTION_OPTIONS type string value '|',
    T_USAGE type string value '|',
    T_SENTIMENT_OPTIONS type string value '|',
    T_SEMANTIC_ROLES_ACTION type string value '|',
    T_SYNTAX_OPTIONS_TOKENS type string value '|',
    T_FILE_AND_METADATA type string value '|LANGUAGE|',
    T_SUMMARIZATION_OPTIONS type string value '|',
    T_KEYWORDS_OPTIONS type string value '|',
    T_RELATIONS_OPTIONS type string value '|',
    T_ENTITIES_OPTIONS type string value '|',
    T_CONCEPTS_OPTIONS type string value '|',
    T_SYNTAX_OPTIONS type string value '|',
    T_CLASSIFICATIONS_OPTIONS type string value '|',
    T_CATEGORIES_OPTIONS type string value '|',
    T_FEATURES type string value '|',
    T_CLSSFCTNS_MDL_FL_AND_MTDT type string value '|LANGUAGE|TRAINING_DATA|',
    T_BASE_ADVANCED_RULES_MODEL type string value '|LANGUAGE|',
    T_ANALYSIS_RESULTS_USAGE type string value '|',
    T_ANALYSIS_RESULTS type string value '|',
    T_CATEGORIES_MODEL type string value '|LANGUAGE|STATUS|MODEL_ID|CREATED|',
    T_CATEGORIES_MODEL_LIST type string value '|',
    T_CLSSFCTNS_TRNNG_PARAMETERS type string value '|',
    T_CLSSFCTNS_MDL_FL_MTDT_AND_T1 type string value '|LANGUAGE|TRAINING_DATA|',
    T_SEMANTIC_ROLES_SUBJECT type string value '|',
    T_SUMMARIZATION_RESULT type string value '|',
    T_ADVANCED_RULES_MODEL type string value '|LANGUAGE|STATUS|MODEL_ID|CREATED|',
    T_ADVANCED_RULES_MODEL_LIST type string value '|',
    T_LIST_MODELS_RESULTS type string value '|',
    T_SEMANTIC_ROLES_OBJECT type string value '|',
    T_PARAMETERS type string value '|FEATURES|',
    T_SENTIMENT_MODEL type string value '|',
    T_CTGRS_MDL_FILE_AND_METADATA type string value '|LANGUAGE|TRAINING_DATA|',
    T_SNTMNT_MDL_FILE_AND_METADATA type string value '|LANGUAGE|TRAINING_DATA|',
    T_MODEL_FILE_AND_METADATA type string value '|LANGUAGE|FILE|',
    T_DELETE_MODEL_RESULTS type string value '|',
    __DUMMY type string value SPACE,
  end of C_REQUIRED_FIELDS .

constants:
  "! <p class="shorttext synchronized" lang="en">Map ABAP identifiers to service identifiers.</p>
  begin of C_ABAPNAME_DICTIONARY,
     NAME type string value 'name',
     USER_METADATA type string value 'user_metadata',
     INNER type string value 'inner',
     LANGUAGE type string value 'language',
     DESCRIPTION type string value 'description',
     MODEL_VERSION type string value 'model_version',
     WORKSPACE_ID type string value 'workspace_id',
     VERSION_DESCRIPTION type string value 'version_description',
     FEATURES type string value 'features',
     STATUS type string value 'status',
     MODEL_ID type string value 'model_id',
     CREATED type string value 'created',
     NOTICES type string value 'notices',
     LAST_TRAINED type string value 'last_trained',
     LAST_DEPLOYED type string value 'last_deployed',
     MODELS type string value 'models',
     MODEL type string value 'model',
     TEXT type string value 'text',
     HTML type string value 'html',
     URL type string value 'url',
     CLEAN type string value 'clean',
     XPATH type string value 'xpath',
     FALLBACK_TO_RAW type string value 'fallback_to_raw',
     RETURN_ANALYZED_TEXT type string value 'return_analyzed_text',
     LIMIT_TEXT_CHARACTERS type string value 'limit_text_characters',
     CLASSIFICATIONS type string value 'classifications',
     CONCEPTS type string value 'concepts',
     EMOTION type string value 'emotion',
     ENTITIES type string value 'entities',
     KEYWORDS type string value 'keywords',
     METADATA type string value 'metadata',
     RELATIONS type string value 'relations',
     SEMANTIC_ROLES type string value 'semantic_roles',
     SENTIMENT type string value 'sentiment',
     SUMMARIZATION type string value 'summarization',
     CATEGORIES type string value 'categories',
     SYNTAX type string value 'syntax',
     DELETED type string value 'deleted',
     VERSION type string value 'version',
     TRAINING_DATA type string value 'training_data',
     FILE type string value 'file',
     ANALYZED_TEXT type string value 'analyzed_text',
     RETRIEVED_URL type string value 'retrieved_url',
     USAGE type string value 'usage',
     TEXT_CHARACTERS type string value 'text_characters',
     TEXT_UNITS type string value 'text_units',
     MESSAGE type string value 'message',
     RELEVANCE type string value 'relevance',
     DBPEDIA_RESOURCE type string value 'dbpedia_resource',
     SUBTYPE type string value 'subtype',
     TYPE type string value 'type',
     CONFIDENCE type string value 'confidence',
     MENTIONS type string value 'mentions',
     COUNT type string value 'count',
     DISAMBIGUATION type string value 'disambiguation',
     LOCATION type string value 'location',
     LABEL type string value 'label',
     SCORE type string value 'score',
     EXPLANATION type string value 'explanation',
     CLASS_NAME type string value 'class_name',
     DOCUMENT type string value 'document',
     TARGETS type string value 'targets',
     ANGER type string value 'anger',
     DISGUST type string value 'disgust',
     FEAR type string value 'fear',
     JOY type string value 'joy',
     SADNESS type string value 'sadness',
     AUTHORS type string value 'authors',
     PUBLICATION_DATE type string value 'publication_date',
     TITLE type string value 'title',
     IMAGE type string value 'image',
     FEEDS type string value 'feeds',
     LINK type string value 'link',
     SENTENCE type string value 'sentence',
     ARGUMENTS type string value 'arguments',
     SUBJECT type string value 'subject',
     ACTION type string value 'action',
     OBJECT type string value 'object',
     NORMALIZED type string value 'normalized',
     VERB type string value 'verb',
     TENSE type string value 'tense',
     TOKENS type string value 'tokens',
     SENTENCES type string value 'sentences',
     PART_OF_SPEECH type string value 'part_of_speech',
     LEMMA type string value 'lemma',
     LIMIT type string value 'limit',
     TRAINING_PARAMETERS type string value 'training_parameters',
     CODE type string value 'code',
     ERROR type string value 'error',
     MODEL_TYPE type string value 'model_type',
     RELEVANT_TEXT type string value 'relevant_text',
  end of C_ABAPNAME_DICTIONARY .


  methods GET_APPNAME
    redefinition .
  methods GET_REQUEST_PROP
    redefinition .
  methods GET_SDK_VERSION_DATE
    redefinition .


    "! <p class="shorttext synchronized" lang="en">Analyze text</p>
    "!   Analyzes text, HTML, or a public webpage for the following features:<br/>
    "!   - Categories<br/>
    "!   - Classifications<br/>
    "!   - Concepts<br/>
    "!   - Emotion<br/>
    "!   - Entities<br/>
    "!   - Keywords<br/>
    "!   - Metadata<br/>
    "!   - Relations<br/>
    "!   - Semantic roles<br/>
    "!   - Sentiment<br/>
    "!   - Syntax<br/>
    "!   - Summarization (Experimental)<br/>
    "!   <br/>
    "!   If a language for the input text is not specified with the `language` parameter,
    "!    the service [automatically detects the
    "!    language](https://cloud.ibm.com/docs/natural-language-understanding?topic=natur
    "!   al-language-understanding-detectable-languages).
    "!
    "! @parameter I_PARAMETERS |
    "!   An object containing request parameters. The `features` object and one of the
    "!    `text`, `html`, or `url` attributes are required.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_ANALYSIS_RESULTS
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods ANALYZE
    importing
      !I_PARAMETERS type T_PARAMETERS
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_ANALYSIS_RESULTS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">List models</p>
    "!   Lists Watson Knowledge Studio [custom entities and relations
    "!    models](https://cloud.ibm.com/docs/natural-language-understanding?topic=natural
    "!   -language-understanding-customizing) that are deployed to your Natural Language
    "!    Understanding service.
    "!
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_LIST_MODELS_RESULTS
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_MODELS
    importing
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_LIST_MODELS_RESULTS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Delete model</p>
    "!   Deletes a custom model
    "!
    "! @parameter I_MODEL_ID |
    "!   Model ID of the model to delete.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_DELETE_MODEL_RESULTS
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_MODEL
    importing
      !I_MODEL_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_DELETE_MODEL_RESULTS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">Create categories model</p>
    "!   (Beta) Creates a custom categories model by uploading training data and
    "!    associated metadata. The model begins the training and deploying process and is
    "!    ready to use when the `status` is `available`.
    "!
    "! @parameter I_LANGUAGE |
    "!   The 2-letter language code of this model.
    "! @parameter I_TRAINING_DATA |
    "!   Training data in JSON format. For more information, see [Categories training
    "!    data
    "!    requirements](https://cloud.ibm.com/docs/natural-language-understanding?topic=n
    "!   atural-language-understanding-categories##categories-training-data-requirements)
    "!   .
    "! @parameter I_TRAINING_DATA_CONTENT_TYPE |
    "!   The content type of trainingData.
    "! @parameter I_NAME |
    "!   An optional name for the model.
    "! @parameter I_USER_METADATA |
    "!   An optional map of metadata key-value pairs to store with this model.
    "! @parameter I_DESCRIPTION |
    "!   An optional description of the model.
    "! @parameter I_MODEL_VERSION |
    "!   An optional version string.
    "! @parameter I_WORKSPACE_ID |
    "!   ID of the Watson Knowledge Studio workspace that deployed this model to Natural
    "!    Language Understanding.
    "! @parameter I_VERSION_DESCRIPTION |
    "!   The description of the version.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_CATEGORIES_MODEL
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods CREATE_CATEGORIES_MODEL
    importing
      !I_LANGUAGE type STRING
      !I_TRAINING_DATA type FILE
      !I_TRAINING_DATA_CONTENT_TYPE type STRING optional
      !I_NAME type STRING optional
      !I_USER_METADATA type JSONOBJECT optional
      !I_DESCRIPTION type STRING optional
      !I_MODEL_VERSION type STRING optional
      !I_WORKSPACE_ID type STRING optional
      !I_VERSION_DESCRIPTION type STRING optional
      !I_contenttype type string default 'multipart/form-data'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_CATEGORIES_MODEL
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">List categories models</p>
    "!   (Beta) Returns all custom categories models associated with this service
    "!    instance.
    "!
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_CATEGORIES_MODEL_LIST
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_CATEGORIES_MODELS
    importing
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_CATEGORIES_MODEL_LIST
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Get categories model details</p>
    "!   (Beta) Returns the status of the categories model with the given model ID.
    "!
    "! @parameter I_MODEL_ID |
    "!   ID of the model.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_CATEGORIES_MODEL
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_CATEGORIES_MODEL
    importing
      !I_MODEL_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_CATEGORIES_MODEL
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Update categories model</p>
    "!   (Beta) Overwrites the training data associated with this custom categories model
    "!    and retrains the model. The new model replaces the current deployment.
    "!
    "! @parameter I_MODEL_ID |
    "!   ID of the model.
    "! @parameter I_LANGUAGE |
    "!   The 2-letter language code of this model.
    "! @parameter I_TRAINING_DATA |
    "!   Training data in JSON format. For more information, see [Categories training
    "!    data
    "!    requirements](https://cloud.ibm.com/docs/natural-language-understanding?topic=n
    "!   atural-language-understanding-categories##categories-training-data-requirements)
    "!   .
    "! @parameter I_TRAINING_DATA_CONTENT_TYPE |
    "!   The content type of trainingData.
    "! @parameter I_NAME |
    "!   An optional name for the model.
    "! @parameter I_USER_METADATA |
    "!   An optional map of metadata key-value pairs to store with this model.
    "! @parameter I_DESCRIPTION |
    "!   An optional description of the model.
    "! @parameter I_MODEL_VERSION |
    "!   An optional version string.
    "! @parameter I_WORKSPACE_ID |
    "!   ID of the Watson Knowledge Studio workspace that deployed this model to Natural
    "!    Language Understanding.
    "! @parameter I_VERSION_DESCRIPTION |
    "!   The description of the version.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_CATEGORIES_MODEL
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods UPDATE_CATEGORIES_MODEL
    importing
      !I_MODEL_ID type STRING
      !I_LANGUAGE type STRING
      !I_TRAINING_DATA type FILE
      !I_TRAINING_DATA_CONTENT_TYPE type STRING optional
      !I_NAME type STRING optional
      !I_USER_METADATA type JSONOBJECT optional
      !I_DESCRIPTION type STRING optional
      !I_MODEL_VERSION type STRING optional
      !I_WORKSPACE_ID type STRING optional
      !I_VERSION_DESCRIPTION type STRING optional
      !I_contenttype type string default 'multipart/form-data'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_CATEGORIES_MODEL
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Delete categories model</p>
    "!   (Beta) Un-deploys the custom categories model with the given model ID and
    "!    deletes all associated customer data, including any training data or binary
    "!    artifacts.
    "!
    "! @parameter I_MODEL_ID |
    "!   ID of the model.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_DELETE_MODEL_RESULTS
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_CATEGORIES_MODEL
    importing
      !I_MODEL_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_DELETE_MODEL_RESULTS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">Create classifications model</p>
    "!   Creates a custom classifications model by uploading training data and associated
    "!    metadata. The model begins the training and deploying process and is ready to
    "!    use when the `status` is `available`.
    "!
    "! @parameter I_LANGUAGE |
    "!   The 2-letter language code of this model.
    "! @parameter I_TRAINING_DATA |
    "!   Training data in JSON format. For more information, see [Classifications
    "!    training data
    "!    requirements](https://cloud.ibm.com/docs/natural-language-understanding?topic=n
    "!   atural-language-understanding-classifications#classification-training-data-requi
    "!   rements).
    "! @parameter I_TRAINING_DATA_CONTENT_TYPE |
    "!   The content type of trainingData.
    "! @parameter I_NAME |
    "!   An optional name for the model.
    "! @parameter I_USER_METADATA |
    "!   An optional map of metadata key-value pairs to store with this model.
    "! @parameter I_DESCRIPTION |
    "!   An optional description of the model.
    "! @parameter I_MODEL_VERSION |
    "!   An optional version string.
    "! @parameter I_WORKSPACE_ID |
    "!   ID of the Watson Knowledge Studio workspace that deployed this model to Natural
    "!    Language Understanding.
    "! @parameter I_VERSION_DESCRIPTION |
    "!   The description of the version.
    "! @parameter I_TRAINING_PARAMETERS |
    "!   Optional classifications training parameters along with model train requests.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_CLASSIFICATIONS_MODEL
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods CREATE_CLASSIFICATIONS_MODEL
    importing
      !I_LANGUAGE type STRING
      !I_TRAINING_DATA type FILE
      !I_TRAINING_DATA_CONTENT_TYPE type STRING optional
      !I_NAME type STRING optional
      !I_USER_METADATA type JSONOBJECT optional
      !I_DESCRIPTION type STRING optional
      !I_MODEL_VERSION type STRING optional
      !I_WORKSPACE_ID type STRING optional
      !I_VERSION_DESCRIPTION type STRING optional
      !I_TRAINING_PARAMETERS type T_CLSSFCTNS_TRNNG_PARAMETERS optional
      !I_contenttype type string default 'multipart/form-data'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_CLASSIFICATIONS_MODEL
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">List classifications models</p>
    "!   Returns all custom classifications models associated with this service instance.
    "!
    "!
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_CLASSIFICATIONS_MODEL_LIST
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_CLASSIFICATIONS_MODELS
    importing
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_CLASSIFICATIONS_MODEL_LIST
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Get classifications model details</p>
    "!   Returns the status of the classifications model with the given model ID.
    "!
    "! @parameter I_MODEL_ID |
    "!   ID of the model.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_CLASSIFICATIONS_MODEL
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_CLASSIFICATIONS_MODEL
    importing
      !I_MODEL_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_CLASSIFICATIONS_MODEL
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Update classifications model</p>
    "!   Overwrites the training data associated with this custom classifications model
    "!    and retrains the model. The new model replaces the current deployment.
    "!
    "! @parameter I_MODEL_ID |
    "!   ID of the model.
    "! @parameter I_LANGUAGE |
    "!   The 2-letter language code of this model.
    "! @parameter I_TRAINING_DATA |
    "!   Training data in JSON format. For more information, see [Classifications
    "!    training data
    "!    requirements](https://cloud.ibm.com/docs/natural-language-understanding?topic=n
    "!   atural-language-understanding-classifications#classification-training-data-requi
    "!   rements).
    "! @parameter I_TRAINING_DATA_CONTENT_TYPE |
    "!   The content type of trainingData.
    "! @parameter I_NAME |
    "!   An optional name for the model.
    "! @parameter I_USER_METADATA |
    "!   An optional map of metadata key-value pairs to store with this model.
    "! @parameter I_DESCRIPTION |
    "!   An optional description of the model.
    "! @parameter I_MODEL_VERSION |
    "!   An optional version string.
    "! @parameter I_WORKSPACE_ID |
    "!   ID of the Watson Knowledge Studio workspace that deployed this model to Natural
    "!    Language Understanding.
    "! @parameter I_VERSION_DESCRIPTION |
    "!   The description of the version.
    "! @parameter I_TRAINING_PARAMETERS |
    "!   Optional classifications training parameters along with model train requests.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_CLASSIFICATIONS_MODEL
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods UPDATE_CLASSIFICATIONS_MODEL
    importing
      !I_MODEL_ID type STRING
      !I_LANGUAGE type STRING
      !I_TRAINING_DATA type FILE
      !I_TRAINING_DATA_CONTENT_TYPE type STRING optional
      !I_NAME type STRING optional
      !I_USER_METADATA type JSONOBJECT optional
      !I_DESCRIPTION type STRING optional
      !I_MODEL_VERSION type STRING optional
      !I_WORKSPACE_ID type STRING optional
      !I_VERSION_DESCRIPTION type STRING optional
      !I_TRAINING_PARAMETERS type T_CLSSFCTNS_TRNNG_PARAMETERS optional
      !I_contenttype type string default 'multipart/form-data'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_CLASSIFICATIONS_MODEL
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Delete classifications model</p>
    "!   Un-deploys the custom classifications model with the given model ID and deletes
    "!    all associated customer data, including any training data or binary artifacts.
    "!
    "! @parameter I_MODEL_ID |
    "!   ID of the model.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_DELETE_MODEL_RESULTS
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_CLASSIFICATIONS_MODEL
    importing
      !I_MODEL_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_DELETE_MODEL_RESULTS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .


protected section.

private section.

ENDCLASS.

class ZCL_IBMC_NAT_LANG_UNDRSTND_V1 IMPLEMENTATION.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_NAT_LANG_UNDRSTND_V1->GET_APPNAME
* +-------------------------------------------------------------------------------------------------+
* | [<-()] E_APPNAME                      TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method GET_APPNAME.

    e_appname = 'Natural Language Understanding'.

  endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Protected Method ZCL_IBMC_NAT_LANG_UNDRSTND_V1->GET_REQUEST_PROP
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
  e_request_prop-url-host        = 'api.us-south.natural-language-understanding.watson.cloud.ibm.com'.
  e_request_prop-url-path_base   = ''.

endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_NAT_LANG_UNDRSTND_V1->GET_SDK_VERSION_DATE
* +-------------------------------------------------------------------------------------------------+
* | [<-()] E_SDK_VERSION_DATE             TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method get_sdk_version_date.

    e_sdk_version_date = '20231212104237'.

  endmethod.



* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_NAT_LANG_UNDRSTND_V1->ANALYZE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PARAMETERS        TYPE T_PARAMETERS
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_ANALYSIS_RESULTS
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method ANALYZE.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/analyze'.

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
    lv_datatype = get_datatype( i_PARAMETERS ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_PARAMETERS i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'parameters' i_value = i_PARAMETERS ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_PARAMETERS to <lv_text>.
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
* | Instance Public Method ZCL_IBMC_NAT_LANG_UNDRSTND_V1->LIST_MODELS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_LIST_MODELS_RESULTS
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_MODELS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/models'.

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
* | Instance Public Method ZCL_IBMC_NAT_LANG_UNDRSTND_V1->DELETE_MODEL
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_MODEL_ID        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_DELETE_MODEL_RESULTS
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_MODEL.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/models/{model_id}'.
    replace all occurrences of `{model_id}` in ls_request_prop-url-path with i_MODEL_ID ignoring case.

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
* | Instance Public Method ZCL_IBMC_NAT_LANG_UNDRSTND_V1->CREATE_CATEGORIES_MODEL
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_LANGUAGE        TYPE STRING
* | [--->] I_TRAINING_DATA        TYPE FILE
* | [--->] I_TRAINING_DATA_CONTENT_TYPE        TYPE STRING(optional)
* | [--->] I_NAME        TYPE STRING(optional)
* | [--->] I_USER_METADATA        TYPE JSONOBJECT(optional)
* | [--->] I_DESCRIPTION        TYPE STRING(optional)
* | [--->] I_MODEL_VERSION        TYPE STRING(optional)
* | [--->] I_WORKSPACE_ID        TYPE STRING(optional)
* | [--->] I_VERSION_DESCRIPTION        TYPE STRING(optional)
* | [--->] I_contenttype       TYPE string (default ='multipart/form-data')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_CATEGORIES_MODEL
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CREATE_CATEGORIES_MODEL.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/models/categories'.

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


    if not i_LANGUAGE is initial.
      clear ls_form_part.
      ls_form_part-content_disposition = 'form-data; name="language"'  ##NO_TEXT.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      lv_formdata = i_LANGUAGE.
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.

    if not i_NAME is initial.
      clear ls_form_part.
      ls_form_part-content_disposition = 'form-data; name="name"'  ##NO_TEXT.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      lv_formdata = i_NAME.
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.

    if not i_USER_METADATA is initial.
      clear ls_form_part.
      ls_form_part-content_disposition = 'form-data; name="user_metadata"'  ##NO_TEXT.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-APPL_JSON.
      lv_formdata = abap_to_json( i_value = i_USER_METADATA i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.

    if not i_DESCRIPTION is initial.
      clear ls_form_part.
      ls_form_part-content_disposition = 'form-data; name="description"'  ##NO_TEXT.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      lv_formdata = i_DESCRIPTION.
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.

    if not i_MODEL_VERSION is initial.
      clear ls_form_part.
      ls_form_part-content_disposition = 'form-data; name="model_version"'  ##NO_TEXT.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      lv_formdata = i_MODEL_VERSION.
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.

    if not i_WORKSPACE_ID is initial.
      clear ls_form_part.
      ls_form_part-content_disposition = 'form-data; name="workspace_id"'  ##NO_TEXT.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      lv_formdata = i_WORKSPACE_ID.
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.

    if not i_VERSION_DESCRIPTION is initial.
      clear ls_form_part.
      ls_form_part-content_disposition = 'form-data; name="version_description"'  ##NO_TEXT.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      lv_formdata = i_VERSION_DESCRIPTION.
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.



    if not i_TRAINING_DATA is initial.
      lv_extension = get_file_extension( I_training_data_content_type ).
      lv_value = `form-data; name="training_data"; filename="file` && lv_index && `.` && lv_extension && `"`  ##NO_TEXT.
      lv_index = lv_index + 1.
      clear ls_form_part.
      ls_form_part-content_type = I_training_data_content_type.
      ls_form_part-content_disposition = lv_value.
      ls_form_part-xdata = i_TRAINING_DATA.
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
* | Instance Public Method ZCL_IBMC_NAT_LANG_UNDRSTND_V1->LIST_CATEGORIES_MODELS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_CATEGORIES_MODEL_LIST
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_CATEGORIES_MODELS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/models/categories'.

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
* | Instance Public Method ZCL_IBMC_NAT_LANG_UNDRSTND_V1->GET_CATEGORIES_MODEL
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_MODEL_ID        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_CATEGORIES_MODEL
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_CATEGORIES_MODEL.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/models/categories/{model_id}'.
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
* | Instance Public Method ZCL_IBMC_NAT_LANG_UNDRSTND_V1->UPDATE_CATEGORIES_MODEL
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_MODEL_ID        TYPE STRING
* | [--->] I_LANGUAGE        TYPE STRING
* | [--->] I_TRAINING_DATA        TYPE FILE
* | [--->] I_TRAINING_DATA_CONTENT_TYPE        TYPE STRING(optional)
* | [--->] I_NAME        TYPE STRING(optional)
* | [--->] I_USER_METADATA        TYPE JSONOBJECT(optional)
* | [--->] I_DESCRIPTION        TYPE STRING(optional)
* | [--->] I_MODEL_VERSION        TYPE STRING(optional)
* | [--->] I_WORKSPACE_ID        TYPE STRING(optional)
* | [--->] I_VERSION_DESCRIPTION        TYPE STRING(optional)
* | [--->] I_contenttype       TYPE string (default ='multipart/form-data')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_CATEGORIES_MODEL
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method UPDATE_CATEGORIES_MODEL.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/models/categories/{model_id}'.
    replace all occurrences of `{model_id}` in ls_request_prop-url-path with i_MODEL_ID ignoring case.

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


    if not i_LANGUAGE is initial.
      clear ls_form_part.
      ls_form_part-content_disposition = 'form-data; name="language"'  ##NO_TEXT.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      lv_formdata = i_LANGUAGE.
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.

    if not i_NAME is initial.
      clear ls_form_part.
      ls_form_part-content_disposition = 'form-data; name="name"'  ##NO_TEXT.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      lv_formdata = i_NAME.
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.

    if not i_USER_METADATA is initial.
      clear ls_form_part.
      ls_form_part-content_disposition = 'form-data; name="user_metadata"'  ##NO_TEXT.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-APPL_JSON.
      lv_formdata = abap_to_json( i_value = i_USER_METADATA i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.

    if not i_DESCRIPTION is initial.
      clear ls_form_part.
      ls_form_part-content_disposition = 'form-data; name="description"'  ##NO_TEXT.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      lv_formdata = i_DESCRIPTION.
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.

    if not i_MODEL_VERSION is initial.
      clear ls_form_part.
      ls_form_part-content_disposition = 'form-data; name="model_version"'  ##NO_TEXT.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      lv_formdata = i_MODEL_VERSION.
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.

    if not i_WORKSPACE_ID is initial.
      clear ls_form_part.
      ls_form_part-content_disposition = 'form-data; name="workspace_id"'  ##NO_TEXT.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      lv_formdata = i_WORKSPACE_ID.
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.

    if not i_VERSION_DESCRIPTION is initial.
      clear ls_form_part.
      ls_form_part-content_disposition = 'form-data; name="version_description"'  ##NO_TEXT.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      lv_formdata = i_VERSION_DESCRIPTION.
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.



    if not i_TRAINING_DATA is initial.
      lv_extension = get_file_extension( I_training_data_content_type ).
      lv_value = `form-data; name="training_data"; filename="file` && lv_index && `.` && lv_extension && `"`  ##NO_TEXT.
      lv_index = lv_index + 1.
      clear ls_form_part.
      ls_form_part-content_type = I_training_data_content_type.
      ls_form_part-content_disposition = lv_value.
      ls_form_part-xdata = i_TRAINING_DATA.
      append ls_form_part to lt_form_part.
    endif.


    " execute HTTP PUT request
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
* | Instance Public Method ZCL_IBMC_NAT_LANG_UNDRSTND_V1->DELETE_CATEGORIES_MODEL
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_MODEL_ID        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_DELETE_MODEL_RESULTS
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_CATEGORIES_MODEL.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/models/categories/{model_id}'.
    replace all occurrences of `{model_id}` in ls_request_prop-url-path with i_MODEL_ID ignoring case.

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
* | Instance Public Method ZCL_IBMC_NAT_LANG_UNDRSTND_V1->CREATE_CLASSIFICATIONS_MODEL
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_LANGUAGE        TYPE STRING
* | [--->] I_TRAINING_DATA        TYPE FILE
* | [--->] I_TRAINING_DATA_CONTENT_TYPE        TYPE STRING(optional)
* | [--->] I_NAME        TYPE STRING(optional)
* | [--->] I_USER_METADATA        TYPE JSONOBJECT(optional)
* | [--->] I_DESCRIPTION        TYPE STRING(optional)
* | [--->] I_MODEL_VERSION        TYPE STRING(optional)
* | [--->] I_WORKSPACE_ID        TYPE STRING(optional)
* | [--->] I_VERSION_DESCRIPTION        TYPE STRING(optional)
* | [--->] I_TRAINING_PARAMETERS        TYPE T_CLSSFCTNS_TRNNG_PARAMETERS(optional)
* | [--->] I_contenttype       TYPE string (default ='multipart/form-data')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_CLASSIFICATIONS_MODEL
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CREATE_CLASSIFICATIONS_MODEL.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/models/classifications'.

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


    if not i_LANGUAGE is initial.
      clear ls_form_part.
      ls_form_part-content_disposition = 'form-data; name="language"'  ##NO_TEXT.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      lv_formdata = i_LANGUAGE.
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.

    if not i_NAME is initial.
      clear ls_form_part.
      ls_form_part-content_disposition = 'form-data; name="name"'  ##NO_TEXT.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      lv_formdata = i_NAME.
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.

    if not i_USER_METADATA is initial.
      clear ls_form_part.
      ls_form_part-content_disposition = 'form-data; name="user_metadata"'  ##NO_TEXT.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-APPL_JSON.
      lv_formdata = abap_to_json( i_value = i_USER_METADATA i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.

    if not i_DESCRIPTION is initial.
      clear ls_form_part.
      ls_form_part-content_disposition = 'form-data; name="description"'  ##NO_TEXT.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      lv_formdata = i_DESCRIPTION.
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.

    if not i_MODEL_VERSION is initial.
      clear ls_form_part.
      ls_form_part-content_disposition = 'form-data; name="model_version"'  ##NO_TEXT.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      lv_formdata = i_MODEL_VERSION.
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.

    if not i_WORKSPACE_ID is initial.
      clear ls_form_part.
      ls_form_part-content_disposition = 'form-data; name="workspace_id"'  ##NO_TEXT.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      lv_formdata = i_WORKSPACE_ID.
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.

    if not i_VERSION_DESCRIPTION is initial.
      clear ls_form_part.
      ls_form_part-content_disposition = 'form-data; name="version_description"'  ##NO_TEXT.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      lv_formdata = i_VERSION_DESCRIPTION.
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.

    if not i_TRAINING_PARAMETERS is initial.
      clear ls_form_part.
      ls_form_part-content_disposition = 'form-data; name="training_parameters"'  ##NO_TEXT.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-APPL_JSON.
      lv_formdata = abap_to_json( i_value = i_TRAINING_PARAMETERS i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.



    if not i_TRAINING_DATA is initial.
      lv_extension = get_file_extension( I_training_data_content_type ).
      lv_value = `form-data; name="training_data"; filename="file` && lv_index && `.` && lv_extension && `"`  ##NO_TEXT.
      lv_index = lv_index + 1.
      clear ls_form_part.
      ls_form_part-content_type = I_training_data_content_type.
      ls_form_part-content_disposition = lv_value.
      ls_form_part-xdata = i_TRAINING_DATA.
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
* | Instance Public Method ZCL_IBMC_NAT_LANG_UNDRSTND_V1->LIST_CLASSIFICATIONS_MODELS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_CLASSIFICATIONS_MODEL_LIST
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_CLASSIFICATIONS_MODELS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/models/classifications'.

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
* | Instance Public Method ZCL_IBMC_NAT_LANG_UNDRSTND_V1->GET_CLASSIFICATIONS_MODEL
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_MODEL_ID        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_CLASSIFICATIONS_MODEL
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_CLASSIFICATIONS_MODEL.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/models/classifications/{model_id}'.
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
* | Instance Public Method ZCL_IBMC_NAT_LANG_UNDRSTND_V1->UPDATE_CLASSIFICATIONS_MODEL
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_MODEL_ID        TYPE STRING
* | [--->] I_LANGUAGE        TYPE STRING
* | [--->] I_TRAINING_DATA        TYPE FILE
* | [--->] I_TRAINING_DATA_CONTENT_TYPE        TYPE STRING(optional)
* | [--->] I_NAME        TYPE STRING(optional)
* | [--->] I_USER_METADATA        TYPE JSONOBJECT(optional)
* | [--->] I_DESCRIPTION        TYPE STRING(optional)
* | [--->] I_MODEL_VERSION        TYPE STRING(optional)
* | [--->] I_WORKSPACE_ID        TYPE STRING(optional)
* | [--->] I_VERSION_DESCRIPTION        TYPE STRING(optional)
* | [--->] I_TRAINING_PARAMETERS        TYPE T_CLSSFCTNS_TRNNG_PARAMETERS(optional)
* | [--->] I_contenttype       TYPE string (default ='multipart/form-data')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_CLASSIFICATIONS_MODEL
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method UPDATE_CLASSIFICATIONS_MODEL.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/models/classifications/{model_id}'.
    replace all occurrences of `{model_id}` in ls_request_prop-url-path with i_MODEL_ID ignoring case.

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


    if not i_LANGUAGE is initial.
      clear ls_form_part.
      ls_form_part-content_disposition = 'form-data; name="language"'  ##NO_TEXT.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      lv_formdata = i_LANGUAGE.
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.

    if not i_NAME is initial.
      clear ls_form_part.
      ls_form_part-content_disposition = 'form-data; name="name"'  ##NO_TEXT.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      lv_formdata = i_NAME.
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.

    if not i_USER_METADATA is initial.
      clear ls_form_part.
      ls_form_part-content_disposition = 'form-data; name="user_metadata"'  ##NO_TEXT.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-APPL_JSON.
      lv_formdata = abap_to_json( i_value = i_USER_METADATA i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.

    if not i_DESCRIPTION is initial.
      clear ls_form_part.
      ls_form_part-content_disposition = 'form-data; name="description"'  ##NO_TEXT.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      lv_formdata = i_DESCRIPTION.
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.

    if not i_MODEL_VERSION is initial.
      clear ls_form_part.
      ls_form_part-content_disposition = 'form-data; name="model_version"'  ##NO_TEXT.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      lv_formdata = i_MODEL_VERSION.
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.

    if not i_WORKSPACE_ID is initial.
      clear ls_form_part.
      ls_form_part-content_disposition = 'form-data; name="workspace_id"'  ##NO_TEXT.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      lv_formdata = i_WORKSPACE_ID.
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.

    if not i_VERSION_DESCRIPTION is initial.
      clear ls_form_part.
      ls_form_part-content_disposition = 'form-data; name="version_description"'  ##NO_TEXT.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      lv_formdata = i_VERSION_DESCRIPTION.
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.

    if not i_TRAINING_PARAMETERS is initial.
      clear ls_form_part.
      ls_form_part-content_disposition = 'form-data; name="training_parameters"'  ##NO_TEXT.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-APPL_JSON.
      lv_formdata = abap_to_json( i_value = i_TRAINING_PARAMETERS i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.



    if not i_TRAINING_DATA is initial.
      lv_extension = get_file_extension( I_training_data_content_type ).
      lv_value = `form-data; name="training_data"; filename="file` && lv_index && `.` && lv_extension && `"`  ##NO_TEXT.
      lv_index = lv_index + 1.
      clear ls_form_part.
      ls_form_part-content_type = I_training_data_content_type.
      ls_form_part-content_disposition = lv_value.
      ls_form_part-xdata = i_TRAINING_DATA.
      append ls_form_part to lt_form_part.
    endif.


    " execute HTTP PUT request
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
* | Instance Public Method ZCL_IBMC_NAT_LANG_UNDRSTND_V1->DELETE_CLASSIFICATIONS_MODEL
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_MODEL_ID        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_DELETE_MODEL_RESULTS
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_CLASSIFICATIONS_MODEL.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/models/classifications/{model_id}'.
    replace all occurrences of `{model_id}` in ls_request_prop-url-path with i_MODEL_ID ignoring case.

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


ENDCLASS.
