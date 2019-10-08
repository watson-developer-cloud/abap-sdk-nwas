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
"! <h1>Natural Language Classifier</h1>
"! IBM Watson&trade; Natural Language Classifier uses machine learning algorithms
"!  to return the top matching predefined classes for short text input. You create
"!  and train a classifier to connect predefined classes to example texts so that
"!  the service can apply those classes to new inputs. <br/>
class ZCL_IBMC_NAT_LANG_CLASS_V1 DEFINITION
  public
  inheriting from ZCL_IBMC_SERVICE_EXT
  create public .

public section.
  types:
    "!   Response payload for HTTP errors.
    begin of T_ERROR_RESPONSE,
      CODE type INTEGER,
      ERROR type STRING,
      DESCRIPTION type STRING,
    end of T_ERROR_RESPONSE.
  types:
    "!   Request payload to classify.
    begin of T_CLASSIFY_INPUT,
      TEXT type STRING,
    end of T_CLASSIFY_INPUT.
  types:
    "!
    begin of T_INLINE_OBJECT,
      TRAINING_METADATA type FILE,
      TRAINING_DATA type FILE,
    end of T_INLINE_OBJECT.
  types:
    "!   Class and confidence.
    begin of T_CLASSIFIED_CLASS,
      CONFIDENCE type DOUBLE,
      CLASS_NAME type STRING,
    end of T_CLASSIFIED_CLASS.
  types:
    "!   Response from the classifier for a phrase in a collection.
    begin of T_COLLECTION_ITEM,
      TEXT type STRING,
      TOP_CLASS type STRING,
      CLASSES type STANDARD TABLE OF T_CLASSIFIED_CLASS WITH NON-UNIQUE DEFAULT KEY,
    end of T_COLLECTION_ITEM.
  types:
    "!   A classifier for natural language phrases.
    begin of T_CLASSIFIER,
      NAME type STRING,
      URL type STRING,
      STATUS type STRING,
      CLASSIFIER_ID type STRING,
      CREATED type DATETIME,
      STATUS_DESCRIPTION type STRING,
      LANGUAGE type STRING,
    end of T_CLASSIFIER.
  types:
    "!   List of available classifiers.
    begin of T_CLASSIFIER_LIST,
      CLASSIFIERS type STANDARD TABLE OF T_CLASSIFIER WITH NON-UNIQUE DEFAULT KEY,
    end of T_CLASSIFIER_LIST.
  types:
    "!   Response from the classifier for a phrase.
    begin of T_CLASSIFICATION,
      CLASSIFIER_ID type STRING,
      URL type STRING,
      TEXT type STRING,
      TOP_CLASS type STRING,
      CLASSES type STANDARD TABLE OF T_CLASSIFIED_CLASS WITH NON-UNIQUE DEFAULT KEY,
    end of T_CLASSIFICATION.
  types:
    "!   Request payload to classify.
    begin of T_CLASSIFY_COLLECTION_INPUT,
      COLLECTION type STANDARD TABLE OF T_CLASSIFY_INPUT WITH NON-UNIQUE DEFAULT KEY,
    end of T_CLASSIFY_COLLECTION_INPUT.
  types:
    "!   Response payload for Cloud errors.
    begin of T_ERROR_CLOUD,
      CODE type INTEGER,
      ERROR type STRING,
    end of T_ERROR_CLOUD.
  types:
    "!
      T_EMPTY type JSONOBJECT.
  types:
    "!   Response from the classifier for multiple phrases.
    begin of T_CLASSIFICATION_COLLECTION,
      CLASSIFIER_ID type STRING,
      URL type STRING,
      COLLECTION type STANDARD TABLE OF T_COLLECTION_ITEM WITH NON-UNIQUE DEFAULT KEY,
    end of T_CLASSIFICATION_COLLECTION.

constants:
  begin of C_REQUIRED_FIELDS,
    T_ERROR_RESPONSE type string value '|',
    T_CLASSIFY_INPUT type string value '|TEXT|',
    T_INLINE_OBJECT type string value '|TRAINING_METADATA|TRAINING_DATA|',
    T_CLASSIFIED_CLASS type string value '|',
    T_COLLECTION_ITEM type string value '|',
    T_CLASSIFIER type string value '|URL|CLASSIFIER_ID|',
    T_CLASSIFIER_LIST type string value '|CLASSIFIERS|',
    T_CLASSIFICATION type string value '|',
    T_CLASSIFY_COLLECTION_INPUT type string value '|COLLECTION|',
    T_ERROR_CLOUD type string value '|',
    T_CLASSIFICATION_COLLECTION type string value '|',
    __DUMMY type string value SPACE,
  end of C_REQUIRED_FIELDS .

constants:
  begin of C_ABAPNAME_DICTIONARY,
     CODE type string value 'code',
     ERROR type string value 'error',
     DESCRIPTION type string value 'description',
     CLASSIFIERS type string value 'classifiers',
     NAME type string value 'name',
     URL type string value 'url',
     STATUS type string value 'status',
     CLASSIFIER_ID type string value 'classifier_id',
     CREATED type string value 'created',
     STATUS_DESCRIPTION type string value 'status_description',
     LANGUAGE type string value 'language',
     COLLECTION type string value 'collection',
     TEXT type string value 'text',
     TOP_CLASS type string value 'top_class',
     CLASSES type string value 'classes',
     CONFIDENCE type string value 'confidence',
     CLASS_NAME type string value 'class_name',
     CLASSIFYINPUT type string value 'classifyInput',
     TRAINING_METADATA type string value 'training_metadata',
     TRAINING_DATA type string value 'training_data',
  end of C_ABAPNAME_DICTIONARY .


  methods GET_APPNAME
    redefinition .
  methods GET_REQUEST_PROP
    redefinition .
  methods GET_SDK_VERSION_DATE
    redefinition .


    "! Classify a phrase.
    "!
    "! @parameter I_classifier_id |
    "!   Classifier ID to use.
    "! @parameter I_body |
    "!   Phrase to classify.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_CLASSIFICATION
    "!
  methods CLASSIFY
    importing
      !I_classifier_id type STRING
      !I_body type T_CLASSIFY_INPUT
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_CLASSIFICATION
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Classify multiple phrases.
    "!
    "! @parameter I_classifier_id |
    "!   Classifier ID to use.
    "! @parameter I_body |
    "!   Phrase to classify. You can submit up to 30 text phrases in a request.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_CLASSIFICATION_COLLECTION
    "!
  methods CLASSIFY_COLLECTION
    importing
      !I_classifier_id type STRING
      !I_body type T_CLASSIFY_COLLECTION_INPUT
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_CLASSIFICATION_COLLECTION
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! Create classifier.
    "!
    "! @parameter I_training_metadata |
    "!   Metadata in JSON format. The metadata identifies the language of the data, and
    "!    an optional name to identify the classifier. Specify the language with the
    "!    2-letter primary language code as assigned in ISO standard 639.
    "!
    "!   Supported languages are English (`en`), Arabic (`ar`), French (`fr`), German,
    "!    (`de`), Italian (`it`), Japanese (`ja`), Korean (`ko`), Brazilian Portuguese
    "!    (`pt`), and Spanish (`es`).
    "! @parameter I_training_data |
    "!   Training data in CSV format. Each text value must have at least one class. The
    "!    data can include up to 3,000 classes and 20,000 records. For details, see [Data
    "!    preparation](https://cloud.ibm.com/docs/services/natural-language-classifier?to
    "!   pic=natural-language-classifier-using-your-data).
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_CLASSIFIER
    "!
  methods CREATE_CLASSIFIER
    importing
      !I_training_metadata type FILE
      !I_training_data type FILE
      !I_training_metadata_CT type STRING default ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-ALL
      !I_training_data_CT type STRING default ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-ALL
      !I_contenttype type string default 'multipart/form-data'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_CLASSIFIER
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! List classifiers.
    "!
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_CLASSIFIER_LIST
    "!
  methods LIST_CLASSIFIERS
    importing
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_CLASSIFIER_LIST
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Get information about a classifier.
    "!
    "! @parameter I_classifier_id |
    "!   Classifier ID to query.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_CLASSIFIER
    "!
  methods GET_CLASSIFIER
    importing
      !I_classifier_id type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_CLASSIFIER
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Delete classifier.
    "!
    "! @parameter I_classifier_id |
    "!   Classifier ID to delete.
    "!
  methods DELETE_CLASSIFIER
    importing
      !I_classifier_id type STRING
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .


protected section.

private section.

  methods SET_DEFAULT_QUERY_PARAMETERS
    changing
      !C_URL type TS_URL .

ENDCLASS.

class ZCL_IBMC_NAT_LANG_CLASS_V1 IMPLEMENTATION.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_NAT_LANG_CLASS_V1->GET_APPNAME
* +-------------------------------------------------------------------------------------------------+
* | [<-()] E_APPNAME                      TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method GET_APPNAME.

    e_appname = 'Natural Language Classifier'.

  endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Protected Method ZCL_IBMC_NAT_LANG_CLASS_V1->GET_REQUEST_PROP
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
  e_request_prop-url-path_base   = '/natural-language-classifier/api'.

endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_NAT_LANG_CLASS_V1->GET_SDK_VERSION_DATE
* +-------------------------------------------------------------------------------------------------+
* | [<-()] E_SDK_VERSION_DATE             TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method get_sdk_version_date.

    e_sdk_version_date = '20191002122844'.

  endmethod.



* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_NAT_LANG_CLASS_V1->CLASSIFY
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_classifier_id        TYPE STRING
* | [--->] I_body        TYPE T_CLASSIFY_INPUT
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_CLASSIFICATION
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CLASSIFY.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/classifiers/{classifier_id}/classify'.
    replace all occurrences of `{classifier_id}` in ls_request_prop-url-path with i_classifier_id ignoring case.

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
* | Instance Public Method ZCL_IBMC_NAT_LANG_CLASS_V1->CLASSIFY_COLLECTION
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_classifier_id        TYPE STRING
* | [--->] I_body        TYPE T_CLASSIFY_COLLECTION_INPUT
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_CLASSIFICATION_COLLECTION
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CLASSIFY_COLLECTION.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/classifiers/{classifier_id}/classify_collection'.
    replace all occurrences of `{classifier_id}` in ls_request_prop-url-path with i_classifier_id ignoring case.

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
* | Instance Public Method ZCL_IBMC_NAT_LANG_CLASS_V1->CREATE_CLASSIFIER
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_training_metadata        TYPE FILE
* | [--->] I_training_data        TYPE FILE
* | [--->] I_training_metadata_CT     TYPE STRING (default = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-all)
* | [--->] I_training_data_CT     TYPE STRING (default = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-all)
* | [--->] I_contenttype       TYPE string (default ='multipart/form-data')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_CLASSIFIER
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CREATE_CLASSIFIER.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/classifiers'.

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




    if not i_training_metadata is initial.
      lv_extension = get_file_extension( I_training_metadata_CT ).
      lv_value = `form-data; name="training_metadata"; filename="file` && lv_index && `.` && lv_extension && `"`  ##NO_TEXT.
      lv_index = lv_index + 1.
      clear ls_form_part.
      ls_form_part-content_type = I_training_metadata_CT.
      ls_form_part-content_disposition = lv_value.
      ls_form_part-xdata = i_training_metadata.
      append ls_form_part to lt_form_part.
    endif.

    if not i_training_data is initial.
      lv_extension = get_file_extension( I_training_data_CT ).
      lv_value = `form-data; name="training_data"; filename="file` && lv_index && `.` && lv_extension && `"`  ##NO_TEXT.
      lv_index = lv_index + 1.
      clear ls_form_part.
      ls_form_part-content_type = I_training_data_CT.
      ls_form_part-content_disposition = lv_value.
      ls_form_part-xdata = i_training_data.
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
* | Instance Public Method ZCL_IBMC_NAT_LANG_CLASS_V1->LIST_CLASSIFIERS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_CLASSIFIER_LIST
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_CLASSIFIERS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/classifiers'.

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
* | Instance Public Method ZCL_IBMC_NAT_LANG_CLASS_V1->GET_CLASSIFIER
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_classifier_id        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_CLASSIFIER
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_CLASSIFIER.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/classifiers/{classifier_id}'.
    replace all occurrences of `{classifier_id}` in ls_request_prop-url-path with i_classifier_id ignoring case.

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
* | Instance Public Method ZCL_IBMC_NAT_LANG_CLASS_V1->DELETE_CLASSIFIER
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_classifier_id        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_CLASSIFIER.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/classifiers/{classifier_id}'.
    replace all occurrences of `{classifier_id}` in ls_request_prop-url-path with i_classifier_id ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








    " execute HTTP DELETE request
    lo_response = HTTP_DELETE( i_request_prop = ls_request_prop ).



endmethod.




* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method ZCL_IBMC_NAT_LANG_CLASS_V1->SET_DEFAULT_QUERY_PARAMETERS
* +-------------------------------------------------------------------------------------------------+
* | [<-->] C_URL                          TYPE        TS_URL
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method set_default_query_parameters.
  endmethod.

ENDCLASS.
