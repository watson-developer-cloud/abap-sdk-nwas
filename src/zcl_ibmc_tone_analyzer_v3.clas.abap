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
"! <p class="shorttext synchronized" lang="en">Tone Analyzer</p>
"! The IBM Watson&trade; Tone Analyzer service uses linguistic analysis to detect
"!  emotional and language tones in written text. The service can analyze tone at
"!  both the document and sentence levels. You can use the service to understand
"!  how your written communications are perceived and then to improve the tone of
"!  your communications. Businesses can use the service to learn the tone of their
"!  customers&apos; communications and to respond to each customer appropriately,
"!  or to understand and improve their customer conversations.<br/>
"! <br/>
"! **Note:** Request logging is disabled for the Tone Analyzer service. Regardless
"!  of whether you set the `X-Watson-Learning-Opt-Out` request header, the service
"!  does not log or retain data from requests and responses. <br/>
class ZCL_IBMC_TONE_ANALYZER_V3 DEFINITION
  public
  inheriting from ZCL_IBMC_SERVICE_EXT
  create public .

public section.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The score for a tone from the input content.</p>
    begin of T_TONE_SCORE,
      "!   The score for the tone.<br/>
      "!   * **`2017-09-21`:** The score that is returned lies in the range of 0.5 to 1. A
      "!    score greater than 0.75 indicates a high likelihood that the tone is perceived
      "!    in the content.<br/>
      "!   * **`2016-05-19`:** The score that is returned lies in the range of 0 to 1. A
      "!    score less than 0.5 indicates that the tone is unlikely to be perceived in the
      "!    content; a score greater than 0.75 indicates a high likelihood that the tone is
      "!    perceived.
      SCORE type DOUBLE,
      "!   The unique, non-localized identifier of the tone.<br/>
      "!   * **`2017-09-21`:** The service can return results for the following tone IDs:
      "!    `anger`, `fear`, `joy`, and `sadness` (emotional tones); `analytical`,
      "!    `confident`, and `tentative` (language tones). The service returns results only
      "!    for tones whose scores meet a minimum threshold of 0.5.<br/>
      "!   * **`2016-05-19`:** The service can return results for the following tone IDs of
      "!    the different categories: for the `emotion` category: `anger`, `disgust`,
      "!    `fear`, `joy`, and `sadness`; for the `language` category: `analytical`,
      "!    `confident`, and `tentative`; for the `social` category: `openness_big5`,
      "!    `conscientiousness_big5`, `extraversion_big5`, `agreeableness_big5`, and
      "!    `emotional_range_big5`. The service returns scores for all tones of a category,
      "!    regardless of their values.
      TONE_ID type STRING,
      "!   The user-visible, localized name of the tone.
      TONE_NAME type STRING,
    end of T_TONE_SCORE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The category for a tone from the input content.</p>
    begin of T_TONE_CATEGORY,
      "!   An array of `ToneScore` objects that provides the results for the tones of the
      "!    category.
      TONES type STANDARD TABLE OF T_TONE_SCORE WITH NON-UNIQUE DEFAULT KEY,
      "!   The unique, non-localized identifier of the category for the results. The
      "!    service can return results for the following category IDs: `emotion_tone`,
      "!    `language_tone`, and `social_tone`.
      CATEGORY_ID type STRING,
      "!   The user-visible, localized name of the category.
      CATEGORY_NAME type STRING,
    end of T_TONE_CATEGORY.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Input for the general-purpose endpoint.</p>
    begin of T_TONE_INPUT,
      "!   The input content that the service is to analyze.
      TEXT type STRING,
    end of T_TONE_INPUT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The score for an utterance from the input content.</p>
    begin of T_TONE_CHAT_SCORE,
      "!   The score for the tone in the range of 0.5 to 1. A score greater than 0.75
      "!    indicates a high likelihood that the tone is perceived in the utterance.
      SCORE type DOUBLE,
      "!   The unique, non-localized identifier of the tone for the results. The service
      "!    returns results only for tones whose scores meet a minimum threshold of 0.5.
      TONE_ID type STRING,
      "!   The user-visible, localized name of the tone.
      TONE_NAME type STRING,
    end of T_TONE_CHAT_SCORE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An utterance for the input of the general-purpose endpoint.</p>
    begin of T_UTTERANCE,
      "!   An utterance contributed by a user in the conversation that is to be analyzed.
      "!    The utterance can contain multiple sentences.
      TEXT type STRING,
      "!   A string that identifies the user who contributed the utterance specified by the
      "!    `text` parameter.
      USER type STRING,
    end of T_UTTERANCE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Input for the customer-engagement endpoint.</p>
    begin of T_TONE_CHAT_INPUT,
      "!   An array of `Utterance` objects that provides the input content that the service
      "!    is to analyze.
      UTTERANCES type STANDARD TABLE OF T_UTTERANCE WITH NON-UNIQUE DEFAULT KEY,
    end of T_TONE_CHAT_INPUT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The results of the analysis for the individual sentences of</p>
    "!     the input content.
    begin of T_SENTENCE_ANALYSIS,
      "!   The unique identifier of a sentence of the input content. The first sentence has
      "!    ID 0, and the ID of each subsequent sentence is incremented by one.
      SENTENCE_ID type INTEGER,
      "!   The text of the input sentence.
      TEXT type STRING,
      "!   **`2017-09-21`:** An array of `ToneScore` objects that provides the results of
      "!    the analysis for each qualifying tone of the sentence. The array includes
      "!    results for any tone whose score is at least 0.5. The array is empty if no tone
      "!    has a score that meets this threshold. **`2016-05-19`:** Not returned.
      TONES type STANDARD TABLE OF T_TONE_SCORE WITH NON-UNIQUE DEFAULT KEY,
      "!   **`2017-09-21`:** Not returned. **`2016-05-19`:** An array of `ToneCategory`
      "!    objects that provides the results of the tone analysis for the sentence. The
      "!    service returns results only for the tones specified with the `tones` parameter
      "!    of the request.
      TONE_CATEGORIES type STANDARD TABLE OF T_TONE_CATEGORY WITH NON-UNIQUE DEFAULT KEY,
      "!   **`2017-09-21`:** Not returned. **`2016-05-19`:** The offset of the first
      "!    character of the sentence in the overall input content.
      INPUT_FROM type INTEGER,
      "!   **`2017-09-21`:** Not returned. **`2016-05-19`:** The offset of the last
      "!    character of the sentence in the overall input content.
      INPUT_TO type INTEGER,
    end of T_SENTENCE_ANALYSIS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The results of the analysis for an utterance of the input</p>
    "!     content.
    begin of T_UTTERANCE_ANALYSIS,
      "!   The unique identifier of the utterance. The first utterance has ID 0, and the ID
      "!    of each subsequent utterance is incremented by one.
      UTTERANCE_ID type INTEGER,
      "!   The text of the utterance.
      UTTERANCE_TEXT type STRING,
      "!   An array of `ToneChatScore` objects that provides results for the most prevalent
      "!    tones of the utterance. The array includes results for any tone whose score is
      "!    at least 0.5. The array is empty if no tone has a score that meets this
      "!    threshold.
      TONES type STANDARD TABLE OF T_TONE_CHAT_SCORE WITH NON-UNIQUE DEFAULT KEY,
      "!   **`2017-09-21`:** An error message if the utterance contains more than 500
      "!    characters. The service does not analyze the utterance. **`2016-05-19`:** Not
      "!    returned.
      ERROR type STRING,
    end of T_UTTERANCE_ANALYSIS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The results of the analysis for the utterances of the input</p>
    "!     content.
    begin of T_UTTERANCE_ANALYSES,
      "!   An array of `UtteranceAnalysis` objects that provides the results for each
      "!    utterance of the input.
      UTTERANCES_TONE type STANDARD TABLE OF T_UTTERANCE_ANALYSIS WITH NON-UNIQUE DEFAULT KEY,
      "!   **`2017-09-21`:** A warning message if the content contains more than 50
      "!    utterances. The service analyzes only the first 50 utterances.
      "!    **`2016-05-19`:** Not returned.
      WARNING type STRING,
    end of T_UTTERANCE_ANALYSES.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The error response from a failed request.</p>
    begin of T_ERROR_MODEL,
      "!   The HTTP status code.
      CODE type INTEGER,
      "!   A service-specific error code.
      SUB_CODE type STRING,
      "!   A description of the error.
      ERROR type STRING,
      "!   A URL to documentation explaining the cause and possibly solutions for the
      "!    error.
      HELP type STRING,
    end of T_ERROR_MODEL.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The results of the analysis for the full input content.</p>
    begin of T_DOCUMENT_ANALYSIS,
      "!   **`2017-09-21`:** An array of `ToneScore` objects that provides the results of
      "!    the analysis for each qualifying tone of the document. The array includes
      "!    results for any tone whose score is at least 0.5. The array is empty if no tone
      "!    has a score that meets this threshold. **`2016-05-19`:** Not returned.
      TONES type STANDARD TABLE OF T_TONE_SCORE WITH NON-UNIQUE DEFAULT KEY,
      "!   **`2017-09-21`:** Not returned. **`2016-05-19`:** An array of `ToneCategory`
      "!    objects that provides the results of the tone analysis for the full document of
      "!    the input content. The service returns results only for the tones specified
      "!    with the `tones` parameter of the request.
      TONE_CATEGORIES type STANDARD TABLE OF T_TONE_CATEGORY WITH NON-UNIQUE DEFAULT KEY,
      "!   **`2017-09-21`:** A warning message if the overall content exceeds 128 KB or
      "!    contains more than 1000 sentences. The service analyzes only the first 1000
      "!    sentences for document-level analysis and the first 100 sentences for
      "!    sentence-level analysis. **`2016-05-19`:** Not returned.
      WARNING type STRING,
    end of T_DOCUMENT_ANALYSIS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The tone analysis results for the input from the</p>
    "!     general-purpose endpoint.
    begin of T_TONE_ANALYSIS,
      "!   The results of the analysis for the full input content.
      DOCUMENT_TONE type T_DOCUMENT_ANALYSIS,
      "!   An array of `SentenceAnalysis` objects that provides the results of the analysis
      "!    for the individual sentences of the input content. The service returns results
      "!    only for the first 100 sentences of the input. The field is omitted if the
      "!    `sentences` parameter of the request is set to `false`.
      SENTENCES_TONE type STANDARD TABLE OF T_SENTENCE_ANALYSIS WITH NON-UNIQUE DEFAULT KEY,
    end of T_TONE_ANALYSIS.

constants:
  "! <p class="shorttext synchronized" lang="en">List of required fields per type.</p>
  begin of C_REQUIRED_FIELDS,
    T_TONE_SCORE type string value '|SCORE|TONE_ID|TONE_NAME|',
    T_TONE_CATEGORY type string value '|TONES|CATEGORY_ID|CATEGORY_NAME|',
    T_TONE_INPUT type string value '|TEXT|',
    T_TONE_CHAT_SCORE type string value '|SCORE|TONE_ID|TONE_NAME|',
    T_UTTERANCE type string value '|TEXT|',
    T_TONE_CHAT_INPUT type string value '|UTTERANCES|',
    T_SENTENCE_ANALYSIS type string value '|SENTENCE_ID|TEXT|',
    T_UTTERANCE_ANALYSIS type string value '|UTTERANCE_ID|UTTERANCE_TEXT|TONES|',
    T_UTTERANCE_ANALYSES type string value '|UTTERANCES_TONE|',
    T_ERROR_MODEL type string value '|CODE|ERROR|',
    T_DOCUMENT_ANALYSIS type string value '|',
    T_TONE_ANALYSIS type string value '|DOCUMENT_TONE|',
    __DUMMY type string value SPACE,
  end of C_REQUIRED_FIELDS .

constants:
  "! <p class="shorttext synchronized" lang="en">Map ABAP identifiers to service identifiers.</p>
  begin of C_ABAPNAME_DICTIONARY,
     TEXT type string value 'text',
     UTTERANCES type string value 'utterances',
     USER type string value 'user',
     DOCUMENT_TONE type string value 'document_tone',
     SENTENCES_TONE type string value 'sentences_tone',
     SENTENCESTONE type string value 'sentencesTone',
     TONES type string value 'tones',
     TONE_CATEGORIES type string value 'tone_categories',
     TONECATEGORIES type string value 'toneCategories',
     WARNING type string value 'warning',
     SENTENCE_ID type string value 'sentence_id',
     INPUT_FROM type string value 'input_from',
     INPUT_TO type string value 'input_to',
     SCORE type string value 'score',
     TONE_ID type string value 'tone_id',
     TONE_NAME type string value 'tone_name',
     CATEGORY_ID type string value 'category_id',
     CATEGORY_NAME type string value 'category_name',
     UTTERANCES_TONE type string value 'utterances_tone',
     UTTERANCESTONE type string value 'utterancesTone',
     UTTERANCE_ID type string value 'utterance_id',
     UTTERANCE_TEXT type string value 'utterance_text',
     ERROR type string value 'error',
     CODE type string value 'code',
     SUB_CODE type string value 'sub_code',
     HELP type string value 'help',
  end of C_ABAPNAME_DICTIONARY .


  methods GET_APPNAME
    redefinition .
  methods GET_REQUEST_PROP
    redefinition .
  methods GET_SDK_VERSION_DATE
    redefinition .


    "! <p class="shorttext synchronized" lang="en">Analyze general tone</p>
    "!   Use the general-purpose endpoint to analyze the tone of your input content. The
    "!    service analyzes the content for emotional and language tones. The method
    "!    always analyzes the tone of the full document; by default, it also analyzes the
    "!    tone of each individual sentence of the content. <br/>
    "!   <br/>
    "!   You can submit no more than 128 KB of total input content and no more than 1000
    "!    individual sentences in JSON, plain text, or HTML format. The service analyzes
    "!    the first 1000 sentences for document-level analysis and only the first 100
    "!    sentences for sentence-level analysis. <br/>
    "!   <br/>
    "!   Per the JSON specification, the default character encoding for JSON content is
    "!    effectively always UTF-8; per the HTTP specification, the default encoding for
    "!    plain text and HTML is ISO-8859-1 (effectively, the ASCII character set). When
    "!    specifying a content type of plain text or HTML, include the `charset`
    "!    parameter to indicate the character encoding of the input text; for example:
    "!    `Content-Type: text/plain;charset=utf-8`. For `text/html`, the service removes
    "!    HTML tags and analyzes only the textual content. <br/>
    "!   <br/>
    "!   **See also:** [Using the general-purpose
    "!    endpoint](https://cloud.ibm.com/docs/tone-analyzer?topic=tone-analyzer-utgpe#ut
    "!   gpe).
    "!
    "! @parameter I_TONE_INPUT |
    "!   JSON, plain text, or HTML input that contains the content to be analyzed. For
    "!    JSON input, provide an object of type `ToneInput`.
    "! @parameter I_CONTENT_TYPE |
    "!   The type of the input. A character encoding can be specified by including a
    "!    `charset` parameter. For example, &apos;text/plain;charset=utf-8&apos;.
    "! @parameter I_SENTENCES |
    "!   Indicates whether the service is to return an analysis of each individual
    "!    sentence in addition to its analysis of the full document. If `true` (the
    "!    default), the service returns results for each sentence.
    "! @parameter I_TONES |
    "!   **`2017-09-21`:** Deprecated. The service continues to accept the parameter for
    "!    backward-compatibility, but the parameter no longer affects the response. <br/>
    "!   <br/>
    "!   **`2016-05-19`:** A comma-separated list of tones for which the service is to
    "!    return its analysis of the input; the indicated tones apply both to the full
    "!    document and to individual sentences of the document. You can specify one or
    "!    more of the valid values. Omit the parameter to request results for all three
    "!    tones.
    "! @parameter I_CONTENT_LANGUAGE |
    "!   The language of the input text for the request: English or French. Regional
    "!    variants are treated as their parent language; for example, `en-US` is
    "!    interpreted as `en`. The input content must match the specified language. Do
    "!    not submit content that contains both languages. You can use different
    "!    languages for **Content-Language** and **Accept-Language**.<br/>
    "!   * **`2017-09-21`:** Accepts `en` or `fr`.<br/>
    "!   * **`2016-05-19`:** Accepts only `en`.
    "! @parameter I_ACCEPT_LANGUAGE |
    "!   The desired language of the response. For two-character arguments, regional
    "!    variants are treated as their parent language; for example, `en-US` is
    "!    interpreted as `en`. You can use different languages for **Content-Language**
    "!    and **Accept-Language**.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_TONE_ANALYSIS
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods TONE
    importing
      !I_TONE_INPUT type T_TONE_INPUT
      !I_CONTENT_TYPE type STRING default 'application/json'
      !I_SENTENCES type BOOLEAN default c_boolean_true
      !I_TONES type TT_STRING optional
      !I_CONTENT_LANGUAGE type STRING default 'en'
      !I_ACCEPT_LANGUAGE type STRING default 'en'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_TONE_ANALYSIS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Analyze customer-engagement tone</p>
    "!   Use the customer-engagement endpoint to analyze the tone of customer service and
    "!    customer support conversations. For each utterance of a conversation, the
    "!    method reports the most prevalent subset of the following seven tones: sad,
    "!    frustrated, satisfied, excited, polite, impolite, and sympathetic. <br/>
    "!   <br/>
    "!   If you submit more than 50 utterances, the service returns a warning for the
    "!    overall content and analyzes only the first 50 utterances. If you submit a
    "!    single utterance that contains more than 500 characters, the service returns an
    "!    error for that utterance and does not analyze the utterance. The request fails
    "!    if all utterances have more than 500 characters. Per the JSON specification,
    "!    the default character encoding for JSON content is effectively always UTF-8.
    "!    <br/>
    "!   <br/>
    "!   **See also:** [Using the customer-engagement
    "!    endpoint](https://cloud.ibm.com/docs/tone-analyzer?topic=tone-analyzer-utco#utc
    "!   o).
    "!
    "! @parameter I_UTTERANCES |
    "!   An object that contains the content to be analyzed.
    "! @parameter I_CONTENT_LANGUAGE |
    "!   The language of the input text for the request: English or French. Regional
    "!    variants are treated as their parent language; for example, `en-US` is
    "!    interpreted as `en`. The input content must match the specified language. Do
    "!    not submit content that contains both languages. You can use different
    "!    languages for **Content-Language** and **Accept-Language**.<br/>
    "!   * **`2017-09-21`:** Accepts `en` or `fr`.<br/>
    "!   * **`2016-05-19`:** Accepts only `en`.
    "! @parameter I_ACCEPT_LANGUAGE |
    "!   The desired language of the response. For two-character arguments, regional
    "!    variants are treated as their parent language; for example, `en-US` is
    "!    interpreted as `en`. You can use different languages for **Content-Language**
    "!    and **Accept-Language**.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_UTTERANCE_ANALYSES
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods TONE_CHAT
    importing
      !I_UTTERANCES type T_TONE_CHAT_INPUT
      !I_CONTENT_LANGUAGE type STRING default 'en'
      !I_ACCEPT_LANGUAGE type STRING default 'en'
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_UTTERANCE_ANALYSES
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .


protected section.

private section.

  methods SET_DEFAULT_QUERY_PARAMETERS
    changing
      !C_URL type TS_URL .

ENDCLASS.

class ZCL_IBMC_TONE_ANALYZER_V3 IMPLEMENTATION.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_TONE_ANALYZER_V3->GET_APPNAME
* +-------------------------------------------------------------------------------------------------+
* | [<-()] E_APPNAME                      TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method GET_APPNAME.

    e_appname = 'Tone Analyzer'.

  endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Protected Method ZCL_IBMC_TONE_ANALYZER_V3->GET_REQUEST_PROP
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
  e_request_prop-url-path_base   = '/tone-analyzer/api'.

endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_TONE_ANALYZER_V3->GET_SDK_VERSION_DATE
* +-------------------------------------------------------------------------------------------------+
* | [<-()] E_SDK_VERSION_DATE             TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method get_sdk_version_date.

    e_sdk_version_date = '20200310173440'.

  endmethod.



* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_TONE_ANALYZER_V3->TONE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_TONE_INPUT        TYPE T_TONE_INPUT
* | [--->] I_CONTENT_TYPE        TYPE STRING (default ='application/json')
* | [--->] I_SENTENCES        TYPE BOOLEAN (default =c_boolean_true)
* | [--->] I_TONES        TYPE TT_STRING(optional)
* | [--->] I_CONTENT_LANGUAGE        TYPE STRING (default ='en')
* | [--->] I_ACCEPT_LANGUAGE        TYPE STRING (default ='en')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_TONE_ANALYSIS
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method TONE.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v3/tone'.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_SENTENCES is supplied.
    lv_queryparam = i_SENTENCES.
    add_query_parameter(
      exporting
        i_parameter  = `sentences`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_TONES is supplied.
    data:
      lv_item_TONES type STRING.
    clear: lv_queryparam, lv_sep.
    loop at i_TONES into lv_item_TONES.
      lv_queryparam = lv_queryparam && lv_sep && lv_item_TONES.
      lv_sep = ','.
    endloop.
    lv_queryparam = escape( val = lv_queryparam format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `tones`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    " process header parameters
    data:
      lv_headerparam type string  ##NEEDED.

    if i_CONTENT_TYPE is supplied.
    ls_request_prop-header_content_type = I_CONTENT_TYPE.
    endif.

    if i_CONTENT_LANGUAGE is supplied.
    lv_headerparam = I_CONTENT_LANGUAGE.
    add_header_parameter(
      exporting
        i_parameter  = 'Content-Language'
        i_value      = lv_headerparam
      changing
        c_headers    = ls_request_prop-headers )  ##NO_TEXT.
    endif.

    if i_ACCEPT_LANGUAGE is supplied.
    lv_headerparam = I_ACCEPT_LANGUAGE.
    add_header_parameter(
      exporting
        i_parameter  = 'Accept-Language'
        i_value      = lv_headerparam
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
    lv_datatype = get_datatype( i_TONE_INPUT ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_TONE_INPUT i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'tone_input' i_value = i_TONE_INPUT ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_TONE_INPUT to <lv_text>.
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
* | Instance Public Method ZCL_IBMC_TONE_ANALYZER_V3->TONE_CHAT
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_UTTERANCES        TYPE T_TONE_CHAT_INPUT
* | [--->] I_CONTENT_LANGUAGE        TYPE STRING (default ='en')
* | [--->] I_ACCEPT_LANGUAGE        TYPE STRING (default ='en')
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_UTTERANCE_ANALYSES
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method TONE_CHAT.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v3/tone_chat'.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).



    " process header parameters
    data:
      lv_headerparam type string  ##NEEDED.

    if i_CONTENT_LANGUAGE is supplied.
    lv_headerparam = I_CONTENT_LANGUAGE.
    add_header_parameter(
      exporting
        i_parameter  = 'Content-Language'
        i_value      = lv_headerparam
      changing
        c_headers    = ls_request_prop-headers )  ##NO_TEXT.
    endif.

    if i_ACCEPT_LANGUAGE is supplied.
    lv_headerparam = I_ACCEPT_LANGUAGE.
    add_header_parameter(
      exporting
        i_parameter  = 'Accept-Language'
        i_value      = lv_headerparam
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
    lv_datatype = get_datatype( i_UTTERANCES ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_UTTERANCES i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'utterances' i_value = i_UTTERANCES ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_UTTERANCES to <lv_text>.
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
* | Instance Private Method ZCL_IBMC_TONE_ANALYZER_V3->SET_DEFAULT_QUERY_PARAMETERS
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
