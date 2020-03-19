* Copyright 2019,2020 IBM Corp. All Rights Reserved.
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
class ZCL_IBMC_SERVICE definition
  public
  inheriting from ZCL_IBMC_SERVICE_ARCH
  create public .

public section.

  types DATA_REFERENCE type ref to DATA .
  types:
    FIELDNAME(30) type c .
  types BOOLEAN type ZIF_IBMC_SERVICE_ARCH~BOOLEAN .
  types CHAR type ZIF_IBMC_SERVICE_ARCH~CHAR .
  types DATE type STRING .
  types TIME type STRING .
  types INTEGER type I .
  types SHORT type INT2 .
  types LONG type INT8 .
  types FLOAT type F .
  types DOUBLE type F .
  types NUMBER type F .
  types FILE type XSTRING .
  types BINARY type XSTRING .
  types JSONOBJECT type ref to DATA .
  types MAP type ref to DATA .
  types:
    "! <p class="shorttext synchronized" lang="en">DateTime type, format 2018-10-23T15:18:18.914xxxZ</p>
    DATETIME(27) type c .
  types TT_STRING type ZIF_IBMC_SERVICE_ARCH~TT_STRING .
  types:
    TT_BOOLEAN type standard table of ZIF_IBMC_SERVICE_ARCH~BOOLEAN with non-unique default key .
  types:
    TT_CHAR type standard table of ZIF_IBMC_SERVICE_ARCH~CHAR with non-unique default key .
  types:
    TT_INTEGER type standard table of INTEGER with non-unique default key .
  types:
    TT_SHORT type standard table of SHORT with non-unique default key .
  types:
    TT_LONG type standard table of LONG with non-unique default key .
  types:
    TT_FLOAT type standard table of FLOAT with non-unique default key .
  types:
    TT_DOUBLE type standard table of DOUBLE with non-unique default key .
  types:
    TT_NUMBER type standard table of NUMBER with non-unique default key .
  types:
    TT_FILE type standard table of FILE with non-unique default key .
  types:
    begin of TS_MAP_FILE,
        KEY  type STRING,
        DATA type FILE,
      end of TS_MAP_FILE .
  types:
    TT_MAP_FILE type standard table of TS_MAP_FILE with non-unique default key .
  types:
    begin of TS_FILE_WITH_METADATA,
      FILENAME     type string,
      CONTENT_TYPE type string,
      DATA         type xstring,
    end of TS_FILE_WITH_METADATA .
  types:
    TT_FILE_WITH_METADATA type standard table of TS_FILE_WITH_METADATA with non-unique default key .
  types TS_FORM_PART type ZIF_IBMC_SERVICE_ARCH~TS_FORM_PART .
  types TT_FORM_PART type ZIF_IBMC_SERVICE_ARCH~TT_FORM_PART .

  constants C_BOOLEAN_FALSE type BOOLEAN value SPACE ##NO_TEXT.
  constants C_BOOLEAN_TRUE type BOOLEAN value 'X' ##NO_TEXT.
  constants C_TRIBOOL_FALSE type BOOLEAN value '-' ##NO_TEXT.
  constants C_DEFAULT type STRING value 'DEFAULT' ##NO_TEXT.
  constants C_SUBRC_UNKNOWN type SY-SUBRC value 999999 ##NO_TEXT.
  constants C_MSGID type SY-MSGID value 'ZIBMC' ##NO_TEXT.
  constants C_I_ZERO type I value -2147481648 ##NO_TEXT.
  constants C_I8_ZERO type INT8 value -9223372036854775608 ##NO_TEXT.
  constants C_F_ZERO type F value '-2147481.648' ##NO_TEXT.
  constants C_BLANK type STRING value '&#§§#&__%$X' ##NO_TEXT.
  constants:
    begin of C_DATATYPE,
      string type char value 'g',
      struct type char value 'v',
    end of C_DATATYPE .
  data P_REQUEST_PROP_DEFAULT type TS_REQUEST_PROP .
  data P_DEBUG_MODE type CHAR value SPACE ##NO_TEXT.
  data P_VERSION type STRING .

  "! <p class="shorttext synchronized" lang="en">Raises an exception.</p>
  "!
  "! @parameter I_MSGNO | Message number.
  "! @parameter I_MSGV1 | Substitution for 1st placeholder in message.
  "! @parameter I_MSGV2 | Substitution for 2nd placeholder in message.
  "! @parameter I_MSGV3 | Substitution for 3rd placeholder in message.
  "! @parameter I_MSGV4 | Substitution for 4th placeholder in message.
  "! @parameter I_TEXT  | Message text; specify if message number is not specified.
  "! @parameter I_SUBRC | Return code being returned.
  "! @parameter I_PREVIOUS | Exception that has been captured before.
  "! @parameter I_HTTP_STATUS | HTTP status code if exception is triggered by HTTP error
  "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised.
  "!
  class-methods RAISE_EXCEPTION
    importing
      !I_MSGNO type SY-MSGNO optional
      !I_MSGV1 type STRING optional
      !I_MSGV2 type STRING optional
      !I_MSGV3 type STRING optional
      !I_MSGV4 type STRING optional
      !I_TEXT type STRING optional
      !I_SUBRC type SY-SUBRC default C_SUBRC_UNKNOWN
      !I_PREVIOUS type ref to CX_ROOT optional
      !I_HTTP_STATUS type TS_HTTP_STATUS optional
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
  "! <p class="shorttext synchronized" lang="en">Returns field type and length of a given parameter.</p>
  "!
  "! @parameter I_FIELD | Field of type that is supposed to be determined.
  "! @parameter E_TECHNICAL_TYPE | Technical type (= base type) of I_FIELD.
  "! @parameter E_RELATIVE_TYPE | Relative type (= data type) of I_FIELD.
  "! @parameter E_LENGTH | Length of type of I_FIELD.
  "!
  class-methods GET_FIELD_TYPE
    importing
      !I_FIELD type ANY
    exporting
      !E_TECHNICAL_TYPE type ZIF_IBMC_SERVICE_ARCH~CHAR
      !E_RELATIVE_TYPE type STRING
      !E_LENGTH type I .
  "! <p class="shorttext synchronized" lang="en">Returns component names of a given structure.</p>
  "!
  "! @parameter I_STRUCTURE | Structure with components.
  "! @parameter E_COMPONENTS | Internal table of component names.
  "!
  class-methods GET_COMPONENTS
    importing
      !I_STRUCTURE type ANY
    exporting
      value(E_COMPONENTS) type ZIF_IBMC_SERVICE_ARCH~TT_STRING .
  "! <p class="shorttext synchronized" lang="en">Parses a JSON string into an ABAP structure.</p>
  "!
  "! @parameter I_JSON | JSON string.
  "! @parameter I_DICTIONARY | Dictionary for mapping of identifier names.
  "! @parameter C_ABAP | ABAP structure to be filled
  "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
  "!
  class-methods PARSE_JSON
    importing
      !I_JSON type STRING
      !I_DICTIONARY type ANY optional
    changing
      value(C_ABAP) type ANY
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
  "! <p class="shorttext synchronized" lang="en">Method for internal use.</p>
  "!
  methods GET_REQUEST_PROP
    importing
      !I_AUTH_METHOD type STRING default C_DEFAULT
    returning
      value(E_REQUEST_PROP) type TS_REQUEST_PROP .
  "! <p class="shorttext synchronized" lang="en">Returns data type of a given parameter.</p>
  "!
  "! @parameter I_FIELD | Field of type that is supposed to be determined.
  "! @parameter E_DATATYPE | Technical type (= base type) of I_FIELD.
  "!
  class-methods GET_DATATYPE
    importing
      !I_FIELD type ANY
    returning
      value(E_DATATYPE) type ZIF_IBMC_SERVICE_ARCH~CHAR .
  "! <p class="shorttext synchronized" lang="en">Unescape unicode codepoints to characters in a string</p>,
  "!  e.g. '\u0041 b \u0063' -&gt; 'A b c'
  "!
  "! @parameter I_IN | String with unicode codepoints.
  "! @parameter E_OUT | Unescaped string.
  "!
  class-methods UNESCAPE_UNICODE
    importing
      !I_IN type STRING
    returning
      value(E_OUT) type STRING .
  "! <p class="shorttext synchronized" lang="en">Returns the file extension for a mime type</p>,
  "!  e.g. 'text/plain' -&gt; 'txt'
  "!
  "! @parameter I_MIME_TYPE | MIME type.
  "! @parameter E_EXTENSION | File extension (without leading dot).
  "!
  class-methods GET_FILE_EXTENSION
    importing
      value(I_MIME_TYPE) type STRING
    returning
      value(E_EXTENSION) type STRING .
  "! <p class="shorttext synchronized" lang="en">Moves a referenced data structure to an ABAP structure.</p>
  "!
  "! @parameter I_DATA_REFERENCE | Reference to data object.
  "! @parameter E_ABAP | ABAP structure to be filled.
  "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
  "!
  class-methods MOVE_DATA_REFERENCE_TO_ABAP
    importing
      !I_DATA_REFERENCE type DATA_REFERENCE
    exporting
      value(E_ABAP) type ANY
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
  "! <p class="shorttext synchronized" lang="en">Method for internal use.</p>
  "!
  class-methods ADD_QUERY_PARAMETER
    importing
      !I_PARAMETER type STRING
      !I_VALUE type STRING
      !I_IS_BOOLEAN type BOOLEAN default C_BOOLEAN_FALSE
    changing
      !C_URL type TS_URL .
  "! <p class="shorttext synchronized" lang="en">Method for internal use.</p>
  "!
  class-methods ADD_HEADER_PARAMETER
    importing
      !I_PARAMETER type STRING
      !I_VALUE type STRING
      !I_IS_BOOLEAN type BOOLEAN default C_BOOLEAN_FALSE
    changing
      !C_HEADERS type ZIF_IBMC_SERVICE_ARCH~TS_REQUEST_PROP-HEADERS .
  "! <p class="shorttext synchronized" lang="en">Method for internal use.</p>
  "!
  class-methods GET_FULL_URL
    importing
      !I_URL type TS_URL
    returning
      value(E_URL) type STRING .
  "! <p class="shorttext synchronized" lang="en">Returns the service name.</p>
  "!
  "! @parameter E_APPNAME | Name of the service.
  "!
  methods GET_APPNAME
    returning
      value(E_APPNAME) type STRING .
  "! <p class="shorttext synchronized" lang="en">Method for internal use.</p>
  "!
  class-methods NORMALIZE_URL
    changing
      !C_URL type TS_URL .
  "! <p class="shorttext synchronized" lang="en">Extracts a JSON string from an ABAP structure.</p>
  "!
  "! @parameter I_NAME | Name of component to be extracted.
  "! @parameter I_VALUE | ABAP structure to be converted to JSON string.
  "! @parameter I_DICTIONARY | Dictionary to be used for mapping ABAP identifiers to JSON keys.
  "! @parameter I_REQUIRED_FIELDS |
  "!   Dictionary of required fields.<br/>
  "!   If a field is required, an initial value appears as initial value in JSON structure.
  "!   Otherwise it is omitted in JSON string.
  "! @parameter I_LOWER_CASE | If set to C_BOOLEAN_TRUE all keys in JSON string will be lower case.
  "! @parameter E_JSON | JSON string.
  "!
  class-methods ABAP_TO_JSON
    importing
      !I_NAME type STRING optional
      !I_VALUE type ANY
      !I_DICTIONARY type ANY optional
      !I_REQUIRED_FIELDS type ANY optional
      !I_LOWER_CASE type BOOLEAN default C_BOOLEAN_TRUE
    returning
      value(E_JSON) type STRING .
  "! <p class="shorttext synchronized" lang="en">Throws an exception, if HTTP response indicates an error.</p>
  "!
  "! @parameter I_RESPONSE | HTTP response to be checked.
  "! @parameter I_URL | URL that the request has been sent to.
  "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
  "!
  methods CHECK_HTTP_RESPONSE
    importing
      !I_RESPONSE type TO_REST_RESPONSE optional
      !I_URL type TS_URL optional
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
  "! <p class="shorttext synchronized" lang="en">Class constructor.</p>
  "!
  "! @parameter I_URL | URL of the service.
  "! @parameter I_HOST | Host of the service. I_URL and I_HOST can be used synonymously.
  "! @parameter I_PROXY_HOST | Proxy server, not applicable on SAP Cloud Platform.
  "! @parameter I_PROXY_PORT | Proxy server port, not applicable on SAP Cloud Platform.
  "! @parameter I_USERNAME | User name to authenticate on service.
  "! @parameter I_PASSWORD | User password to authenticate on service.
  "! @parameter I_APIKEY | API key password to authenticate on service.
  "! @parameter I_ACCESS_TOKEN | Access token to authenticate on service.
  "! @parameter I_SSL_ID | ID of PSE, not applicable on SAP Cloud Platform.
  "! @parameter I_DEBUG_MODE | not used.
  "!
  methods CONSTRUCTOR
    importing
      !I_URL type STRING optional
      !I_HOST type STRING optional
      !I_PROXY_HOST type STRING optional
      !I_PROXY_PORT type STRING optional
      !I_USERNAME type STRING optional
      !I_PASSWORD type STRING optional
      !I_APIKEY type STRING optional
      !I_ACCESS_TOKEN type TS_ACCESS_TOKEN optional
      !I_SSL_ID type ZIF_IBMC_SERVICE_ARCH~TY_SSL_ID optional
      !I_DEBUG_MODE type CHAR default SPACE .
  "! <p class="shorttext synchronized" lang="en">Method for internal use.</p>
  "!
  methods GET_REST_CLIENT
    importing
      !I_REQUEST_PROP type TS_REQUEST_PROP
    returning
      value(E_CLIENT) type TS_CLIENT
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
  "! <p class="shorttext synchronized" lang="en">Method for internal use.</p>
  "!
  methods GET_ACCESS_TOKEN
    importing
      !I_REQUEST_PROP type TS_REQUEST_PROP optional
    returning
      value(E_ACCESS_TOKEN) type TS_ACCESS_TOKEN
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
  "! <p class="shorttext synchronized" lang="en">Sends a HTTP DELETE request.</p>
  "!
  "! @parameter I_REQUEST_PROP | Request properties.
  "! @parameter E_RESPONSE | Response returned by service.
  "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
  "!
  methods HTTP_DELETE
    importing
      !I_REQUEST_PROP type TS_REQUEST_PROP
    returning
      value(E_RESPONSE) type TO_REST_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
  "! <p class="shorttext synchronized" lang="en">Sets an access token explicitly.</p>
  "!
  "! @parameter I_ACCESS_TOKEN | Access token.
  "!
  methods SET_ACCESS_TOKEN
    importing
      !I_ACCESS_TOKEN type TS_ACCESS_TOKEN .
  "! <p class="shorttext synchronized" lang="en">Sends a HTTP GET request.</p>
  "!
  "! @parameter I_REQUEST_PROP | Request properties.
  "! @parameter E_RESPONSE | Response returned by service.
  "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
  "!
  methods HTTP_GET
    importing
      !I_REQUEST_PROP type TS_REQUEST_PROP
    returning
      value(E_RESPONSE) type TO_REST_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
  "! <p class="shorttext synchronized" lang="en">Sends a HTTP POST request.</p>
  "!
  "! @parameter I_REQUEST_PROP | Request properties.
  "! @parameter E_RESPONSE | Response returned by service.
  "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
  "!
  methods HTTP_POST
    importing
      !I_REQUEST_PROP type TS_REQUEST_PROP
    returning
      value(E_RESPONSE) type TO_REST_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
  "! <p class="shorttext synchronized" lang="en">Sends a HTTP POST request with multipart body.</p>
  "!
  "! @parameter I_REQUEST_PROP | Request properties.
  "! @parameter IT_FORM_PART | Internal table of form parts in request body.
  "! @parameter E_RESPONSE | Response returned by service.
  "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
  "!
  methods HTTP_POST_MULTIPART
    importing
      !I_REQUEST_PROP type TS_REQUEST_PROP
      !IT_FORM_PART type TT_FORM_PART
    returning
      value(E_RESPONSE) type TO_REST_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
  "! <p class="shorttext synchronized" lang="en">Sends a HTTP PUT request.</p>
  "!
  "! @parameter I_REQUEST_PROP | Request properties.
  "! @parameter E_RESPONSE | Response returned by service.
  "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
  "!
  methods HTTP_PUT
    importing
      !I_REQUEST_PROP type TS_REQUEST_PROP
    returning
      value(E_RESPONSE) type TO_REST_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
protected section.

  "! <p class="shorttext synchronized" lang="en">Method for internal use.</p>
  methods ADJUST_REQUEST_PROP
    changing
      !C_REQUEST_PROP type TS_REQUEST_PROP .
  "! <p class="shorttext synchronized" lang="en">Method for internal use.</p>
  class-methods MERGE_STRUCTURE
    importing
      !I_ALTERNATIVE type ANY
    changing
      !C_BASE type ANY .
  "! <p class="shorttext synchronized" lang="en">Method for internal use.</p>
  methods SET_URI_AND_AUTHORIZATION
    importing
      !I_CLIENT type TS_CLIENT
      !I_REQUEST_PROP type TS_REQUEST_PROP
    returning
      value(E_URI) type STRING
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
private section.
ENDCLASS.



CLASS ZCL_IBMC_SERVICE IMPLEMENTATION.


  method abap_to_json.

    data:
      lv_json          type string,
      lv_json_comp     type string,
      lv_json_num(24)  type c,
      lv_sep(1)        type c,
      lv_name          type string,
      lv_name_uc       type string,
      lv_type          type char,
      lt_compname      type tt_string,
      lv_name_in_dict  type boolean,
      lv_relative_type type string,
      lv_pattern       type string,
      lv_str           type string.
    field-symbols:
      <i_value>     type any,
      <ls_compname> type string,
      <l_value>     type any,
      <l_i_value>   type i,
      <l_i8_value>  type int8,
      <l_f_value>   type f,
      <lt_value>    type any table,
      <lv_name>     type string,
      <lv_required> type string.


    get_field_type(
      exporting
        i_field = i_value
      importing
        e_technical_type = lv_type
        e_relative_type  = lv_relative_type ).
    if lv_type eq zif_ibmc_service_arch~c_datatype-dataref or lv_type eq zif_ibmc_service_arch~c_datatype-objectref.
      if i_value is initial.
        return.
      endif.
      assign i_value->* to <i_value>.
      get_field_type(
      exporting
        i_field = <i_value>
      importing
        e_technical_type = lv_type
        e_relative_type  = lv_relative_type ).
    else.
      assign i_value to <i_value>.
    endif.


    if lv_type ne zif_ibmc_service_arch~c_datatype-struct and lv_type ne zif_ibmc_service_arch~c_datatype-struct_deep and lv_type ne zif_ibmc_service_arch~c_datatype-itab.
      " simple type

      if lv_type eq 'C' or lv_type eq 'N' or lv_type eq 'g'.
        lv_str = <i_value>.
        if lv_str eq c_blank.
          " parameter is blank, not initial (i.e. null)
          lv_str = ''.
        else.
          replace all occurrences of '"' in lv_str with '\"'.
          replace all occurrences of cl_abap_char_utilities=>cr_lf in lv_str with '\n'.
          replace all occurrences of cl_abap_char_utilities=>newline in lv_str with '\n'.
        endif.

        " quote value unless it is a boolean
        if lv_relative_type eq 'BOOLEAN'.
          if lv_str eq c_boolean_true.
            lv_json = `true`.
          elseif lv_str eq c_boolean_false.
            lv_json = `false`.
          else.
            lv_json = lv_str.
          endif.
        else.
          lv_json = `"` && lv_str && `"`.
        endif.
      else.
        do 1 times.  " to allow exit command

          " special handling for optional parameters explicitly set to initial
          if lv_type eq 'I'.
            assign <i_value> to <l_i_value>.
            if <l_i_value> = c_i_zero.
              lv_json_num = '0'.
              exit.
            endif.
          elseif lv_type eq '8'.
            assign <i_value> to <l_i8_value>.
            if <l_i8_value> = c_i8_zero.
              lv_json_num = '0'.
              exit.
            endif.
          elseif lv_type eq 'F'.
            assign <i_value> to <l_f_value>.
            if <l_f_value> = c_f_zero.
              lv_json_num = '0'.
              exit.
            endif.
          endif.

          lv_json_num = conv #( <i_value> ).
          condense lv_json_num no-gaps.
        enddo.
        lv_json = lv_json_num.
      endif.

    elseif lv_type eq zif_ibmc_service_arch~c_datatype-struct or lv_type eq zif_ibmc_service_arch~c_datatype-struct_deep.
      " structure

      get_components(
        exporting
          i_structure = <i_value>
        importing
          e_components = lt_compname ).
      clear lv_sep.
      lv_json = lv_json && `{`.
      loop at lt_compname assigning <ls_compname>.
        assign component <ls_compname> of structure <i_value> to <l_value>.
        if sy-subrc <> 0.
          continue.
        endif.

        " do not add property if not required and corresponding abap field is initial
        if <l_value> is initial and not i_required_fields is initial.
          assign component lv_relative_type of structure i_required_fields to <lv_required>.
          if sy-subrc <> 0.
            continue.
          endif.
          lv_pattern = `*|` && <ls_compname> && `|*`.
          if not <lv_required> cp lv_pattern.
            continue.
          endif.
        endif.

        lv_name = <ls_compname>.

        " check if key name exists in abap names dictionary
        lv_name_in_dict = c_boolean_false.
        try.
            assign component lv_name of structure i_dictionary to <lv_name>.
            if sy-subrc = 0.
              lv_name = <lv_name>.
              lv_name_in_dict = c_boolean_true.
            endif.
          catch cx_sy_assign_cast_illegal_cast cx_sy_assign_cast_unknown_type cx_sy_assign_out_of_range.
        endtry.

        if lv_name_in_dict eq c_boolean_false and i_lower_case eq c_boolean_true.
          " convert name to lower case
          translate lv_name to lower case.
        endif.
        " add property (recursively)
        lv_json_comp = abap_to_json( i_name = lv_name i_value = <l_value> i_lower_case = i_lower_case i_dictionary = i_dictionary i_required_fields = i_required_fields ).
        lv_json = lv_json && lv_sep && lv_json_comp.
        lv_sep = ','.
      endloop.
      lv_json = lv_json && `}`.

    elseif lv_type eq zif_ibmc_service_arch~c_datatype-itab.
      " internal table

      lv_json = lv_json && `[`.
      clear lv_sep.
      assign <i_value> to <lt_value>.
      loop at <lt_value> assigning <l_value>.
        lv_json_comp = abap_to_json( i_value = <l_value> i_lower_case = i_lower_case i_dictionary = i_dictionary i_required_fields = i_required_fields ).
        lv_json = lv_json && lv_sep && lv_json_comp.
        lv_sep = ','.
      endloop.
      lv_json = lv_json && `]`.

    endif.

    if not i_name is initial.
      lv_name_in_dict = c_boolean_false.
      lv_name = i_name.
      if not i_dictionary is initial.
        assign component i_name of structure i_dictionary to <lv_name>.
        if sy-subrc = 0.
          lv_name = <lv_name>.
          lv_name_in_dict = c_boolean_true.
        endif.
      endif.
      if lv_name_in_dict eq c_boolean_false and i_lower_case eq c_boolean_true.
        " convert name to lower case
        translate lv_name to lower case.
      endif.
      e_json = `"` && lv_name && `": ` && lv_json.
    else.
      e_json = lv_json.
    endif.

  endmethod.


  method add_header_parameter.

    data:
      ls_header type line of zif_ibmc_service_arch~ts_request_prop-headers,
      lv_value  type string.

    if i_is_boolean eq c_boolean_true.
      if i_value eq c_boolean_true.
        lv_value = 'true'.
      else.
        lv_value = 'false'.
      endif.
    else.
      lv_value = i_value.
    endif.
    condense lv_value.  " remove trailing spaces

    ls_header-name  = i_parameter.
    ls_header-value = lv_value.
    append ls_header to c_headers.

  endmethod.


  method add_query_parameter.

    data:
      lv_param type string.

    if i_is_boolean eq c_boolean_true.
      if i_value eq c_boolean_true.
        lv_param = 'true'.
      else.
        lv_param = 'false'.
      endif.
    else.
      lv_param = i_value.
    endif.
    condense lv_param.  " remove trailing spaces
    lv_param = i_parameter && `=` && lv_param.

    if c_url-querystring is initial.
      c_url-querystring = lv_param.
    else.
      c_url-querystring = c_url-querystring && `&` && lv_param.
    endif.

  endmethod.


  method adjust_request_prop.

    data:
      ls_request_prop_openapi type ts_request_prop.

    merge_structure(
      exporting
        i_alternative = p_request_prop_default
      changing
        c_base        = c_request_prop ).

    " Separate protocol, host and path in url
    normalize_url(
      changing
        c_url = c_request_prop-url ).

    " Set defaults for some unspecified properties
    if c_request_prop-url-protocol is initial.
      c_request_prop-url-protocol = 'http' ##NO_TEXT.
    endif.
    if c_request_prop-auth_headername is initial.
      c_request_prop-auth_headername = 'Authorization' ##NO_TEXT.
    endif.

    " Allow basic authentication with apikey
    if c_request_prop-auth_basic eq c_boolean_true.
      if c_request_prop-username is initial and c_request_prop-password is initial and not c_request_prop-apikey is initial.
        c_request_prop-username = 'apikey' ##NO_TEXT.
        c_request_prop-password = c_request_prop-apikey.
      endif.
    endif.

    " Correct authentication location
    if ( c_request_prop-auth_basic  ne c_boolean_false or
         c_request_prop-auth_oauth  ne c_boolean_false or
         c_request_prop-auth_apikey ne c_boolean_false ) and
       not ( c_request_prop-auth_header eq c_boolean_true or
             c_request_prop-auth_query  eq c_boolean_true or
             c_request_prop-auth_body   eq c_boolean_true ).
      c_request_prop-auth_header = c_boolean_true.
    endif.

  endmethod.


  method check_http_response.

    data:
      lv_http_status       type ts_http_status,
      lv_full_url          type string,
      ls_url               type ts_url,
      lv_strlen            type i,
      lv_code              type string,
      lo_service_exception type ref to zcx_ibmc_service_exception.

    lv_http_status = get_http_status( i_rest_response = i_response ).
    lv_code = lv_http_status-code.
    shift lv_code left deleting leading space.
    if lv_code ne '200' and   " ok
       lv_code ne '201' and   " ok with response
       lv_code ne '202' and   " Accepted (asynchronous function call)
       lv_code ne '204'.      " Deleted

      ls_url = i_url.
      merge_structure(
        exporting
          i_alternative = p_request_prop_default-url
        changing
          c_base        = ls_url ).
      lv_full_url = get_full_url( ls_url ).

      try.
           raise_exception(
            i_msgno = '003'          " HTTP Status: &1 (&2)
            i_msgv1 = lv_code
            i_msgv2 = lv_http_status-reason
            i_msgv3 = lv_full_url
            i_http_status = lv_http_status ).
        catch zcx_ibmc_service_exception into lo_service_exception.
          lo_service_exception->p_msg_json = lv_http_status-json.
      endtry.

      raise exception lo_service_exception.
    endif.

  endmethod.


  method constructor.

    data:
      lv_host type string.

    super->constructor( ).

    " use i_url and i_host synonymously
    if not i_url is initial.
      lv_host = i_url.
    else.
      lv_host = i_host.
    endif.

    p_request_prop_default-url-host     = lv_host.
    p_request_prop_default-username     = i_username.
    p_request_prop_default-password     = i_password.
    p_request_prop_default-apikey       = i_apikey.
    p_request_prop_default-access_token = i_access_token.

    p_debug_mode = i_debug_mode.

    normalize_url(
      changing
        c_url = p_request_prop_default-url ).

    if not i_proxy_host is supplied.

      get_default_proxy(
        exporting
          i_url = p_request_prop_default-url
        importing
          e_proxy_host = p_request_prop_default-proxy_host
          e_proxy_port = p_request_prop_default-proxy_port ).

    else.
      p_request_prop_default-proxy_host = i_proxy_host.
      if not i_proxy_port is initial.
        p_request_prop_default-proxy_port = i_proxy_port.
      else.
        p_request_prop_default-proxy_port = '8080'.
      endif.
    endif.


  endmethod.


  method get_access_token.

    e_access_token = p_request_prop_default-access_token.

  endmethod.


  method get_appname.
  endmethod.


  method get_components.

    data:
      lo_abap_struc type ref to cl_abap_structdescr,
      lt_comp       type cl_abap_structdescr=>component_table.

    field-symbols:
      <ls_comp>     type line of cl_abap_structdescr=>component_table.

    lo_abap_struc ?= cl_abap_structdescr=>describe_by_data( i_structure ).
    lt_comp = lo_abap_struc->get_components( ).

    clear e_components[].
    loop at lt_comp assigning <ls_comp>.
      append <ls_comp>-name to e_components.
    endloop.

  endmethod.


  method get_datatype.

    get_field_type(
      exporting
        i_field = i_field
      importing
        e_technical_type = e_datatype ).

  endmethod.


  method get_field_type.
    data:
      lo_abap_type type ref to cl_abap_typedescr,
      lo_typedescr type ref to cl_abap_typedescr.

    call method cl_abap_typedescr=>describe_by_data
      exporting
        p_data      = i_field
      receiving
        p_descr_ref = lo_typedescr.

    e_technical_type = lo_typedescr->type_kind.

    if e_relative_type is requested.
      if e_technical_type eq zif_ibmc_service_arch~c_datatype-objectref.
        data lo_refdescr type ref to cl_abap_refdescr.
        lo_refdescr ?= cl_abap_typedescr=>describe_by_data( i_field ).
        lo_abap_type ?= lo_refdescr->get_referenced_type( ).
      else.
        lo_abap_type = cl_abap_typedescr=>describe_by_data( i_field ).
      endif.
      e_relative_type = lo_abap_type->get_relative_name( ).
    endif.

    if e_length is requested.
      if e_technical_type eq zif_ibmc_service_arch~c_datatype-c or
         e_technical_type eq zif_ibmc_service_arch~c_datatype-n.
         e_length = lo_typedescr->length.
      else.
        e_length = 0.
      endif.
    endif.

  endmethod.


  method get_file_extension.

    data:
      lv_mime_type type string,
      lv_ext       type string,
      lv_len       type i.

    translate i_mime_type to lower case.

    case i_mime_type.
      when 'text/plain'.               e_extension = 'txt'.
      when 'image/jpeg'.               e_extension = 'jpg'.
      when 'application/octet-stream'. e_extension = 'bin'.
      when others.
        e_extension = 'dat'.
        find regex '([^/]*)$' in i_mime_type submatches lv_ext.
        if sy-subrc = 0.
          lv_len = strlen( lv_ext ).
          if lv_len >= 2 and lv_len <= 4.
            e_extension = lv_ext.
          endif.
        endif.
    endcase.

  endmethod.


  method get_full_url.

    data:
      lv_url type string.

    if not i_url-host cp 'http*'.
      if i_url-protocol is initial.
        lv_url = 'http://'.
      else.
        lv_url = i_url-protocol && `://`.
      endif.
    endif.

    lv_url = lv_url && i_url-host && i_url-path_base && i_url-path.

    if not i_url-querystring is initial.
      lv_url = lv_url && `?` && i_url-querystring.
    endif.

    e_url = lv_url.

  endmethod.


  method get_request_prop.

    e_request_prop-url-protocol    = 'http'.
    e_request_prop-auth_headername = ''.
    e_request_prop-auth_basic      = c_boolean_false.
    e_request_prop-auth_oauth      = c_boolean_false.
    e_request_prop-auth_apikey     = c_boolean_false.
    e_request_prop-auth_query      = c_boolean_false.
    e_request_prop-auth_header     = c_boolean_false.

  endmethod.


  method get_rest_client.

    data:
      ls_header       type ts_header,
      ls_request_prop type ts_request_prop,
      lv_url          type string.

    ls_request_prop = i_request_prop.
    adjust_request_prop(
      changing
        c_request_prop = ls_request_prop ).

    " create http client instance
    lv_url = ls_request_prop-url-protocol && `://` && ls_request_prop-url-host.
    create_client_by_url(
      exporting
        i_url          = lv_url
        i_request_prop = ls_request_prop
      importing
        e_client       = e_client ).

    " set URI and authorization
    lv_url = set_uri_and_authorization( i_client = e_client i_request_prop = ls_request_prop ).

    " set request uri
    set_request_uri( i_client = e_client i_uri = lv_url ).

    " set 'Content-Type' header
    if not i_request_prop-header_content_type is initial.
      set_request_header( i_client = e_client i_name = zif_ibmc_service_arch~c_header_content_type i_value = ls_request_prop-header_content_type ).
    endif.

    " set 'Accept' header
    if not i_request_prop-header_accept is initial.
      set_request_header( i_client = e_client i_name = zif_ibmc_service_arch~c_header_accept i_value = ls_request_prop-header_accept ).
    endif.

    " set additional headers
    if not ls_request_prop-headers is initial.
      loop at ls_request_prop-headers into ls_header.
        set_request_header( i_client = e_client i_name = ls_header-name i_value = ls_header-value ).
      endloop.
    endif.

  endmethod.


  method http_delete.

    data:
      lo_client    type ts_client.

    " create REST client
    lo_client = get_rest_client( i_request_prop = i_request_prop ).

    " execute DELETE request
    e_response = execute( i_client = lo_client i_method = zif_ibmc_service_arch~c_method_delete ).

    " check response
    check_http_response(
      i_response = e_response
      i_url      = i_request_prop-url ).

  endmethod.


  method http_get.

    data:
      lo_client    type ts_client.

    " create REST client
    lo_client = get_rest_client( i_request_prop = i_request_prop ).

    " execute GET request
    e_response = execute( i_client = lo_client i_method = zif_ibmc_service_arch~c_method_get ).

    " check response
    check_http_response(
      i_response = e_response
      i_url      = i_request_prop-url ).

  endmethod.


  method http_post.

    data:
      lo_client    type ts_client.

    " create REST client
    lo_client = get_rest_client( i_request_prop = i_request_prop ).

    " set request body
    if not i_request_prop-body is initial.
      set_request_body_cdata( i_client = lo_client i_data = i_request_prop-body ).
    endif.
    if not i_request_prop-body_bin is initial.
      set_request_body_xdata( i_client = lo_client i_data = i_request_prop-body_bin ).
    endif.

    " error:      querystring of a POST request is not sent to server if the request body is empty
    " workaround: set an empty json object for request body
    if i_request_prop-body is initial and i_request_prop-body_bin is initial.
      set_request_body_cdata( i_client = lo_client i_data = `{}` ).
      set_request_header( i_client = lo_client i_name = zif_ibmc_service_arch~c_header_content_type i_value = zif_ibmc_service_arch~c_mediatype-appl_json ).
    endif.

    " execute POST request
    e_response = execute( i_client = lo_client i_method = zif_ibmc_service_arch~c_method_post ).

    " check response
    check_http_response(
      i_response = e_response
      i_url      = i_request_prop-url ).

  endmethod.


  method HTTP_POST_MULTIPART.

    data:
      lo_client    type ts_client.

    " create REST client
    lo_client = get_rest_client( i_request_prop = i_request_prop ).

    " set request body (multipart)
    add_form_part( i_client = lo_client it_form_part = it_form_part ).

    " execute POST request
    e_response = execute( i_client = lo_client i_method = zif_ibmc_service_arch~c_method_post ).

    " check response
    check_http_response(
      i_response = e_response
      i_url      = i_request_prop-url ).

  endmethod.


  method http_put.

    data:
      lo_client    type ts_client.

    " create REST client
    lo_client = get_rest_client( i_request_prop = i_request_prop ).

    " set request body
    if not i_request_prop-body is initial.
      set_request_body_cdata( i_client = lo_client i_data = i_request_prop-body ).
    endif.
    if not i_request_prop-body_bin is initial.
      set_request_body_xdata( i_client = lo_client i_data = i_request_prop-body_bin ).
    endif.

    " execute PUT request
    e_response = execute( i_client = lo_client i_method = zif_ibmc_service_arch~c_method_put ).

    " check response
    check_http_response(
      i_response = e_response
      i_url      = i_request_prop-url ).

  endmethod.


  method merge_structure.

    data:
     lv_type     type char,
     lt_compname type tt_string.

    field-symbols:
      <lv_comp_base> type any,
      <lv_comp_alt>  type any,
      <lv_tab_base>  type standard table,
      <lv_tab_alt>   type standard table,
      <lv_compname>  type string.

    get_components(
      exporting
        i_structure = c_base
      importing
        e_components = lt_compname ).

    loop at lt_compname assigning <lv_compname>.
      assign component <lv_compname> of structure c_base to <lv_comp_base>.
      check sy-subrc = 0.
      get_field_type(
        exporting
          i_field = <lv_comp_base>
        importing
          e_technical_type = lv_type ).
      if lv_type eq zif_ibmc_service_arch~c_datatype-struct or lv_type eq zif_ibmc_service_arch~c_datatype-struct_deep.
        assign component <lv_compname> of structure i_alternative to <lv_comp_alt>.
        check sy-subrc = 0.
        merge_structure(
          exporting
            i_alternative = <lv_comp_alt>
          changing
            c_base        = <lv_comp_base> ).
      else.
        if <lv_comp_base> is initial.
          if lv_type eq zif_ibmc_service_arch~c_datatype-itab.
            assign component <lv_compname> of structure c_base to <lv_tab_base>.
            check sy-subrc = 0.
            assign component <lv_compname> of structure i_alternative to <lv_tab_alt>.
            check sy-subrc = 0.
            if not <lv_tab_alt> is initial.
              append lines of <lv_tab_alt> to <lv_tab_base>.
            endif.
          else.
            assign component <lv_compname> of structure i_alternative to <lv_comp_alt>.
            check sy-subrc = 0.
            <lv_comp_base> = <lv_comp_alt>.
          endif.
        endif.
      endif.
    endloop.

  endmethod.


  method move_data_reference_to_abap.

    data:
      lt_compname   type tt_string,
      lv_compname   type string,
      lv_index      type i,
      begin of ls_stack,
        name   type string,
        ref    type ref to data,
        struct type ref to data,
        type   type char,
      end of ls_stack,
      ls_stack_new like ls_stack,
      lt_stack     like standard table of ls_stack.
    field-symbols:
      <ls_dataref> type data,
      <lv_comp>    type any,
      <lv_subcomp> type any,
      <lv_ref>     type ref to data,
      <lv_struct>  type any.


    clear ls_stack-name.
    ls_stack-ref  = i_data_reference.
    ls_stack-struct = ref #( e_abap ).
    get_field_type(
      exporting
        i_field = e_abap
      importing
        e_technical_type = ls_stack-type ).
    append ls_stack to lt_stack.

    do.
      lv_index = lines( lt_stack ).
      if lv_index <= 0. exit. endif.
      read table lt_stack into ls_stack index lv_index.

      assign ls_stack-ref->* to <ls_dataref>.
      assign ls_stack-struct->* to <lv_struct>.
      if ls_stack-name is initial.
        assign e_abap to <lv_comp>.
      else.
        assign component ls_stack-name of structure <lv_struct> to <lv_comp>.
      endif.
      if ls_stack-type eq 'u' or ls_stack-type eq 'v'.  " structure
        get_components(
          exporting
            i_structure = <lv_comp>
          importing
            e_components = lt_compname ).
        loop at lt_compname into lv_compname.
          ls_stack_new-name = lv_compname.
          ls_stack_new-struct = ref #( <lv_comp> ).
          assign component lv_compname of structure <ls_dataref> to <lv_ref>.
          if sy-subrc = 0.
            ls_stack_new-ref = <lv_ref>.
            assign component lv_compname of structure <lv_comp> to <lv_subcomp>.
            get_field_type(
              exporting
                i_field = <lv_subcomp>
              importing
                e_technical_type = ls_stack_new-type ).
            append ls_stack_new to lt_stack.
          endif.
        endloop.

      else.
        if not ls_stack-name is initial.
          assign ls_stack-struct->* to <lv_struct>.
          assign component ls_stack-name of structure <lv_struct> to <lv_comp>.
        endif.
        if ls_stack-type eq 'l' or ls_stack-type eq 'r'.  " reference
          <lv_comp> = ls_stack-ref.
        else.
          <lv_comp> = <ls_dataref>.
        endif.
      endif.

      delete lt_stack index lv_index.

    enddo.


  endmethod.


  method normalize_url.

    check not c_url is initial.

    data(lv_protocol) = c_url-protocol.
    if not lv_protocol is initial and lv_protocol np '*://'.
      lv_protocol = lv_protocol && '://'.
    endif.

    data(lv_host) = c_url-host.
    if c_url-host cp 'http:*' or c_url-host cp 'https:*'.
      clear lv_protocol.
    endif.
    shift lv_host right deleting trailing '/'.
    if not c_url-path_base is initial.
      shift c_url-path_base left deleting leading '/'.
      lv_host = lv_host && '/' && c_url-path_base.
      shift lv_host right deleting trailing '/'.
    endif.
    shift lv_host left deleting leading space.

    data(lv_path) = c_url-path.
    if not lv_path is initial.
      if lv_path np '/*'.
        lv_path = '/' && lv_path.
      endif.
    endif.

    data(lv_url_full) = lv_protocol && lv_host && lv_path.
    shift lv_url_full right deleting trailing '/'.
    shift lv_url_full left deleting leading space.

    clear: c_url-protocol, c_url-host, c_url-path_base, c_url-path.  " do not clear other components
    find regex '^(http.?:\/\/)?([^\/]*)(.*)$' in lv_url_full submatches c_url-protocol c_url-host c_url-path.

    shift c_url-protocol right deleting trailing '/'.
    shift c_url-protocol right deleting trailing ':'.
    shift c_url-protocol left deleting leading space.

    " split path into base_path and path
    if not lv_host is initial.
      find lv_host in lv_url_full match offset data(lv_offset) match length data(lv_length).
      if sy-subrc = 0.
        data(lv_strlen_url) = strlen( lv_url_full ).
        data(lv_strlen_path) = strlen( c_url-path ).
        data(lv_splitpoint) = lv_strlen_path - ( lv_strlen_url - lv_offset - lv_length ).
        c_url-path_base = c_url-path+0(lv_splitpoint).
        c_url-path = c_url-path+lv_splitpoint.
      endif.
    endif.

    return.

  endmethod.


  method PARSE_JSON.

    data:
      lv_json       type string,
      lt_dictionary type zif_ibmc_service_arch~tt_string,
      lv_dictionary type string,
      lv_orgname    type string,
      lv_abapname   type string,
      lv_regex      type string,
      lo_json       type ref to /ui2/cl_json,
      lv_msg        type string,
      lr_exception  type ref to cx_sy_move_cast_error.
    field-symbols:
      <lv_orgname> type string.

    if not i_json is initial.

      lv_json = i_json.

      if i_dictionary is supplied.
        get_components(
          exporting
            i_structure = i_dictionary
          importing
            e_components = lt_dictionary ).

        loop at lt_dictionary into lv_dictionary.
          assign component lv_dictionary of structure i_dictionary to <lv_orgname>.
          lv_orgname = <lv_orgname>.
          translate lv_orgname to upper case.
          if lv_dictionary ne lv_orgname.
            lv_regex = `"` && <lv_orgname> && `"\s*:`.
            lv_abapname = `"` && lv_dictionary && `":`.
            replace all occurrences of regex lv_regex in lv_json with lv_abapname.
          endif.
        endloop.

      endif.

      " copy code to execute /ui2/cl_json=>deserialize( exporting json = lv_json changing data = c_abap ) and catch exception
      create object lo_json.
      try.
          lo_json->deserialize_int( exporting json = lv_json changing data = c_abap ).
          catch cx_sy_move_cast_error into lr_exception.
            zcl_ibmc_service=>raise_exception(
              exporting
                i_msgno = 20 ).
        endtry.

      endif.

    endmethod.


  method raise_exception.

    data:
      ls_msg               like if_t100_message=>t100key,
      lv_charval(11)       type c,
      lo_service_exception type ref to zcx_ibmc_service_exception.

    ls_msg-msgid = c_msgid.

    if not i_msgno is initial.
      ls_msg-msgno = i_msgno.
      ls_msg-attr1 = i_msgv1.
      ls_msg-attr2 = i_msgv2.
      ls_msg-attr3 = i_msgv3.
      ls_msg-attr4 = i_msgv4.
    else.
      if not i_text is initial.
        if i_subrc <> c_subrc_unknown.
          lv_charval = conv #( i_subrc ).
          ls_msg-attr2 = lv_charval.
          ls_msg-msgno = '001'.   " &1: return code &2
        else.
          ls_msg-msgno = '000'.   " &1
        endif.
        ls_msg-attr1 = i_text.
      else.
        ls_msg-msgno = '002'.   " An exception has occurred, reason code &1.
        lv_charval = conv #( i_subrc ).
        ls_msg-attr1 = lv_charval.
      endif.
    endif.

    if ls_msg-attr4 is initial and not i_http_status-json is initial.
      data:
        begin of ls_error,
          error type string,
          description type string,
        end of ls_error.
      parse_json(
        exporting
          i_json = i_http_status-json
        changing
          c_abap = ls_error ).
      if not ls_error-error is initial.
        ls_msg-attr4 = unescape_unicode( ls_error-error ).
      elseif not ls_error-description is initial.
        ls_msg-attr4 = unescape_unicode( ls_error-description ).
      else.
        ls_msg-attr4 = unescape_unicode( i_http_status-json ).
      endif.
    endif.

    raise exception type zcx_ibmc_service_exception
      message id c_msgid type 'E' number ls_msg-msgno with ls_msg-attr1 ls_msg-attr2 ls_msg-attr3 ls_msg-attr4.

  endmethod.


  method set_access_token.

    p_request_prop_default-access_token = i_access_token.
    if p_request_prop_default-access_token-token_type is initial.
      p_request_prop_default-access_token-token_type = 'Bearer'.
    endif.
    if p_request_prop_default-access_token-expires_ts = 0.
      p_request_prop_default-access_token-expires_ts   = '99991231235959'  ##LITERAL.   " avoid token being refreshed by sdk
    endif.

  endmethod.


  method set_uri_and_authorization.

    data:
      ls_url type ts_url,
      lv_url type string.

    ls_url = i_request_prop-url.

    " OAuth authorization
    if i_request_prop-auth_oauth eq c_boolean_true.  " = not ( c_boolean_false or c_tribool_false )
      data:
        ls_access_token type ts_access_token,
        lv_full_token   type string.
      ls_access_token = get_access_token( i_request_prop = i_request_prop ).
      if not ls_access_token-token_type is initial.
        concatenate ls_access_token-token_type ls_access_token-access_token into lv_full_token separated by space.
      else.
        lv_full_token = ls_access_token-access_token.
      endif.
      if i_request_prop-auth_header eq c_boolean_true.
        set_request_header( i_client = i_client i_name = i_request_prop-auth_headername i_value = lv_full_token ).
      endif.

      " Basic authentication
    elseif i_request_prop-auth_basic eq c_boolean_true or i_request_prop-auth_apikey eq c_boolean_true.
      data:
        lv_username type string,
        lv_password type string.
      if i_request_prop-auth_apikey eq c_boolean_true.
        lv_username = 'apikey' ##NO_TEXT.
        lv_password = i_request_prop-apikey.
      else.
        lv_username = i_request_prop-username.
        lv_password = i_request_prop-password.
      endif.
      if i_request_prop-auth_header eq c_boolean_true.
        set_authentication_basic( i_client = i_client i_username = lv_username i_password = lv_password ).
      elseif i_request_prop-auth_query eq c_boolean_true.
        if i_request_prop-auth_apikey eq c_boolean_true.
          add_query_parameter(
            exporting
              i_parameter = 'apikey'  ##NO_TEXT
              i_value     = lv_password
            changing
              c_url       = ls_url ).
        else.
          add_query_parameter(
            exporting
              i_parameter = 'username'  ##NO_TEXT
              i_value     = lv_username
            changing
              c_url       = ls_url ).
          add_query_parameter(
            exporting
              i_parameter = 'password'  ##NO_TEXT
              i_value     = lv_password
            changing
              c_url       = ls_url ).
        endif.
      elseif i_request_prop-auth_body eq c_boolean_true.
        data:
          lv_body type string.
        if i_request_prop-auth_apikey eq c_boolean_true.
          lv_body = `{ "userid": "apikey", "password": "` && i_request_prop-apikey && `" }` ##NO_TEXT.
        else.
          lv_body = `{ "userid": "` && i_request_prop-username && `", "password": "` && i_request_prop-password && `" }`  ##NO_TEXT.
        endif.
        set_request_body_cdata( i_client = i_client i_data = lv_body ).
        set_request_header( i_client = i_client i_name = zif_ibmc_service_arch~c_header_content_type i_value = zif_ibmc_service_arch~c_mediatype-appl_json ).
      endif.
    endif.

    e_uri = get_full_url( ls_url ).

  endmethod.


  method unescape_unicode.

    data:
      lv_match     type string,
      lv_cp_str    type string,
      lv_cp_hex(4) type x,
      lv_ucchar(1) type c.

    field-symbols:
      <lv_c> like lv_ucchar.

    e_out = i_in.

    do.
      find regex '(\\u[A-Fa-f0-9]{4})' in e_out ignoring case submatches lv_match  ##NO_TEXT.
      if sy-subrc <> 0.
        exit.
      endif.

      lv_cp_str = lv_match+2.
      translate lv_cp_str to upper case.
      lv_cp_hex = lv_cp_str.

      assign lv_cp_hex to <lv_c> CASTING.
      lv_ucchar = <lv_c>.

      replace all occurrences of lv_match in e_out with lv_ucchar.

    enddo.

  endmethod.
ENDCLASS.
