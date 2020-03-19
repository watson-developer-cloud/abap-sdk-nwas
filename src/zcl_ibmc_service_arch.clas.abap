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
class zcl_ibmc_service_arch definition
  public
  create public .

  public section.

    interfaces zif_ibmc_service_arch .

    types to_http_client type ref to if_http_client .
    types to_rest_client type ref to cl_rest_http_client .
    types to_http_entity type ref to if_http_entity .
    types to_rest_entity type ref to if_rest_entity .
    types to_rest_request type ref to if_rest_entity .
    types to_rest_response type ref to if_rest_entity .
    types to_form_part type ref to if_http_entity .
    types:
      begin of ts_client,
        http type to_http_client,
        rest type to_rest_client,
      end of ts_client .
    types ts_http_status type zif_ibmc_service_arch~ts_http_status .
    types ts_header type zif_ibmc_service_arch~ts_header .
    types tt_header type zif_ibmc_service_arch~tt_header .
    types ts_url type zif_ibmc_service_arch~ts_url .
    types ts_access_token type zif_ibmc_service_arch~ts_access_token .
    types ts_request_prop type zif_ibmc_service_arch~ts_request_prop .

    "! <p class="shorttext synchronized" lang="en">Returns a HTTP response header.</p>
    "!
    "! @parameter I_RESPONSE | HTTP/REST response
    "! @parameter I_HEADER_FIELD | Header field name
    "! @parameter E_VALUE | Header field value
    "!
    class-methods get_response_header
      importing
        !i_response     type to_rest_response
        !i_header_field type string
      returning
        value(e_value)  type string .
    "! <p class="shorttext synchronized" lang="en">Returns the user's time zone.</p>
    "!
    "! @parameter E_TIMEZONE | user's time zone
    "!
    class-methods get_timezone
      returning
        value(e_timezone) type zif_ibmc_service_arch~ty_timezone .
    "! <p class="shorttext synchronized" lang="en">Returns an ABAP module identifier.</p>
    "!
    "! @parameter E_PROGNAME | ABAP module identifier
    "!
    class-methods get_progname
      returning
        value(e_progname) type string .
    "! <p class="shorttext synchronized" lang="en">Decodes base64 encoded data to binary.</p>
    "!
    "! @parameter I_BASE64 | Base64-encoded binary
    "! @parameter E_BINARY | Binary data
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
    class-methods base64_decode
      importing
        !i_base64       type string
      returning
        value(e_binary) type xstring
      raising
        zcx_ibmc_service_exception .
    "! <p class="shorttext synchronized" lang="en">Returns a HTTP/REST client based on an URL.</p>
    "!
    "! @parameter I_URL | URL
    "! @parameter I_REQUEST_PROP | Request parameters
    "! @parameter E_CLIENT | HTTP/REST client
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
    class-methods create_client_by_url
      importing
        !i_url          type string
        !i_request_prop type ts_request_prop
      exporting
        !e_client       type ts_client
      raising
        zcx_ibmc_service_exception .
    "! <p class="shorttext synchronized" lang="en">Generates a multi-part request body.</p>
    "!
    "! @parameter I_CLIENT | HTTP/REST client
    "! @parameter IT_FORM_PART | Table of form parts
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
    methods add_form_part
      importing
        !i_client     type ts_client
        !it_form_part type zif_ibmc_service_arch=>tt_form_part
      raising
        zcx_ibmc_service_exception .
    "! <p class="shorttext synchronized" lang="en">Returns the default proxy host and port.</p>
    "!
    "! @parameter I_URL | target URL
    "! @parameter E_PROXY_HOST | Proxy host
    "! @parameter E_PROXY_PORT | Proxy port
    "!
    class-methods get_default_proxy
      importing
        !i_url        type ts_url optional
      exporting
        !e_proxy_host type string
        !e_proxy_port type string .
    "! <p class="shorttext synchronized" lang="en">Sets request header for basic authentication.</p>
    "!
    "! @parameter I_CLIENT | HTTP/REST client
    "! @parameter I_USERNAME | User name
    "! @parameter I_PASSWORD | Password
    "!
    class-methods set_authentication_basic
      importing
        !i_client   type ts_client
        !i_username type string
        !i_password type string .
    "! <p class="shorttext synchronized" lang="en">Sets a HTTP header.</p>
    "!
    "! @parameter I_CLIENT | HTTP/REST client
    "! @parameter I_NAME | Header field name
    "! @parameter I_VALUE | Header field value
    "!
    class-methods set_request_header
      importing
        !i_client type ts_client
        !i_name   type string
        !i_value  type string .
    "! <p class="shorttext synchronized" lang="en">Sets the URI for a HTTP request.</p>
    "!
    "! @parameter I_CLIENT | HTTP/REST client
    "! @parameter I_URI | URI
    "!
    class-methods set_request_uri
      importing
        !i_client type ts_client
        !i_uri    type string .
    "! <p class="shorttext synchronized" lang="en">Executes a HTTP request.</p>
    "!
    "! @parameter I_CLIENT | HTTP/REST client
    "! @parameter I_METHOD | HTTP method (GET,POST,PUT,DELETE)
    "! @parameter E_RESPONSE | Response of the request
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
    class-methods execute
      importing
        !i_client         type ts_client
        !i_method         type zif_ibmc_service_arch~char default zif_ibmc_service_arch~c_method_get
      returning
        value(e_response) type to_rest_response
      raising
        zcx_ibmc_service_exception .
    "! <p class="shorttext synchronized" lang="en">Reads character data from a HTTP response.</p>
    "!
    "! @parameter I_RESPONSE | HTTP response
    "! @parameter E_DATA | Character data
    "!
    class-methods get_response_string
      importing
        !i_response   type to_rest_response
      returning
        value(e_data) type string .
    "! <p class="shorttext synchronized" lang="en">Set character data for the body of a HTTP request.</p>
    "!
    "! @parameter I_CLIENT | HTTP/REST client
    "! @parameter I_DATA | Character data
    "!
    class-methods set_request_body_cdata
      importing
        !i_client type ts_client
        !i_data   type string .
    "! <p class="shorttext synchronized" lang="en">Set binary data for the body of a HTTP request.</p>
    "!
    "! @parameter I_CLIENT | HTTP/REST client
    "! @parameter I_DATA | Binary data
    "!
    class-methods set_request_body_xdata
      importing
        !i_client type ts_client
        !i_data   type xstring .
    "! <p class="shorttext synchronized" lang="en">Reads binary data from a HTTP response.</p>
    "!
    "! @parameter I_RESPONSE | HTTP response
    "! @parameter E_DATA | Binary data
    "!
    class-methods get_response_binary
      importing
        !i_response   type to_rest_response
      returning
        value(e_data) type xstring .
    "! <p class="shorttext synchronized" lang="en">Returns a request object from a HTTP client object.</p>
    "!
    "! @parameter I_CLIENT | HTTP/REST client
    "! @parameter E_REST_REQUEST | REST request object
    "!
    class-methods get_rest_request
      importing
        !i_client             type ts_client
      returning
        value(e_rest_request) type to_rest_request .
    "! <p class="shorttext synchronized" lang="en">Returns the status of a REST response.</p>
    "!
    "! @parameter I_REST_RESPONSE | HTTP/REST response
    "! @parameter E_STATUS | HTTP status
    "!
    class-methods get_http_status
      importing
        !i_rest_response type to_rest_response
      returning
        value(e_status)  type ts_http_status .
    "! <p class="shorttext synchronized" lang="en">Converts STRING data to UTF8 encoded XSTRING.</p>
    "!
    "! @parameter I_STRING | STRING data
    "! @parameter E_UTF8 | UTF8-encoded data
    "!
    class-methods convert_string_to_utf8
      importing
        !i_string     type string
      returning
        value(e_utf8) type xstring
      raising
        zcx_ibmc_service_exception .
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


  method get_response_header.

    e_value = i_response->get_header_field( iv_name = i_header_field ).

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
