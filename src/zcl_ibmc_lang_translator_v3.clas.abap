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
"! <p class="shorttext synchronized" lang="en">Language Translator</p>
"! IBM Watson&trade; Language Translator translates text from one language to
"!  another. The service offers multiple IBM provided translation models that you
"!  can customize based on your unique terminology and language. Use Language
"!  Translator to take news from across the globe and present it in your language,
"!  communicate with your customers in their own language, and more. <br/>
class ZCL_IBMC_LANG_TRANSLATOR_V3 DEFINITION
  public
  inheriting from ZCL_IBMC_SERVICE_EXT
  create public .

public section.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A globally unique string that identifies the underlying</p>
    "!     model that is used for translation.
      T_MODEL_ID type String.
  types:
    "! No documentation available.
    begin of T_IDENTIFIABLE_LANGUAGE,
      "!   The language code for an identifiable language.
      LANGUAGE type STRING,
      "!   The name of the identifiable language.
      NAME type STRING,
    end of T_IDENTIFIABLE_LANGUAGE.
  types:
    "! No documentation available.
    begin of T_IDENTIFIABLE_LANGUAGES,
      "!   A list of all languages that the service can identify.
      LANGUAGES type STANDARD TABLE OF T_IDENTIFIABLE_LANGUAGE WITH NON-UNIQUE DEFAULT KEY,
    end of T_IDENTIFIABLE_LANGUAGES.
  types:
    "! No documentation available.
    begin of T_TRANSLATION,
      "!   Translation output in UTF-8.
      TRANSLATION type STRING,
    end of T_TRANSLATION.
  types:
    "! No documentation available.
    begin of T_TRANSLATION_RESULT,
      "!   An estimate of the number of words in the input text.
      WORD_COUNT type INTEGER,
      "!   Number of characters in the input text.
      CHARACTER_COUNT type INTEGER,
      "!   List of translation output in UTF-8, corresponding to the input text entries.
      TRANSLATIONS type STANDARD TABLE OF T_TRANSLATION WITH NON-UNIQUE DEFAULT KEY,
    end of T_TRANSLATION_RESULT.
  types:
    "! No documentation available.
    begin of T_IDENTIFIED_LANGUAGE,
      "!   The language code for an identified language.
      LANGUAGE type STRING,
      "!   The confidence score for the identified language.
      CONFIDENCE type DOUBLE,
    end of T_IDENTIFIED_LANGUAGE.
  types:
    "! No documentation available.
    begin of T_IDENTIFIED_LANGUAGES,
      "!   A ranking of identified languages with confidence scores.
      LANGUAGES type STANDARD TABLE OF T_IDENTIFIED_LANGUAGE WITH NON-UNIQUE DEFAULT KEY,
    end of T_IDENTIFIED_LANGUAGES.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Translation target language code.</p>
      T_TARGET type String.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The status of the translation job associated with a</p>
    "!     submitted document.
      T_TRANSLATION_STATUS type String.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Document information, including translation status.</p>
    begin of T_DOCUMENT_STATUS,
      "!   System generated ID identifying a document being translated using one specific
      "!    translation model.
      DOCUMENT_ID type STRING,
      "!   filename from the submission (if it was missing in the multipart-form,
      "!    &apos;noname.&lt;ext matching content type&gt;&apos; is used.
      FILENAME type STRING,
      "!   The status of the translation job associated with a submitted document.
      STATUS type STRING,
      "!   A globally unique string that identifies the underlying model that is used for
      "!    translation.
      MODEL_ID type STRING,
      "!   Model ID of the base model that was used to customize the model. If the model is
      "!    not a custom model, this will be absent or an empty string.
      BASE_MODEL_ID type STRING,
      "!   Translation source language code.
      SOURCE type STRING,
      "!   Translation target language code.
      TARGET type STRING,
      "!   The time when the document was submitted.
      CREATED type DATETIME,
      "!   The time when the translation completed.
      COMPLETED type DATETIME,
      "!   An estimate of the number of words in the source document. Returned only if
      "!    `status` is `available`.
      WORD_COUNT type INTEGER,
      "!   The number of characters in the source document, present only if
      "!    status=available.
      CHARACTER_COUNT type INTEGER,
    end of T_DOCUMENT_STATUS.
  types:
    "! No documentation available.
    begin of T_ERROR_RESPONSE,
      "!   The http error code.
      CODE type INTEGER,
      "!   A short description of the error.
      ERROR type STRING,
    end of T_ERROR_RESPONSE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Translation source language code.</p>
      T_SOURCE type String.
  types:
    "! No documentation available.
    begin of T_INLINE_OBJECT1,
      "!   The model to use for translation. `model_id` or both `source` and `target` are
      "!    required.
      MODEL_ID type STRING,
      "!   Language code that specifies the language of the source document.
      SOURCE type STRING,
      "!   Language code that specifies the target language for translation.
      TARGET type STRING,
      "!   To use a previously submitted document as the source for a new translation,
      "!    enter the `document_id` of the document.
      DOCUMENT_ID type STRING,
      "!   The contents of the source file to translate.<br/>
      "!   <br/>
      "!   [Supported file
      "!    types](https://cloud.ibm.com/docs/services/language-translator?topic=language-t
      "!   ranslator-document-translator-tutorial#supported-file-formats)<br/>
      "!   <br/>
      "!   Maximum file size: **20 MB**.
      FILE type FILE,
    end of T_INLINE_OBJECT1.
  types:
    "! No documentation available.
    begin of T_INLINE_OBJECT,
      "!   A TMX file with your customizations. The customizations in the file completely
      "!    overwrite the domain translaton data, including high frequency or high
      "!    confidence phrase translations. You can upload only one glossary with a file
      "!    size less than 10 MB per call. A forced glossary should contain single words or
      "!    short phrases.
      FORCED_GLOSSARY type FILE,
      "!   A TMX file with parallel sentences for source and target language. You can
      "!    upload multiple parallel_corpus files in one request. All uploaded
      "!    parallel_corpus files combined, your parallel corpus must contain at least
      "!    5,000 parallel sentences to train successfully.
      PARALLEL_CORPUS type FILE,
    end of T_INLINE_OBJECT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Response payload for models.</p>
    begin of T_TRANSLATION_MODEL,
      "!   A globally unique string that identifies the underlying model that is used for
      "!    translation.
      MODEL_ID type STRING,
      "!   Optional name that can be specified when the model is created.
      NAME type STRING,
      "!   Translation source language code.
      SOURCE type STRING,
      "!   Translation target language code.
      TARGET type STRING,
      "!   Model ID of the base model that was used to customize the model. If the model is
      "!    not a custom model, this will be an empty string.
      BASE_MODEL_ID type STRING,
      "!   The domain of the translation model.
      DOMAIN type STRING,
      "!   Whether this model can be used as a base for customization. Customized models
      "!    are not further customizable, and some base models are not customizable.
      CUSTOMIZABLE type BOOLEAN,
      "!   Whether or not the model is a default model. A default model is the model for a
      "!    given language pair that will be used when that language pair is specified in
      "!    the source and target parameters.
      DEFAULT_MODEL type BOOLEAN,
      "!   Either an empty string, indicating the model is not a custom model, or the ID of
      "!    the service instance that created the model.
      OWNER type STRING,
      "!   Availability of a model.
      STATUS type STRING,
    end of T_TRANSLATION_MODEL.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The response type for listing existing translation models.</p>
    begin of T_TRANSLATION_MODELS,
      "!   An array of available models.
      MODELS type STANDARD TABLE OF T_TRANSLATION_MODEL WITH NON-UNIQUE DEFAULT KEY,
    end of T_TRANSLATION_MODELS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Model ID of the base model that was used to customize the</p>
    "!     model. If the model is not a custom model, this will be absent or an empty
    "!     string.
      T_BASE_MODEL_ID type String.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    System generated ID identifying a document being translated</p>
    "!     using one specific translation model.
      T_DOCUMENT_ID type String.
  types:
    "! No documentation available.
    begin of T_TRANSLATE_REQUEST,
      "!   Input text in UTF-8 encoding. Multiple entries will result in multiple
      "!    translations in the response.
      TEXT type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   A globally unique string that identifies the underlying model that is used for
      "!    translation.
      MODEL_ID type STRING,
      "!   Translation source language code.
      SOURCE type STRING,
      "!   Translation target language code.
      TARGET type STRING,
    end of T_TRANSLATE_REQUEST.
  types:
    "! No documentation available.
    begin of T_DELETE_MODEL_RESULT,
      "!   &quot;OK&quot; indicates that the model was successfully deleted.
      STATUS type STRING,
    end of T_DELETE_MODEL_RESULT.
  types:
    "! No documentation available.
    begin of T_DOCUMENT_LIST,
      "!   An array of all previously submitted documents.
      DOCUMENTS type STANDARD TABLE OF T_DOCUMENT_STATUS WITH NON-UNIQUE DEFAULT KEY,
    end of T_DOCUMENT_LIST.

constants:
  "! <p class="shorttext synchronized" lang="en">List of required fields per type.</p>
  begin of C_REQUIRED_FIELDS,
    T_IDENTIFIABLE_LANGUAGE type string value '|LANGUAGE|NAME|',
    T_IDENTIFIABLE_LANGUAGES type string value '|LANGUAGES|',
    T_TRANSLATION type string value '|TRANSLATION|',
    T_TRANSLATION_RESULT type string value '|WORD_COUNT|CHARACTER_COUNT|TRANSLATIONS|',
    T_IDENTIFIED_LANGUAGE type string value '|LANGUAGE|CONFIDENCE|',
    T_IDENTIFIED_LANGUAGES type string value '|LANGUAGES|',
    T_DOCUMENT_STATUS type string value '|DOCUMENT_ID|FILENAME|STATUS|MODEL_ID|SOURCE|TARGET|CREATED|',
    T_ERROR_RESPONSE type string value '|CODE|ERROR|',
    T_INLINE_OBJECT1 type string value '|FILE|',
    T_INLINE_OBJECT type string value '|',
    T_TRANSLATION_MODEL type string value '|MODEL_ID|',
    T_TRANSLATION_MODELS type string value '|MODELS|',
    T_TRANSLATE_REQUEST type string value '|TEXT|',
    T_DELETE_MODEL_RESULT type string value '|STATUS|',
    T_DOCUMENT_LIST type string value '|DOCUMENTS|',
    __DUMMY type string value SPACE,
  end of C_REQUIRED_FIELDS .

constants:
  "! <p class="shorttext synchronized" lang="en">Map ABAP identifiers to service identifiers.</p>
  begin of C_ABAPNAME_DICTIONARY,
     DOCUMENTS type string value 'documents',
     DOCUMENT_ID type string value 'document_id',
     FILENAME type string value 'filename',
     STATUS type string value 'status',
     MODEL_ID type string value 'model_id',
     BASE_MODEL_ID type string value 'base_model_id',
     SOURCE type string value 'source',
     TARGET type string value 'target',
     CREATED type string value 'created',
     COMPLETED type string value 'completed',
     WORD_COUNT type string value 'word_count',
     CHARACTER_COUNT type string value 'character_count',
     MODELS type string value 'models',
     NAME type string value 'name',
     DOMAIN type string value 'domain',
     CUSTOMIZABLE type string value 'customizable',
     DEFAULT_MODEL type string value 'default_model',
     OWNER type string value 'owner',
     TEXT type string value 'text',
     TRANSLATIONS type string value 'translations',
     TRANSLATION type string value 'translation',
     LANGUAGES type string value 'languages',
     LANGUAGE type string value 'language',
     CONFIDENCE type string value 'confidence',
     CODE type string value 'code',
     ERROR type string value 'error',
     FORCED_GLOSSARY type string value 'forced_glossary',
     PARALLEL_CORPUS type string value 'parallel_corpus',
     FILE type string value 'file',
  end of C_ABAPNAME_DICTIONARY .


  methods GET_APPNAME
    redefinition .
  methods GET_REQUEST_PROP
    redefinition .
  methods GET_SDK_VERSION_DATE
    redefinition .


    "! <p class="shorttext synchronized" lang="en">Translate</p>
    "!   Translates the input text from the source language to the target language.
    "!
    "! @parameter I_REQUEST |
    "!   The translate request containing the text, and either a model ID or source and
    "!    target language pair.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_TRANSLATION_RESULT
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods TRANSLATE
    importing
      !I_REQUEST type T_TRANSLATE_REQUEST
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_TRANSLATION_RESULT
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">List identifiable languages</p>
    "!   Lists the languages that the service can identify. Returns the language code
    "!    (for example, `en` for English or `es` for Spanish) and name of each language.
    "!
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_IDENTIFIABLE_LANGUAGES
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_IDENTIFIABLE_LANGUAGES
    importing
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_IDENTIFIABLE_LANGUAGES
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Identify language</p>
    "!   Identifies the language of the input text.
    "!
    "! @parameter I_TEXT |
    "!   Input text in UTF-8 format.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_IDENTIFIED_LANGUAGES
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods IDENTIFY
    importing
      !I_TEXT type STRING
      !I_contenttype type string default 'text/plain'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_IDENTIFIED_LANGUAGES
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">List models</p>
    "!   Lists available translation models.
    "!
    "! @parameter I_SOURCE |
    "!   Specify a language code to filter results by source language.
    "! @parameter I_TARGET |
    "!   Specify a language code to filter results by target language.
    "! @parameter I_DEFAULT |
    "!   If the default parameter isn&apos;t specified, the service will return all
    "!    models (default and non-default) for each language pair. To return only default
    "!    models, set this to `true`. To return only non-default models, set this to
    "!    `false`. There is exactly one default model per language pair, the IBM provided
    "!    base model.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_TRANSLATION_MODELS
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_MODELS
    importing
      !I_SOURCE type STRING optional
      !I_TARGET type STRING optional
      !I_DEFAULT type BOOLEAN optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_TRANSLATION_MODELS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Create model</p>
    "!   Uploads Translation Memory eXchange (TMX) files to customize a translation
    "!    model.<br/>
    "!   <br/>
    "!   You can either customize a model with a forced glossary or with a corpus that
    "!    contains parallel sentences. To create a model that is customized with a
    "!    parallel corpus &lt;b&gt;and&lt;/b&gt; a forced glossary, proceed in two steps:
    "!    customize with a parallel corpus first and then customize the resulting model
    "!    with a glossary. Depending on the type of customization and the size of the
    "!    uploaded corpora, training can range from minutes for a glossary to several
    "!    hours for a large parallel corpus. You can upload a single forced glossary file
    "!    and this file must be less than &lt;b&gt;10 MB&lt;/b&gt;. You can upload
    "!    multiple parallel corpora tmx files. The cumulative file size of all uploaded
    "!    files is limited to &lt;b&gt;250 MB&lt;/b&gt;. To successfully train with a
    "!    parallel corpus you must have at least &lt;b&gt;5,000 parallel
    "!    sentences&lt;/b&gt; in your corpus.<br/>
    "!   <br/>
    "!   You can have a &lt;b&gt;maximum of 10 custom models per language pair&lt;/b&gt;.
    "!
    "!
    "! @parameter I_BASE_MODEL_ID |
    "!   The model ID of the model to use as the base for customization. To see available
    "!    models, use the `List models` method. Usually all IBM provided models are
    "!    customizable. In addition, all your models that have been created via parallel
    "!    corpus customization, can be further customized with a forced glossary.
    "! @parameter I_FORCED_GLOSSARY |
    "!   A TMX file with your customizations. The customizations in the file completely
    "!    overwrite the domain translaton data, including high frequency or high
    "!    confidence phrase translations. You can upload only one glossary with a file
    "!    size less than 10 MB per call. A forced glossary should contain single words or
    "!    short phrases.
    "! @parameter I_PARALLEL_CORPUS |
    "!   A TMX file with parallel sentences for source and target language. You can
    "!    upload multiple parallel_corpus files in one request. All uploaded
    "!    parallel_corpus files combined, your parallel corpus must contain at least
    "!    5,000 parallel sentences to train successfully.
    "! @parameter I_NAME |
    "!   An optional model name that you can use to identify the model. Valid characters
    "!    are letters, numbers, dashes, underscores, spaces and apostrophes. The maximum
    "!    length is 32 characters.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_TRANSLATION_MODEL
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods CREATE_MODEL
    importing
      !I_BASE_MODEL_ID type STRING
      !I_FORCED_GLOSSARY type FILE optional
      !I_PARALLEL_CORPUS type FILE optional
      !I_NAME type STRING optional
      !I_FORCED_GLOSSARY_CT type STRING default ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-ALL
      !I_PARALLEL_CORPUS_CT type STRING default ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-ALL
      !I_contenttype type string default 'multipart/form-data'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_TRANSLATION_MODEL
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Delete model</p>
    "!   Deletes a custom translation model.
    "!
    "! @parameter I_MODEL_ID |
    "!   Model ID of the model to delete.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_DELETE_MODEL_RESULT
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_MODEL
    importing
      !I_MODEL_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_DELETE_MODEL_RESULT
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Get model details</p>
    "!   Gets information about a translation model, including training status for custom
    "!    models. Use this API call to poll the status of your customization request. A
    "!    successfully completed training will have a status of `available`.
    "!
    "! @parameter I_MODEL_ID |
    "!   Model ID of the model to get.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_TRANSLATION_MODEL
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_MODEL
    importing
      !I_MODEL_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_TRANSLATION_MODEL
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">List documents</p>
    "!   Lists documents that have been submitted for translation
    "!
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_DOCUMENT_LIST
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_DOCUMENTS
    importing
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_DOCUMENT_LIST
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Translate document</p>
    "!   Submit a document for translation. You can submit the document contents in the
    "!    `file` parameter, or you can reference a previously submitted document by
    "!    document ID.
    "!
    "! @parameter I_FILE |
    "!   The contents of the source file to translate.<br/>
    "!   <br/>
    "!   [Supported file
    "!    types](https://cloud.ibm.com/docs/services/language-translator?topic=language-t
    "!   ranslator-document-translator-tutorial#supported-file-formats)<br/>
    "!   <br/>
    "!   Maximum file size: **20 MB**.
    "! @parameter I_FILENAME |
    "!   The filename for file.
    "! @parameter I_FILE_CONTENT_TYPE |
    "!   The content type of file.
    "! @parameter I_MODEL_ID |
    "!   The model to use for translation. `model_id` or both `source` and `target` are
    "!    required.
    "! @parameter I_SOURCE |
    "!   Language code that specifies the language of the source document.
    "! @parameter I_TARGET |
    "!   Language code that specifies the target language for translation.
    "! @parameter I_DOCUMENT_ID |
    "!   To use a previously submitted document as the source for a new translation,
    "!    enter the `document_id` of the document.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_DOCUMENT_STATUS
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods TRANSLATE_DOCUMENT
    importing
      !I_FILE type FILE
      !I_FILENAME type STRING
      !I_FILE_CONTENT_TYPE type STRING optional
      !I_MODEL_ID type STRING optional
      !I_SOURCE type STRING optional
      !I_TARGET type STRING optional
      !I_DOCUMENT_ID type STRING optional
      !I_contenttype type string default 'multipart/form-data'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_DOCUMENT_STATUS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Get document status</p>
    "!   Gets the translation status of a document
    "!
    "! @parameter I_DOCUMENT_ID |
    "!   The document ID of the document.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_DOCUMENT_STATUS
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_DOCUMENT_STATUS
    importing
      !I_DOCUMENT_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_DOCUMENT_STATUS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Delete document</p>
    "!   Deletes a document
    "!
    "! @parameter I_DOCUMENT_ID |
    "!   Document ID of the document to delete.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_DOCUMENT
    importing
      !I_DOCUMENT_ID type STRING
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Get translated document</p>
    "!   Gets the translated document associated with the given document ID
    "!
    "! @parameter I_DOCUMENT_ID |
    "!   The document ID of the document that was submitted for translation.
    "! @parameter I_ACCEPT |
    "!   The type of the response: application/powerpoint, application/mspowerpoint,
    "!    application/x-rtf, application/json, application/xml, application/vnd.ms-excel,
    "!    application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,
    "!    application/vnd.ms-powerpoint,
    "!    application/vnd.openxmlformats-officedocument.presentationml.presentation,
    "!    application/msword,
    "!    application/vnd.openxmlformats-officedocument.wordprocessingml.document,
    "!    application/vnd.oasis.opendocument.spreadsheet,
    "!    application/vnd.oasis.opendocument.presentation,
    "!    application/vnd.oasis.opendocument.text, application/pdf, application/rtf,
    "!    text/html, text/json, text/plain, text/richtext, text/rtf, or text/xml. A
    "!    character encoding can be specified by including a `charset` parameter. For
    "!    example, &apos;text/html;charset=utf-8&apos;.
    "! @parameter E_RESPONSE |
    "!   Service return value of type FILE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_TRANSLATED_DOCUMENT
    importing
      !I_DOCUMENT_ID type STRING
      !I_ACCEPT type STRING optional
    exporting
      !E_RESPONSE type FILE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .


protected section.

private section.

  methods SET_DEFAULT_QUERY_PARAMETERS
    changing
      !C_URL type TS_URL .

ENDCLASS.

class ZCL_IBMC_LANG_TRANSLATOR_V3 IMPLEMENTATION.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_LANG_TRANSLATOR_V3->GET_APPNAME
* +-------------------------------------------------------------------------------------------------+
* | [<-()] E_APPNAME                      TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method GET_APPNAME.

    e_appname = 'Language Translator'.

  endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Protected Method ZCL_IBMC_LANG_TRANSLATOR_V3->GET_REQUEST_PROP
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
  elseif lv_auth_method eq 'basicAuth'.
    e_request_prop-auth_name       = 'basicAuth'.
    e_request_prop-auth_type       = 'http'.
    e_request_prop-auth_basic      = c_boolean_true.
  else.
  endif.

  e_request_prop-url-protocol    = 'http'.
  e_request_prop-url-host        = 'localhost'.
  e_request_prop-url-path_base   = '/language-translator/api'.

endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_LANG_TRANSLATOR_V3->GET_SDK_VERSION_DATE
* +-------------------------------------------------------------------------------------------------+
* | [<-()] E_SDK_VERSION_DATE             TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method get_sdk_version_date.

    e_sdk_version_date = '20200310173429'.

  endmethod.



* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_LANG_TRANSLATOR_V3->TRANSLATE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_REQUEST        TYPE T_TRANSLATE_REQUEST
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_TRANSLATION_RESULT
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method TRANSLATE.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v3/translate'.

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
    lv_datatype = get_datatype( i_REQUEST ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_REQUEST i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'request' i_value = i_REQUEST ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_REQUEST to <lv_text>.
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
* | Instance Public Method ZCL_IBMC_LANG_TRANSLATOR_V3->LIST_IDENTIFIABLE_LANGUAGES
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_IDENTIFIABLE_LANGUAGES
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_IDENTIFIABLE_LANGUAGES.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v3/identifiable_languages'.

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
* | Instance Public Method ZCL_IBMC_LANG_TRANSLATOR_V3->IDENTIFY
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_TEXT        TYPE STRING
* | [--->] I_contenttype       TYPE string (default ='text/plain')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_IDENTIFIED_LANGUAGES
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method IDENTIFY.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v3/identify'.

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
    lv_datatype = get_datatype( i_TEXT ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_TEXT i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'text' i_value = i_TEXT ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_TEXT to <lv_text>.
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
* | Instance Public Method ZCL_IBMC_LANG_TRANSLATOR_V3->LIST_MODELS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_SOURCE        TYPE STRING(optional)
* | [--->] I_TARGET        TYPE STRING(optional)
* | [--->] I_DEFAULT        TYPE BOOLEAN(optional)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_TRANSLATION_MODELS
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_MODELS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v3/models'.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_SOURCE is supplied.
    lv_queryparam = escape( val = i_SOURCE format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `source`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_TARGET is supplied.
    lv_queryparam = escape( val = i_TARGET format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `target`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_DEFAULT is supplied.
    lv_queryparam = i_DEFAULT.
    add_query_parameter(
      exporting
        i_parameter  = `default`
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
* | Instance Public Method ZCL_IBMC_LANG_TRANSLATOR_V3->CREATE_MODEL
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_BASE_MODEL_ID        TYPE STRING
* | [--->] I_FORCED_GLOSSARY        TYPE FILE(optional)
* | [--->] I_PARALLEL_CORPUS        TYPE FILE(optional)
* | [--->] I_NAME        TYPE STRING(optional)
* | [--->] I_FORCED_GLOSSARY_CT     TYPE STRING (default = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-all)
* | [--->] I_PARALLEL_CORPUS_CT     TYPE STRING (default = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-all)
* | [--->] I_contenttype       TYPE string (default ='multipart/form-data')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_TRANSLATION_MODEL
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CREATE_MODEL.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v3/models'.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    lv_queryparam = escape( val = i_BASE_MODEL_ID format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `base_model_id`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.

    if i_NAME is supplied.
    lv_queryparam = escape( val = i_NAME format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `name`
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




    if not i_FORCED_GLOSSARY is initial.
      lv_extension = get_file_extension( I_FORCED_GLOSSARY_CT ).
      lv_value = `form-data; name="forced_glossary"; filename="file` && lv_index && `.` && lv_extension && `"`  ##NO_TEXT.
      lv_index = lv_index + 1.
      clear ls_form_part.
      ls_form_part-content_type = I_FORCED_GLOSSARY_CT.
      ls_form_part-content_disposition = lv_value.
      ls_form_part-xdata = i_FORCED_GLOSSARY.
      append ls_form_part to lt_form_part.
    endif.

    if not i_PARALLEL_CORPUS is initial.
      lv_extension = get_file_extension( I_PARALLEL_CORPUS_CT ).
      lv_value = `form-data; name="parallel_corpus"; filename="file` && lv_index && `.` && lv_extension && `"`  ##NO_TEXT.
      lv_index = lv_index + 1.
      clear ls_form_part.
      ls_form_part-content_type = I_PARALLEL_CORPUS_CT.
      ls_form_part-content_disposition = lv_value.
      ls_form_part-xdata = i_PARALLEL_CORPUS.
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
* | Instance Public Method ZCL_IBMC_LANG_TRANSLATOR_V3->DELETE_MODEL
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_MODEL_ID        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_DELETE_MODEL_RESULT
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_MODEL.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v3/models/{model_id}'.
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
* | Instance Public Method ZCL_IBMC_LANG_TRANSLATOR_V3->GET_MODEL
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_MODEL_ID        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_TRANSLATION_MODEL
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_MODEL.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v3/models/{model_id}'.
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
* | Instance Public Method ZCL_IBMC_LANG_TRANSLATOR_V3->LIST_DOCUMENTS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_DOCUMENT_LIST
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_DOCUMENTS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v3/documents'.

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
* | Instance Public Method ZCL_IBMC_LANG_TRANSLATOR_V3->TRANSLATE_DOCUMENT
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_FILE        TYPE FILE
* | [--->] I_FILENAME        TYPE STRING
* | [--->] I_FILE_CONTENT_TYPE        TYPE STRING(optional)
* | [--->] I_MODEL_ID        TYPE STRING(optional)
* | [--->] I_SOURCE        TYPE STRING(optional)
* | [--->] I_TARGET        TYPE STRING(optional)
* | [--->] I_DOCUMENT_ID        TYPE STRING(optional)
* | [--->] I_contenttype       TYPE string (default ='multipart/form-data')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_DOCUMENT_STATUS
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method TRANSLATE_DOCUMENT.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v3/documents'.

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


    if not i_MODEL_ID is initial.
      clear ls_form_part.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      ls_form_part-content_disposition = 'form-data; name="model_id"'  ##NO_TEXT.
      lv_formdata = i_MODEL_ID.
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.

    if not i_SOURCE is initial.
      clear ls_form_part.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      ls_form_part-content_disposition = 'form-data; name="source"'  ##NO_TEXT.
      lv_formdata = i_SOURCE.
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.

    if not i_TARGET is initial.
      clear ls_form_part.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      ls_form_part-content_disposition = 'form-data; name="target"'  ##NO_TEXT.
      lv_formdata = i_TARGET.
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.

    if not i_DOCUMENT_ID is initial.
      clear ls_form_part.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      ls_form_part-content_disposition = 'form-data; name="document_id"'  ##NO_TEXT.
      lv_formdata = i_DOCUMENT_ID.
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
* | Instance Public Method ZCL_IBMC_LANG_TRANSLATOR_V3->GET_DOCUMENT_STATUS
* +-------------------------------------------------------------------------------------------------+
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

    ls_request_prop-url-path = '/v3/documents/{document_id}'.
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
* | Instance Public Method ZCL_IBMC_LANG_TRANSLATOR_V3->DELETE_DOCUMENT
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_DOCUMENT_ID        TYPE STRING
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_DOCUMENT.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v3/documents/{document_id}'.
    replace all occurrences of `{document_id}` in ls_request_prop-url-path with i_DOCUMENT_ID ignoring case.

    " standard headers
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








    " execute HTTP DELETE request
    lo_response = HTTP_DELETE( i_request_prop = ls_request_prop ).



endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_LANG_TRANSLATOR_V3->GET_TRANSLATED_DOCUMENT
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_DOCUMENT_ID        TYPE STRING
* | [--->] I_ACCEPT        TYPE STRING(optional)
* | [<---] E_RESPONSE                    TYPE        FILE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_TRANSLATED_DOCUMENT.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v3/documents/{document_id}/translated_document'.
    replace all occurrences of `{document_id}` in ls_request_prop-url-path with i_DOCUMENT_ID ignoring case.

    " standard headers
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).



    " process header parameters
    data:
      lv_headerparam type string  ##NEEDED.

    if i_ACCEPT is supplied.
    lv_headerparam = I_ACCEPT.
    add_header_parameter(
      exporting
        i_parameter  = 'Accept'
        i_value      = lv_headerparam
      changing
        c_headers    = ls_request_prop-headers )  ##NO_TEXT.
    endif.





    " execute HTTP GET request
    lo_response = HTTP_GET( i_request_prop = ls_request_prop ).


    " retrieve file data
    e_response = get_response_binary( lo_response ).

endmethod.




* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method ZCL_IBMC_LANG_TRANSLATOR_V3->SET_DEFAULT_QUERY_PARAMETERS
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
