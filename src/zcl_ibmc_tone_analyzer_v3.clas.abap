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
"! <h1>Tone Analyzer</h1>
"! The IBM Watson&trade; Tone Analyzer service uses linguistic analysis to detect
"!  emotional and language tones in written text. The service can analyze tone at
"!  both the document and sentence levels. You can use the service to understand
"!  how your written communications are perceived and then to improve the tone of
"!  your communications. Businesses can use the service to learn the tone of their
"!  customers' communications and to respond to each customer appropriately, or to
"!  understand and improve their customer conversations.
"!
"! **Note:** Request logging is disabled for the Tone Analyzer service. Regardless
"!  of whether you set the `X-Watson-Learning-Opt-Out` request header, the service
"!  does not log or retain data from requests and responses. <br/>
class ZCL_IBMC_TONE_ANALYZER_V3 DEFINITION
  public
  inheriting from ZCL_IBMC_SERVICE_EXT
  create public .

public section.
  types:
    "!   The score for a tone from the input content.
    begin of T_TONE_SCORE,
      SCORE type DOUBLE,
      TONE_ID type STRING,
      TONE_NAME type STRING,
    end of T_TONE_SCORE.
  types:
    "!   The category for a tone from the input content.
    begin of T_TONE_CATEGORY,
      TONES type STANDARD TABLE OF T_TONE_SCORE WITH NON-UNIQUE DEFAULT KEY,
      CATEGORY_ID type STRING,
      CATEGORY_NAME type STRING,
    end of T_TONE_CATEGORY.
  types:
    "!   Input for the general-purpose endpoint.
    begin of T_TONE_INPUT,
      TEXT type STRING,
    end of T_TONE_INPUT.
  types:
    "!   The score for an utterance from the input content.
    begin of T_TONE_CHAT_SCORE,
      SCORE type DOUBLE,
      TONE_ID type STRING,
      TONE_NAME type STRING,
    end of T_TONE_CHAT_SCORE.
  types:
    "!   An utterance for the input of the general-purpose endpoint.
    begin of T_UTTERANCE,
      TEXT type STRING,
      USER type STRING,
    end of T_UTTERANCE.
  types:
    "!   Input for the customer-engagement endpoint.
    begin of T_TONE_CHAT_INPUT,
      UTTERANCES type STANDARD TABLE OF T_UTTERANCE WITH NON-UNIQUE DEFAULT KEY,
    end of T_TONE_CHAT_INPUT.
  types:
    "!   The results of the analysis for the individual sentences of the input content.
    begin of T_SENTENCE_ANALYSIS,
      SENTENCE_ID type INTEGER,
      TEXT type STRING,
      TONES type STANDARD TABLE OF T_TONE_SCORE WITH NON-UNIQUE DEFAULT KEY,
      TONE_CATEGORIES type STANDARD TABLE OF T_TONE_CATEGORY WITH NON-UNIQUE DEFAULT KEY,
      INPUT_FROM type INTEGER,
      INPUT_TO type INTEGER,
    end of T_SENTENCE_ANALYSIS.
  types:
    "!   The results of the analysis for an utterance of the input content.
    begin of T_UTTERANCE_ANALYSIS,
      UTTERANCE_ID type INTEGER,
      UTTERANCE_TEXT type STRING,
      TONES type STANDARD TABLE OF T_TONE_CHAT_SCORE WITH NON-UNIQUE DEFAULT KEY,
      ERROR type STRING,
    end of T_UTTERANCE_ANALYSIS.
  types:
    "!   The results of the analysis for the utterances of the input content.
    begin of T_UTTERANCE_ANALYSES,
      UTTERANCES_TONE type STANDARD TABLE OF T_UTTERANCE_ANALYSIS WITH NON-UNIQUE DEFAULT KEY,
      WARNING type STRING,
    end of T_UTTERANCE_ANALYSES.
  types:
    "!   The error response from a failed request.
    begin of T_ERROR_MODEL,
      CODE type INTEGER,
      SUB_CODE type STRING,
      ERROR type STRING,
      HELP type STRING,
    end of T_ERROR_MODEL.
  types:
    "!   The results of the analysis for the full input content.
    begin of T_DOCUMENT_ANALYSIS,
      TONES type STANDARD TABLE OF T_TONE_SCORE WITH NON-UNIQUE DEFAULT KEY,
      TONE_CATEGORIES type STANDARD TABLE OF T_TONE_CATEGORY WITH NON-UNIQUE DEFAULT KEY,
      WARNING type STRING,
    end of T_DOCUMENT_ANALYSIS.
  types:
    "!   The tone analysis results for the input from the general-purpose endpoint.
    begin of T_TONE_ANALYSIS,
      DOCUMENT_TONE type T_DOCUMENT_ANALYSIS,
      SENTENCES_TONE type STANDARD TABLE OF T_SENTENCE_ANALYSIS WITH NON-UNIQUE DEFAULT KEY,
    end of T_TONE_ANALYSIS.

constants:
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


    "! Analyze general tone.
    "!
    "! @parameter I_tone_input |
    "!   JSON, plain text, or HTML input that contains the content to be analyzed. For
    "!    JSON input, provide an object of type `ToneInput`.
    "! @parameter I_Content_Type |
    "!   The type of the input. A character encoding can be specified by including a
    "!    `charset` parameter. For example, 'text/plain;charset=utf-8'.
    "! @parameter I_sentences |
    "!   Indicates whether the service is to return an analysis of each individual
    "!    sentence in addition to its analysis of the full document. If `true` (the
    "!    default), the service returns results for each sentence.
    "! @parameter I_tones |
    "!   **`2017-09-21`:** Deprecated. The service continues to accept the parameter for
    "!   ** backward-compatibility, but the parameter no longer affects the response.
    "!   **
    "!   ****`2016-05-19`:** A comma-separated list of tones for which the service is to
    "!   ** return its analysis of the input; the indicated tones apply both to the full
    "!   ** document and to individual sentences of the document. You can specify one or
    "!   ** more of the valid values. Omit the parameter to request results for all three
    "!   ** tones.
    "! @parameter I_Content_Language |
    "!   The language of the input text for the request: English or French. Regional
    "!    variants are treated as their parent language; for example, `en-US` is
    "!    interpreted as `en`. The input content must match the specified language. Do
    "!    not submit content that contains both languages. You can use different
    "!    languages for **Content-Language** and **Accept-Language**.
    "!   * **`2017-09-21`:** Accepts `en` or `fr`.
    "!   * **`2016-05-19`:** Accepts only `en`.
    "! @parameter I_Accept_Language |
    "!   The desired language of the response. For two-character arguments, regional
    "!    variants are treated as their parent language; for example, `en-US` is
    "!    interpreted as `en`. You can use different languages for **Content-Language**
    "!    and **Accept-Language**.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_TONE_ANALYSIS
    "!
  methods TONE
    importing
      !I_tone_input type T_TONE_INPUT
      !I_Content_Type type STRING default 'application/json'
      !I_sentences type BOOLEAN default c_boolean_true
      !I_tones type TT_STRING optional
      !I_Content_Language type STRING default 'en'
      !I_Accept_Language type STRING default 'en'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_TONE_ANALYSIS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Analyze customer-engagement tone.
    "!
    "! @parameter I_utterances |
    "!   An object that contains the content to be analyzed.
    "! @parameter I_Content_Language |
    "!   The language of the input text for the request: English or French. Regional
    "!    variants are treated as their parent language; for example, `en-US` is
    "!    interpreted as `en`. The input content must match the specified language. Do
    "!    not submit content that contains both languages. You can use different
    "!    languages for **Content-Language** and **Accept-Language**.
    "!   * **`2017-09-21`:** Accepts `en` or `fr`.
    "!   * **`2016-05-19`:** Accepts only `en`.
    "! @parameter I_Accept_Language |
    "!   The desired language of the response. For two-character arguments, regional
    "!    variants are treated as their parent language; for example, `en-US` is
    "!    interpreted as `en`. You can use different languages for **Content-Language**
    "!    and **Accept-Language**.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_UTTERANCE_ANALYSES
    "!
  methods TONE_CHAT
    importing
      !I_utterances type T_TONE_CHAT_INPUT
      !I_Content_Language type STRING default 'en'
      !I_Accept_Language type STRING default 'en'
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

    e_sdk_version_date = '20191002122853'.

  endmethod.



* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_TONE_ANALYZER_V3->TONE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_tone_input        TYPE T_TONE_INPUT
* | [--->] I_Content_Type        TYPE STRING (default ='application/json')
* | [--->] I_sentences        TYPE BOOLEAN (default =c_boolean_true)
* | [--->] I_tones        TYPE TT_STRING(optional)
* | [--->] I_Content_Language        TYPE STRING (default ='en')
* | [--->] I_Accept_Language        TYPE STRING (default ='en')
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

    if i_sentences is supplied.
    lv_queryparam = i_sentences.
    add_query_parameter(
      exporting
        i_parameter  = `sentences`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_tones is supplied.
    data:
      lv_item_tones type STRING.
    clear: lv_queryparam, lv_sep.
    loop at i_tones into lv_item_tones.
      lv_queryparam = lv_queryparam && lv_sep && lv_item_tones.
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

    if i_Content_Type is supplied.
    ls_request_prop-header_content_type = I_Content_Type.
    endif.

    if i_Content_Language is supplied.
    lv_headerparam = I_Content_Language.
    add_header_parameter(
      exporting
        i_parameter  = 'Content-Language'
        i_value      = lv_headerparam
      changing
        c_headers    = ls_request_prop-headers )  ##NO_TEXT.
    endif.

    if i_Accept_Language is supplied.
    lv_headerparam = I_Accept_Language.
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
    lv_datatype = get_datatype( i_tone_input ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_tone_input i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'tone_input' i_value = i_tone_input ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_tone_input to <lv_text>.
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
* | [--->] I_utterances        TYPE T_TONE_CHAT_INPUT
* | [--->] I_Content_Language        TYPE STRING (default ='en')
* | [--->] I_Accept_Language        TYPE STRING (default ='en')
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

    if i_Content_Language is supplied.
    lv_headerparam = I_Content_Language.
    add_header_parameter(
      exporting
        i_parameter  = 'Content-Language'
        i_value      = lv_headerparam
      changing
        c_headers    = ls_request_prop-headers )  ##NO_TEXT.
    endif.

    if i_Accept_Language is supplied.
    lv_headerparam = I_Accept_Language.
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
    lv_datatype = get_datatype( i_utterances ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_utterances i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'utterances' i_value = i_utterances ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_utterances to <lv_text>.
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
