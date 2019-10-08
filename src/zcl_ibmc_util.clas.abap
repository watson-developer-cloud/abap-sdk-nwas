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
class ZCL_IBMC_UTIL definition
  public
  final
  create public .

public section.

  class-methods CONVERT_TIMESTAMP_TO_LOCAL
    importing
      !IV_TIMESTAMP type TIMESTAMP
    returning
      value(EV_LOCAL) type STRING .
  class-methods GET_MIMETYPE_FROM_EXTENSION
    importing
      !I_FILENAME type STRING
    returning
      value(E_MIMETYPE) type STRING .
  class-methods UTC_TO_TIMEZONE
    importing
      !I_TIMESTAMP type TIMESTAMP
      !I_TIMEZONE type ZIF_IBMC_SERVICE_ARCH=>TY_TIMEZONE optional
    returning
      value(E_TIMESTAMP) type TIMESTAMP .
  class-methods CONVERT_DATETIME_TO_TIMESTAMP
    importing
      !I_DATETIME type ZCL_IBMC_SERVICE=>DATETIME
    returning
      value(E_TIMESTAMP) type TIMESTAMP .
  class-methods CONVERT_TIMESTAMP_TO_DATETIME
    importing
      !I_TIMESTAMP type TIMESTAMP
    returning
      value(E_DATETIME) type ZCL_IBMC_SERVICE=>DATETIME .
protected section.
private section.
ENDCLASS.



CLASS ZCL_IBMC_UTIL IMPLEMENTATION.


  method CONVERT_DATETIME_TO_TIMESTAMP.

    constants:
      c_zero type timestamp value '0'.  " avoid conversion at runtime

    " check if input string applies to schema yyyy-mm-ddThh:mm:ssZ
    if i_datetime cp '++++-++-++T++:++:++*'.
      try.
          e_timestamp =
            i_datetime(4) * 10000000000 + i_datetime+5(2) * 100000000 + i_datetime+8(2) * 1000000 +
            i_datetime+11(2) * 10000 + i_datetime+14(2) * 100 + i_datetime+17(2).
        catch cx_sy_conversion_no_number.
          " invalid input
          e_timestamp = c_zero.
      endtry.
    else.
      " invalid input
      e_timestamp = c_zero.
    endif.

  endmethod.


  method CONVERT_TIMESTAMP_TO_DATETIME.

    data:
      lv_year(4) type n,
      lv_month(2) type n,
      lv_day(2) type n,
      lv_hour(2) type n,
      lv_min(2) type n,
      lv_sec(2) type n,
      lv_rest type timestamp.

    lv_rest = i_timestamp.
    lv_year = lv_rest div 10000000000.
    lv_rest = lv_rest - ( lv_year * 10000000000 ).
    lv_month = lv_rest div 100000000.
    lv_rest = lv_rest - ( lv_month * 100000000 ).
    lv_day = lv_rest div 1000000.
    lv_rest = lv_rest - ( lv_day * 1000000 ).
    lv_hour = lv_rest div 10000.
    lv_rest = lv_rest - ( lv_hour * 10000 ).
    lv_min = lv_rest div 100.
    lv_rest = lv_rest - ( lv_min * 100 ).
    lv_sec = lv_rest div 1.  " type conversion

    concatenate lv_year '-' lv_month '-' lv_day 'T' lv_hour ':' lv_min ':' lv_sec 'Z' into e_datetime.

  endmethod.


  method convert_timestamp_to_local.

    data:
      lv_dats     type d,
      lv_tims     type t,
      lv_timezone type zif_ibmc_service_arch=>ty_timezone,
      lv_datc(10) type c,
      lv_timc(8)  type c.



    " split timestamp to date and time according to time zone
    lv_timezone = zcl_ibmc_service_arch=>get_timezone( ).
    convert time stamp iv_timestamp time zone lv_timezone
            into date lv_dats time lv_tims.

    " write date and time to string using local date/time format
    lv_datc = conv #( lv_dats ).
    lv_timc = conv #( lv_tims ).
    concatenate lv_datc lv_timc into ev_local separated by space.

  endmethod.


  method get_mimetype_from_extension.
    data:
      l_extension type string.

    if i_filename is initial.
      e_mimetype = zif_ibmc_service_arch=>c_mediatype-all.
      exit.
    endif.

    find regex '\.([^\.]*)$' in i_filename submatches l_extension.
    if sy-subrc <> 0.
      l_extension = i_filename.
    endif.

    translate l_extension to lower case.

    case l_extension.
      when 'jpg' or 'jpeg'. e_mimetype = zif_ibmc_service_arch=>c_mediatype-image_jpeg.
      when 'png'. e_mimetype = zif_ibmc_service_arch=>c_mediatype-image_png.
      when 'txt'. e_mimetype = zif_ibmc_service_arch=>c_mediatype-text_plain.
      when 'csv'. e_mimetype = zif_ibmc_service_arch=>c_mediatype-text_csv.
      when others. e_mimetype = `application/` && l_extension ##NO_TEXT.
    endcase.

*    select single type
*      into e_mimetype
*      from sdokfext
*     where extension = l_extension.
*
*    if sy-subrc <> 0.
*      e_mimetype = `application/` && l_extension.
*    endif.

  endmethod.


  method utc_to_timezone.

    data:
      lv_timezone type zif_ibmc_service_arch=>ty_timezone,
      lv_date     type d,
      lv_time     type t.

    if i_timezone is initial.
      lv_timezone = zcl_ibmc_service_arch=>get_timezone( ).
    else.
      lv_timezone = i_timezone.
    endif.

    convert time stamp i_timestamp time zone lv_timezone into date lv_date time lv_time.
    convert date lv_date time lv_time into time stamp e_timestamp time zone 'UTC'.

  endmethod.
ENDCLASS.
