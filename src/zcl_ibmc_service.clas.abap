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
      "! DateTime type, format 2018-10-23T15:18:18.914xxxZ
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
  types:
    begin of TS_FORM_PART,
      CONTENT_TYPE type STRING,
      CONTENT_DISPOSITION type STRING,
      CDATA type STRING,
      XDATA type XSTRING,
    end of TS_FORM_PART .
  types:
    TT_FORM_PART type standard table of TS_FORM_PART .

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
  methods GET_REQUEST_PROP
    importing
      !I_AUTH_METHOD type STRING default C_DEFAULT
    returning
      value(E_REQUEST_PROP) type TS_REQUEST_PROP .
  class-methods GET_DATATYPE
    importing
      !I_FIELD type ANY
    returning
      value(E_DATATYPE) type ZIF_IBMC_SERVICE_ARCH~CHAR .
  methods ADD_FORM_PART
    importing
      !I_CLIENT type TS_CLIENT
      !IT_FORM_PART type TT_FORM_PART
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
  class-methods UNESCAPE_UNICODE
    importing
      !I_IN type STRING
    returning
      value(E_OUT) type STRING .
  class-methods GET_FILE_EXTENSION
    importing
      value(I_MIME_TYPE) type STRING
    returning
      value(E_EXTENSION) type STRING .
  class-methods MOVE_DATA_REFERENCE_TO_ABAP
    importing
      !I_DATA_REFERENCE type DATA_REFERENCE
    exporting
      value(E_ABAP) type ANY
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
  class-methods ADD_QUERY_PARAMETER
    importing
      !I_PARAMETER type STRING
      !I_VALUE type STRING
      !I_IS_BOOLEAN type BOOLEAN default C_BOOLEAN_FALSE
    changing
      !C_URL type TS_URL .
  class-methods ADD_HEADER_PARAMETER
    importing
      !I_PARAMETER type STRING
      !I_VALUE type STRING
      !I_IS_BOOLEAN type BOOLEAN default C_BOOLEAN_FALSE
    changing
      !C_HEADERS type ZIF_IBMC_SERVICE_ARCH~TS_REQUEST_PROP-HEADERS .
  class-methods GET_FULL_URL
    importing
      !I_URL type TS_URL
    returning
      value(E_URL) type STRING .
  methods GET_APPNAME
    returning
      value(E_APPNAME) type STRING .
  class-methods NORMALIZE_URL
    changing
      !C_URL type TS_URL .
  class-methods ABAP_TO_JSON
    importing
      !I_NAME type STRING optional
      !I_VALUE type ANY
      !I_DICTIONARY type ANY optional
      !I_REQUIRED_FIELDS type ANY optional
      !I_LOWER_CASE type BOOLEAN default C_BOOLEAN_TRUE
    returning
      value(E_JSON) type STRING .
  methods CHECK_HTTP_RESPONSE
    importing
      !I_RESPONSE type TO_REST_RESPONSE optional
      !I_URL type TS_URL optional
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
  methods CONSTRUCTOR
    importing
      !I_HOST type STRING optional
      !I_PROXY_HOST type STRING optional
      !I_PROXY_PORT type STRING optional
      !I_USERNAME type STRING optional
      !I_PASSWORD type STRING optional
      !I_APIKEY type STRING optional
      !I_ACCESS_TOKEN type TS_ACCESS_TOKEN optional
      !I_SSL_ID type ZIF_IBMC_SERVICE_ARCH~TY_SSL_ID optional
      !I_DEBUG_MODE type CHAR default SPACE .
  methods GET_REST_CLIENT
    importing
      !I_REQUEST_PROP type TS_REQUEST_PROP
    returning
      value(E_CLIENT) type TS_CLIENT
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
  methods GET_ACCESS_TOKEN
    importing
      !I_REQUEST_PROP type TS_REQUEST_PROP optional
    returning
      value(E_ACCESS_TOKEN) type TS_ACCESS_TOKEN
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
  methods HTTP_DELETE
    importing
      !I_REQUEST_PROP type TS_REQUEST_PROP
    returning
      value(E_RESPONSE) type TO_REST_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
  methods SET_ACCESS_TOKEN
    importing
      !I_ACCESS_TOKEN type TS_ACCESS_TOKEN
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
  methods HTTP_GET
    importing
      !I_REQUEST_PROP type TS_REQUEST_PROP
    returning
      value(E_RESPONSE) type TO_REST_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
  methods HTTP_POST
    importing
      !I_REQUEST_PROP type TS_REQUEST_PROP
    returning
      value(E_RESPONSE) type TO_REST_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
  methods HTTP_POST_MULTIPART
    importing
      !I_REQUEST_PROP type TS_REQUEST_PROP
      !IT_FORM_PART type TT_FORM_PART
    returning
      value(E_RESPONSE) type TO_REST_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
  methods HTTP_PUT
    importing
      !I_REQUEST_PROP type TS_REQUEST_PROP
    returning
      value(E_RESPONSE) type TO_REST_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
protected section.

  methods ADJUST_REQUEST_PROP
    changing
      !C_REQUEST_PROP type TS_REQUEST_PROP .
  class-methods MERGE_STRUCTURE
    importing
      !I_ALTERNATIVE type ANY
    changing
      !C_BASE type ANY .
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

    if lv_type ne zif_ibmc_service_arch~c_datatype-struct and lv_type ne zif_ibmc_service_arch~c_datatype-struct_deep and lv_type ne zif_ibmc_service_arch~c_datatype-itab.
      " simple type

      if lv_type eq 'C' or lv_type eq 'N' or lv_type eq 'g'.
        lv_str = i_value.
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
            assign i_value to <l_i_value>.
            if <l_i_value> = c_i_zero.
              lv_json_num = '0'.
              exit.
            endif.
          elseif lv_type eq '8'.
            assign i_value to <l_i8_value>.
            if <l_i8_value> = c_i8_zero.
              lv_json_num = '0'.
              exit.
            endif.
          elseif lv_type eq 'F'.
            assign i_value to <l_f_value>.
            if <l_f_value> = c_f_zero.
              lv_json_num = '0'.
              exit.
            endif.
          endif.

          lv_json_num = conv #( i_value ).
          condense lv_json_num no-gaps.
        enddo.
        lv_json = lv_json_num.
      endif.

    elseif lv_type eq zif_ibmc_service_arch~c_datatype-struct or lv_type eq zif_ibmc_service_arch~c_datatype-struct_deep.
      " structure

      get_components(
        exporting
          i_structure = i_value
        importing
          e_components = lt_compname ).
      clear lv_sep.
      lv_json = lv_json && `{`.
      loop at lt_compname assigning <ls_compname>.
        assign component <ls_compname> of structure i_value to <l_value>.
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
      assign i_value to <lt_value>.
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


  method add_form_part.

    data:
      ls_form_part type ts_form_part,
      lo_part      type to_form_part.

    loop at it_form_part into ls_form_part.
      lo_part = form_part_add( i_client = i_client ).
      if not ls_form_part-content_type is initial.
        form_part_set_header( i_form_part = lo_part i_name = 'Content-Type' i_value = ls_form_part-content_type )  ##NO_TEXT.
      endif.
      if not ls_form_part-content_disposition is initial.
        form_part_set_header( i_form_part = lo_part i_name = 'Content-Disposition' i_value = ls_form_part-content_disposition )  ##NO_TEXT.
      endif.
      if not ls_form_part-xdata is initial.
        form_part_set_xdata( i_form_part = lo_part i_data = ls_form_part-xdata ).
      endif.
      if not ls_form_part-cdata is initial.
        form_part_set_cdata( i_form_part = lo_part i_data = ls_form_part-cdata ).
      endif.
    endloop.

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
      lo_service_exception type ref to zcx_ibmc_service_exception.

    lv_http_status = get_http_status( i_rest_response = i_response ).
    if lv_http_status-code ne '200' and   " ok
       lv_http_status-code ne '201' and   " ok with response
       lv_http_status-code ne '202' and   " Accepted (asynchronous function call)
       lv_http_status-code ne '204'.      " Deleted

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
            i_msgv1 = lv_http_status-code
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

    super->constructor( ).

    p_request_prop_default-url-host     = i_host.
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


  method get_datatype.

    get_field_type(
      exporting
        i_field = i_field
      importing
        e_technical_type = e_datatype ).

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

    data:
      lv_path_base type string value is initial,
      lv_path      type string,
      lv_protocol  type ts_url-protocol,
      lv_host      type ts_url-host,
      lv_strlen    type i,
      lv_offset    type i.

    check not c_url is initial.

    if not c_url-path_base is initial.
      lv_path = c_url-path_base.
    else.
      lv_path = c_url-path.
    endif.

    " extract host from path
    if lv_path cp 'http:*' or lv_path cp 'https:*'.
      find regex '(http.?:\/\/[^\/]*)' in lv_path submatches lv_host.
      lv_strlen = strlen( lv_host ).
      lv_path = lv_path+lv_strlen.
      c_url-host = lv_host.
    endif.

    " extract protocol from host
    if c_url-host cp 'http:*' or c_url-host cp 'https:*'.
      find regex '(http.?):\/\/' in c_url-host submatches lv_protocol.
      lv_strlen = strlen( lv_protocol ).
      lv_strlen = lv_strlen + 3.  " for ://
      c_url-host     = c_url-host+lv_strlen.
      c_url-protocol = lv_protocol.
    endif.

    " extrcat base path from host
    find first occurrence of '/' in c_url-host match offset lv_offset.
    if sy-subrc = 0.
      lv_path_base = c_url-host+lv_offset.
      c_url-host   = c_url-host+0(lv_offset).
    endif.

    if c_url-path_base is initial.
      c_url-path_base = lv_path_base.
      c_url-path      = lv_path.
    else.
      c_url-path_base = lv_path_base && lv_path.
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
