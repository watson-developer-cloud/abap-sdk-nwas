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
"! <p class="shorttext synchronized" lang="en">Natural Language Understanding</p>
"! Analyze various features of text content at scale. Provide text, raw HTML, or a
"!  public URL and IBM Watson Natural Language Understanding will give you results
"!  for the features you request. The service cleans HTML content before analysis
"!  by default, so the results can ignore most advertisements and other unwanted
"!  content.<br/>
"! <br/>
"! You can create [custom
"!  models](https://cloud.ibm.com/docs/services/natural-language-understanding?topi
"! c=natural-language-understanding-customizing) with Watson Knowledge Studio to
"!  detect custom entities and relations in Natural Language Understanding. <br/>
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
      USER_METADATA type MAP,
      "!   The language code of this model.
      LANGUAGE type STRING,
      "!   An optional description of the model.
      DESCRIPTION type STRING,
      "!   An optional version string.
      VERSION type STRING,
      "!   ID of the Watson Knowledge Studio workspace that deployed this model to Natural
      "!    Language Understanding.
      WORKSPACE_ID type STRING,
      "!   The description of the version.
      VERSION_DESCRIPTION type STRING,
    end of T_MODEL_METADATA.
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
      "!   ISO 639-1 code indicating the language of the model.
      LANGUAGE type STRING,
      "!   Model description.
      DESCRIPTION type STRING,
      "!   ID of the Watson Knowledge Studio workspace that deployed this model to Natural
      "!    Language Understanding.
      WORKSPACE_ID type STRING,
      "!   The model version, if it was manually provided in Watson Knowledge Studio.
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
      "!   The part of speech of the token. For descriptions of the values, see [Universal
      "!    Dependencies POS tags](https://universaldependencies.org/u/pos/).
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
      "!   The path to the category through the 5-level taxonomy hierarchy. For the
      "!    complete list of categories, see the [Categories
      "!    hierarchy](https://cloud.ibm.com/docs/services/natural-language-understanding?t
      "!   opic=natural-language-understanding-categories#categories-hierarchy)
      "!    documentation.
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
    "!     entities &quot;Nobel Prize&quot; and &quot;Albert Einstein&quot;. See [Relation
    "!     types](https://cloud.ibm.com/docs/services/natural-language-understanding?topic
    "!    =natural-language-understanding-relations).<br/>
    "!    <br/>
    "!    Supported languages: Arabic, English, German, Japanese, Korean, Spanish.
    "!     Chinese, Dutch, French, Italian, and Portuguese custom models are also
    "!     supported.
    begin of T_RELATIONS_OPTIONS,
      "!   Enter a [custom
      "!    model](https://cloud.ibm.com/docs/services/natural-language-understanding?topic
      "!   =natural-language-understanding-customizing) ID to override the default model.
      MODEL type STRING,
    end of T_RELATIONS_OPTIONS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Identifies people, cities, organizations, and other entities</p>
    "!     in the content. See [Entity types and
    "!     subtypes](https://cloud.ibm.com/docs/services/natural-language-understanding?to
    "!    pic=natural-language-understanding-entity-types).<br/>
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
      "!    model](https://cloud.ibm.com/docs/services/natural-language-understanding?topic
      "!   =natural-language-understanding-customizing) ID to override the standard entity
      "!    detection model.
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
    "!    Returns information from the document, including author</p>
    "!     name, title, RSS/ATOM feeds, prominent page image, and publication date.
    "!     Supports URL and HTML input types only.
      T_METADATA_OPTIONS type JSONOBJECT.
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
    "!    Returns a five-level taxonomy of the content. The top three</p>
    "!     categories are returned. <br/>
    "!    <br/>
    "!    Supported languages: Arabic, English, French, German, Italian, Japanese, Korean,
    "!     Portuguese, Spanish.
    begin of T_CATEGORIES_OPTIONS,
      "!   Set this to `true` to return explanations for each categorization. **This is
      "!    available only for English categories.**.
      EXPLANATION type BOOLEAN,
      "!   Maximum number of categories to return.
      LIMIT type INTEGER,
      "!   Enter a [custom
      "!    model](https://cloud.ibm.com/docs/services/natural-language-understanding?topic
      "!   =natural-language-understanding-customizing) ID to override the standard
      "!    categories model. <br/>
      "!   <br/>
      "!   The custom categories experimental feature will be retired on 19 December 2019.
      "!    On that date, deployed custom categories models will no longer be accessible in
      "!    Natural Language Understanding. The feature will be removed from Knowledge
      "!    Studio on an earlier date. Custom categories models will no longer be
      "!    accessible in Knowledge Studio on 17 December 2019.
      MODEL type STRING,
    end of T_CATEGORIES_OPTIONS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Analysis features and options.</p>
    begin of T_FEATURES,
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
      "!   Identifies people, cities, organizations, and other entities in the content. See
      "!    [Entity types and
      "!    subtypes](https://cloud.ibm.com/docs/services/natural-language-understanding?to
      "!   pic=natural-language-understanding-entity-types).<br/>
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
      METADATA type T_METADATA_OPTIONS,
      "!   Recognizes when two entities are related and identifies the type of relation.
      "!    For example, an `awardedTo` relation might connect the entities &quot;Nobel
      "!    Prize&quot; and &quot;Albert Einstein&quot;. See [Relation
      "!    types](https://cloud.ibm.com/docs/services/natural-language-understanding?topic
      "!   =natural-language-understanding-relations).<br/>
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
      "!   Returns a five-level taxonomy of the content. The top three categories are
      "!    returned. <br/>
      "!   <br/>
      "!   Supported languages: Arabic, English, French, German, Italian, Japanese, Korean,
      "!    Portuguese, Spanish.
      CATEGORIES type T_CATEGORIES_OPTIONS,
      "!   Returns tokens and sentences from the input text.
      SYNTAX type T_SYNTAX_OPTIONS,
    end of T_FEATURES.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Webpage metadata, such as the author and the title of the</p>
    "!     page.
    begin of T_ANALYSIS_RESULTS_METADATA,
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
    end of T_ANALYSIS_RESULTS_METADATA.
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
      "!   The anger, disgust, fear, joy, or sadness conveyed by the content.
      EMOTION type T_EMOTION_RESULT,
      "!   Webpage metadata, such as the author and the title of the page.
      METADATA type T_ANALYSIS_RESULTS_METADATA,
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
      "!   Set this to `false` to disable webpage cleaning. To learn more about webpage
      "!    cleaning, see the [Analyzing
      "!    webpages](https://cloud.ibm.com/docs/services/natural-language-understanding?to
      "!   pic=natural-language-understanding-analyzing-webpages) documentation.
      CLEAN type BOOLEAN,
      "!   An [XPath
      "!    query](https://cloud.ibm.com/docs/services/natural-language-understanding?topic
      "!   =natural-language-understanding-analyzing-webpages#xpath) to perform on `html`
      "!    or `url` input. Results of the query will be appended to the cleaned webpage
      "!    text before it is analyzed. To analyze only the results of the XPath query, set
      "!    the `clean` parameter to `false`.
      XPATH type STRING,
      "!   Whether to use raw HTML content if text cleaning fails.
      FALLBACK_TO_RAW type BOOLEAN,
      "!   Whether or not to return the analyzed text.
      RETURN_ANALYZED_TEXT type BOOLEAN,
      "!   ISO 639-1 code that specifies the language of your text. This overrides
      "!    automatic language detection. Language support differs depending on the
      "!    features you include in your analysis. See [Language
      "!    support](https://cloud.ibm.com/docs/services/natural-language-understanding?top
      "!   ic=natural-language-understanding-language-support) for more information.
      LANGUAGE type STRING,
      "!   Sets the maximum number of characters that are processed by the service.
      LIMIT_TEXT_CHARACTERS type INTEGER,
    end of T_PARAMETERS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Link to the corresponding DBpedia resource.</p>
      T_DBPEDIA_RESOURCE type String.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Metadata associated with this custom model.</p>
    begin of T_MODEL_FILE_AND_METADATA,
      "!   An optional name for the model.
      NAME type STRING,
      "!   An optional map of metadata key-value pairs to store with this model.
      USER_METADATA type MAP,
      "!   The language code of this model.
      LANGUAGE type STRING,
      "!   An optional description of the model.
      DESCRIPTION type STRING,
      "!   An optional version string.
      VERSION type STRING,
      "!   ID of the Watson Knowledge Studio workspace that deployed this model to Natural
      "!    Language Understanding.
      WORKSPACE_ID type STRING,
      "!   The description of the version.
      VERSION_DESCRIPTION type STRING,
      "!   No documentation available.
      FILE type FILE,
    end of T_MODEL_FILE_AND_METADATA.
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
    T_MODEL_FILE_AND_METADATA type string value '|LANGUAGE|FILE|',
    T_DELETE_MODEL_RESULTS type string value '|',
    __DUMMY type string value SPACE,
  end of C_REQUIRED_FIELDS .

constants:
  "! <p class="shorttext synchronized" lang="en">Map ABAP identifiers to service identifiers.</p>
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
     NAME type string value 'name',
     USER_METADATA type string value 'user_metadata',
     INNER type string value 'inner',
     FILE type string value 'file',
     ANALYZED_TEXT type string value 'analyzed_text',
     RETRIEVED_URL type string value 'retrieved_url',
     USAGE type string value 'usage',
     SEMANTICROLES type string value 'semanticRoles',
     TEXT_CHARACTERS type string value 'text_characters',
     TEXT_UNITS type string value 'text_units',
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


    "! <p class="shorttext synchronized" lang="en">Analyze text</p>
    "!   Analyzes text, HTML, or a public webpage for the following features:<br/>
    "!   - Categories<br/>
    "!   - Concepts<br/>
    "!   - Emotion<br/>
    "!   - Entities<br/>
    "!   - Keywords<br/>
    "!   - Metadata<br/>
    "!   - Relations<br/>
    "!   - Semantic roles<br/>
    "!   - Sentiment<br/>
    "!   - Syntax (Experimental).<br/>
    "!   <br/>
    "!   If a language for the input text is not specified with the `language` parameter,
    "!    the service [automatically detects the
    "!    language](https://cloud.ibm.com/docs/services/natural-language-understanding?to
    "!   pic=natural-language-understanding-detectable-languages).
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
    "!    models](https://cloud.ibm.com/docs/services/natural-language-understanding?topi
    "!   c=natural-language-understanding-customizing) that are deployed to your Natural
    "!    Language Understanding service.
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
  e_request_prop-url-path_base   = '/natural-language-understanding/api'.

endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_NAT_LANG_UNDRSTND_V1->GET_SDK_VERSION_DATE
* +-------------------------------------------------------------------------------------------------+
* | [<-()] E_SDK_VERSION_DATE             TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method get_sdk_version_date.

    e_sdk_version_date = '20200310173433'.

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
