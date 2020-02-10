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
class ZCL_IBMC_SERVICE_ARCH definition
  public
  create public .

public section.

  interfaces ZIF_IBMC_SERVICE_ARCH .

  types TO_HTTP_CLIENT type ref to IF_HTTP_CLIENT .
  types TO_REST_CLIENT type ref to CL_REST_HTTP_CLIENT .
  types TO_HTTP_ENTITY type ref to IF_HTTP_ENTITY .
  types TO_REST_ENTITY type ref to IF_REST_ENTITY .
  types TO_REST_REQUEST type ref to IF_REST_ENTITY .
  types TO_REST_RESPONSE type ref to IF_REST_ENTITY .
  types TO_FORM_PART type ref to IF_HTTP_ENTITY .
  types:
    begin of ts_client,
        http type to_http_client,
        rest type to_rest_client,
      end of ts_client .
  types TS_HTTP_STATUS type ZIF_IBMC_SERVICE_ARCH~TS_HTTP_STATUS .
  types TS_HEADER type ZIF_IBMC_SERVICE_ARCH~TS_HEADER .
  types TT_HEADER type ZIF_IBMC_SERVICE_ARCH~TT_HEADER .
  types TS_URL type ZIF_IBMC_SERVICE_ARCH~TS_URL .
  types TS_ACCESS_TOKEN type ZIF_IBMC_SERVICE_ARCH~TS_ACCESS_TOKEN .
  types TS_REQUEST_PROP type ZIF_IBMC_SERVICE_ARCH~TS_REQUEST_PROP .

  class-methods GET_TIMEZONE
    returning
      value(E_TIMEZONE) type ZIF_IBMC_SERVICE_ARCH~TY_TIMEZONE .
  class-methods GET_PROGNAME
    returning
      value(E_PROGNAME) type STRING .
  class-methods BASE64_DECODE
    importing
      !I_BASE64 type STRING
    returning
      value(E_BINARY) type XSTRING
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
  class-methods CREATE_CLIENT_BY_URL
    importing
      !I_URL type STRING
      !I_REQUEST_PROP type TS_REQUEST_PROP
    exporting
      !E_CLIENT type TS_CLIENT
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
  methods ADD_FORM_PART
    importing
      !I_CLIENT type TS_CLIENT
      !IT_FORM_PART type ZIF_IBMC_SERVICE_ARCH=>TT_FORM_PART
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
  class-methods GET_DEFAULT_PROXY
    importing
      !I_URL type TS_URL optional
    exporting
      !E_PROXY_HOST type STRING
      !E_PROXY_PORT type STRING .
  class-methods SET_AUTHENTICATION_BASIC
    importing
      !I_CLIENT type TS_CLIENT
      !I_USERNAME type STRING
      !I_PASSWORD type STRING .
  class-methods SET_REQUEST_HEADER
    importing
      !I_CLIENT type TS_CLIENT
      !I_NAME type STRING
      !I_VALUE type STRING .
  class-methods SET_REQUEST_URI
    importing
      !I_CLIENT type TS_CLIENT
      !I_URI type STRING .
  class-methods EXECUTE
    importing
      !I_CLIENT type TS_CLIENT
      !I_METHOD type ZIF_IBMC_SERVICE_ARCH~CHAR default ZIF_IBMC_SERVICE_ARCH~C_METHOD_GET
    returning
      value(E_RESPONSE) type TO_REST_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
  class-methods GET_RESPONSE_STRING
    importing
      !I_RESPONSE type TO_REST_RESPONSE
    returning
      value(E_DATA) type STRING .
  class-methods SET_REQUEST_BODY_CDATA
    importing
      !I_CLIENT type TS_CLIENT
      !I_DATA type STRING .
  class-methods SET_REQUEST_BODY_XDATA
    importing
      !I_CLIENT type TS_CLIENT
      !I_DATA type XSTRING .
  class-methods GET_RESPONSE_BINARY
    importing
      !I_RESPONSE type TO_REST_RESPONSE
    returning
      value(E_DATA) type XSTRING .
  class-methods GET_REST_REQUEST
    importing
      !I_CLIENT type TS_CLIENT
    returning
      value(E_REST_REQUEST) type TO_REST_REQUEST .
  class-methods GET_HTTP_STATUS
    importing
      !I_REST_RESPONSE type TO_REST_RESPONSE
    returning
      value(E_STATUS) type TS_HTTP_STATUS .
  class-methods CONVERT_STRING_TO_UTF8
    importing
      !I_STRING type STRING
    returning
      value(E_UTF8) type XSTRING
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_IBMC_SERVICE_ARCH IMPLEMENTATION.


  method add_form_part.

    data:
      ls_form_part type zif_ibmc_service_arch=>ts_form_part,
      lo_part      type to_form_part.

    loop at it_form_part into ls_form_part.
      lo_part = i_client-http->request->if_http_entity~add_multipart( ). "form_part_add( i_client = i_client ).
      if not ls_form_part-content_type is initial.
        lo_part->set_header_field( name = 'Content-Type' value = ls_form_part-content_type ) ##NO_TEXT.
        "form_part_set_header( i_form_part = lo_part i_name = 'Content-Type' i_value = ls_form_part-content_type )  ##NO_TEXT.
      endif.
      if not ls_form_part-content_disposition is initial.
        lo_part->set_header_field( name = 'Content-Disposition' value = ls_form_part-content_disposition ) ##NO_TEXT.
        "form_part_set_header( i_form_part = lo_part i_name = 'Content-Disposition' i_value = ls_form_part-content_disposition )  ##NO_TEXT.
      endif.
      if not ls_form_part-xdata is initial.
        data(lv_length) = xstrlen( ls_form_part-xdata ).
        lo_part->set_data( data = ls_form_part-xdata offset = 0 length = lv_length ).
        "form_part_set_xdata( i_form_part = lo_part i_data = ls_form_part-xdata ).
      endif.
      if not ls_form_part-cdata is initial.
        lo_part->append_cdata( data = ls_form_part-cdata ).
        "form_part_set_cdata( i_form_part = lo_part i_data = ls_form_part-cdata ).
      endif.
    endloop.

  endmethod.


  method base64_decode.

    call function 'SCMS_BASE64_DECODE_STR'
      exporting
        input  = i_base64
      importing
        output = e_binary
      exceptions
        failed = 1
        others = 2.

    if sy-subrc <> 0.
      zcl_ibmc_service=>raise_exception( i_msgno = '030' ).  " Decoding of base64 string failed
    endif.

  endmethod.


  method convert_string_to_utf8.

    data:
      lv_codepage type cpcodepage,
      lv_encoding type abap_encoding.

    clear e_utf8.
    call function 'SCP_CODEPAGE_BY_EXTERNAL_NAME'
      exporting
        external_name = 'UTF-8'
      importing
        sap_codepage  = lv_codepage
      exceptions
        not_found     = 1
        others        = 2.
    if sy-subrc <> 0.
      zcl_ibmc_service=>raise_exception( i_text = 'Cannot determine UTF-8 codepage' )  ##NO_TEXT.
    endif.
    lv_encoding = lv_codepage.
    call function 'SCMS_STRING_TO_XSTRING'
      exporting
        text     = i_string
        encoding = lv_encoding
      importing
        buffer   = e_utf8
      exceptions
        failed   = 1
        others   = 2.
    if sy-subrc <> 0.
      zcl_ibmc_service=>raise_exception( i_text = 'Cannot convert string to UTF-8' )  ##NO_TEXT.
    endif.

  endmethod.


  method create_client_by_url.

    data:
      lv_text type string.

    cl_http_client=>create_by_url(
      exporting
        url                = i_url
        proxy_host         = i_request_prop-proxy_host       " proxy server (w/o protocol prefix)
        proxy_service      = i_request_prop-proxy_port       " proxy port
        ssl_id             = i_request_prop-ssl_id
      importing
        client             = e_client-http
      exceptions
        argument_not_found = 1
        plugin_not_active  = 2
        internal_error     = 3
        others             = 99 )  ##NUMBER_OK.
    if sy-subrc <> 0.
      case sy-subrc.
        when 1.
          lv_text = 'Argument not found'  ##NO_TEXT.
        when 2.
          lv_text = 'Plugin not active'  ##NO_TEXT.
        when others.
          lv_text = 'Internal error'  ##NO_TEXT.
      endcase.
      lv_text = `HTTP client cannot be created: ` && lv_text  ##NO_TEXT.
      zcl_ibmc_service=>raise_exception( i_text = lv_text ).
    endif.

    " set http protocol version
    e_client-http->request->set_version( if_http_request=>co_protocol_version_1_1 ).
    e_client-http->propertytype_logon_popup = if_http_client=>co_disabled.

    " create REST client instance from http client instance
    create object e_client-rest
      exporting
        io_http_client = e_client-http.

  endmethod.


  method execute.

    data:
      lo_request   type to_rest_request,
      lv_method    type string,
      lv_text      type string,
      lo_exception type ref to cx_rest_client_exception.

    try.
        case i_method.
          when zif_ibmc_service_arch~c_method_get.
            lv_method = 'GET'  ##NO_TEXT.
            i_client-rest->if_rest_client~get( ).
          when zif_ibmc_service_arch~c_method_post.
            lv_method = 'POST'  ##NO_TEXT.
            lo_request = get_rest_request( i_client = i_client ).
            i_client-rest->if_rest_client~post( lo_request ).
          when zif_ibmc_service_arch~c_method_put.
            lv_method = 'PUT'  ##NO_TEXT.
            lo_request = get_rest_request( i_client = i_client ).
            i_client-rest->if_rest_client~put( lo_request ).
          when zif_ibmc_service_arch~c_method_delete.
            lv_method = 'DELETE'  ##NO_TEXT.
            i_client-rest->if_rest_client~delete( ).
          when others.
            "raise_exception( ).
        endcase.
      catch cx_rest_client_exception into lo_exception.
        lv_text = lo_exception->get_text( ).
        lv_text = `HTTP ` && lv_method && ` request failed: ` && lv_text  ##NO_TEXT.
        zcl_ibmc_service=>raise_exception( i_text = lv_text i_previous = lo_exception ).
    endtry.

    e_response = i_client-rest->if_rest_client~get_response_entity( ).

  endmethod.


  method get_default_proxy.

    data:
      ls_proxy    type pproxy_c,
      lv_protocol type i.
    if i_url-protocol eq 'https' or i_url-protocol eq 'HTTPS'.
      lv_protocol = 2.
    else.
      lv_protocol = 1.
    endif.
    call function 'ICF_READ_PROXY_CONFIGURATION'
      exporting
        authority_check               = space
        mandant                       = sy-mandt
        protocol                      = lv_protocol
        hostname                      = i_url-host
      importing
        proxy_configuraion            = ls_proxy
      exceptions
        authority_not_available       = 1
        proxy_invalid_protocol        = 2
        proxy_entry_not_available     = 3
        proxy_entry_not_active        = 4
        proxy_parameter_not_available = 5
        proxy_not_necessary           = 6
        proxy_no_authority            = 7
        proxy_exit_erroneous          = 8
        others                        = 9.
    if sy-subrc <> 0.
    else.
      e_proxy_host = ls_proxy-host.
      e_proxy_port = ls_proxy-port.
    endif.

  endmethod.


  method get_http_status.

    e_status-code   = i_rest_response->get_header_field( '~status_code' ).
    e_status-reason = i_rest_response->get_header_field( '~status_reason' ).
    e_status-json   = i_rest_response->get_string_data( ).

  endmethod.


  method get_progname.

    e_progname = sy-cprog.

  endmethod.


  method get_response_binary.

    e_data = i_response->get_binary_data( ).

  endmethod.


  method get_response_string.

    e_data = i_response->get_string_data( ).

  endmethod.


  method get_rest_request.

    e_rest_request = i_client-rest->if_rest_client~create_request_entity( ).

  endmethod.


  method get_timezone.

    e_timezone = sy-zonlo.

  endmethod.


  method set_authentication_basic.

    i_client-http->authenticate( username = i_username password = i_password ).

  endmethod.


  method set_request_body_cdata.

    i_client-http->request->if_http_entity~set_cdata( data = i_data ).

  endmethod.


  method set_request_body_xdata.

    i_client-http->request->if_http_entity~set_data( data = i_data ).

  endmethod.


  method set_request_header.

    i_client-rest->if_rest_client~set_request_header( iv_name = i_name iv_value = i_value ) .

  endmethod.


  method set_request_uri.

    cl_http_utility=>set_request_uri(
      exporting
        request = i_client-http->request
        uri     = i_uri ).

  endmethod.
ENDCLASS.
