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
interface ZIF_IBMC_SERVICE_ARCH
  public .


  types:
    boolean(1) type c .
  types:
    char(1) type c .
  types:
    begin of ts_http_status,
      code   type string,
      reason type string,
      json   type string,
    end of ts_http_status .
  types:
    begin of ts_header,
      name  type string,
      value type string,
    end of ts_header .
  types:
    tt_header type standard table of ts_header with non-unique default key .
  types:
    begin of ts_url,
      protocol    type string,
      host        type string,
      path_base   type string,
      path        type string,
      querystring type string,
    end of ts_url .
  types:
    begin of ts_access_token,
      access_token   type string,
      token_type(32) type c,
      expires_ts     type timestamp,
    end of ts_access_token .
  types:
    ty_timezone(6) type c .
  types:
    ty_ssl_id(6) type c .
  types:
    begin of ts_request_prop,
      url                 type ts_url,
      proxy_host          type string,
      proxy_port          type string,
      auth_name           type string,
      auth_type           type string,
      auth_headername     type string,
      auth_basic          type boolean,
      auth_oauth          type boolean,
      auth_apikey         type boolean,
      auth_query          type boolean,
      auth_header         type boolean,
      auth_body           type boolean,
      header_accept       type string,
      header_content_type type string,
      headers             type tt_header,
      body                type string,
      body_bin            type xstring,
      username            type string,
      password            type string,
      apikey              type string,
      access_token        type ts_access_token,
      ssl_id              type ty_ssl_id,
    end of ts_request_prop .
  types:
    tt_string type standard table of string with non-unique default key .
  types:
    begin of TS_FORM_PART,
      CONTENT_TYPE        type STRING,
      CONTENT_DISPOSITION type STRING,
      CDATA               type STRING,
      XDATA               type XSTRING,
    end of TS_FORM_PART .
  types:
    TT_FORM_PART type standard table of TS_FORM_PART with non-unique default key .


  constants C_METHOD_GET type CHAR value 'g' ##NO_TEXT.
  constants C_METHOD_POST type CHAR value 'p' ##NO_TEXT.
  constants C_METHOD_CREATE type CHAR value 'c' ##NO_TEXT.
  constants C_METHOD_PUT type CHAR value 'u' ##NO_TEXT.
  constants C_METHOD_DELETE type CHAR value 'd' ##NO_TEXT.
  constants C_HEADER_CONTENT_TYPE type STRING value 'Content-Type' ##NO_TEXT.
  constants C_HEADER_ACCEPT type STRING value 'Accept' ##NO_TEXT.
  constants C_HEADER_CONTENT_DISPOSITION type STRING value 'Content-Disposition' ##NO_TEXT.
  constants:
    begin of c_mediatype,
      all                      type string value '*/*',
      appl_gzip                type string value 'application/gzip',
      appl_html                type string value 'application/html',
      appl_json                type string value 'application/json',
      appl_octet_stream        type string value 'application/octet-stream',
      appl_pdf                 type string value 'application/pdf',
      appl_www_form_urlencoded type string value 'application/x-www-form-urlencoded',
      appl_xml                 type string value 'application/xml',
      appl_xhtml_xml           type string value 'application/xhtml+xml',
      atom_xml                 type string value 'application/atom+xml',
      appl_zip                 type string value 'application/zip',
      audio_all                type string value 'audio/*',
      audio_mpeg               type string value 'audio/mpeg',
      audio_ogg                type string value 'audio/ogg',
      audio_wav                type string value 'audio/wav',
      image_all                type string value 'image/*',
      image_bmp                type string value 'image/bmp',
      image_gif                type string value 'image/gif',
      image_jpeg               type string value 'image/jpeg',
      image_png                type string value 'image/png',
      image_tiff               type string value 'image/tiff',
      multipart_all            type string value 'multipart/*',
      multipart_form_data      type string value 'multipart/form-data',
      multipart_mixed          type string value 'multipart/mixed',
      text_all                 type string value 'text/*',
      text_css                 type string value 'text/css',
      text_csv                 type string value 'text/csv',
      text_html                type string value 'text/html',
      text_javascript          type string value 'text/javascript',
      text_plain               type string value 'text/plain',
      video_all                type string value 'video/*',
      video_mp4                type string value 'video/mp4',
      video_mpeg               type string value 'video/mpeg',
    end of c_mediatype .
  constants:
    begin of c_datatype,
      i           type char value 'I',
      int8        type char value '8',
      p           type char value 'P',
      f           type char value 'F',
      c           type char value 'C',
      n           type char value 'N',
      string      type char value 'g',
      x           type char value 'X',
      xstring     type char value 'y',
      dataref     type char value 'l',
      objectref   type char value 'r',
      struct      type char value 'u',
      struct_deep type char value 'v',
      itab        type char value 'h',
    end of c_datatype .
endinterface.
