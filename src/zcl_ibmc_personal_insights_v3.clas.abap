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
"! <h1>Personality Insights</h1>
"! The IBM Watson&trade; Personality Insights service enables applications to
"!  derive insights from social media, enterprise data, or other digital
"!  communications. The service uses linguistic analytics to infer individuals'
"!  intrinsic personality characteristics, including Big Five, Needs, and Values,
"!  from digital communications such as email, text messages, tweets, and forum
"!  posts.
"!
"! The service can automatically infer, from potentially noisy social media,
"!  portraits of individuals that reflect their personality characteristics. The
"!  service can infer consumption preferences based on the results of its analysis
"!  and, for JSON content that is timestamped, can report temporal behavior.
"! * For information about the meaning of the models that the service uses to
"!  describe personality characteristics, see [Personality
"!  models](https://cloud.ibm.com/docs/services/personality-insights?topic=personal
"! ity-insights-models#models).
"! * For information about the meaning of the consumption preferences, see
"!  [Consumption
"!  preferences](https://cloud.ibm.com/docs/services/personality-insights?topic=per
"! sonality-insights-preferences#preferences).
"!
"! **Note:** Request logging is disabled for the Personality Insights service.
"!  Regardless of whether you set the `X-Watson-Learning-Opt-Out` request header,
"!  the service does not log or retain data from requests and responses. <br/>
class ZCL_IBMC_PERSONAL_INSIGHTS_V3 DEFINITION
  public
  inheriting from ZCL_IBMC_SERVICE_EXT
  create public .

public section.
  types:
    "!   The characteristics that the service inferred from the input content.
    begin of T_TRAIT,
      TRAIT_ID type STRING,
      NAME type STRING,
      CATEGORY type STRING,
      PERCENTILE type DOUBLE,
      RAW_SCORE type DOUBLE,
      SIGNIFICANT type BOOLEAN,
      CHILDREN type STANDARD TABLE OF DATA_REFERENCE WITH NON-UNIQUE DEFAULT KEY,
    end of T_TRAIT.
  types:
    "!   The temporal behavior for the input content.
    begin of T_BEHAVIOR,
      TRAIT_ID type STRING,
      NAME type STRING,
      CATEGORY type STRING,
      PERCENTAGE type DOUBLE,
    end of T_BEHAVIOR.
  types:
    "!   A consumption preference that the service inferred from the input content.
    begin of T_CONSUMPTION_PREFERENCES,
      CONSUMPTION_PREFERENCE_ID type STRING,
      NAME type STRING,
      SCORE type DOUBLE,
    end of T_CONSUMPTION_PREFERENCES.
  types:
    "!   A warning message that is associated with the input content.
    begin of T_WARNING,
      WARNING_ID type STRING,
      MESSAGE type STRING,
    end of T_WARNING.
  types:
    "!   The consumption preferences that the service inferred from the input content.
    begin of T_CNSMPTN_PREFERENCES_CATEGORY,
      CNSMPTN_PREFERENCE_CATEGORY_ID type STRING,
      NAME type STRING,
      CONSUMPTION_PREFERENCES type STANDARD TABLE OF T_CONSUMPTION_PREFERENCES WITH NON-UNIQUE DEFAULT KEY,
    end of T_CNSMPTN_PREFERENCES_CATEGORY.
  types:
    "!   The personality profile that the service generated for the input content.
    begin of T_PROFILE,
      PROCESSED_LANGUAGE type STRING,
      WORD_COUNT type INTEGER,
      WORD_COUNT_MESSAGE type STRING,
      PERSONALITY type STANDARD TABLE OF T_TRAIT WITH NON-UNIQUE DEFAULT KEY,
      NEEDS type STANDARD TABLE OF T_TRAIT WITH NON-UNIQUE DEFAULT KEY,
      VALUES type STANDARD TABLE OF T_TRAIT WITH NON-UNIQUE DEFAULT KEY,
      BEHAVIOR type STANDARD TABLE OF T_BEHAVIOR WITH NON-UNIQUE DEFAULT KEY,
      CONSUMPTION_PREFERENCES type STANDARD TABLE OF T_CNSMPTN_PREFERENCES_CATEGORY WITH NON-UNIQUE DEFAULT KEY,
      WARNINGS type STANDARD TABLE OF T_WARNING WITH NON-UNIQUE DEFAULT KEY,
    end of T_PROFILE.
  types:
    "!   An input content item that the service is to analyze.
    begin of T_CONTENT_ITEM,
      CONTENT type STRING,
      ID type STRING,
      CREATED type LONG,
      UPDATED type LONG,
      CONTENTTYPE type STRING,
      LANGUAGE type STRING,
      PARENTID type STRING,
      REPLY type BOOLEAN,
      FORWARD type BOOLEAN,
    end of T_CONTENT_ITEM.
  types:
    "!   A CSV file that contains the results of the personality profile that the service
    "!    generated for the input content.
      T_CSV_FILE type String.
  types:
    "!   The error response from a failed request.
    begin of T_ERROR_MODEL,
      CODE type INTEGER,
      SUB_CODE type STRING,
      ERROR type STRING,
      HELP type STRING,
    end of T_ERROR_MODEL.
  types:
    "!   The full input content that the service is to analyze.
    begin of T_CONTENT,
      CONTENTITEMS type STANDARD TABLE OF T_CONTENT_ITEM WITH NON-UNIQUE DEFAULT KEY,
    end of T_CONTENT.

constants:
  begin of C_REQUIRED_FIELDS,
    T_TRAIT type string value '|TRAIT_ID|NAME|CATEGORY|PERCENTILE|',
    T_BEHAVIOR type string value '|TRAIT_ID|NAME|CATEGORY|PERCENTAGE|',
    T_CONSUMPTION_PREFERENCES type string value '|CONSUMPTION_PREFERENCE_ID|NAME|SCORE|',
    T_WARNING type string value '|WARNING_ID|MESSAGE|',
    T_CNSMPTN_PREFERENCES_CATEGORY type string value '|CNSMPTN_PREFERENCE_CATEGORY_ID|NAME|CONSUMPTION_PREFERENCES|',
    T_PROFILE type string value '|PROCESSED_LANGUAGE|WORD_COUNT|PERSONALITY|NEEDS|VALUES|WARNINGS|',
    T_CONTENT_ITEM type string value '|CONTENT|',
    T_ERROR_MODEL type string value '|CODE|ERROR|',
    T_CONTENT type string value '|CONTENTITEMS|',
    __DUMMY type string value SPACE,
  end of C_REQUIRED_FIELDS .

constants:
  begin of C_ABAPNAME_DICTIONARY,
     PROCESSED_LANGUAGE type string value 'processed_language',
     WORD_COUNT type string value 'word_count',
     WORD_COUNT_MESSAGE type string value 'word_count_message',
     PERSONALITY type string value 'personality',
     NEEDS type string value 'needs',
     VALUES type string value 'values',
     BEHAVIOR type string value 'behavior',
     CONSUMPTION_PREFERENCES type string value 'consumption_preferences',
     CONSUMPTIONPREFERENCES type string value 'consumptionPreferences',
     WARNINGS type string value 'warnings',
     TRAIT_ID type string value 'trait_id',
     NAME type string value 'name',
     CATEGORY type string value 'category',
     PERCENTILE type string value 'percentile',
     RAW_SCORE type string value 'raw_score',
     SIGNIFICANT type string value 'significant',
     CHILDREN type string value 'children',
     PERCENTAGE type string value 'percentage',
     CNSMPTN_PREFERENCE_CATEGORY_ID type string value 'consumption_preference_category_id',
     CONSUMPTION_PREFERENCE_ID type string value 'consumption_preference_id',
     SCORE type string value 'score',
     WARNING_ID type string value 'warning_id',
     MESSAGE type string value 'message',
     CONTENTITEMS type string value 'contentItems',
     CONTENTITEM type string value 'contentItem',
     CONTENT type string value 'content',
     ID type string value 'id',
     CREATED type string value 'created',
     UPDATED type string value 'updated',
     CONTENTTYPE type string value 'contenttype',
     LANGUAGE type string value 'language',
     PARENTID type string value 'parentid',
     REPLY type string value 'reply',
     FORWARD type string value 'forward',
     CODE type string value 'code',
     SUB_CODE type string value 'sub_code',
     ERROR type string value 'error',
     HELP type string value 'help',
  end of C_ABAPNAME_DICTIONARY .


  methods GET_APPNAME
    redefinition .
  methods GET_REQUEST_PROP
    redefinition .
  methods GET_SDK_VERSION_DATE
    redefinition .


    "! Get profile.
    "!
    "! @parameter I_content |
    "!   A maximum of 20 MB of content to analyze, though the service requires much less
    "!    text; for more information, see [Providing sufficient
    "!    input](https://cloud.ibm.com/docs/services/personality-insights?topic=personali
    "!   ty-insights-input#sufficient). For JSON input, provide an object of type
    "!    `Content`.
    "! @parameter I_Content_Type |
    "!   The type of the input. For more information, see **Content types** in the method
    "!    description.
    "! @parameter I_Content_Language |
    "!   The language of the input text for the request: Arabic, English, Japanese,
    "!    Korean, or Spanish. Regional variants are treated as their parent language; for
    "!    example, `en-US` is interpreted as `en`.
    "!
    "!   The effect of the **Content-Language** parameter depends on the **Content-Type**
    "!    parameter. When **Content-Type** is `text/plain` or `text/html`,
    "!    **Content-Language** is the only way to specify the language. When
    "!    **Content-Type** is `application/json`, **Content-Language** overrides a
    "!    language specified with the `language` parameter of a `ContentItem` object, and
    "!    content items that specify a different language are ignored; omit this
    "!    parameter to base the language on the specification of the content items. You
    "!    can specify any combination of languages for **Content-Language** and
    "!    **Accept-Language**.
    "! @parameter I_Accept_Language |
    "!   The desired language of the response. For two-character arguments, regional
    "!    variants are treated as their parent language; for example, `en-US` is
    "!    interpreted as `en`. You can specify any combination of languages for the input
    "!    and response content.
    "! @parameter I_raw_scores |
    "!   Indicates whether a raw score in addition to a normalized percentile is returned
    "!    for each characteristic; raw scores are not compared with a sample population.
    "!    By default, only normalized percentiles are returned.
    "! @parameter I_csv_headers |
    "!   Indicates whether column labels are returned with a CSV response. By default, no
    "!    column labels are returned. Applies only when the response type is CSV
    "!    (`text/csv`).
    "! @parameter I_consumption_preferences |
    "!   Indicates whether consumption preferences are returned with the results. By
    "!    default, no consumption preferences are returned.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_PROFILE
    "!
  methods PROFILE
    importing
      !I_content type T_CONTENT
      !I_Content_Type type STRING default 'text/plain'
      !I_Content_Language type STRING default 'en'
      !I_Accept_Language type STRING default 'en'
      !I_raw_scores type BOOLEAN default c_boolean_false
      !I_csv_headers type BOOLEAN default c_boolean_false
      !I_consumption_preferences type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_PROFILE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Get profile as csv.
    "!
    "! @parameter I_content |
    "!   A maximum of 20 MB of content to analyze, though the service requires much less
    "!    text; for more information, see [Providing sufficient
    "!    input](https://cloud.ibm.com/docs/services/personality-insights?topic=personali
    "!   ty-insights-input#sufficient). For JSON input, provide an object of type
    "!    `Content`.
    "! @parameter I_Content_Type |
    "!   The type of the input. For more information, see **Content types** in the method
    "!    description.
    "! @parameter I_Content_Language |
    "!   The language of the input text for the request: Arabic, English, Japanese,
    "!    Korean, or Spanish. Regional variants are treated as their parent language; for
    "!    example, `en-US` is interpreted as `en`.
    "!
    "!   The effect of the **Content-Language** parameter depends on the **Content-Type**
    "!    parameter. When **Content-Type** is `text/plain` or `text/html`,
    "!    **Content-Language** is the only way to specify the language. When
    "!    **Content-Type** is `application/json`, **Content-Language** overrides a
    "!    language specified with the `language` parameter of a `ContentItem` object, and
    "!    content items that specify a different language are ignored; omit this
    "!    parameter to base the language on the specification of the content items. You
    "!    can specify any combination of languages for **Content-Language** and
    "!    **Accept-Language**.
    "! @parameter I_Accept_Language |
    "!   The desired language of the response. For two-character arguments, regional
    "!    variants are treated as their parent language; for example, `en-US` is
    "!    interpreted as `en`. You can specify any combination of languages for the input
    "!    and response content.
    "! @parameter I_raw_scores |
    "!   Indicates whether a raw score in addition to a normalized percentile is returned
    "!    for each characteristic; raw scores are not compared with a sample population.
    "!    By default, only normalized percentiles are returned.
    "! @parameter I_csv_headers |
    "!   Indicates whether column labels are returned with a CSV response. By default, no
    "!    column labels are returned. Applies only when the response type is CSV
    "!    (`text/csv`).
    "! @parameter I_consumption_preferences |
    "!   Indicates whether consumption preferences are returned with the results. By
    "!    default, no consumption preferences are returned.
    "!
  methods PROFILE_AS_CSV
    importing
      !I_content type T_CONTENT
      !I_Content_Type type STRING default 'text/plain'
      !I_Content_Language type STRING default 'en'
      !I_Accept_Language type STRING default 'en'
      !I_raw_scores type BOOLEAN default c_boolean_false
      !I_csv_headers type BOOLEAN default c_boolean_false
      !I_consumption_preferences type BOOLEAN default c_boolean_false
      !I_accept      type string default 'text/csv'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .


protected section.

private section.

  methods SET_DEFAULT_QUERY_PARAMETERS
    changing
      !C_URL type TS_URL .

ENDCLASS.

class ZCL_IBMC_PERSONAL_INSIGHTS_V3 IMPLEMENTATION.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_PERSONAL_INSIGHTS_V3->GET_APPNAME
* +-------------------------------------------------------------------------------------------------+
* | [<-()] E_APPNAME                      TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method GET_APPNAME.

    e_appname = 'Personality Insights'.

  endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Protected Method ZCL_IBMC_PERSONAL_INSIGHTS_V3->GET_REQUEST_PROP
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
  e_request_prop-url-path_base   = '/personality-insights/api'.

endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_PERSONAL_INSIGHTS_V3->GET_SDK_VERSION_DATE
* +-------------------------------------------------------------------------------------------------+
* | [<-()] E_SDK_VERSION_DATE             TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method get_sdk_version_date.

    e_sdk_version_date = '20191002122847'.

  endmethod.



* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_PERSONAL_INSIGHTS_V3->PROFILE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_content        TYPE T_CONTENT
* | [--->] I_Content_Type        TYPE STRING (default ='text/plain')
* | [--->] I_Content_Language        TYPE STRING (default ='en')
* | [--->] I_Accept_Language        TYPE STRING (default ='en')
* | [--->] I_raw_scores        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_csv_headers        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_consumption_preferences        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_PROFILE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method PROFILE.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v3/profile'.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_raw_scores is supplied.
    lv_queryparam = i_raw_scores.
    add_query_parameter(
      exporting
        i_parameter  = `raw_scores`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_csv_headers is supplied.
    lv_queryparam = i_csv_headers.
    add_query_parameter(
      exporting
        i_parameter  = `csv_headers`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_consumption_preferences is supplied.
    lv_queryparam = i_consumption_preferences.
    add_query_parameter(
      exporting
        i_parameter  = `consumption_preferences`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
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
    lv_datatype = get_datatype( i_content ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_content i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'content' i_value = i_content ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_content to <lv_text>.
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
* | Instance Public Method ZCL_IBMC_PERSONAL_INSIGHTS_V3->PROFILE_AS_CSV
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_content        TYPE T_CONTENT
* | [--->] I_Content_Type        TYPE STRING (default ='text/plain')
* | [--->] I_Content_Language        TYPE STRING (default ='en')
* | [--->] I_Accept_Language        TYPE STRING (default ='en')
* | [--->] I_raw_scores        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_csv_headers        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_consumption_preferences        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_accept            TYPE string (default ='text/csv')
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method PROFILE_AS_CSV.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v3/profile'.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_raw_scores is supplied.
    lv_queryparam = i_raw_scores.
    add_query_parameter(
      exporting
        i_parameter  = `raw_scores`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_csv_headers is supplied.
    lv_queryparam = i_csv_headers.
    add_query_parameter(
      exporting
        i_parameter  = `csv_headers`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_consumption_preferences is supplied.
    lv_queryparam = i_consumption_preferences.
    add_query_parameter(
      exporting
        i_parameter  = `consumption_preferences`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
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
    lv_datatype = get_datatype( i_content ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_content i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'content' i_value = i_content ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_content to <lv_text>.
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



endmethod.




* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method ZCL_IBMC_PERSONAL_INSIGHTS_V3->SET_DEFAULT_QUERY_PARAMETERS
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
