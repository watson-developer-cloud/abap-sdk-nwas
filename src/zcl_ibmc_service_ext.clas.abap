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
class ZCL_IBMC_SERVICE_EXT definition
  public
  inheriting from ZCL_IBMC_SERVICE
  create public .

public section.

  types:
    ty_instance_id(32) type c .
  types:
    ty_servicename(30) type c .
  types:
    ty_image_format(3) type c .
  types TY_IMAGE_CLASS type STRING .
  types:
    begin of ts_oauth_prop,
        url      type ts_url,
        username type string,
        password type string,
        apikey   type string,
      end of ts_oauth_prop .

  constants C_FIELD_NONE type FIELDNAME value '###' ##NO_TEXT.
  constants C_FORMAT_JPG type TY_IMAGE_FORMAT value 'jpg' ##NO_TEXT.
  constants C_FORMAT_PNG type TY_IMAGE_FORMAT value 'png' ##NO_TEXT.
  constants C_FORMAT_GIF type TY_IMAGE_FORMAT value 'gif' ##NO_TEXT.
  constants C_FORMAT_TIF type TY_IMAGE_FORMAT value 'tif' ##NO_TEXT.
  constants C_FORMAT_ZIP type TY_IMAGE_FORMAT value 'zip' ##NO_TEXT.
  constants C_FORMAT_ALL type TY_IMAGE_FORMAT value '*' ##NO_TEXT.
  constants C_FORMAT_UNKNOWN type TY_IMAGE_FORMAT value '###' ##NO_TEXT.
  constants C_TOKEN_GENERATION_NEVER type CHAR value 'N' ##NO_TEXT.
  constants C_TOKEN_GENERATION_ALWAYS type CHAR value 'A' ##NO_TEXT.
  constants C_TOKEN_GENERATION_AUTO type CHAR value SPACE ##NO_TEXT.
  constants C_IAM_TOKEN_HOST type STRING value 'iam.cloud.ibm.com' ##NO_TEXT.
  constants C_IAM_TOKEN_PATH type STRING value '/identity/token' ##NO_TEXT.
  constants C_ICP4D_TOKEN_PATH type STRING value '/v1/preauth/validateAuth' ##NO_TEXT.
  data P_INSTANCE_ID type TY_INSTANCE_ID .
  data P_SERVICENAME type TY_SERVICENAME .

  "! <p class="shorttext synchronized" lang="en">Returns the bearer token, if available.</p>
  "!
  "! @parameter E_BEARER_TOKEN | Access token.
  "!
  methods GET_BEARER_TOKEN
    returning
      value(E_BEARER_TOKEN) type STRING .
  "! <p class="shorttext synchronized" lang="en">Returns the SDK built date.</p>
  "!
  "! @parameter E_SDK_VERSION_DATE | Built data in format YYYYMMDD.
  "!
  methods GET_SDK_VERSION_DATE
    returning
      value(E_SDK_VERSION_DATE) type STRING .
  "! <p class="shorttext synchronized" lang="en">Method for internal use.</p>
  "!
  methods SET_BEARER_TOKEN
    importing
      !I_BEARER_TOKEN type STRING .
  "! <p class="shorttext synchronized" lang="en">Retrieves a value of a configuration parameter</p> from table ZIBMC_CONFIG.
  "!
  "! @parameter I_DEFAULT | Default value, if configuration parameter is not found.
  "! @parameter I_PARAM | Configuration parameter name.
  "!
  methods GET_CONFIG_VALUE
    importing
      !I_DEFAULT type ZIBMC_CONFIG-VALUE optional
      !I_PARAM type ZIBMC_CONFIG-PARAM
    returning
      value(E_VALUE) type ZIBMC_CONFIG-VALUE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
  "! <p class="shorttext synchronized" lang="en">Factory method to instantiate a service specific wrapper class.</p>
  "!
  "! @parameter I_INSTANCE_ID |
  "!   Value of field INSTANCE_UID in table ZIBMC_CONFIG.
  "!   Service credentials are read from table ZIBMC_CONFIG with key SERVICE = Name of service wrapper class without prefix ZCL_IBMC_ and INSTANCE_UID.
  "! @parameter I_URL | URL of the service.
  "! @parameter I_HOST | Host of the service. I_URL and I_HOST can be used synonymously.
  "! @parameter I_USERNAME | User password to authenticate on service.
  "! @parameter I_PASSWORD | User password to authenticate on service.
  "! @parameter I_PROXY_HOST | Proxy server, not applicable on SAP Cloud Platform.
  "! @parameter I_PROXY_PORT | Proxy server port, not applicable on SAP Cloud Platform.
  "! @parameter I_APIKEY | API key password to authenticate on service.
  "! @parameter I_AUTH_METHOD | Authentication method. Possible values are "IAM", "ICP4D", "basicAuth", "NONE".
  "! @parameter I_OAUTH_PROP | Credentials to generate token for OAuth authentication.
  "! @parameter I_TOKEN_GENERATION | Method for access token refresh: <br/>
  "!   C_TOKEN_GENERATION_NEVER - Access token is not refreshed.
  "!   C_TOKEN_GENERATION_ALWAYS - Access to token is refreshed for each service call.
  "!   C_TOKEN_GENERATION_AUTO - Access to token is refreshed just before it expires.
  "! @parameter I_REQUEST_HEADERS | List of headers sent with every request, format 'Header1=Value1;Header2=Value2'.
  "! @parameter I_VERSION | Value of query parameter VERSION.
  "!
  class-methods GET_INSTANCE
    importing
      !I_INSTANCE_ID type TY_INSTANCE_ID optional
      !I_URL type STRING optional
      !I_HOST type STRING optional
      !I_USERNAME type STRING optional
      !I_PASSWORD type STRING optional
      !I_PROXY_HOST type STRING optional
      !I_PROXY_PORT type STRING optional
      !I_APIKEY type STRING optional
      !I_AUTH_METHOD type STRING default C_DEFAULT
      !I_OAUTH_PROP type TS_OAUTH_PROP optional
      !I_ACCESS_TOKEN type TS_ACCESS_TOKEN optional
      !I_TOKEN_GENERATION type CHAR default C_TOKEN_GENERATION_AUTO
      !I_REQUEST_HEADERS type STRING optional
      !I_VERSION type STRING optional
    exporting
      value(EO_INSTANCE) type ANY .
  "! <p class="shorttext synchronized" lang="en">Compresses multiple images from an internal table</p> to a one or more xstrings in ZIP format.
  "!
  "! @parameter IT_EXAMPLES | Internal table of images.
  "! @parameter IV_FIELD_CLASS |
  "!   Field in IT_EXAMPLES that contains the file class.
  "!   All records in IT_EXAMPLES with same class will be compress into one ZIP xstring.
  "! @parameter IV_FIELD_FILENAME | Field in IT_EXAMPLES that contains the filename for the image.
  "! @parameter IV_FIELD_IMAGE | Field in IT_EXAMPLES that contains the image.
  "! @parameter IV_IMAGE_FORMAT | Format of the image. Possible values are
  "!   C_FORMAT_JPG, C_FORMAT_PNG, C_FORMAT_GIF, C_FORMAT_TIF, C_FORMAT_ALL.
  "! @parameter IV_IMAGE_NAME | Name of the image.
  "! @parameter ET_ZIPDATA | Internal table containing a compressed ZIP xstring for each image class.
  "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
  "!
  class-methods GET_ZIPDATA
    importing
      !IT_EXAMPLES type ANY TABLE
      !IV_FIELD_CLASS type FIELDNAME default C_FIELD_NONE
      !IV_FIELD_FILENAME type FIELDNAME optional
      !IV_FIELD_IMAGE type FIELDNAME optional
      !IV_IMAGE_FORMAT type TY_IMAGE_FORMAT optional
      !IV_IMAGE_NAME type STRING optional
    exporting
      !ET_ZIPDATA type TT_MAP_FILE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

  methods GET_ACCESS_TOKEN
    redefinition .
  methods GET_REQUEST_PROP
    redefinition .
protected section.
private section.

  data P_OAUTH_PROP type TS_OAUTH_PROP .
  data P_TOKEN_GENERATION type CHAR .

  "! <p class="shorttext synchronized" lang="en">Method for internal use.</p>
  "!
  class-methods ADD_CONFIG_PROP
    importing
      !I_SERVICENAME type TY_SERVICENAME
      !I_INSTANCE_ID type TY_INSTANCE_ID optional
    changing
      !C_REQUEST_PROP type ANY .
  "! <p class="shorttext synchronized" lang="en">Method for internal use.</p>
  "!
  class-methods ADD_IMAGE_TO_ZIP
    importing
      !IS_TABLELINE type ANY
      !IO_ZIP type ref to CL_ABAP_ZIP
      !IV_BASE64 type BOOLEAN
      !IV_FILENAME type STRING optional
      !IV_FIELD_IMAGE type FIELDNAME
      !IV_FIELD_FILENAME type FIELDNAME optional
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
  "! <p class="shorttext synchronized" lang="en">Method for internal use.</p>
  "!
  class-methods GET_FIELD_DATA
    importing
      !IS_TABLELINE type ANY
      !IV_FIELD_CLASS type FIELDNAME optional
      !IV_FIELD_FILENAME type FIELDNAME optional
      !IV_FIELD_IMAGE type FIELDNAME optional
    exporting
      !EV_FIELD_CLASS type FIELDNAME
      !EV_FIELD_FILENAME type FIELDNAME
      !EV_FIELD_IMAGE type FIELDNAME
      !EV_FIELD_IMAGE_BASE64 type FIELDNAME
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
ENDCLASS.



CLASS ZCL_IBMC_SERVICE_EXT IMPLEMENTATION.


  method add_config_prop.

    data:
      lt_compname type tt_string,
      lv_type     type char,
      ls_config   type zibmc_config,
      lt_config   type standard table of zibmc_config,
      lt_ref      type standard table of ref to data,
      lr_data     type ref to data,
      lv_index    type i value 0,
      ls_url      type ts_url value is initial.

    field-symbols:
      <lv_comp_val> type any,
      <lv_comp_sub> type any,
      <lv_compname> type string,
      <l_struct>    type any.

    " read config table
    if not i_instance_id is initial.
      select *
        from zibmc_config
       where service      = @i_servicename and
             instance_uid = @i_instance_id
        into table @lt_config.
    else.
      select *
       from zibmc_config
      where service      = @i_servicename and
            instance_uid = @space
       into table @lt_config.
    endif.

    " quit, if no relevant entry in config table exists
    check sy-subrc = 0.

    " change config parameter "URL" to "HOST"
    ls_config-param = 'HOST'.
    modify lt_config from ls_config transporting param where param = 'URL'.

    " perform breadth-first search on c_request_prop to allow setting values on deeper levels,
    " e.g. HOST -> c_request_prop-url-host
    lr_data = ref #( c_request_prop ).
    append lr_data to lt_ref.

    do.
      lv_index = lv_index + 1.
      read table lt_ref into lr_data index lv_index.
      if sy-subrc <> 0.
        exit.
      endif.
      assign lr_data->* to <l_struct>.

      get_components(
        exporting
          i_structure = <l_struct>
        importing
          e_components = lt_compname ).

      loop at lt_compname assigning <lv_compname>.
        assign component <lv_compname> of structure <l_struct> to <lv_comp_val>.
        check sy-subrc = 0.
        get_field_type(
          exporting
            i_field = <lv_comp_val>
          importing
            e_technical_type = lv_type ).
        if lv_type eq zif_ibmc_service_arch~c_datatype-struct or
           lv_type eq zif_ibmc_service_arch~c_datatype-struct_deep.
          lr_data = ref #( <lv_comp_val> ).
          append lr_data to lt_ref.
        else.
          if <lv_comp_val> is initial.
            read table lt_config into ls_config with key param = <lv_compname>  ##WARN_OK.
            if sy-subrc = 0.
              condense ls_config-value.
              <lv_comp_val> = ls_config-value.
            endif.
          endif.
        endif.
      endloop.

    enddo.

  endmethod.


  method add_image_to_zip.
    data:
      lx_image       type xstring,
      lv_filename    type string.
    field-symbols:
      <lv_image>    type any,
      <lv_filename> type any.

    if not iv_filename is initial.
      lv_filename = iv_filename.
    else.
      assign component iv_field_filename of structure is_tableline to <lv_filename>.
      lv_filename = conv #( <lv_filename> ).  " type conversion
      if lv_filename is initial.
        raise_exception( i_msgno = '056' ).
      endif.
    endif.

    assign component iv_field_image of structure is_tableline to <lv_image>.

    if iv_base64 eq c_boolean_true.

      lx_image = base64_decode( i_base64 = <lv_image> ).

      io_zip->add(
        name    = lv_filename
        content = lx_image ).

    else.

      io_zip->add(
        name    = lv_filename
        content = <lv_image> ).

    endif.

  endmethod.


  method get_access_token.
    data:
      lo_response         type to_rest_response,
      lv_grand_urlencoded type string,
      lv_key_urlencoded   type string,
      lv_json             type string,
      lv_seconds          type i,
      lv_timestamp        type timestamp,
      ls_token            type zibmc_token value is initial,
      ls_timestamp        type timestamp,
      begin of ls_token_classic,
        token type string,
      end of ls_token_classic.

    if not i_request_prop-access_token-access_token is initial.
      ls_token-access_token = p_request_prop_default-access_token-access_token.
      ls_token-token_type   = p_request_prop_default-access_token-token_type.
      ls_token-expires_ts   = p_request_prop_default-access_token-expires_ts.
    else.

      select single *
        from zibmc_token
       where service      = @p_servicename and
             instance_uid = @p_instance_id
        into @ls_token.

    endif.

    " check if access token has expired
    get time stamp field ls_timestamp.
    if ls_timestamp >= ls_token-expires_ts.
      clear ls_token.
    endif.

    " (re)new token unless it is still valid
    if ls_token-access_token is initial and p_token_generation ne c_token_generation_never.

      data:
        ls_token_request_prop type ts_request_prop.

      ls_token_request_prop-url = p_oauth_prop-url.
      " set to tribool_false to distinguish between false and inital
      ls_token_request_prop-auth_basic    = c_tribool_false.
      ls_token_request_prop-auth_oauth    = c_tribool_false.
      ls_token_request_prop-auth_apikey   = c_tribool_false.
      ls_token_request_prop-header_accept = zcl_ibmc_service=>zif_ibmc_service_arch~c_mediatype-appl_json.


      if i_request_prop-auth_name eq 'IAM' ##NO_TEXT.

        " write urlencoded parameters
        if not ls_token-refresh_token is initial.
          lv_grand_urlencoded = escape( val = 'refresh_token' format = cl_abap_format=>e_uri_full ) ##NO_TEXT.
          lv_key_urlencoded = escape( val = ls_token-refresh_token format = cl_abap_format=>e_uri_full ).
          ls_token_request_prop-body = `grant_type=` && lv_grand_urlencoded && `&refresh_token=` && lv_key_urlencoded ##NO_TEXT.
        else.
          if not p_oauth_prop-apikey is initial.
            lv_grand_urlencoded = escape( val = 'urn:ibm:params:oauth:grant-type:apikey' format = cl_abap_format=>e_uri_full ) ##NO_TEXT.
            lv_key_urlencoded = escape( val = p_oauth_prop-apikey format = cl_abap_format=>e_uri_full ).
            ls_token_request_prop-body = `grant_type=` && lv_grand_urlencoded && `&apikey=` && lv_key_urlencoded ##NO_TEXT.
          elseif not p_oauth_prop-password is initial.
            lv_grand_urlencoded = escape( val = 'urn:ibm:params:oauth:grant-type:password' format = cl_abap_format=>e_uri_full ) ##NO_TEXT.
            lv_key_urlencoded = escape( val = p_oauth_prop-password format = cl_abap_format=>e_uri_full ).
            ls_token_request_prop-body = `grant_type=` && lv_grand_urlencoded && `&username=` && p_oauth_prop-username && `&password=` &&  p_oauth_prop-password ##NO_TEXT.
          else.
            ls_token_request_prop-username = p_oauth_prop-username.
            ls_token_request_prop-password = p_oauth_prop-password.
            ls_token_request_prop-apikey   = p_oauth_prop-apikey.
          endif.
        endif.
        ls_token_request_prop-header_content_type = zcl_ibmc_service=>zif_ibmc_service_arch~c_mediatype-appl_www_form_urlencoded.

        " execute HTTP POST request
        lo_response = http_post( i_request_prop = ls_token_request_prop ).

        " receive response json
        lv_json = get_response_string( lo_response ).

        " call json parser (ignore properties that do not exist in abap structure)
        parse_json(
          exporting
            i_json = lv_json
          changing
            c_abap = ls_token ).

      else.

        if i_request_prop-auth_body eq c_boolean_true.

          " POST request having username/password in body (e.g. for Db2 Warehouse)
          ls_token_request_prop-body = `{ "userid": "` && p_oauth_prop-username && `", "password": "` && p_oauth_prop-password && `" }` ##NO_TEXT.
          ls_token_request_prop-header_content_type = zcl_ibmc_service=>zif_ibmc_service_arch~c_mediatype-appl_json.

          " execute HTTP POST request
          lo_response = http_post( i_request_prop = ls_token_request_prop ).

        else.

          ls_token_request_prop-username   = p_oauth_prop-username.
          ls_token_request_prop-password   = p_oauth_prop-password.
          ls_token_request_prop-apikey     = p_oauth_prop-apikey.
          ls_token_request_prop-url        = p_oauth_prop-url.
          ls_token_request_prop-auth_basic = c_boolean_true.

          " execute HTTP GET request
          lo_response = http_get( i_request_prop = ls_token_request_prop ).

          " receive response json
          lv_json = get_response_string( lo_response ).

          if i_request_prop-auth_name eq 'ICP4D' ##NO_TEXT.

            " parse expected response:
            "   { "username": "joe", "role": "User", "uid": "1003",
            "     "accessToken": "eyJhbGc…1AjT_w",
            "     "messageCode": "success", "message": "success" }
            data:
              begin of ls_access_token_icp4d,
                accesstoken type string,
              end of ls_access_token_icp4d.
            parse_json(
             exporting
               i_json = lv_json
             changing
               c_abap = ls_access_token_icp4d ).

            ls_token-access_token = ls_access_token_icp4d-accesstoken.
            ls_token-expires_in = 12 * 3600.

          else.

            " call json parser
            parse_json(
              exporting
                i_json = lv_json
              changing
                c_abap = ls_token_classic ).

            ls_token-access_token = ls_token_classic-token.
            ls_token-expires_in = 3600.

          endif.

          ls_token-token_type = 'Bearer' ##NO_TEXT.

        endif.

      endif.


      " calculate expiration time
      if ls_token-expires_in > 0.
        get time stamp field lv_timestamp.
        lv_seconds = ls_token-expires_in - 300.  " subtract 5 minutes to be save
        ls_token-expires_ts = cl_abap_tstmp=>add( tstmp = lv_timestamp secs = lv_seconds ).
      endif.

      ls_token-service = p_servicename.
      ls_token-instance_uid = p_instance_id.

      if p_token_generation eq c_token_generation_auto.
        modify zibmc_token from @ls_token.
        commit work.
      endif.

    endif.

    " fill returning parameter
    move-corresponding ls_token to e_access_token  ##ENH_OK.

  endmethod.


  method get_bearer_token.

    data:
      ls_access_token type ts_access_token.

    try.
        ls_access_token = get_access_token( ).
      catch zcx_ibmc_service_exception.
        clear ls_access_token.
    endtry.


    if ls_access_token-token_type eq 'Bearer'.
      e_bearer_token = ls_access_token-access_token.
    else.
      clear e_bearer_token.
    endif.

  endmethod.


  method get_config_value.


    select single value
      from zibmc_config
     where param        = @i_param and
           service      = @p_servicename and
           instance_uid = @p_instance_id
      into @e_value.

    if sy-subrc <> 0.
      select single value
        from zibmc_config
       where param        = @i_param and
             service      = @p_servicename and
             instance_uid = @space
        into @e_value.

      if sy-subrc <> 0.
        if i_default is supplied.
          e_value = i_default.
        else.
          raise exception type zcx_ibmc_service_exception.
        endif.
      endif.

    endif.

  endmethod.


  method get_field_data.

    data:
      begin of ls_comp,
        name   type string,
        type   type char,
        length type i,
      end of ls_comp,
      lt_comp     like standard table of ls_comp,
      lt_compname type tt_string,
      lv_msg1     type string.
    field-symbols:
      <l_comp> type any.

    get_components(
      exporting
        i_structure = is_tableline
      importing
        e_components = lt_compname ).

    loop at lt_compname into ls_comp-name.
      assign component ls_comp-name of structure is_tableline to <l_comp>.
      get_field_type(
        exporting
          i_field = <l_comp>
        importing
          e_technical_type = ls_comp-type
          e_length         = ls_comp-length ).
      append ls_comp to lt_comp.
    endloop.

    clear: ev_field_class, ev_field_filename, ev_field_image, ev_field_image_base64.

    if ev_field_class is requested.
      if not iv_field_class is initial.
        " field that contains class name is explicit specified
        ev_field_class = iv_field_class.
      else.
        " field CLASS
        read table lt_comp with key name = 'CLASS' into ls_comp.
        if sy-subrc = 0 and
           ( ls_comp-type eq 'C' or ls_comp-type eq 'g' or ls_comp-type eq 'N' ).  " character type
          ev_field_class = ls_comp-name.
        else.
          " first field of character type and length 6 or more contains class name
          loop at lt_comp into ls_comp where ( type eq 'C' or type eq 'N' ) and length >= 6 and
               name ne 'FILENAME' and name ne 'IMAGE' and name ne 'IMAGE_BASE64'.
            ev_field_class = ls_comp-name.
            exit.
          endloop.
        endif.
        if ev_field_class is initial.
          " first field of type string contains class name
          loop at lt_comp into ls_comp where type eq 'g' and
               name ne 'FILENAME' and name ne 'IMAGE' and name ne 'IMAGE_BASE64'.
            ev_field_class = ls_comp-name.
            exit.
          endloop.
        endif.
      endif.
    endif.


    if ev_field_filename is requested.
      if not iv_field_filename is initial.
        " field that contains image name is explicit specified
        ev_field_filename = iv_field_filename.
      else.
        read table lt_comp with key name = 'FILENAME' into ls_comp.
        if sy-subrc = 0 and
           ( ls_comp-type eq 'C' or ls_comp-type eq 'g' or ls_comp-type eq 'N' ).
          ev_field_filename = ls_comp-name.
        else.
          " first field of character type and length 12 or more contains image name
          loop at lt_comp into ls_comp where ( type eq 'C' or type eq 'N' ) and length >= 12 and
            name ne ev_field_class and name ne 'IMAGE' and name ne 'IMAGE_BASE64'.
            ev_field_filename = ls_comp-name.
            exit.
          endloop.
        endif.
        if ev_field_filename is initial.
          " first field of type string contains image name
          loop at lt_comp into ls_comp where type eq 'g' and name ne ev_field_class.
            ev_field_filename = ls_comp-name.
            exit.
          endloop.
        endif.
      endif.
    endif.


    if ev_field_image is requested.
      if not iv_field_image is initial.
        " field that contains image data is explicit specified

        " check image field data type to determine encoding
        read table lt_comp into ls_comp with key name = iv_field_image.
        if sy-subrc <> 0.
          lv_msg1 = conv #( ev_field_image ).  " type conversion
          raise_exception(
            i_msgno = '054'   " Field &1 is missing or has incompatible type.
            i_msgv1    = lv_msg1 ).
        endif.
        if ls_comp-type eq 'g'.
          " image is base64 encoded
          ev_field_image_base64 = iv_field_image.
        else.
          " image in binary data
          ev_field_image = iv_field_image.
        endif.

      else.
        read table lt_comp with key name = 'IMAGE' into ls_comp.
        if sy-subrc <> 0.
          read table lt_comp with key name = 'IMAGE_BASE64' into ls_comp.
        endif.
        if sy-subrc = 0 and
           ( ls_comp-type eq 'y' or ls_comp-type eq 'g' ).  " xstring or string
          if ls_comp-type eq 'g'.
            ev_field_image_base64 = ls_comp-name.
          else.
            ev_field_image = ls_comp-name.
          endif.
        else.
          " first field of type xstring contains image data (binary)
          loop at lt_comp into ls_comp where type eq 'y' and
               name ne ev_field_class and name ne ev_field_filename.
            ev_field_image = ls_comp-name.
            exit.
          endloop.
        endif.
        if ev_field_image is initial.
          " first field of type string contains image data (base64 encoded)
          loop at lt_comp into ls_comp where type eq 'g' and
               name ne ev_field_class and name ne ev_field_filename.
            ev_field_image_base64 = ls_comp-name.
            exit.
          endloop.
        endif.
      endif.
    endif.

  endmethod.


  method get_instance.
    data:
      lv_classname    type string,
      ls_request_prop type ts_request_prop,
      lo_instance     type ref to zcl_ibmc_service_ext,
      lt_headerstr    type tt_string,
      lv_headerstr    type string,
      ls_header       type ts_header.

    " instantiate object of type of exporting parameter
    get_field_type(
      exporting
        i_field         = eo_instance
      importing
        e_relative_type = lv_classname ).

    create object eo_instance type (lv_classname)
      exporting
        i_url      = i_url
        i_host     = i_host
        i_proxy_host = i_proxy_host
        i_proxy_port = i_proxy_port
        i_username = i_username
        i_password = i_password
        i_apikey   = i_apikey.

    lo_instance ?= eo_instance.

    " Set service name (= class name without namespace and prefix 'CL_')
    if lv_classname cp 'Z*'.
      find first occurrence of regex 'ZCL_[^_]*_([^\/]*)$' in lv_classname submatches lo_instance->p_servicename.
    else.
      find first occurrence of regex 'CL_([^\/]*)$' in lv_classname submatches lo_instance->p_servicename.
    endif.
    if lo_instance->p_servicename is initial.
      find first occurrence of regex '([^\/]*)$' in lv_classname submatches lo_instance->p_servicename.
      if lo_instance->p_servicename is initial.
        lo_instance->p_servicename = lv_classname.
      endif.
    endif.

    " Set default request headers
    split i_request_headers at ';' into table lt_headerstr.
    if sy-subrc = 0.
      loop at lt_headerstr into lv_headerstr.
        split lv_headerstr at '=' into ls_header-name ls_header-value.
        if sy-subrc = 0.
          append ls_header to lo_instance->p_request_prop_default-headers.
        endif.
      endloop.
    endif.

    " Set instance ID
    if not i_instance_id is initial.
      lo_instance->p_instance_id = i_instance_id.
    else.
      lo_instance->p_instance_id = get_progname( ).
    endif.

    " Merge properties from config table for this service and instance
    add_config_prop(
      exporting
        i_servicename  = lo_instance->p_servicename
        i_instance_id  = lo_instance->p_instance_id
      changing
        c_request_prop = lo_instance->p_request_prop_default ).

    normalize_url( changing c_url = lo_instance->p_request_prop_default-url ).

    " Merge properties from config table for this service type
    add_config_prop(
      exporting
        i_servicename  = lo_instance->p_servicename
      changing
        c_request_prop = lo_instance->p_request_prop_default ).

    normalize_url( changing c_url = lo_instance->p_request_prop_default-url ).

    " Get service default properties
    ls_request_prop = lo_instance->get_request_prop( i_auth_method = i_auth_method ).
    merge_structure(
      exporting
        i_alternative = ls_request_prop
      changing
        c_base        = lo_instance->p_request_prop_default ).

    " Ensure that OAuth is set in case IAM is used.
    if lo_instance->p_request_prop_default-auth_name eq 'IAM'.
      lo_instance->p_request_prop_default-auth_oauth = c_boolean_true.
    endif.

    " Set OAuth properties
    lo_instance->p_oauth_prop = i_oauth_prop.
    normalize_url(
      changing
        c_url = lo_instance->p_oauth_prop-url ).
    if ls_request_prop-auth_name eq 'IAM' or ls_request_prop-auth_name eq 'ICP4D' ##NO_TEXT.
      if lo_instance->p_oauth_prop-url-host is initial.
        lo_instance->p_oauth_prop-url-protocol = 'https' ##NO_TEXT.
        if ls_request_prop-auth_name eq 'IAM'.
          lo_instance->p_oauth_prop-url-host = c_iam_token_host.
        else.
          lo_instance->p_oauth_prop-url-host = lo_instance->p_request_prop_default-url-host.
        endif.
      endif.
      if lo_instance->p_oauth_prop-url-path_base is initial and lo_instance->p_oauth_prop-url-path is initial.
        " Set path_base (not path), otherwise the default service path_base would be added, which is not correct
        if ls_request_prop-auth_name eq 'IAM'.
          lo_instance->p_oauth_prop-url-path_base = c_iam_token_path.
        else.
          lo_instance->p_oauth_prop-url-path_base = c_icp4d_token_path.
        endif.
      endif.
      if lo_instance->p_oauth_prop-password is initial and lo_instance->p_oauth_prop-apikey is initial.
        lo_instance->p_oauth_prop-username = lo_instance->p_request_prop_default-username.
        lo_instance->p_oauth_prop-password = lo_instance->p_request_prop_default-password.
        lo_instance->p_oauth_prop-apikey   = lo_instance->p_request_prop_default-apikey.
      endif.
    endif.

    if not i_access_token-access_token is initial.
      lo_instance->p_token_generation =  c_token_generation_never.
      lo_instance->set_access_token( i_access_token = i_access_token ).
    else.
      lo_instance->p_token_generation = i_token_generation.
    endif.

    lo_instance->p_version = i_version.

  endmethod.


  method get_request_prop.
    data:
      lv_auth_method type string.

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
    endif.
  endmethod.


  method get_sdk_version_date.

    e_sdk_version_date = ''.

  endmethod.


  method get_zipdata.

    constants:
      c_class_all type string value '#ALL#'.

    data:
      lv_field_class        type fieldname,
      lv_field_filename     type fieldname,
      lv_field_image        type fieldname,
      lv_field_image_base64 type fieldname,
      lv_field_image_act    type fieldname,
      lv_base64             type boolean,
      lr_data               type ref to data,
      ls_zipdata            type ts_map_file,
      lv_image_count        type i,
      lv_class              type ty_image_class,
      lt_classes            type standard table of ty_image_class,
      lv_filename           type string,
      lv_filename_suffix(4) type n value 0,
      lo_zip                type ref to cl_abap_zip value is initial,
      lv_image_name         type string,
      lv_image_format       type ty_image_format.
    field-symbols:
      <ls_examples> type any,
      <lv_class>    type any,
      <lv_filename> type any,
      <lv_image>    type any.

    create data lr_data like line of it_examples.
    assign lr_data->* to <ls_examples>.

    " determine field with filename
    if iv_field_filename is initial or iv_field_filename eq c_field_none.
      if not iv_image_name is initial.
        lv_field_filename = c_field_none.
        lv_image_name     = iv_image_name.
      endif.
    else.
      lv_field_filename = iv_field_filename.
      clear: lv_image_name, lv_image_format.
    endif.

    " get field names
    get_field_data(
      exporting
        is_tableline          = <ls_examples>
        iv_field_class        = iv_field_class
        iv_field_filename     = lv_field_filename
        iv_field_image        = iv_field_image
      importing
        ev_field_class        = lv_field_class
        ev_field_filename     = lv_field_filename
        ev_field_image        = lv_field_image
        ev_field_image_base64 = lv_field_image_base64 ).

    " reset field name for filename if explicitly set to 'none'.
    if lv_field_filename eq c_field_none.
      clear lv_field_filename.
    endif.


    if iv_field_class eq c_field_none.
      " do not separate into different classes
      append c_class_all to lt_classes.
    else.
      " compile list of different classes
      loop at it_examples assigning <ls_examples>.
        assign component lv_field_class of structure <ls_examples> to <lv_class>.
        append <lv_class> to lt_classes.
      endloop.
      sort lt_classes.
      delete adjacent duplicates from lt_classes.
    endif.

    " determine default image format
    if iv_image_format is initial or
       iv_image_format eq c_format_all or
       iv_image_format eq c_format_unknown.
      lv_image_format = c_format_jpg.
    else.
      lv_image_format = iv_image_format.
    endif.
    translate lv_image_format to lower case.


    " generate a zip data xstring per class
    loop at lt_classes into lv_class.
      check not lv_class is initial.

      create object lo_zip.

      lv_image_count = 0.

      loop at it_examples assigning <ls_examples>.
        if lv_class ne c_class_all.
          assign component lv_field_class of structure <ls_examples> to <lv_class>.
          check <lv_class> eq lv_class.
        endif.

        " determine filename
        clear lv_filename.
        if not lv_field_filename is initial.
          assign component lv_field_filename of structure <ls_examples> to <lv_filename>.
          if sy-subrc = 0.
            " remove path from filename
            find regex '([^/\\]*)$' in <lv_filename> submatches lv_filename.
          endif.
        endif.

        " if valid filename was not found, use the default
        if lv_filename np '*+.+++'.
          if lv_filename is initial.
            if lv_image_name is initial.
              lv_filename = lv_class && lv_filename_suffix && `.` && lv_image_format.
            else.
              lv_filename = lv_image_name && lv_filename_suffix && `.` && lv_image_format.
            endif.
          else.
            lv_filename = lv_filename && `.` && lv_image_format.
          endif.
          lv_filename_suffix = lv_filename_suffix + 1.
        endif.

        " determine image encoding
        if lv_field_image is initial.
          lv_field_image_act = lv_field_image_base64.
          lv_base64          = c_boolean_true.
        elseif lv_field_image_base64 is initial.
          lv_field_image_act = lv_field_image.
          lv_base64          = c_boolean_false.
        else.
          assign component lv_field_image of structure <ls_examples> to <lv_image>.
          if not <lv_image> is initial.
            lv_field_image_act = lv_field_image.
            lv_base64          = c_boolean_false.
          else.
            lv_field_image_act = lv_field_image_base64.
            lv_base64          = c_boolean_true.
          endif.
        endif.

        " add image to zip data
        add_image_to_zip(
          exporting
            io_zip         = lo_zip
            is_tableline   = <ls_examples>
            iv_filename    = lv_filename
            iv_field_image = lv_field_image_act
            iv_base64      = lv_base64 ).

        lv_image_count = lv_image_count + 1.

      endloop.

      if lv_image_count > 0.

        ls_zipdata-key  = lv_class.
        ls_zipdata-data = lo_zip->save( ).
        append ls_zipdata to et_zipdata.

      endif.

    endloop.

  endmethod.


  method set_bearer_token.

    data:
      ls_access_token type ts_access_token.

    ls_access_token-token_type   = 'Bearer'  ##NO_TEXT.
    ls_access_token-access_token = i_bearer_token.
    try.
        set_access_token( i_access_token = ls_access_token ).
      catch zcx_ibmc_service_exception  ##NO_HANDLER.
    endtry.

  endmethod.
ENDCLASS.
