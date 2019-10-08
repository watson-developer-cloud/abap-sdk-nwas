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
"! <h1>Natural Language Understanding</h1>
"! Analyze various features of text content at scale. Provide text, raw HTML, or a
"!  public URL and IBM Watson Natural Language Understanding will give you results
"!  for the features you request. The service cleans HTML content before analysis
"!  by default, so the results can ignore most advertisements and other unwanted
"!  content.
"!
"! You can create [custom
"!  models](https://cloud.ibm.com/docs/services/natural-language-understanding?topi
"! c=natural-language-understanding-customizing) with Watson Knowledge Studio to
"!  detect custom entities, relations, and categories in Natural Language
"!  Understanding. <br/>
class ZCL_IBMC_NAT_LANG_UNDRSTND_V1 DEFINITION
  public
  inheriting from ZCL_IBMC_SERVICE_EXT
  create public .

public section.
  types:
    "!
    begin of T_SEMANTIC_ROLES_ENTITY,
      TYPE type STRING,
      TEXT type STRING,
    end of T_SEMANTIC_ROLES_ENTITY.
  types:
    "!
    begin of T_SEMANTIC_ROLES_KEYWORD,
      TEXT type STRING,
    end of T_SEMANTIC_ROLES_KEYWORD.
  types:
    "!   The extracted subject from the sentence.
    begin of T_SMNTC_ROLES_RESULT_SUBJECT,
      TEXT type STRING,
      ENTITIES type STANDARD TABLE OF T_SEMANTIC_ROLES_ENTITY WITH NON-UNIQUE DEFAULT KEY,
      KEYWORDS type STANDARD TABLE OF T_SEMANTIC_ROLES_KEYWORD WITH NON-UNIQUE DEFAULT KEY,
    end of T_SMNTC_ROLES_RESULT_SUBJECT.
  types:
    "!   The extracted object from the sentence.
    begin of T_SEMANTIC_ROLES_RESULT_OBJECT,
      TEXT type STRING,
      KEYWORDS type STANDARD TABLE OF T_SEMANTIC_ROLES_KEYWORD WITH NON-UNIQUE DEFAULT KEY,
    end of T_SEMANTIC_ROLES_RESULT_OBJECT.
  types:
    "!
    begin of T_SEMANTIC_ROLES_VERB,
      TEXT type STRING,
      TENSE type STRING,
    end of T_SEMANTIC_ROLES_VERB.
  types:
    "!   The extracted action from the sentence.
    begin of T_SEMANTIC_ROLES_RESULT_ACTION,
      TEXT type STRING,
      NORMALIZED type STRING,
      VERB type T_SEMANTIC_ROLES_VERB,
    end of T_SEMANTIC_ROLES_RESULT_ACTION.
  types:
    "!   The object containing the actions and the objects the actions act upon.
    begin of T_SEMANTIC_ROLES_RESULT,
      SENTENCE type STRING,
      SUBJECT type T_SMNTC_ROLES_RESULT_SUBJECT,
      ACTION type T_SEMANTIC_ROLES_RESULT_ACTION,
      OBJECT type T_SEMANTIC_ROLES_RESULT_OBJECT,
    end of T_SEMANTIC_ROLES_RESULT.
  types:
    "!   Parses sentences into subject, action, and object form.
    "!
    "!   Supported languages: English, German, Japanese, Korean, Spanish.
    begin of T_SEMANTIC_ROLES_OPTIONS,
      LIMIT type INTEGER,
      KEYWORDS type BOOLEAN,
      ENTITIES type BOOLEAN,
    end of T_SEMANTIC_ROLES_OPTIONS.
  types:
    "!   An entity that corresponds with an argument in a relation.
    begin of T_RELATION_ENTITY,
      TEXT type STRING,
      TYPE type STRING,
    end of T_RELATION_ENTITY.
  types:
    "!
    begin of T_RELATION_ARGUMENT,
      ENTITIES type STANDARD TABLE OF T_RELATION_ENTITY WITH NON-UNIQUE DEFAULT KEY,
      LOCATION type STANDARD TABLE OF INTEGER WITH NON-UNIQUE DEFAULT KEY,
      TEXT type STRING,
    end of T_RELATION_ARGUMENT.
  types:
    "!   The relations between entities found in the content.
    begin of T_RELATIONS_RESULT,
      SCORE type DOUBLE,
      SENTENCE type STRING,
      TYPE type STRING,
      ARGUMENTS type STANDARD TABLE OF T_RELATION_ARGUMENT WITH NON-UNIQUE DEFAULT KEY,
    end of T_RELATIONS_RESULT.
  types:
    "!
    begin of T_MODEL,
      STATUS type STRING,
      MODEL_ID type STRING,
      LANGUAGE type STRING,
      DESCRIPTION type STRING,
      WORKSPACE_ID type STRING,
      VERSION type STRING,
      VERSION_DESCRIPTION type STRING,
      CREATED type DATETIME,
    end of T_MODEL.
  types:
    "!
    begin of T_FEATURE_SENTIMENT_RESULTS,
      SCORE type DOUBLE,
    end of T_FEATURE_SENTIMENT_RESULTS.
  types:
    "!
    begin of T_EMOTION_SCORES,
      ANGER type DOUBLE,
      DISGUST type DOUBLE,
      FEAR type DOUBLE,
      JOY type DOUBLE,
      SADNESS type DOUBLE,
    end of T_EMOTION_SCORES.
  types:
    "!   The author of the analyzed content.
    begin of T_AUTHOR,
      NAME type STRING,
    end of T_AUTHOR.
  types:
    "!   RSS or ATOM feed found on the webpage.
    begin of T_FEED,
      LINK type STRING,
    end of T_FEED.
  types:
    "!   Webpage metadata, such as the author and the title of the page.
    begin of T_FEATURES_RESULTS_METADATA,
      AUTHORS type STANDARD TABLE OF T_AUTHOR WITH NON-UNIQUE DEFAULT KEY,
      PUBLICATION_DATE type STRING,
      TITLE type STRING,
      IMAGE type STRING,
      FEEDS type STANDARD TABLE OF T_FEED WITH NON-UNIQUE DEFAULT KEY,
    end of T_FEATURES_RESULTS_METADATA.
  types:
    "!
    begin of T_ENTITY_MENTION,
      TEXT type STRING,
      LOCATION type STANDARD TABLE OF INTEGER WITH NON-UNIQUE DEFAULT KEY,
      CONFIDENCE type DOUBLE,
    end of T_ENTITY_MENTION.
  types:
    "!   Disambiguation information for the entity.
    begin of T_DISAMBIGUATION_RESULT,
      NAME type STRING,
      DBPEDIA_RESOURCE type STRING,
      SUBTYPE type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
    end of T_DISAMBIGUATION_RESULT.
  types:
    "!   The important people, places, geopolitical entities and other types of entities
    "!    in your content.
    begin of T_ENTITIES_RESULT,
      TYPE type STRING,
      TEXT type STRING,
      RELEVANCE type DOUBLE,
      CONFIDENCE type DOUBLE,
      MENTIONS type STANDARD TABLE OF T_ENTITY_MENTION WITH NON-UNIQUE DEFAULT KEY,
      COUNT type INTEGER,
      EMOTION type T_EMOTION_SCORES,
      SENTIMENT type T_FEATURE_SENTIMENT_RESULTS,
      DISAMBIGUATION type T_DISAMBIGUATION_RESULT,
    end of T_ENTITIES_RESULT.
  types:
    "!   Emotion results for a specified target.
    begin of T_TARGETED_EMOTION_RESULTS,
      TEXT type STRING,
      EMOTION type T_EMOTION_SCORES,
    end of T_TARGETED_EMOTION_RESULTS.
  types:
    "!   The important keywords in the content, organized by relevance.
    begin of T_KEYWORDS_RESULT,
      COUNT type INTEGER,
      RELEVANCE type DOUBLE,
      TEXT type STRING,
      EMOTION type T_EMOTION_SCORES,
      SENTIMENT type T_FEATURE_SENTIMENT_RESULTS,
    end of T_KEYWORDS_RESULT.
  types:
    "!
    begin of T_TARGETED_SENTIMENT_RESULTS,
      TEXT type STRING,
      SCORE type DOUBLE,
    end of T_TARGETED_SENTIMENT_RESULTS.
  types:
    "!   Relevant text that contributed to the categorization.
    begin of T_CATEGORIES_RELEVANT_TEXT,
      TEXT type STRING,
    end of T_CATEGORIES_RELEVANT_TEXT.
  types:
    "!   Emotion results for the document as a whole.
    begin of T_DOCUMENT_EMOTION_RESULTS,
      EMOTION type T_EMOTION_SCORES,
    end of T_DOCUMENT_EMOTION_RESULTS.
  types:
    "!
    begin of T_DOCUMENT_SENTIMENT_RESULTS,
      LABEL type STRING,
      SCORE type DOUBLE,
    end of T_DOCUMENT_SENTIMENT_RESULTS.
  types:
    "!   The sentiment of the content.
    begin of T_SENTIMENT_RESULT,
      DOCUMENT type T_DOCUMENT_SENTIMENT_RESULTS,
      TARGETS type STANDARD TABLE OF T_TARGETED_SENTIMENT_RESULTS WITH NON-UNIQUE DEFAULT KEY,
    end of T_SENTIMENT_RESULT.
  types:
    "!
    begin of T_TOKEN_RESULT,
      TEXT type STRING,
      PART_OF_SPEECH type STRING,
      LOCATION type STANDARD TABLE OF INTEGER WITH NON-UNIQUE DEFAULT KEY,
      LEMMA type STRING,
    end of T_TOKEN_RESULT.
  types:
    "!
    begin of T_SENTENCE_RESULT,
      TEXT type STRING,
      LOCATION type STANDARD TABLE OF INTEGER WITH NON-UNIQUE DEFAULT KEY,
    end of T_SENTENCE_RESULT.
  types:
    "!   Tokens and sentences returned from syntax analysis.
    begin of T_SYNTAX_RESULT,
      TOKENS type STANDARD TABLE OF T_TOKEN_RESULT WITH NON-UNIQUE DEFAULT KEY,
      SENTENCES type STANDARD TABLE OF T_SENTENCE_RESULT WITH NON-UNIQUE DEFAULT KEY,
    end of T_SYNTAX_RESULT.
  types:
    "!   The general concepts referenced or alluded to in the analyzed text.
    begin of T_CONCEPTS_RESULT,
      TEXT type STRING,
      RELEVANCE type DOUBLE,
      DBPEDIA_RESOURCE type STRING,
    end of T_CONCEPTS_RESULT.
  types:
    "!   Information that helps to explain what contributed to the categories result.
    begin of T_CTGRS_RESULT_EXPLANATION,
      RELEVANT_TEXT type STANDARD TABLE OF T_CATEGORIES_RELEVANT_TEXT WITH NON-UNIQUE DEFAULT KEY,
    end of T_CTGRS_RESULT_EXPLANATION.
  types:
    "!   A categorization of the analyzed text.
    begin of T_CATEGORIES_RESULT,
      LABEL type STRING,
      SCORE type DOUBLE,
      EXPLANATION type T_CTGRS_RESULT_EXPLANATION,
    end of T_CATEGORIES_RESULT.
  types:
    "!   The detected anger, disgust, fear, joy, or sadness that is conveyed by the
    "!    content. Emotion information can be returned for detected entities, keywords,
    "!    or user-specified target phrases found in the text.
    begin of T_EMOTION_RESULT,
      DOCUMENT type T_DOCUMENT_EMOTION_RESULTS,
      TARGETS type STANDARD TABLE OF T_TARGETED_EMOTION_RESULTS WITH NON-UNIQUE DEFAULT KEY,
    end of T_EMOTION_RESULT.
  types:
    "!   Analysis results for each requested feature.
    begin of T_FEATURES_RESULTS,
      CONCEPTS type STANDARD TABLE OF T_CONCEPTS_RESULT WITH NON-UNIQUE DEFAULT KEY,
      ENTITIES type STANDARD TABLE OF T_ENTITIES_RESULT WITH NON-UNIQUE DEFAULT KEY,
      KEYWORDS type STANDARD TABLE OF T_KEYWORDS_RESULT WITH NON-UNIQUE DEFAULT KEY,
      CATEGORIES type STANDARD TABLE OF T_CATEGORIES_RESULT WITH NON-UNIQUE DEFAULT KEY,
      EMOTION type T_EMOTION_RESULT,
      METADATA type T_FEATURES_RESULTS_METADATA,
      RELATIONS type STANDARD TABLE OF T_RELATIONS_RESULT WITH NON-UNIQUE DEFAULT KEY,
      SEMANTIC_ROLES type STANDARD TABLE OF T_SEMANTIC_ROLES_RESULT WITH NON-UNIQUE DEFAULT KEY,
      SENTIMENT type T_SENTIMENT_RESULT,
      SYNTAX type T_SYNTAX_RESULT,
    end of T_FEATURES_RESULTS.
  types:
    "!   The authors, publication date, title, prominent page image, and RSS/ATOM feeds
    "!    of the webpage. Supports URL and HTML input types.
    begin of T_METADATA_RESULT,
      AUTHORS type STANDARD TABLE OF T_AUTHOR WITH NON-UNIQUE DEFAULT KEY,
      PUBLICATION_DATE type STRING,
      TITLE type STRING,
      IMAGE type STRING,
      FEEDS type STANDARD TABLE OF T_FEED WITH NON-UNIQUE DEFAULT KEY,
    end of T_METADATA_RESULT.
  types:
    "!
    begin of T_ERROR_RESPONSE,
      CODE type INTEGER,
      ERROR type STRING,
    end of T_ERROR_RESPONSE.
  types:
    "!   Detects anger, disgust, fear, joy, or sadness that is conveyed in the content or
    "!    by the context around target phrases specified in the targets parameter. You
    "!    can analyze emotion for detected entities with `entities.emotion` and for
    "!    keywords with `keywords.emotion`.
    "!
    "!   Supported languages: English.
    begin of T_EMOTION_OPTIONS,
      DOCUMENT type BOOLEAN,
      TARGETS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
    end of T_EMOTION_OPTIONS.
  types:
    "!   Usage information.
    begin of T_USAGE,
      FEATURES type INTEGER,
      TEXT_CHARACTERS type INTEGER,
      TEXT_UNITS type INTEGER,
    end of T_USAGE.
  types:
    "!   Analyzes the general sentiment of your content or the sentiment toward specific
    "!    target phrases. You can analyze sentiment for detected entities with
    "!    `entities.sentiment` and for keywords with `keywords.sentiment`.
    "!
    "!    Supported languages: Arabic, English, French, German, Italian, Japanese,
    "!    Korean, Portuguese, Russian, Spanish.
    begin of T_SENTIMENT_OPTIONS,
      DOCUMENT type BOOLEAN,
      TARGETS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
    end of T_SENTIMENT_OPTIONS.
  types:
    "!
    begin of T_SEMANTIC_ROLES_ACTION,
      TEXT type STRING,
      NORMALIZED type STRING,
      VERB type T_SEMANTIC_ROLES_VERB,
    end of T_SEMANTIC_ROLES_ACTION.
  types:
    "!   Tokenization options.
    begin of T_SYNTAX_OPTIONS_TOKENS,
      LEMMA type BOOLEAN,
      PART_OF_SPEECH type BOOLEAN,
    end of T_SYNTAX_OPTIONS_TOKENS.
  types:
    "!   Returns important keywords in the content.
    "!
    "!   Supported languages: English, French, German, Italian, Japanese, Korean,
    "!    Portuguese, Russian, Spanish, Swedish.
    begin of T_KEYWORDS_OPTIONS,
      LIMIT type INTEGER,
      SENTIMENT type BOOLEAN,
      EMOTION type BOOLEAN,
    end of T_KEYWORDS_OPTIONS.
  types:
    "!   Recognizes when two entities are related and identifies the type of relation.
    "!    For example, an `awardedTo` relation might connect the entities "Nobel Prize"
    "!    and "Albert Einstein". See [Relation
    "!    types](https://cloud.ibm.com/docs/services/natural-language-understanding?topic
    "!   =natural-language-understanding-relations).
    "!
    "!   Supported languages: Arabic, English, German, Japanese, Korean, Spanish.
    "!    Chinese, Dutch, French, Italian, and Portuguese custom models are also
    "!    supported.
    begin of T_RELATIONS_OPTIONS,
      MODEL type STRING,
    end of T_RELATIONS_OPTIONS.
  types:
    "!   Identifies people, cities, organizations, and other entities in the content. See
    "!    [Entity types and
    "!    subtypes](https://cloud.ibm.com/docs/services/natural-language-understanding?to
    "!   pic=natural-language-understanding-entity-types).
    "!
    "!   Supported languages: English, French, German, Italian, Japanese, Korean,
    "!    Portuguese, Russian, Spanish, Swedish. Arabic, Chinese, and Dutch are supported
    "!    only through custom models.
    begin of T_ENTITIES_OPTIONS,
      LIMIT type INTEGER,
      MENTIONS type BOOLEAN,
      MODEL type STRING,
      SENTIMENT type BOOLEAN,
      EMOTION type BOOLEAN,
    end of T_ENTITIES_OPTIONS.
  types:
    "!   Returns high-level concepts in the content. For example, a research paper about
    "!    deep learning might return the concept, "Artificial Intelligence" although the
    "!    term is not mentioned.
    "!
    "!   Supported languages: English, French, German, Italian, Japanese, Korean,
    "!    Portuguese, Spanish.
    begin of T_CONCEPTS_OPTIONS,
      LIMIT type INTEGER,
    end of T_CONCEPTS_OPTIONS.
  types:
    "!   Returns information from the document, including author name, title, RSS/ATOM
    "!    feeds, prominent page image, and publication date. Supports URL and HTML input
    "!    types only.
      T_METADATA_OPTIONS type JSONOBJECT.
  types:
    "!   Returns tokens and sentences from the input text.
    begin of T_SYNTAX_OPTIONS,
      TOKENS type T_SYNTAX_OPTIONS_TOKENS,
      SENTENCES type BOOLEAN,
    end of T_SYNTAX_OPTIONS.
  types:
    "!   Returns a five-level taxonomy of the content. The top three categories are
    "!    returned.
    "!
    "!   Supported languages: Arabic, English, French, German, Italian, Japanese, Korean,
    "!    Portuguese, Spanish.
    begin of T_CATEGORIES_OPTIONS,
      EXPLANATION type BOOLEAN,
      LIMIT type INTEGER,
      MODEL type STRING,
    end of T_CATEGORIES_OPTIONS.
  types:
    "!   Analysis features and options.
    begin of T_FEATURES,
      CONCEPTS type T_CONCEPTS_OPTIONS,
      EMOTION type T_EMOTION_OPTIONS,
      ENTITIES type T_ENTITIES_OPTIONS,
      KEYWORDS type T_KEYWORDS_OPTIONS,
      METADATA type T_METADATA_OPTIONS,
      RELATIONS type T_RELATIONS_OPTIONS,
      SEMANTIC_ROLES type T_SEMANTIC_ROLES_OPTIONS,
      SENTIMENT type T_SENTIMENT_OPTIONS,
      CATEGORIES type T_CATEGORIES_OPTIONS,
      SYNTAX type T_SYNTAX_OPTIONS,
    end of T_FEATURES.
  types:
    "!   Webpage metadata, such as the author and the title of the page.
    begin of T_ANALYSIS_RESULTS_METADATA,
      AUTHORS type STANDARD TABLE OF T_AUTHOR WITH NON-UNIQUE DEFAULT KEY,
      PUBLICATION_DATE type STRING,
      TITLE type STRING,
      IMAGE type STRING,
      FEEDS type STANDARD TABLE OF T_FEED WITH NON-UNIQUE DEFAULT KEY,
    end of T_ANALYSIS_RESULTS_METADATA.
  types:
    "!   API usage information for the request.
    begin of T_ANALYSIS_RESULTS_USAGE,
      FEATURES type INTEGER,
      TEXT_CHARACTERS type INTEGER,
      TEXT_UNITS type INTEGER,
    end of T_ANALYSIS_RESULTS_USAGE.
  types:
    "!   Results of the analysis, organized by feature.
    begin of T_ANALYSIS_RESULTS,
      LANGUAGE type STRING,
      ANALYZED_TEXT type STRING,
      RETRIEVED_URL type STRING,
      USAGE type T_ANALYSIS_RESULTS_USAGE,
      CONCEPTS type STANDARD TABLE OF T_CONCEPTS_RESULT WITH NON-UNIQUE DEFAULT KEY,
      ENTITIES type STANDARD TABLE OF T_ENTITIES_RESULT WITH NON-UNIQUE DEFAULT KEY,
      KEYWORDS type STANDARD TABLE OF T_KEYWORDS_RESULT WITH NON-UNIQUE DEFAULT KEY,
      CATEGORIES type STANDARD TABLE OF T_CATEGORIES_RESULT WITH NON-UNIQUE DEFAULT KEY,
      EMOTION type T_EMOTION_RESULT,
      METADATA type T_ANALYSIS_RESULTS_METADATA,
      RELATIONS type STANDARD TABLE OF T_RELATIONS_RESULT WITH NON-UNIQUE DEFAULT KEY,
      SEMANTIC_ROLES type STANDARD TABLE OF T_SEMANTIC_ROLES_RESULT WITH NON-UNIQUE DEFAULT KEY,
      SENTIMENT type T_SENTIMENT_RESULT,
      SYNTAX type T_SYNTAX_RESULT,
    end of T_ANALYSIS_RESULTS.
  types:
    "!
    begin of T_SEMANTIC_ROLES_SUBJECT,
      TEXT type STRING,
      ENTITIES type STANDARD TABLE OF T_SEMANTIC_ROLES_ENTITY WITH NON-UNIQUE DEFAULT KEY,
      KEYWORDS type STANDARD TABLE OF T_SEMANTIC_ROLES_KEYWORD WITH NON-UNIQUE DEFAULT KEY,
    end of T_SEMANTIC_ROLES_SUBJECT.
  types:
    "!   Custom models that are available for entities and relations.
    begin of T_LIST_MODELS_RESULTS,
      MODELS type STANDARD TABLE OF T_MODEL WITH NON-UNIQUE DEFAULT KEY,
    end of T_LIST_MODELS_RESULTS.
  types:
    "!
    begin of T_SEMANTIC_ROLES_OBJECT,
      TEXT type STRING,
      KEYWORDS type STANDARD TABLE OF T_SEMANTIC_ROLES_KEYWORD WITH NON-UNIQUE DEFAULT KEY,
    end of T_SEMANTIC_ROLES_OBJECT.
  types:
    "!   An object containing request parameters.
    begin of T_PARAMETERS,
      TEXT type STRING,
      HTML type STRING,
      URL type STRING,
      FEATURES type T_FEATURES,
      CLEAN type BOOLEAN,
      XPATH type STRING,
      FALLBACK_TO_RAW type BOOLEAN,
      RETURN_ANALYZED_TEXT type BOOLEAN,
      LANGUAGE type STRING,
      LIMIT_TEXT_CHARACTERS type INTEGER,
    end of T_PARAMETERS.
  types:
    "!   Link to the corresponding DBpedia resource.
      T_DBPEDIA_RESOURCE type String.
  types:
    "!   Delete model results.
    begin of T_DELETE_MODEL_RESULTS,
      DELETED type STRING,
    end of T_DELETE_MODEL_RESULTS.

constants:
  begin of C_REQUIRED_FIELDS,
    T_SEMANTIC_ROLES_ENTITY type string value '|',
    T_SEMANTIC_ROLES_KEYWORD type string value '|',
    T_SMNTC_ROLES_RESULT_SUBJECT type string value '|',
    T_SEMANTIC_ROLES_RESULT_OBJECT type string value '|',
    T_SEMANTIC_ROLES_VERB type string value '|',
    T_SEMANTIC_ROLES_RESULT_ACTION type string value '|',
    T_SEMANTIC_ROLES_RESULT type string value '|',
    T_SEMANTIC_ROLES_OPTIONS type string value '|',
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
    T_KEYWORDS_OPTIONS type string value '|',
    T_RELATIONS_OPTIONS type string value '|',
    T_ENTITIES_OPTIONS type string value '|',
    T_CONCEPTS_OPTIONS type string value '|',
    T_SYNTAX_OPTIONS type string value '|',
    T_CATEGORIES_OPTIONS type string value '|',
    T_FEATURES type string value '|',
    T_ANALYSIS_RESULTS_METADATA type string value '|',
    T_ANALYSIS_RESULTS_USAGE type string value '|',
    T_ANALYSIS_RESULTS type string value '|',
    T_SEMANTIC_ROLES_SUBJECT type string value '|',
    T_LIST_MODELS_RESULTS type string value '|',
    T_SEMANTIC_ROLES_OBJECT type string value '|',
    T_PARAMETERS type string value '|FEATURES|',
    T_DELETE_MODEL_RESULTS type string value '|',
    __DUMMY type string value SPACE,
  end of C_REQUIRED_FIELDS .

constants:
  begin of C_ABAPNAME_DICTIONARY,
     TEXT type string value 'text',
     HTML type string value 'html',
     URL type string value 'url',
     FEATURES type string value 'features',
     CLEAN type string value 'clean',
     XPATH type string value 'xpath',
     FALLBACK_TO_RAW type string value 'fallback_to_raw',
     RETURN_ANALYZED_TEXT type string value 'return_analyzed_text',
     LANGUAGE type string value 'language',
     LIMIT_TEXT_CHARACTERS type string value 'limit_text_characters',
     CONCEPTS type string value 'concepts',
     EMOTION type string value 'emotion',
     ENTITIES type string value 'entities',
     KEYWORDS type string value 'keywords',
     METADATA type string value 'metadata',
     RELATIONS type string value 'relations',
     SEMANTIC_ROLES type string value 'semantic_roles',
     SENTIMENT type string value 'sentiment',
     CATEGORIES type string value 'categories',
     SYNTAX type string value 'syntax',
     MODELS type string value 'models',
     DELETED type string value 'deleted',
     STATUS type string value 'status',
     MODEL_ID type string value 'model_id',
     DESCRIPTION type string value 'description',
     WORKSPACE_ID type string value 'workspace_id',
     VERSION type string value 'version',
     VERSION_DESCRIPTION type string value 'version_description',
     CREATED type string value 'created',
     ANALYZED_TEXT type string value 'analyzed_text',
     RETRIEVED_URL type string value 'retrieved_url',
     USAGE type string value 'usage',
     SEMANTICROLES type string value 'semanticRoles',
     TEXT_CHARACTERS type string value 'text_characters',
     TEXT_UNITS type string value 'text_units',
     RELEVANCE type string value 'relevance',
     DBPEDIA_RESOURCE type string value 'dbpedia_resource',
     NAME type string value 'name',
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
     MODEL type string value 'model',
     CODE type string value 'code',
     ERROR type string value 'error',
     RELEVANT_TEXT type string value 'relevant_text',
     RELEVANTTEXT type string value 'relevantText',
  end of C_ABAPNAME_DICTIONARY .


  methods GET_APPNAME
    redefinition .
  methods GET_REQUEST_PROP
    redefinition .
  methods GET_SDK_VERSION_DATE
    redefinition .


    "! Analyze text.
    "!
    "! @parameter I_parameters |
    "!   An object containing request parameters. The `features` object and one of the
    "!    `text`, `html`, or `url` attributes are required.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_ANALYSIS_RESULTS
    "!
  methods ANALYZE
    importing
      !I_parameters type T_PARAMETERS
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_ANALYSIS_RESULTS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! List models.
    "!
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_LIST_MODELS_RESULTS
    "!
  methods LIST_MODELS
    importing
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_LIST_MODELS_RESULTS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Delete model.
    "!
    "! @parameter I_model_id |
    "!   Model ID of the model to delete.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_DELETE_MODEL_RESULTS
    "!
  methods DELETE_MODEL
    importing
      !I_model_id type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_DELETE_MODEL_RESULTS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .


protected section.

private section.

  methods SET_DEFAULT_QUERY_PARAMETERS
    changing
      !C_URL type TS_URL .

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
  e_request_prop-url-path_base   = '/natural-language-understanding/api'.

endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_NAT_LANG_UNDRSTND_V1->GET_SDK_VERSION_DATE
* +-------------------------------------------------------------------------------------------------+
* | [<-()] E_SDK_VERSION_DATE             TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method get_sdk_version_date.

    e_sdk_version_date = '20191002122846'.

  endmethod.



* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_NAT_LANG_UNDRSTND_V1->ANALYZE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_parameters        TYPE T_PARAMETERS
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
    lv_datatype = get_datatype( i_parameters ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_parameters i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'parameters' i_value = i_parameters ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_parameters to <lv_text>.
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
* | [--->] I_model_id        TYPE STRING
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
    replace all occurrences of `{model_id}` in ls_request_prop-url-path with i_model_id ignoring case.

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
* | Instance Private Method ZCL_IBMC_NAT_LANG_UNDRSTND_V1->SET_DEFAULT_QUERY_PARAMETERS
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
